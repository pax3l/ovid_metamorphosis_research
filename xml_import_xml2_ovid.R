# ---------------------------+
# Working with XML files in R
# Based on Aurélien Berra's file, modified by Axelle Penture in the context of her research on Ovid
# Version 1.3 – 2024-12-14
# ---------------------------+

pacman::p_load(here, xml2)

# XML2 package: main functions --------------------------------------------
# Documentation: http://xml2.r-lib.org/reference/index.html

# Read XML document
pallas_xml <-
  read_xml("https://raw.githubusercontent.com/pax3l/ovid_metamorphosis_research/refs/heads/main/draft_encode_Pallas_1.xml")
class(pallas_xml)

# See structure of a document
xml_structure(iliad_xml)

# Find and use XML namespace (here, TEI)
# "Default namespaces are named d1, d2 etc."
xml_ns(iliad_xml)

# Find nodes that match an XPath expression
iliad_div <- xml_find_all(iliad_xml, "//d1:div", xml_ns(iliad_xml))
iliad_lines <- xml_find_all(iliad_xml, "//d1:l", xml_ns(iliad_xml))
class(iliad_lines)

# Find attributes
xml_attr(iliad_div, "type", xml_ns(iliad_xml))
xml_attr(iliad_lines, "n", xml_ns(iliad_xml))

# Find the names of elements and
xml_name(iliad_xml)
xml_name(xml_children(iliad_xml))

# Count elements
xml_length(iliad_div)
xml_length(xml_children(iliad_div))

# Get contents of elements
xml_contents(iliad_lines)

# Extract or modify the text
xml_text(iliad_lines)
iliad_lines_as_text <- xml_text(iliad_lines)
str(iliad_lines_as_text)

# XML document to R structures
iliad_l <- as_list(iliad_lines)
str(iliad_l)
iliad_v <- as_list(iliad_lines) |> unlist()
str(iliad_v)
# setdiff(iliad_lines_as_text, iliad_v)  # vecteurs identiques

# Write XML document
write_xml(iliad_xml, here("output", "iliad_out_test.xml"))

# Download XML document from URL
download_xml(
  "https://raw.githubusercontent.com/classnum/mnemosyne/master/corpora/data/tlg0012/tlg002/tlg0012.tlg002.perseus-grc2.xml",
  here("data", "corpus_test", "odyssey_perseus_mnemosyne.xml")
)

# Works with HTML as well (normalised as XHTML on import)
download_html(
  "https://classnum.hypotheses.org/credits",
  here("data", "corpus_test", "classnum_credits.html")
)
classnum_html <-
  read_html(here("data", "corpus_test/classnum_credits.html"))
html_structure(classnum_html)
xml_text(classnum_html)
xml_find_all(classnum_html, "//title")
xml_find_all(classnum_html, "//li")
write_xml(classnum_html, here("output", "classnum_credits.html"))
