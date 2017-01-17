<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.pbcore.org/PBCore/PBCoreNamespace.html"
    xsi:schemaLocation="http://www.pbcore.org/PBCore/PBCoreNamespace.html http://pbcore.org/xsd/pbcore-2.0.xsd"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    
    <!-- Gives line breaks etc -->
    <xsl:output encoding="UTF-8" method="xml" version="1.0" standalone="yes" indent="yes"/>
    
    <!--Output definitions -->
    <xsl:template match="pbcoreCollection">
        <pbcoreCollection>
            
            <xsl:apply-templates select="pbcoreDescriptionDocument"/>
            
        </pbcoreCollection>
    </xsl:template>
    
    <xsl:template match="pbcoreDescriptionDocument">
        <pbcoreDescriptionDocument>
        <pbcoreIdentifier>
            <xsl:attribute name="source">WNYC Archive Catalog</xsl:attribute>
            <xsl:value-of select="wnyc_archive_catalog"/>
        </pbcoreIdentifier>
        <pbcoreTitle>
            <xsl:attribute name="titleType">Collection</xsl:attribute>
            <xsl:value-of select="collection_title"/>
        </pbcoreTitle>
            <pbcoreAnnotation annotationType="CMS Image"><xsl:value-of select="cms_image"/></pbcoreAnnotation>
        </pbcoreDescriptionDocument>
    </xsl:template>
</xsl:stylesheet>
