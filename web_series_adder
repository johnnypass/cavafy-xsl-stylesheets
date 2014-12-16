<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="pbcoreTitle[@titleType='Collection']">
        <pbcoreTitle>
            <xsl:attribute name="titleType">web_series</xsl:attribute>
            <xsl:text>Archives and Preservation</xsl:text>
        </pbcoreTitle>
        <xsl:choose>
            <xsl:when test="string(../pbcoreTitle[@titleType='Collection'])='MUNI'">              
            <pbcoreTitle>
                    <xsl:attribute name="titleType">web_series</xsl:attribute>
                    <xsl:text>Municipal Collection</xsl:text>
                </pbcoreTitle>
            </xsl:when>
        </xsl:choose>     
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
