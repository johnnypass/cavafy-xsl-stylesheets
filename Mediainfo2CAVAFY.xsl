<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:mt="http://www.iana.org/assignments/media-types/" xmlns:la="http://www.loc.gov/standards/iso639-2/" xmlns:str="http://exslt.org/strings" extension-element-prefixes="str" xmlns="http://www.pbcore.org/PBCore/PBCoreNamespace.html" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
<xsl:output encoding="UTF-8" method="xml" version="1.0" indent="yes"/>

<!--
Title: mediainfo2pbcoreinstantiation.xsl
Version: 0.4
Based on Mediainfo version 0.7.38
Based on PBCore version 2.0RC1

	 2010 AudioVisual Preservation Solutions
	Created to transform XML output of MediaInfo (http://mediainfo.sourceforge.net by MediaArea, SARL) to an instantiation element of a PBCore 1.2.1 record (http://www.pbcore.org). The translation expects that MediaInfo be operated with the '-f', '__Language=Raw', and '__Output=XML' options (change double-underscores to double-hyphens). The translation is customized for mediainfo version 0.7.27 and may provide unexpected results with any other version of mediainfo.
		
	Updated for use with the Secure Media Network of the Dance Heritage Coalition, September 2009 and January 2011.

	This work employs PBCore. The PBCore (Public Broadcasting Metadata Dictionary) was created by the public broadcasting community in the United States of America for use by public broadcasters and others. Initial development funding for PBCore was provided by the Corporation for Public Broadcasting. The PBCore is built on the foundation of the Dublin Core (ISO 15836), an international standard for resource discovery (http://dublincore.org), and has been reviewed by the Dublin Core Metadata Initiative Usage Board. Copyright: 2005, Corporation for Public Broadcasting. 

Versions:

0.1.1 initial release
0.2   added fileextension to instantiationIdentifier where instantiationIdentifierSource is 'File Name'
	  updated from MediaInfo 0.7.27 to 0.7.32, see http://mediainfo.sourceforge.net/Log
		- this update allows the removal of the iso 639-1 to 639-2 lookup table

		
		Example use:
		
		a. generate mediainfo.xml (change double-underscore to double-hyphen)
		
		   mediainfo -f __Language=raw __Output=XML file.mov > mediainfo.xml
		
		b. use mediainfo_2_pbcore_inst.xsl to transform mediainfo.xml to pbcore.xml
		
		   xsltproc mediainfo2pbcoreinstantiation.xsl mediainfo.xml > pbcore.xml
		   
		Or as one line:
		
		   mediainfo __Language=raw -f __Output=XML file.mov > mediainfo.xml && xsltproc mediainfo2pbcoreinstantiation.xsl mediainfo.xml > pbcore.xml
-->
	<xsl:template match="Mediainfo">
		<xsl:variable name="mediainfoSource">MediaInfoLib</xsl:variable>
		<xsl:variable name="mediainfoVersion"><xsl:value-of select="@version"/></xsl:variable>
		<pbcoreCollection>
			   		<xsl:for-each select="File">
			   			<pbcoreDescriptionDocument>
			   				<!-- pbcoreTitle/pbcoreTitleType -->
			   				<pbcoreTitle titleType="Collection">WNYC</pbcoreTitle>
			   				<!-- pbcoreIdentifier/pbcoreIdentifierSource -->
			   				<xsl:for-each select="track[@type='General']">
			   				<xsl:if test="FileName">
			   					<pbcoreIdentifier>
			   						<xsl:attribute name="source">WNYC Archive Catalog</xsl:attribute>
			   						<xsl:value-of select="substring(FileName,22,5)"/>
			   					</pbcoreIdentifier>
			   				</xsl:if>
			   				</xsl:for-each>
			   		<pbcoreInstantiation>
					   		<xsl:apply-templates select="."/>
			   		</pbcoreInstantiation>
			   			</pbcoreDescriptionDocument>
			   		</xsl:for-each>	
		</pbcoreCollection>
	</xsl:template>
	<xsl:template match="File">
		<xsl:variable name="mediainfoSource">MediaInfoLib</xsl:variable>
		<xsl:variable name="mediainfoVersion"><xsl:value-of select="../@version"/></xsl:variable>
			<xsl:comment> generated by mediainfo2pbcoreinstantiation.xsl ; version 0.1.2 ; based on MediaInfoLib - v0.7.37; www.avpreserve.com </xsl:comment>			
			<xsl:for-each select="track[@type='General']">
			
				
			

				<!-- instantiationIdentifier/instantiationIdentifierSource -->

				<xsl:if test="FileName">
					
					<instantiationIdentifier>
						<xsl:attribute name="source">David Title</xsl:attribute>
						<xsl:value-of select="FileName"/>
					</instantiationIdentifier>
						
				</xsl:if>
				
				<xsl:for-each select="str:tokenize(Media_UUID, '/')"><!-- this matches on the 'uuid' element in Final Cut XML Interchange Format-->
					<instantiationIdentifier>
						<xsl:attribute name="source">com.apple.finalcutstudio.media.uuid</xsl:attribute>
						<xsl:value-of select="normalize-space(.)"/>
					</instantiationIdentifier>
					
				</xsl:for-each>
				
				<!-- dates -->
				<xsl:if test="File_Created_Date">
					<instantiationDate>
						<xsl:attribute name="dateType">Created</xsl:attribute>
						<xsl:value-of select="substring(File_Created_Date,5,10)"/>
					</instantiationDate>
				</xsl:if>
				
				<xsl:if test="FileName">
					<instantiationDate>
						<xsl:attribute name="dateType">Broadcast</xsl:attribute>
						<xsl:value-of select="substring(FileName,11,10)"/>
					</instantiationDate>
				</xsl:if>
				
				<!-- formatPhysical: is this applicable in a mapping from a digital file analysis? -->
				<!-- formatDigital -->
				<xsl:if test="InternetMediaType">
					<instantiationDigital><xsl:text>BWF</xsl:text>
					</instantiationDigital>
				</xsl:if>
				<!-- formatStandard -->
				<xsl:if test="Format">
					<instantiationStandard>
   						<xsl:attribute name="profile"><xsl:value-of select="Format"/></xsl:attribute>
   						<xsl:attribute name="source"><xsl:value-of select="$mediainfoSource"/></xsl:attribute>
						<xsl:attribute name="version"><xsl:value-of select="$mediainfoVersion"/></xsl:attribute>
						<xsl:value-of select="Format"/>
					</instantiationStandard>
				</xsl:if>
				<!-- formatLocation -->
				<instantiationLocation>DAVID</instantiationLocation>
				<!-- formatMediaType -->
				<xsl:if test="string-length(VideoCount)>0 or string-length(AudioCount)>0 or string-length(ImageCount)>0 or string-length(TextCount)>0">
   					<instantiationMediaType>
	   					<xsl:attribute name="source">PBCore</xsl:attribute>
	   					<xsl:attribute name="version">1.1</xsl:attribute>
	   					<xsl:choose><!-- attempts to make a guess at formatMediaType. There is no method to clarify if a file is 'Animation' vs 'Moving Image', 'Presentation' vs 'Text', etc. Only these four mediaTypes are tested for now. -->
	   						<xsl:when test="VideoCount > 0">Moving Image</xsl:when>
	   						<xsl:when test="AudioCount > 0">Sound</xsl:when>
	   						<xsl:when test="ImageCount > 0">Static Image</xsl:when>
	   						<xsl:when test="TextCount  > 0">Text</xsl:when>
	   					</xsl:choose>
   					</instantiationMediaType>
   				</xsl:if>
				
				<!-- formatGenerations -->
				<xsl:if test="Format">
					<instantiationGenerations><xsl:text>Master: Preservation</xsl:text>
					</instantiationGenerations>
				</xsl:if>
				
				<!-- formatFileSize -->
				<xsl:if test="FileSize_String"><!-- this expresses filesize as an integer count of Megabytes -->
					<instantiationFileSize_String>
						<xsl:attribute name="unitsOfMeasure">MiB</xsl:attribute>
						<xsl:value-of select="normalize-space(FileSize_String)"/>
   					</instantiationFileSize_String>
				</xsl:if>
				
				<!-- formatTimeStart -->
				<xsl:choose>
					<xsl:when test="Delay_Original_String3"><instantiationTimeStart><xsl:value-of select="Delay_Original_String3"/></instantiationTimeStart></xsl:when>
					<xsl:when test="Delay_String3"><instantiationTimeStart><xsl:value-of select="Delay_String3"/></instantiationTimeStart></xsl:when>
				</xsl:choose>
				<!-- formatDuration -->
				<xsl:if test="Duration_String3"><!-- expresses duration as HH:MM:SS -->
					<instantiationDuration>
						<xsl:value-of select="substring(Duration_String3,1,8)"/>
					</instantiationDuration>
				</xsl:if>
				<!-- formatDataRate -->
				<xsl:if test="OverallBitRate"><!-- expresses bitrate as bits per second -->
					<instantiationDataRate>
   						<xsl:attribute name="unitsOfMeasure">bits/second</xsl:attribute>
   						<xsl:value-of select="OverallBitRate"/>
					</instantiationDataRate>
				</xsl:if>
				 	<!-- formatColors: undetermined, this value is about how the video color is presented, not stored -->			
				<!-- formatTracks -->
				<xsl:variable name='track'>
   					<xsl:if test="VideoCount">
	 						<xsl:value-of select="VideoCount"/><xsl:text> video track</xsl:text><xsl:if test="not(VideoCount='1')">s</xsl:if><xsl:text>, </xsl:text>
					</xsl:if>
					<xsl:if test="AudioCount">
	 						<xsl:value-of select="AudioCount"/><xsl:text> audio track</xsl:text><xsl:if test="not(AudioCount='1')">s</xsl:if><xsl:text>, </xsl:text>
					</xsl:if>
					<xsl:if test="TextCount">
	 						<xsl:value-of select="TextCount"/><xsl:text> text track</xsl:text><xsl:if test="not(TextCount='1')">s</xsl:if><xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:variable>
				<instantiationTracks>
					<xsl:value-of select="substring($track,1,string-length($track)-2)"/>
				</instantiationTracks>				
				
				<!-- formatChannelConfiguration -->
				<xsl:if test="AudioCount>0"><!-- results aren't very interesting without audio configuration data -->
					<xsl:variable name='fCC_audio'>
						<xsl:for-each select="../track[@type='Audio']"><xsl:value-of select="Channel_s_"/><xsl:if test='ChannelPositions'><xsl:text> (</xsl:text><xsl:value-of select="ChannelPositions"/><xsl:text>)</xsl:text></xsl:if><xsl:text>, </xsl:text></xsl:for-each>
					</xsl:variable>
					<xsl:variable name='fCC_text'>
						<xsl:for-each select="../track[@type='Text']"><xsl:value-of select="Format"/><xsl:if test='string-length(Language_String3)=3'><xsl:text> (</xsl:text><xsl:value-of select="Language_String3"/><xsl:text>)</xsl:text></xsl:if><xsl:text>, </xsl:text></xsl:for-each>
					</xsl:variable>
					<xsl:variable name='formatChannelConfigurations'>
						<xsl:if test="Video_Format_WithHint_List"><xsl:value-of select="Video_Format_WithHint_List"/> with </xsl:if>
						<xsl:if test="Audio_Format_WithHint_List">
							<xsl:value-of select="substring($fCC_audio,1,string-length($fCC_audio)-2)"/><xsl:text> with </xsl:text>
						</xsl:if>
						<xsl:if test="Text_Format_WithHint_List">
							<xsl:value-of select="substring($fCC_text,1,string-length($fCC_text)-2)"/><xsl:text> with </xsl:text>
						</xsl:if>
						<xsl:if test="Image_Format_WithHint_List"><xsl:value-of select="Image_Format_WithHint_List"/> with </xsl:if>
						<xsl:if test="Menu_Format_WithHint_List"><xsl:value-of select="Menu_Format_WithHint_List"/> with </xsl:if>
					</xsl:variable>
					<instantiationChannelConfiguration>
						<xsl:value-of select="substring($formatChannelConfigurations,1,string-length($formatChannelConfigurations)-6)"/>
					</instantiationChannelConfiguration>
				</xsl:if>
				
				<!-- language -->
   				<xsl:if test="string-length(Language_String3)=3">
   					<instantiationLanguage>
   						<xsl:value-of select="Language_String3"/>
   					</instantiationLanguage>
   				</xsl:if>
   				<!-- alternativeModes: nothing inferred here yet -->
   				<!-- essenceTrack -->
			</xsl:for-each>
   				<xsl:for-each select="track[@type!='General']">
   				  <instantiationEssenceTrack>
   					<!-- essenceTrackType -->
   					<essenceTrackType>
	   					<xsl:choose><!-- some translation of reported trackType, else reported as is -->
	   						<xsl:when test="Format='TimeCode'">timecode</xsl:when>
	   						<xsl:when test="Format='EIA-608' or Format='EIA-708'">caption</xsl:when>
	   						<xsl:when test="../track[@type='Text']/Format='Apple text|ASS|DivX Subtitle|DVB Subtitles|PGS|SSA|Teletext|Text|Subrip|SubRip|Timed text|USF|VobSub'">subtitle</xsl:when>
	   						<xsl:when test="Format='CMML'">metadata</xsl:when>
	   						<xsl:when test="Format='Audio'">audio</xsl:when>
	   						<xsl:when test="Format='Video'">video</xsl:when>
	   						<xsl:otherwise><xsl:value-of select="@type"/></xsl:otherwise>
	   					</xsl:choose>
   					</essenceTrackType>
   					<!-- essenceTrackIdentifier/essenceTrackIdentifierSource -->
   				  	<essenceTrackIdentifier>
   				  		<xsl:attribute name="source">DAVID Title</xsl:attribute>
   				  			<xsl:for-each select="../track[@type='General']">
   				  				<xsl:value-of select="FileName"/>
   				  			</xsl:for-each>
   				  	</essenceTrackIdentifier>
   				   	<!-- essenceTrackStandard -->
   					<xsl:if test="Codec">
   						<essenceTrackStandard><xsl:value-of select="Codec"/></essenceTrackStandard>
   					</xsl:if>
   					<!-- essenceTrackEncoding -->
   					<xsl:if test="Format"><!-- not sure how best to handle encoding, feel free to remove the extra xsl:if statements to reduce verbosity -->
   						<xsl:variable name="encoding">
	   						<xsl:if test="Format_Version">
	   							<xsl:value-of select="Format_Version"/>
	   						</xsl:if>
	   						<xsl:if test="Format_Commercial_IfAny">
	   							<xsl:text> </xsl:text><xsl:value-of select="Format_Commercial_IfAny"/>
	   						</xsl:if>
	   						<xsl:if test="Format_Profile">
	   							<xsl:text> </xsl:text><xsl:value-of select="Format_Profile"/>
	   						</xsl:if>
	   						<xsl:if test="Format_Settings_Endianness">
	   							<xsl:text> </xsl:text><xsl:value-of select="Format_Settings_Endianness"/><xsl:text>-endian</xsl:text>
	   						</xsl:if>
	   						<xsl:if test="Format_Settings_Sign">
	   							<xsl:text> </xsl:text><xsl:value-of select="Format_Settings_Sign"/>
	   						</xsl:if>
   						</xsl:variable>
   						<essenceTrackEncoding><xsl:text>Captured from MFDigital Ripstation</xsl:text>
   						</essenceTrackEncoding>
   					</xsl:if>
   					<!-- essenceTrackDataRate -->
   					<xsl:if test="BitRate">
   						<essenceTrackDataRate>
	   						<xsl:attribute name="unitsOfMeasure">bits/second</xsl:attribute>
	   						<xsl:attribute name="annotation"><xsl:value-of select="BitRate_Mode"/></xsl:attribute>
	   						<xsl:value-of select="BitRate"/>
	  						</essenceTrackDataRate>
   					</xsl:if>
   					<!-- essenceTrackFrameRate -->
	 				<xsl:if test="FrameRate">
		  				<essenceTrackFrameRate>
			  				<xsl:if test="FrameRate_Original">
				  				<xsl:attribute name="annotation">
					  				<xsl:text>Frame rate of codec:</xsl:text><xsl:value-of select="FrameRate_Original"/><xsl:text> fps</xsl:text>
				 				</xsl:attribute>
			  				</xsl:if>
			  				<xsl:value-of select="FrameRate"/><xsl:text> fps</xsl:text>
		  				</essenceTrackFrameRate>
	 				</xsl:if>
	 				<!-- essenceTrackSamplingRate -->
   					<xsl:if test="SamplingRate">
   						<essenceTrackSamplingRate><xsl:value-of select="SamplingRate div 1000"/><xsl:text> kHz</xsl:text></essenceTrackSamplingRate>
   					</xsl:if>
   					<!-- essenceTrackBitDepth -->
   					<xsl:if test="BitDepth">
   						<essenceTrackBitDepth><xsl:value-of select="BitDepth"/><xsl:text> bit</xsl:text></essenceTrackBitDepth>
   					</xsl:if>
   					<!-- essenceTrackFrameSize -->
   					<xsl:if test="Width">
   						<essenceTrackFrameSize>
   						<xsl:choose>
		  						<xsl:when test="Width_Original">
									<xsl:value-of select="Width_Original"/>
	   						</xsl:when>
	   						<xsl:otherwise>
			  						<xsl:value-of select="Width"/>
	   						</xsl:otherwise>
   						</xsl:choose>
   						<xsl:text>x</xsl:text>
		  					<xsl:choose>
		  						<xsl:when test="Height_Original">
									<xsl:value-of select="Height_Original"/>
	   						</xsl:when>
	   						<xsl:otherwise>
			  						<xsl:value-of select="Height"/>
	   						</xsl:otherwise>
   						</xsl:choose>
   						</essenceTrackFrameSize>
   					</xsl:if>
   					<!-- essenceTrackAspectRatio: as displayed not stored -->
   					<xsl:if test="DisplayAspectRatio_String">
   						<essenceTrackAspectRatio><xsl:value-of select="DisplayAspectRatio_String"/></essenceTrackAspectRatio>
   					</xsl:if>
   					<!-- essenceTrackTimeStart -->
   					<xsl:choose>
   						<xsl:when test="Delay_Original_String3">
   							<essenceTrackTimeStart><xsl:value-of select="Delay_Original_String3"/></essenceTrackTimeStart>
   						</xsl:when>
   						<xsl:when test="Delay_String3">
   							<essenceTrackTimeStart><xsl:value-of select="Delay_String3"/></essenceTrackTimeStart>
   						</xsl:when>
   					</xsl:choose>
   					<!-- essenceTrackDuration -->
   					<xsl:if test="Duration_String3">
   						<essenceTrackDuration><xsl:value-of select="Duration_String3"/></essenceTrackDuration>
   					</xsl:if>
   					
   					<!-- essenceTrackLanguage -->
   					<xsl:if test="string-length(Language_String3)=3">
   						<essenceTrackLanguage>
   							<xsl:value-of select="Language_String3"/>
   						</essenceTrackLanguage>
   					</xsl:if>
   					<!-- essenceTrackAnnotation -->
	 					<!-- the following potential annotations from MediaInfo are renamed for PBCore -->
	 					<xsl:if test="Channel_s_">
	 						<essenceTrackAnnotation>
		 						<xsl:attribute name="annotationType">Channels</xsl:attribute>
		 						<xsl:value-of select="Channel_s_"/>
								</essenceTrackAnnotation>
	 					</xsl:if>
	 					<xsl:if test="Bits-_Pixel_Frame_">
	 						<essenceTrackAnnotation>
		 						<xsl:attribute name="annotationType">BitsPerPixel</xsl:attribute>
		 						<xsl:value-of select="Bits-_Pixel_Frame_"/>
								</essenceTrackAnnotation>
	 					</xsl:if>
	 					<xsl:if test="Delay_Settings"><!-- note occasionally a codec and container can have conflicting timecode setting data -->
			 				<essenceTrackAnnotation>
		 						<xsl:attribute name="annotationType">TimecodeSettings_Container</xsl:attribute>
		 						<xsl:value-of select="Delay_Settings"/>
								</essenceTrackAnnotation>
	 					</xsl:if>
	 					<xsl:if test="Delay_Original_Settings">
	 						<essenceTrackAnnotation>
		 						<xsl:attribute name="annotationType">TimecodeSettings_Codec</xsl:attribute>
		 						<xsl:value-of select="Delay_Original_Settings"/>
								</essenceTrackAnnotation>
	 					</xsl:if>
	 
	 					
	  				  </instantiationEssenceTrack>
					 
	  				</xsl:for-each>
		
			<!-- annotations: there seems to be 2 ways to go about handling annotations in a MediaInfo to pbcore-instantiation workflow: 1). inclusive and 2). exclusive. The below method goes with an exclusive approach where MediaInfo values that aren't specifically mapped elsewhere are retained while depreciated and redundant values are also excluded. Feel free to tinker with the test attribute in the xsl:if element to adjust the verbosity. An alternate inclusive approach is commented out just below this. -->
   				<xsl:for-each select="track[@type='General']">
	   				<!-- instantiationRelations -->
	  				<xsl:for-each select="str:tokenize(Media_History_UUID, '/')">
						<instantiationRelation>
							<instantiationRelationType>Is Derived From</instantiationRelationType>
							<instantiationRelationIdentifier>
	   							<xsl:attribute name="source">Final Cut UUID</xsl:attribute>
	   							<xsl:attribute name="ref">com.apple.finalcutstudio.media.uuid</xsl:attribute>
	   							<xsl:value-of select="normalize-space(.)"/>
			   				</instantiationRelationIdentifier>
						</instantiationRelation>
					</xsl:for-each>
					<xsl:for-each select="str:tokenize(OriginalSourceMedium, '/')"><!-- this matches the value 'Reel' in Final Cut, it's stored as a label on a Quicktime timecode track -->
						<instantiationRelation>
							<instantiationRelationType>Is Digitized From</instantiationRelationType>
							<instantiationRelationIdentifier>
	   							<xsl:attribute name="source">Original Source Medium</xsl:attribute>
	   							<xsl:value-of select="normalize-space(.)"/>
			   				</instantiationRelationIdentifier>
						</instantiationRelation>
					</xsl:for-each>
   					</xsl:for-each>
	</xsl:template>	
</xsl:stylesheet>