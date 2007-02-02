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
	xmlns:sep="http://ns.hr-xml.org/2006-02-28"
	exclude-result-prefixes="sep">

	<xsl:template match="sep:PublicationHistory">

		<xsl:variable name="title">
			<xsl:call-template name="message">
				<xsl:with-param name="name">header.publicationHistory</xsl:with-param>
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

			<xsl:if test="sep:Article">

				<xsl:variable name="title2">
					<xsl:call-template name="message">
						<xsl:with-param name="name">header.publicationHistory.articles</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>

				<sect2>

					<!-- Generate a section ID from the title -->
					<xsl:attribute name="id">
						<!-- Remove spaces from the title because IDs can't have them -->
						<xsl:value-of select="translate($title2, ' ', '')"/>
					</xsl:attribute>

					<title>
						<xsl:value-of select="$title2"/>
					</title>
				
					<itemizedlist>
						<xsl:apply-templates select="sep:Article"/>
					</itemizedlist>

				</sect2>

			</xsl:if>		

			<xsl:if test="sep:Book">
				
				<xsl:variable name="title2">
					<xsl:call-template name="message">
						<xsl:with-param name="name">header.publicationHistory.books</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>

				<sect2>

					<!-- Generate a section ID from the title -->
					<xsl:attribute name="id">
						<!-- Remove spaces from the title because IDs can't have them -->
						<xsl:value-of select="translate($title2, ' ', '')"/>
					</xsl:attribute>

					<title>
						<xsl:value-of select="$title2"/>
					</title>
				
					<itemizedlist>
						<xsl:apply-templates select="sep:Book"/>
					</itemizedlist>
				</sect2>
			</xsl:if>		

			<xsl:if test="sep:ConferencePaper">
				
				<xsl:variable name="title2">
					<xsl:call-template name="message">
						<xsl:with-param name="name">header.publicationHistory.conferencePapers</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>
				
				<sect2>

					<!-- Generate a section ID from the title -->
					<xsl:attribute name="id">
						<!-- Remove spaces from the title because IDs can't have them -->
						<xsl:value-of select="translate($title2, ' ', '')"/>
					</xsl:attribute>

					<title>					
						<xsl:value-of select="$title2"/>
					</title>

					<itemizedlist>
						<xsl:apply-templates select="sep:ConferencePaper"/>
					</itemizedlist>
				</sect2>
			</xsl:if>		

			<xsl:if test="sep:OtherPublication">

				<xsl:variable name="title2">
					<xsl:call-template name="message">
						<xsl:with-param name="name">header.publicationHistory.otherPublications</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>

				<sect2>

					<!-- Generate a section ID from the title -->
					<xsl:attribute name="id">
						<!-- Remove spaces from the title because IDs can't have them -->
						<xsl:value-of select="translate($title2, ' ', '')"/>
					</xsl:attribute>

					<title>
						<xsl:value-of select="$title2"/>
					</title>
				
					<itemizedlist>
						<xsl:apply-templates select="sep:OtherPublication"/>
					</itemizedlist>
				</sect2>
			</xsl:if>		
			
		</sect1>

	</xsl:template>

	<xsl:template match="sep:Article">
	
		<listitem>
			<simpara>

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
						
				<xsl:text> </xsl:text>

				<xsl:if test="sep:Name">				
					<xsl:call-template name="namelist"/>
					<xsl:text>. </xsl:text> 
				</xsl:if>

				<emphasis>
					<xsl:value-of select="normalize-space(sep:JournalOrSerialName)"/>
				</emphasis>

				<xsl:if test="sep:PublicationDate">
					<xsl:text>, </xsl:text>
					<xsl:apply-templates select="sep:PublicationDate"/>
					<xsl:if test="sep:Volume | sep:Issue | sep:PageNumber">
						<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:if>

				<xsl:if test="sep:Volume">
					<xsl:call-template name="message">
						<xsl:with-param name="name">publicationHistory.volume</xsl:with-param>
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="sep:Volume"/>
					<xsl:if test="sep:Issue | sep:PageNumber">
						<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:if>

				<xsl:if test="sep:Issue">
					<xsl:call-template name="message">
						<xsl:with-param name="name">publicationHistory.issue</xsl:with-param>
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="sep:Issue"/>
					<xsl:if test="sep:PageNumber">
						<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:if>

				<xsl:if test="sep:PageNumber">
					<xsl:call-template name="message">
						<xsl:with-param name="name">publicationHistory.pages</xsl:with-param>
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="sep:PageNumber"/>
				</xsl:if>

				<xsl:text>.</xsl:text>

				<xsl:if test="sep:Comments">
					<xsl:text> </xsl:text>
					<xsl:value-of select="sep:Comments"/>
				</xsl:if>
				
			</simpara>
		</listitem>
				
	</xsl:template>

	<xsl:template match="sep:Book">
	
		<listitem>
			<simpara>

				<emphasis>
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
				</emphasis>

				<xsl:text>.</xsl:text>
		
				<xsl:if test="sep:Chapter">
					<xsl:text> </xsl:text>
					<xsl:call-template name="message">
						<xsl:with-param name="name">publicationHistory.chapter</xsl:with-param>
					</xsl:call-template>
					<xsl:text>: </xsl:text>
					<xsl:value-of select="sep:Chapter"/>
					<xsl:text>.</xsl:text>
				</xsl:if>
		
				<xsl:text> </xsl:text>

				<xsl:if test="sep:Name">				
					<xsl:call-template name="namelist"/>
					<xsl:text>. </xsl:text> 
				</xsl:if>

				<xsl:if test="sep:PublisherName and sep:PublisherLocation">
					<xsl:value-of select="sep:PublisherName"/>
					<xsl:text>, </xsl:text>
					<xsl:value-of select="sep:PublisherLocation"/>
					<xsl:text>, </xsl:text>
				</xsl:if>
		
				<xsl:apply-templates select="sep:PublicationDate"/>
				<xsl:text>.</xsl:text>
			
			</simpara>
		</listitem>
		
	</xsl:template>

	<xsl:template match="sep:ConferencePaper">
	
		<listitem>
			<simpara>
				
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

				<xsl:text> </xsl:text>

				<xsl:if test="sep:Name">				
					<xsl:call-template name="namelist"/>
					<xsl:text>. </xsl:text> 
				</xsl:if>

				<emphasis>
					<xsl:value-of select="sep:EventName"/>
				</emphasis>
		
				<xsl:if test="sep:ConferenceLocation">
					<xsl:text>, </xsl:text>
					<xsl:apply-templates select="sep:ConferenceLocation"/>
				</xsl:if>

				<xsl:if test="sep:ConferenceDate">
					<xsl:text>, </xsl:text>
					<xsl:apply-templates select="sep:ConferenceDate"/>
				</xsl:if>

				<xsl:text>.</xsl:text>
	
				<xsl:if test="sep:Comments">
					<xsl:text> </xsl:text>
					<xsl:value-of select="sep:Comments"/>
				</xsl:if>
			</simpara>
		</listitem>
		
	</xsl:template>

	<xsl:template match="sep:OtherPublication">
	
		<listitem>
			<simpara>
				
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

				<xsl:text> </xsl:text>

				<xsl:if test="sep:Name">				
					<xsl:call-template name="namelist"/>
					<xsl:text>. </xsl:text> 
				</xsl:if>

				<xsl:if test="sep:PublicationDate">
					<xsl:apply-templates select="sep:PublicationDate"/>
					<xsl:text>.</xsl:text>
				</xsl:if>

				<xsl:if test="sep:Comments">
					<xsl:text> </xsl:text>
					<xsl:value-of select="sep:Comments"/>
				</xsl:if>
			</simpara>
		</listitem>
		
	</xsl:template>

	<!-- Helper template to generate a comma-separated list of author names -->
	<xsl:template name="namelist">
		<xsl:choose>
			<!-- Special-case handling for a single author -->
			<xsl:when test="count(sep:Name) = 1">
				<xsl:apply-templates select="sep:Name"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="sep:Name"> 
					<xsl:choose> 
						<xsl:when test="position() != last()">       <!-- Add a comma if this isn't the last author -->
							<xsl:apply-templates select="."/> 
							<xsl:if test="count(../sep:Name) != 2">  <!-- Special handling when there are two authors -->
								<xsl:text>,</xsl:text> 
							</xsl:if>
							<xsl:text> </xsl:text> 
						</xsl:when> 
						<xsl:otherwise> 
							<xsl:call-template name="message"> 
								<xsl:with-param name="name">and</xsl:with-param> 
							</xsl:call-template> 
							<xsl:text> </xsl:text> 
							<xsl:apply-templates select="."/> 
						</xsl:otherwise> 
					</xsl:choose> 
				</xsl:for-each> 
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
