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

	<xsl:template match="sep:Associations">

		<xsl:variable name="title">
			<xsl:call-template name="message"> 
				<xsl:with-param name="name">header.associations</xsl:with-param> 
			</xsl:call-template> 
		</xsl:variable>
		
		<sect1>
			<xsl:attribute name="id">
				<xsl:value-of select="translate($title, ' ', '')"/>
			</xsl:attribute>

			<title>
				<xsl:value-of select="$title"/>
			</title>

			<xsl:for-each-group select="sep:Association" group-by="@type">

				<xsl:variable name="title2">
					<xsl:choose>
						<!-- If the type starts with "x:", it's custom, so use it directly -->
						<xsl:when test="starts-with(current-grouping-key(), 'x:')">
							<xsl:value-of select="substring-after(current-grouping-key(), 'x:')"/>
						</xsl:when>
						<!-- Otherwise, it's a standard type, so use the localized name -->
						<xsl:otherwise>
							<xsl:call-template name="message"> 
								<xsl:with-param name="name">header.associations.<xsl:value-of select="current-grouping-key()"/></xsl:with-param> 
							</xsl:call-template> 
							<xsl:text> </xsl:text> 
							<xsl:call-template name="message"> 
								<xsl:with-param name="name">header.associations</xsl:with-param> 
							</xsl:call-template> 
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>					

				<sect2>
					<xsl:attribute name="id">
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
		
			<!-- The for-each-group command skips associations that don't specify a type, -->
			<!-- so we have to do those separately here. -->
			<xsl:if test="count(sep:Association[not(@type)]) != 0">

				<xsl:variable name="title2">
					<xsl:call-template name="message"> 
						<xsl:with-param name="name">header.associations.other</xsl:with-param> 
					</xsl:call-template> 
					<xsl:text> </xsl:text> 
					<xsl:call-template name="message"> 
						<xsl:with-param name="name">header.associations</xsl:with-param> 
					</xsl:call-template> 
				</xsl:variable>

				<sect2>
					<xsl:attribute name="id">
						<xsl:value-of select="translate($title2, ' ', '')"/>
					</xsl:attribute>

					<title>
						<xsl:value-of select="$title2"/>					
					</title>

					<itemizedlist>
						<xsl:for-each select="sep:Association[not(@type)]"> 
							<xsl:apply-templates select="."/>
						</xsl:for-each> 
					</itemizedlist>

				</sect2>
				
			</xsl:if>
	
		</sect1>

	</xsl:template>
	
	<xsl:template match="sep:Association">
	
		<listitem>
			<simpara>

				<xsl:if test="sep:Role/sep:Name">
					<xsl:value-of select="sep:Role/sep:Name"/>
					<xsl:text>, </xsl:text>
				</xsl:if>
	
				<xsl:choose>
					<xsl:when test="sep:Link">
						<ulink>
							<xsl:attribute name="url">
								<xsl:value-of select="sep:Link"/>
							</xsl:attribute>
							<xsl:value-of select="sep:Name"/> 
						</ulink> 
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="sep:Name"/>
					</xsl:otherwise>
				</xsl:choose>

				<xsl:if test="sep:StartDate">
					<xsl:text>, </xsl:text>
					<xsl:apply-templates select="sep:StartDate"/>
					
					<xsl:if test="sep:EndDate">
						<xsl:text> - </xsl:text>
						<xsl:apply-templates select="sep:EndDate"/>
					</xsl:if>
					
				</xsl:if>

			</simpara>			
		</listitem>

	</xsl:template>

</xsl:stylesheet>
