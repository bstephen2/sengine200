/*
 *	sengine
 *	A threaded program for solving directmate chess problems.
 *
 *	(c) 2020-2021, Brian Stephenson
 * brian@bstephen.me.uk
 *
 */

#include <assert.h>
#include <libxml/encoding.h>
#include <libxml/xmlwriter.h>
#include "sengine.h"

#if defined(LIBXML_WRITER_ENABLED) && defined(LIBXML_OUTPUT_ENABLED)
#define MY_ENCODING "UTF-8"

xmlChar* ConvertInput(const char* in, const char* encoding);

extern bool g_meson;
extern char* g_kings;
extern char* g_gbr;
extern char* g_pos;
extern enum SOUNDNESS sound;

static xmlTextWriterPtr writer;
static xmlDocPtr doc;

void xml_start()
{
    int rc;
    UT_string* tmp;

    LIBXML_TEST_VERSION

    writer = xmlNewTextWriterDoc(&doc, 0);
    assert(writer != NULL);

    rc = xmlTextWriterStartElement(writer, BAD_CAST "MesonSolution");
    assert(rc >= 0);

    utstring_new(tmp);
    utstring_printf(tmp, "%s (v. %s)", SENGINE_PROG_NAME, SENGINE_PROG_VERSION);
    rc = xmlTextWriterWriteElement(writer, BAD_CAST "Program", BAD_CAST utstring_body(tmp));
    assert(rc >= 0);
    utstring_clear(tmp);

    if (g_meson == false) {
        rc = xmlTextWriterWriteElement(writer, BAD_CAST "Author", BAD_CAST SENGINE_PROG_AUTHOR);
        utstring_printf(tmp, "%s (v %s)", COMP, CV);
        rc = xmlTextWriterWriteElement(writer, BAD_CAST "compiler", BAD_CAST utstring_body(tmp));
        assert(rc >= 0);
        utstring_clear(tmp);
        rc = xmlTextWriterWriteElement(writer, BAD_CAST "platform", BAD_CAST SENGINE_PLATFORM);
        assert(rc >= 0);
        utstring_printf(tmp, "%s:%s:%s", g_kings, g_gbr, g_pos);
        rc = xmlTextWriterWriteElement(writer, BAD_CAST "Diagram", BAD_CAST utstring_body(tmp));
        assert(rc >= 0);
        utstring_clear(tmp);
    }

    switch (sound) {
    case UNSET:
        rc = xmlTextWriterWriteElement(writer, BAD_CAST "Soundness", BAD_CAST "UNSET");
        assert(rc >= 0);
        break;

    case SHORT_SOLUTION:
        rc = xmlTextWriterWriteElement(writer, BAD_CAST "Soundness", BAD_CAST "SHORT_SOLUTION");
        assert(rc >= 0);
        break;

    case SOUND:
        rc = xmlTextWriterWriteElement(writer, BAD_CAST "Soundness", BAD_CAST "SOUND");
        assert(rc >= 0);
        break;

    case COOKED:
        rc = xmlTextWriterWriteElement(writer, BAD_CAST "Soundness", BAD_CAST "COOKED");
        assert(rc >= 0);
        break;

    case NO_SOLUTION:
        rc = xmlTextWriterWriteElement(writer, BAD_CAST "Soundness", BAD_CAST "NO_SOLUTION");
        assert(rc >= 0);
        break;

    case MISSING_SOLUTION:
        rc = xmlTextWriterWriteElement(writer, BAD_CAST "Soundness", BAD_CAST "MISSING_SOLUTION");
        assert(rc >= 0);
        break;

    default:
        (void) fputs("Sengine200: Invalid soundess indicator\n", stderr);
        exit(1);
        break;
    }

    utstring_free(tmp);

    return;
}

void xml_set(BOARDLIST* set_list)
{
	 int rc;
    xmlChar* tmp;
    rc = xmlTextWriterStartElement(writer, BAD_CAST "Sets");
    assert(rc >= 0);
	 rc = xmlTextWriterEndElement(writer);
    assert(rc >= 0);
    return;
}

void xml_tries(BOARDLIST* tries_list)
{
	 int rc;
    xmlChar* tmp;
    rc = xmlTextWriterStartElement(writer, BAD_CAST "Tries");
    assert(rc >= 0);
	 rc = xmlTextWriterEndElement(writer);
    assert(rc >= 0);

    return;
}

void xml_keys(BOARDLIST* keys_list)
{
	 int rc;
    xmlChar* tmp;
    rc = xmlTextWriterStartElement(writer, BAD_CAST "Keys");
    assert(rc >= 0);
	 rc = xmlTextWriterEndElement(writer);
    assert(rc >= 0);

    return;
}

void xml_options()
{
	 int rc;
    xmlChar* tmp;
    rc = xmlTextWriterStartElement(writer, BAD_CAST "options");
    assert(rc >= 0);
	 rc = xmlTextWriterEndElement(writer);
    assert(rc >= 0);

    return;
}

void xml_stats(DIR_SOL* dir_sol)
{
	 int rc;
    xmlChar* tmp;
    rc = xmlTextWriterStartElement(writer, BAD_CAST "stats");
    assert(rc >= 0);
	 rc = xmlTextWriterEndElement(writer);
    assert(rc >= 0);

    return;
}

void xml_time(double runtime)
{
    int rc;

    rc = xmlTextWriterWriteFormatElement(writer, BAD_CAST "SolvingTime", "%f", runtime);
    assert(rc >= 0);

    rc = xmlTextWriterEndElement(writer);
    assert(rc >= 0);

    return;
}

void xml_end()
{
    int rc;

    rc = xmlTextWriterEndDocument(writer);
    assert(rc >= 0);

    xmlFreeTextWriter(writer);

    xmlSaveFileEnc("-", doc, MY_ENCODING);

    xmlFreeDoc(doc);

    return;
}

xmlChar*
ConvertInput(const char* in, const char* encoding)
{
    xmlChar* out;
    int ret;
    int size;
    int out_size;
    int temp;
    xmlCharEncodingHandlerPtr handler;

    if (in == 0)
        return 0;

    handler = xmlFindCharEncodingHandler(encoding);

    if (!handler) {
        printf("ConvertInput: no encoding handler found for '%s'\n",
               encoding ? encoding : "");
        return 0;
    }

    size = (int) strlen(in) + 1;
    out_size = size * 2 - 1;
    out = (unsigned char*) xmlMalloc((size_t) out_size);

    if (out != 0) {
        temp = size - 1;
        ret = handler->input(out, &out_size, (const xmlChar*) in, &temp);

        if ((ret < 0) || (temp - size + 1)) {
            if (ret < 0) {
                printf("ConvertInput: conversion wasn't successful.\n");
            } else {
                printf
                ("ConvertInput: conversion wasn't successful. converted: %i octets.\n",
                 temp);
            }

            xmlFree(out);
            out = 0;
        } else {
            out = (unsigned char*) xmlRealloc(out, out_size + 1);
            out[out_size] = 0;  /*null terminating out */
        }
    } else {
        printf("ConvertInput: no mem\n");
    }

    return out;
}

#endif

