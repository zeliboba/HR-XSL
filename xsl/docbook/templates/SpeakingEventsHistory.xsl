<?xml version="1.0" encoding="UTF-8"?>

<!--

   Copyright 2006 Trevor Harmon

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

-->

<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sep="http://ns.hr-xml.org/2007-04-15"
	exclude-result-prefixes="sep">

	<xsl:template match="sep:SpeakingEventsHistory">

		<xsl:variable name="title">
			<xsl:call-template name="message">
				<xsl:with-param name="name">header.speakingEventsHistory</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>

		<sect1>

			<!-- Generate a section ID from the title -->
			<xsl:attribute name="id">
				<!-- Remove spaces from the title because IDs can't have them -->
				<xsl:value-of select="translate($title, ' ', '')"/>
			</xsl:attribute>

			<title>
				<xsl:value-of select="$title"/>
			</title>
			
			<itemizedlist>
				<xsl:apply-templates select="sep:SpeakingEvent"/>
			</itemizedlist>
		</sect1>

	</xsl:template>

	<xsl:template match="sep:SpeakingEvent">
	
		<listitem>
			<simpara>

				<xsl:if test="sep:Title">
					<quote>
						<xsl:choose>
							<xsl:when test="sep:Link">
								<ulink>
									<xsl:attribute name="url">
										<xsl:value-of select="sep:Link"/>
									</xsl:attribute>
									<xsl:value-of select="sep:Title"/> 
								</ulink> 
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="sep:Title"/>
							</xsl:otherwise>
						</xsl:choose>
					</quote>
				</xsl:if>

				<xsl:text> </xsl:text>

				<xsl:value-of select="sep:EventName"/> 
				
				<xsl:if test="sep:AffiliatedOrganization">
					<xsl:text>, </xsl:text>
					<xsl:value-of select="sep:AffiliatedOrganization"/>
				</xsl:if>
				
				<xsl:text>. </xsl:text> 
				
				<xsl:if test="sep:Location">
					<xsl:value-of select="sep:Location"/>
					<xsl:text>. </xsl:text>
				</xsl:if>
				
				<xsl:apply-templates select="sep:StartDate"/>
		
				<xsl:if test="sep:EndDate">
					<xsl:text> - </xsl:text>
					<xsl:apply-templates select="sep:EndDate"/>
				</xsl:if>
		
				<xsl:text>.</xsl:text> 

			</simpara>
		</listitem>
		
	</xsl:template>

</xsl:stylesheet>
