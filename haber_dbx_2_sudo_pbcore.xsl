<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xsi:schemaLocation="http://www.pbcore.org/PBCore/PBCoreNamespace.html http://pbcore.org/xsd/pbcore-2.0.xsd"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:str="http://exslt.org/strings">
    <xsl:output encoding="UTF-8" method="xml" version="1.0" indent="yes"/>
    <xsl:template match="ENTRIES">
        <pbcoreCollection>
            <xsl:attribute name="xmlns"
                >http://www.pbcore.org/PBCore/PBCoreNamespace.html</xsl:attribute>
            <xsl:attribute name="xsi:schemaLocation"
                >http://www.pbcore.org/PBCore/PBCoreNamespace.html http://pbcore.org/xsd/pbcore-2.0.xsd</xsl:attribute>
            <xsl:for-each select="ENTRY">
                <pbcoreDescriptionDocument>
				
					<pbcoreIdentifier source="WNYC Archive Catalog">
					</pbcoreIdentifier>
					<pbcoreTitle titleType="Episode"></pbcoreTitle>
					<pbcoreTitle2 titleType="Series"></pbcoreTitle2>
					<pbcoreTitle3 titleType="Collection"></pbcoreTitle3>
					<pbcoreAssetDate dateType="broadcast"></pbcoreAssetDate>

					
					 <pbcoreDescription descriptionType="Abstract">
                     </pbcoreDescription>
					 
                    
                    <xsl:for-each select="MEDIUM/FILE[TYPE='Audio' and not(FILESIZE='-1')]">
                        <!-- just looking at audio files (DAVID uses filesize='-1' to indicate a virtual file -->
                        <pbcoreInstantiation>					                         
							<instantiationIdentifier2>
							<xsl:attribute name="source">DAVID TITLE</xsl:attribute>
                                            <xsl:value-of select="../../TITLE"/>
							</instantiationIdentifier2>
							<xsl:if test="string-length(UMID)>0">
                                <instantiationIdentifier>
                                    <xsl:attribute name="source">DAVID UMID</xsl:attribute>
                                    <xsl:value-of select="UMID"/>
                                </instantiationIdentifier>
                            </xsl:if>
                           
                            <!--  
                            <xsl:if test="string-length(../../USA/WNYC/IDSOURCE)>0">
                                <instantiationIdentifier>
                                    <xsl:attribute name="source">National Archives</xsl:attribute>
                                    <xsl:value-of select="../../USA/WNYC/IDSOURCE"/>
                                </instantiationIdentifier>
                                </xsl:if>-->

                            <xsl:if test="string-length(../../TIMESTAMP)>0">
                                <instantiationDate>
                                    <xsl:attribute name="dateType">Timestamp</xsl:attribute>
                                    <xsl:value-of select="../../TIMESTAMP"/>
                                </instantiationDate>
                            </xsl:if>
                            <xsl:choose>
                                <xsl:when
                                    test="string(../../AUDIOFORMAT)='Wave,BWF,RIFF' or 'Wave,MTEProject,DavidProject,RIFF' or 'Wave,RIFF'">
                                    <instantiationDigital>
                                        <xsl:text>audio/x-wav</xsl:text>
                                    </instantiationDigital>
                                </xsl:when>
                                <xsl:when test="string(../../AUDIOFORMAT)='Wave,BWF,RIFF'">
                                    <instantiationStandard>
                                        <xsl:attribute name="source">EBU</xsl:attribute>
                                        <xsl:attribute name="ref"
                                            >http://tech.ebu.ch/docs/tech/tech3285.pdf</xsl:attribute>
                                        <xsl:text>BWF</xsl:text>
                                    </instantiationStandard>
                                </xsl:when>
                                <xsl:when
                                    test="string(../../AUDIOFORMAT)='Wave,MTEProject,DavidProject,RIFF' or 'Wave,RIFF'">
                                    <instantiationStandard>
                                        <xsl:attribute name="source">DAVID AUDIOFORMAT</xsl:attribute>
                                        <xsl:text>WAVE</xsl:text>
                                    </instantiationStandard>
                                </xsl:when>
                            </xsl:choose>
                            <xsl:if test="string-length(FILEREF)>0">
                                <instantiationLocation>
                                    <xsl:value-of select="FILEREF"/>
                                </instantiationLocation>
                            </xsl:if>
                            <instantiationMediaType>Sound</instantiationMediaType>
                            <xsl:if test="string-length(../../DURATION)">
                                <instantiationDuration>
                                    <xsl:call-template name="milliseconds_to_tc">
                                        <xsl:with-param name="mill"
                                            select="number(../../DURATION)"/>
                                    </xsl:call-template>
                                </instantiationDuration>
                            </xsl:if>
                            <xsl:if test="string-length(../../AUDIOMODE)>0">
                                <instantiationChannelConfiguration>
                                    <xsl:value-of select="../../AUDIOMODE"/>
                                </instantiationChannelConfiguration>
                            </xsl:if>
                            <xsl:if test="string-length(LANGUAGE)>0">
                                <instantiationlanguage>
                                    <xsl:value-of select="LANGUAGE"/>
                                </instantiationlanguage>
                            </xsl:if>
							    <instantiationEssenceTrack>
                                <essenceTrackType>Audio</essenceTrackType>
                                <xsl:if test="string-length(../../FILENAME)>0">
                                    <xsl:if test="string-length(../../TITLE)>0">
                                        <essenceTrackIdentifier>
                                            <xsl:attribute name="source">DAVID TITLE</xsl:attribute>
                                            <xsl:value-of select="../../TITLE"/>
                                        </essenceTrackIdentifier>
                                    </xsl:if>
                                    <essenceTrackIdentifier2>
                                        <xsl:attribute name="source"
                                            >NYPR DAVID FILENAME</xsl:attribute>
                                        <xsl:value-of select="../../FILENAME"/>
                                    </essenceTrackIdentifier2>
                                </xsl:if>
                                <xsl:if test="FORMAT">
                                    <essenceTrackEncoding>
                                        <xsl:value-of select="FORMAT"/>
                                    </essenceTrackEncoding>
                                </xsl:if>
                                <xsl:if test="string-length(../../SAMPLERATE)>0">
                                    <essenceTrackSamplingRate>
                                        <xsl:attribute name="unitsOfMeasure">Hz</xsl:attribute>
                                        <xsl:value-of select="../../SAMPLERATE"/>
                                    </essenceTrackSamplingRate>
                                </xsl:if>
                            </instantiationEssenceTrack>
							<xsl:if test="string-length(../../REMARK)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">DAVID REMARK</xsl:attribute>
                                    <xsl:value-of select="../../REMARK"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../AUTHOR)>0">
                                <instantiationAnnotation2>
                                    <xsl:attribute name="annotationType"
                                        >DAVID AUTHOR</xsl:attribute>
                                    <xsl:value-of select="../../AUTHOR"/>
                                </instantiationAnnotation2>
                            </xsl:if>
                            


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
