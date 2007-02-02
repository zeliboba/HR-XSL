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

	<xsl:template match="sep:ResumeAdditionalItems">

		<xsl:variable name="title">
			<xsl:call-template name="message"> 
				<xsl:with-param name="name">header.additionalItems</xsl:with-param> 
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

			<xsl:for-each-group select="sep:ResumeAdditionalItem" group-by="@type">

				<xsl:variable name="title2">
					<xsl:choose>
						<!-- If the type starts with "x:", it's custom, so use it directly -->
						<xsl:when test="starts-with(current-grouping-key(), 'x:')">
							<xsl:value-of select="substring-after(current-grouping-key(), 'x:')"/>
						</xsl:when>
						<!-- Otherwise, it's a standard type, so use the localized name -->
						<xsl:otherwise>
							<xsl:call-template name="message"> 
								<xsl:with-param name="name">header.additionalItems.<xsl:value-of select="current-grouping-key()"/></xsl:with-param> 
							</xsl:call-template> 
						</xsl:otherwise>
					</xsl:choose>
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
						<xsl:apply-templates select="current-group()"/>
					</itemizedlist>

				</sect2>

			</xsl:for-each-group>
		
			<!-- The for-each-group command skips items that don't specify a type, -->
			<!-- so we have to do those separately here. -->
			<xsl:if test="count(sep:ResumeAdditionalItem[not(@type)]) != 0">

				<xsl:variable name="title2">
					<xsl:call-template name="message"> 
						<xsl:with-param name="name">header.additionalItems.other</xsl:with-param> 
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
						<xsl:for-each select="sep:ResumeAdditionalItem[not(@type)]"> 
							<xsl:apply-templates select="."/>
						</xsl:for-each> 
					</itemizedlist>

				</sect2>
				
			</xsl:if>
	
		</sect1>

	</xsl:template>

	<xsl:template match="sep:ResumeAdditionalItem">

		<listitem>
			<simpara>
				<xsl:if test="sep:EffectiveDate">
					<xsl:apply-templates select="sep:EffectiveDate/sep:StartDate"/>
					
					<xsl:if test="sep:EffectiveDate/sep:EndDate">
						<xsl:text> - </xsl:text>
						<xsl:apply-templates select="sep:EffectiveDate/sep:EndDate"/>
					</xsl:if>
					
					<xsl:text>: </xsl:text>
				</xsl:if>

				<xsl:value-of select="sep:Description"/>
			</simpara>			
		</listitem>

	</xsl:template>

</xsl:stylesheet>
