<?xml version="1.1" encoding="UTF-8"?>
<!--This script grabs URLs from a list and outputs full xml-->


<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:et="http://ns.exiftool.ca/1.0/"
    et:toolkit="Image::ExifTool 9.46" xmlns:ExifTool="http://ns.exiftool.ca/ExifTool/1.0/"
    xmlns:System="http://ns.exiftool.ca/File/System/1.0/"
    xmlns:File="http://ns.exiftool.ca/File/1.0/" xmlns:RIFF="http://ns.exiftool.ca/RIFF/RIFF/1.0/"
    xmlns:XMP-x="http://ns.exiftool.ca/XMP/XMP-x/1.0/"
    xmlns:XMP-xmp="http://ns.exiftool.ca/XMP/XMP-xmp/1.0/"
    xmlns:XMP-xmpDM="http://ns.exiftool.ca/XMP/XMP-xmpDM/1.0/"
    xmlns:XMP-xmpMM="http://ns.exiftool.ca/XMP/XMP-xmpMM/1.0/"
    xmlns:XMP-dc="http://ns.exiftool.ca/XMP/XMP-dc/1.0/"
    xmlns:XMP-WNYCSchema="http://ns.exiftool.ca/XMP/XMP-WNYCSchema/1.0/"
    xmlns:Composite="http://ns.exiftool.ca/Composite/1.0/"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    xmlns:XMP-exif="http://ns.exiftool.ca/XMP/XMP-exif/1.0/" xmlns:lc="http://www.loc.gov/"
    xmlns="http://purl.org/dc/elements/1.1/"
    exclude-result-prefixes="xsi rdf et ExifTool System File RIFF XMP-x XMP-xmp XMP-xmpDM XMP-xmpMM XMP-dc XMP-WNYCSchema Composite xi XMP-dc XMP-exif lc">





    <!--Gives line breaks etc-->
    <xsl:output encoding="UTF-8" method="text" version="1.0" standalone="no" indent="yes"/>

    <!--Output definitions -->

    <xsl:template match="neh2015xmls">
        <pbcorexmls>
            <xsl:apply-templates select="record"/>
        </pbcorexmls>
    </xsl:template>




    <xsl:template match="record">
        <pbcorexml>
        <xsl:value-of select="string(.)"/>
        </pbcorexml>
    </xsl:template>
</xsl:stylesheet>
