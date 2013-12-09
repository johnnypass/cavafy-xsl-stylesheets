<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xsi:schemaLocation="http://www.pbcore.org/PBCore/PBCoreNamespace.html http://pbcore.org/xsd/pbcore-2.0.xsd"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:str="http://exslt.org/strings"
    extension-element-prefixes="str">
    <xsl:output encoding="UTF-8" method="xml" version="1.0" indent="yes"/>
	
    <xsl:template match="pbcoreDescriptionDocument">
        <pbcoreCollection>
		
            <xsl:attribute name="xmlns"
                >http://www.pbcore.org/PBCore/PBCoreNamespace.html</xsl:attribute>
            <xsl:for-each select="pbcoreRecord">
                <pbcoreDescriptionDocument>
                    <xsl:for-each select="pbcoreIdentifier">
                        <xsl:if test=".!='NULL'">
                            <xsl:copy-of select="."/>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:for-each select="pbcoreTitle">
                        <xsl:if test=".!='NULL'">
                            <pbcoreTitle>
                                <xsl:if test="@titleType!='NULL'">
                                    <xsl:attribute name="titleType">
                                        <xsl:value-of select="@titleType"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xsl:value-of select="."/>
                            </pbcoreTitle>
                        </xsl:if>
                    </xsl:for-each>

                    <xsl:for-each select="pbcoreInstantiation">
                        <pbcoreInstantiation>
					
                            <xsl:for-each select="instantiationIdentifier">
                                <xsl:if test=".!='NULL'">
                                    <xsl:copy-of select="."/>
                                </xsl:if>
                            </xsl:for-each>
							
                            <xsl:for-each select="instantiationDate">
                                <xsl:if test=".!='NULL'">
                                    <instantiationDate>
                                        <xsl:if test="@dateType!='NULL'">
                                            <xsl:attribute name="dateType">
                                                <xsl:value-of select="@dateType"/>
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="."/>
                                    </instantiationDate>
                                </xsl:if>
                            </xsl:for-each>
							
                            <xsl:copy-of select="instantiationDigital"/>
                            <xsl:copy-of select="instantiationLocation"/>
							<xsl:copy-of select="instantiationFileSize"/>
                            <xsl:copy-of select="instantiationMediaType"/>
                            <xsl:for-each select="instantiationGenerations">
                                <xsl:copy-of select="."/>
                            </xsl:for-each>
							
                            <xsl:if test="instantiationDuration!='NULL'">
                                <xsl:copy-of select="instantiationDuration"/>
                            </xsl:if>
							
							<xsl:copy-of select="instantiationChannelConfiguration"/>
							
                            <xsl:for-each select="instantiationAnnotation">
                                <xsl:if test=".!='NULL'">
                                    <xsl:copy-of select="."/>
                                </xsl:if>
                            </xsl:for-each>
                            <xsl:for-each select="instantiationAnnotation1">
                                <xsl:if test="string-length(.)>0">
                                    <instantiationAnnotation>
                                        <xsl:if test="@annotationType!='NULL'">
                                            <xsl:attribute name="annotationType">
                                                <xsl:value-of select="@annotationType"/>
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="."/>
                                    </instantiationAnnotation>
                                </xsl:if>
                            </xsl:for-each>
                            <xsl:for-each select="instantiationAnnotation2">
                                <xsl:if test="string-length(.)>0">
                                    <instantiationAnnotation>
                                        <xsl:if test="@annotationType!='NULL'">
                                            <xsl:attribute name="annotationType">
                                                <xsl:value-of select="@annotationType"/>
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="."/>
                                    </instantiationAnnotation>
                                </xsl:if>
                            </xsl:for-each>
                            <xsl:for-each select="instantiationAnnotation3">
                                <xsl:if test="string-length(.)>0">
                                    <instantiationAnnotation>
                                        <xsl:if test="@annotationType!='NULL'">
                                            <xsl:attribute name="annotationType">
                                                <xsl:value-of select="@annotationType"/>
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="."/>
                                    </instantiationAnnotation>
                                </xsl:if>
                            </xsl:for-each>
							<xsl:for-each select="instantiationAnnotation4">
                                <xsl:if test="string-length(.)>0">
                                    <instantiationAnnotation>
                                        <xsl:if test="@annotationType!='NULL'">
                                            <xsl:attribute name="annotationType">
                                                <xsl:value-of select="@annotationType"/>
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="."/>
                                    </instantiationAnnotation>
                                </xsl:if>
                            </xsl:for-each>
							<xsl:for-each select="instantiationAnnotation5">
                                <xsl:if test="string-length(.)>0">
                                    <instantiationAnnotation>
                                        <xsl:if test="@annotationType!='NULL'">
                                            <xsl:attribute name="annotationType">
                                                <xsl:value-of select="@annotationType"/>
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:value-of select="."/>
                                    </instantiationAnnotation>
                                </xsl:if>
                            </xsl:for-each>
							<xsl:for-each select="instantiationEssenceTrack">
								<instantiationEssenceTrack>
									<xsl:copy-of select="essenceTrackType"/>
									<xsl:copy-of select="essenceTrackStandard"/>
								    <xsl:copy-of select="essenceTrackDuration"/>
									<xsl:copy-of select="essenceTrackEncoding"/>
								    <xsl:copy-of select="essenceTrackBitDepth"/>
								    <xsl:for-each select="essenceTrackIdentifier1">
								        <xsl:if test="string-length(.)>0">
								            <essenceTrackIdentifier>
								                <xsl:if test="@source!='NULL'">
								                    <xsl:attribute name="source">
								                        <xsl:value-of select="@source"/>
								                    </xsl:attribute>
								                </xsl:if>
								                <xsl:value-of select="."/>
								            </essenceTrackIdentifier>
				
								        </xsl:if>
								    </xsl:for-each>
								    <xsl:for-each select="essenceTrackIdentifier2">
								        <xsl:if test="string-length(.)>0">
								            <essenceTrackIdentifier>
								                <xsl:if test="@source!='NULL'">
								                    <xsl:attribute name="source">
								                        <xsl:value-of select="@source"/>
								                    </xsl:attribute>
								                </xsl:if>
								                <xsl:value-of select="."/>
								            </essenceTrackIdentifier>
								        </xsl:if>
								    </xsl:for-each>
								    

								    <xsl:copy-of select="essenceTrackSamplingRate"/>
									

								</instantiationEssenceTrack>
							</xsl:for-each>	

                        </pbcoreInstantiation>
                    </xsl:for-each>
                </pbcoreDescriptionDocument>
            </xsl:for-each>
        </pbcoreCollection>
    </xsl:template>
    <xsl:template name="milliseconds_to_tc">
        <xsl:param name="mill"/>
        <xsl:variable name="hh" select="($mill div 3600000)"/>
        <xsl:variable name="rh" select="($mill mod 3600000)"/>
        <xsl:variable name="mm" select="($rh   div 60000)"/>
        <xsl:variable name="rm" select="($rh   mod 60000)"/>
        <xsl:variable name="ss" select="($rm   div 1000)"/>
        <xsl:variable name="rs" select="($rm   mod 1000)"/>
        <xsl:variable name="mmm" select="($rs   mod 1000)"/>
        <xsl:value-of select="format-number(floor($hh),'00')"/>
        <xsl:text>:</xsl:text>
        <xsl:value-of select="format-number(floor($mm),'00')"/>
        <xsl:text>:</xsl:text>
        <xsl:value-of select="format-number(floor($ss),'00')"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="format-number(floor($mmm),'000')"/>
    </xsl:template>
</xsl:stylesheet>
