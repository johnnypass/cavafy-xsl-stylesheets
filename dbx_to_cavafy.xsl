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

                    <xsl:for-each select="MEDIUM/FILE[TYPE='Audio' and not(FILESIZE='-1')]">
                        <!-- just looking at audio files (DAVID uses filesize='-1' to indicate a virtual file -->
                        <pbcoreInstantiation>
                            <xsl:if test="string-length(UMID)>0">
                                <instantiationIdentifier>
                                    <xsl:attribute name="source">NYPR DAVID UMID</xsl:attribute>
                                    <xsl:value-of select="UMID"/>
                                </instantiationIdentifier>
                            </xsl:if>
                            <xsl:if test="string-length(../../FOREIGNMOTIVE)>0">
                                <instantiationIdentifier>
                                    <xsl:attribute name="source">NYPR DAVID RUNNING NUMBER</xsl:attribute>
                                    <xsl:value-of select="../../FOREIGNMOTIVE"/>
                                </instantiationIdentifier>
                            </xsl:if>
                            <!--  
                            <xsl:if test="string-length(../../USA/WNYC/IDSOURCE)>0">
                                <instantiationIdentifier>
                                    <xsl:attribute name="source">National Archives</xsl:attribute>
                                    <xsl:value-of select="../../USA/WNYC/IDSOURCE"/>
                                </instantiationIdentifier>
                                </xsl:if>-->
                            <xsl:if test="string-length(../../BROADCASTDATE)>0">
                                <instantiationDate>
                                    <xsl:attribute name="dateType">Broadcast</xsl:attribute>
                                    <xsl:value-of select="../../BROADCASTDATE"/>
                                </instantiationDate>
                            </xsl:if>
                            <xsl:if test="string-length(CREATEDATE)>0">
                                <instantiationDate>
                                    <xsl:attribute name="dateType">Created</xsl:attribute>
                                    <xsl:value-of select="CREATEDATE"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="CREATETIME"/>
                                </instantiationDate>
                            </xsl:if>
                            <xsl:if test="string-length(../../CHANGEDATE)>0">
                                <instantiationDate>
                                    <xsl:attribute name="dateType">Revised</xsl:attribute>
                                    <xsl:value-of select="../../CHANGEDATE"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="../../CHANGETIME"/>
                                </instantiationDate>
                            </xsl:if>
                            <xsl:if test="string-length(../../RECORDDATE)>0">
                                <instantiationDate>
                                    <xsl:attribute name="dateType">Recorded</xsl:attribute>
                                    <xsl:value-of select="../../RECORDDATE"/>
                                </instantiationDate>
                            </xsl:if>
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
                                        <xsl:attribute name="source">NYPR DAVID AUDIOFORMAT</xsl:attribute>
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
                            <xsl:if test="not(FILESIZE='-1') and string-length(FILESIZE)>0">
                                <instantiationFileSize>
                                    <xsl:attribute name="unitsOfMeasure">bytes</xsl:attribute>
                                    <xsl:value-of select="FILESIZE"/>
                                </instantiationFileSize>
                            </xsl:if>
                            <xsl:if test="string-length(STARTTIMECODE)>0">
                                <instantiationTimeStart>
                                    <xsl:value-of select="STARTTIMECODE"/>
                                </instantiationTimeStart>
                            </xsl:if>
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
                                            <xsl:attribute name="source">NYPR DAVID TITLE</xsl:attribute>
                                            <xsl:value-of select="../../TITLE"/>
                                        </essenceTrackIdentifier>
                                    </xsl:if>
                                    <essenceTrackIdentifier>
                                        <xsl:attribute name="source"
                                            >NYPR DAVID FILENAME</xsl:attribute>
                                        <xsl:value-of select="../../FILENAME"/>
                                    </essenceTrackIdentifier>
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
                            <xsl:if test="string-length(../../BROADCAST)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID BROADCAST</xsl:attribute>
                                    <xsl:value-of select="../../BROADCAST"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../USA/WNYC/BEAT)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID BEAT</xsl:attribute>
                                    <xsl:value-of select="../USA/WNYC/BEAT"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../KEYWORDS)>0">
                                <xsl:for-each select="str:tokenize(../../KEYWORDS, ',')">
                                    <instantiationAnnotation>
                                        <xsl:attribute name="annotationType">NYPR DAVID KEYWORDS</xsl:attribute>
                                        <xsl:value-of select="normalize-space(.)"/>
                                    </instantiationAnnotation>
                                </xsl:for-each>
                            </xsl:if>
                            <xsl:if test="string-length(../../REMARK)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID REMARK</xsl:attribute>
                                    <xsl:value-of select="../../REMARK"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../FIRSTWORDS)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID FIRSTWORDS</xsl:attribute>
                                    <xsl:value-of select="../../FIRSTWORDS"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../LASTWORDS)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID FIRSTWORDS</xsl:attribute>
                                    <xsl:value-of select="../../LASTWORDS"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../SUBJECT)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID SUBJECT</xsl:attribute>
                                    <xsl:value-of select="../../SUBJECT"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../TYPEDETAIL)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID TYPEDETAIL</xsl:attribute>
                                    <xsl:value-of select="../../TYPEDETAIL"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../PERFORMER)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID PERFORMER</xsl:attribute> 
                                    <xsl:value-of select="../../PERFORMER"/>                                   
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../SPEAKER)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID SPEAKER</xsl:attribute>
                                        <xsl:value-of select="../../SPEAKER"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../AUTHOR)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType"
                                        >NYPR DAVID AUTHOR</xsl:attribute>
                                    <xsl:value-of select="../../AUTHOR"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../EDITOR)">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType"
                                        >NYPR DAVID EDITOR</xsl:attribute>
                                    <xsl:value-of select="../../EDITOR"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../PROGRAM)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType"
                                        >NYPR DAVID BROADCASTSTREAM</xsl:attribute>
                                    <xsl:value-of select="../../PROGRAM"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../BROADCASTINGS)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType"
                                        >NYPR DAVID BROADCASTINGS</xsl:attribute>
                                    <xsl:value-of select="../../BROADCASTINGS"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../DELETEDATE)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID DELETEDATE</xsl:attribute>
                                    <xsl:value-of select="../../DELETEDATE"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../FIRSTUSEDATE)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType"
                                        >NYPR DAVID FIRSTUSEDATE</xsl:attribute>
                                    <xsl:value-of select="../../FIRSTUSEDATE"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../FIRSTUSETIME)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType"
                                        >NYPR DAVID FIRSTUSETIME</xsl:attribute>
                                    <xsl:value-of select="../../FIRSTUSETIME"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(FLAGS)">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID FLAGS</xsl:attribute>>
                                        <xsl:value-of select="FLAGS"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../GENERATOR)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID GENERATOR</xsl:attribute>
                                    <xsl:value-of select="../../GENERATOR"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../CONVERTANDSEND/HISTORY)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID HISTORY</xsl:attribute>
                                    <xsl:value-of select="../../CONVERTANDSEND/HISTORY"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../LASTUSEDATE)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID LASTUSEDATE</xsl:attribute>
                                    <xsl:value-of select="../../LASTUSEDATE"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../LOWRESEXISTS)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType"
                                        >NYPR DAVID LOWRESEXISTS</xsl:attribute>
                                    <xsl:value-of select="../../LOWRESEXISTS"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../MOTIVE)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID MOTIVE</xsl:attribute>
                                    <xsl:value-of select="../../MOTIVE"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../MUSICID)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID MUSICID</xsl:attribute>
                                    <xsl:value-of select="../../MUSICID"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../NUMBER)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID NUMBER</xsl:attribute>
                                    <xsl:value-of select="../../NUMBER"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(REFNR)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID REFNR</xsl:attribute>
                                    <xsl:value-of select="REFNR"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(REFNRMAIN)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID REFNRMAIN</xsl:attribute>
                                    <xsl:value-of select="REFNRMAIN"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(REFNRMEDIUM)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID REFNRMEDUIM</xsl:attribute>
                                    <xsl:value-of select="REFNRMEDIUM"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../TEXTFILE)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID TEXTFILE</xsl:attribute>
                                    <xsl:value-of select="../../TEXTFILE"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(TRACK)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID TRACK</xsl:attribute>
                                    <xsl:value-of select="TRACK"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../FILENAME2)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID FILENAME2</xsl:attribute>
                                    <xsl:value-of select="../../FILENAME2"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../CREATOR)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID CREATOR</xsl:attribute>
                                    <xsl:value-of select="../../CREATOR"/>
                                </instantiationAnnotation>
                            </xsl:if>
                            <xsl:if test="string-length(../../CHANGEUSER)>0">
                                <instantiationAnnotation>
                                    <xsl:attribute name="annotationType">NYPR DAVID CHANGEUSER</xsl:attribute>
                                    <xsl:value-of select="../../CHANGEUSER"/>
                                </instantiationAnnotation>
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
