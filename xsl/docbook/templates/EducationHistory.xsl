<?xml version="1.0" encoding="UTF-8"?>

<!--

   Copyright 2002 Charles Chan

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

	<xsl:template match="sep:EducationHistory">

		<xsl:variable name="title">
			<xsl:call-template name="message">
				<xsl:with-param name="name">header.educationHistory</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>

		<sect1>
			<xsl:attribute name="id">
				<xsl:value-of select="translate($title, ' ', '')"/>
			</xsl:attribute>

			<title>
				<xsl:value-of select="$title"/>
			</title>

			<xsl:for-each select="sep:SchoolOrInstitution/sep:Degree">
		
				<para>
					<xsl:choose>
						<xsl:when test="@degreeType = 'high school or equivalent'">					
							<xsl:call-template name="message">
								<xsl:with-param name="name">educationHistory.highschool</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="@degreeType = 'associates'">					
							<xsl:call-template name="message">
								<xsl:with-param name="name">educationHistory.associates</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="@degreeType = 'bachelors'">					
							<xsl:call-template name="message">
								<xsl:with-param name="name">educationHistory.bachelors</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="@degreeType = 'masters'">					
							<xsl:call-template name="message">
								<xsl:with-param name="name">educationHistory.masters</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="@degreeType = 'doctorate'">					
							<xsl:call-template name="message">
								<xsl:with-param name="name">educationHistory.doctorate</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="@degreeType = 'international'">					
							<xsl:call-template name="message">
								<xsl:with-param name="name">educationHistory.international</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
		
					<xsl:choose>
						<xsl:when test="@degreeType and not(sep:DegreeMajor/sep:Name)">
							<xsl:text>, </xsl:text>
						</xsl:when>
						<xsl:when test="@degreeType and sep:DegreeMajor/sep:Name">
							<xsl:text> </xsl:text>
							<xsl:call-template name="message">
								<xsl:with-param name="name">educationHistory.degreeIn</xsl:with-param>
							</xsl:call-template>
							<xsl:text> </xsl:text>
							<xsl:value-of select="sep:DegreeMajor/sep:Name"/>
							<xsl:text>, </xsl:text>
						</xsl:when>
					</xsl:choose>

					<xsl:if test="sep:DegreeDate">
						<xsl:apply-templates select="sep:DegreeDate"/>
						<xsl:text>, </xsl:text>
					</xsl:if>

					<xsl:value-of select="../sep:School/sep:SchoolName"/>

					<xsl:if test="../sep:LocationSummary">
						<xsl:text>, </xsl:text>
						<xsl:apply-templates select="../sep:LocationSummary"/>
					</xsl:if>

					<xsl:if test="sep:DegreeMajor/sep:DegreeConcentration">
						<xsl:text>, </xsl:text>
						<xsl:call-template name="message">
							<xsl:with-param name="name">educationHistory.concentrationIn</xsl:with-param>
						</xsl:call-template>
						<xsl:text> </xsl:text>
						<xsl:value-of select="sep:DegreeMajor/sep:DegreeConcentration"/>
					</xsl:if>
				
				</para>
				
				<xsl:if test="sep:OtherHonors or sep:Comments">
					<xsl:if test="sep:OtherHonors">
						<itemizedlist>
							<xsl:for-each select="sep:OtherHonors">
								<listitem>
									<simpara>
										<xsl:value-of select="."/>
									</simpara>
								</listitem>
							</xsl:for-each>
						</itemizedlist>
					</xsl:if>
				
					<xsl:if test="sep:Comments">
						<blockquote>
							<para>
								<xsl:value-of select="sep:Comments"/>
							</para>
						</blockquote>
					</xsl:if>
				</xsl:if>

			</xsl:for-each> 
			
		</sect1>
	
	</xsl:template>

	<xsl:template match="sep:LocationSummary">

		<xsl:value-of select="sep:Municipality"/>
		
		<xsl:if test="sep:Region">
			<xsl:text>, </xsl:text>
			<xsl:value-of select="sep:Region"/>
		</xsl:if>
		
		<xsl:if test="sep:CountryCode">
			<xsl:text>, </xsl:text>
			<xsl:call-template name="message"> 
				<xsl:with-param name="name">countryCode.<xsl:value-of select="sep:CountryCode"/></xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		
	</xsl:template>

</xsl:stylesheet>
