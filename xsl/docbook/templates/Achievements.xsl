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

	<xsl:template match="sep:Achievements">

		<xsl:variable name="title">
			<xsl:call-template name="message">
				<xsl:with-param name="name">header.achievements</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>

		<sect1>
			<xsl:attribute name="id">
				<xsl:value-of select="translate($title, ' ', '')"/>
			</xsl:attribute>

			<title>
				<xsl:value-of select="$title"/>
			</title>

			<itemizedlist>
				<xsl:apply-templates select="sep:Achievement"/>
			</itemizedlist>
		</sect1>

	</xsl:template>

	<xsl:template match="sep:Achievement">
	
		<listitem>
			<simpara>
				<xsl:value-of select="sep:Description"/>		
				<xsl:text>. </xsl:text>
				<xsl:value-of select="sep:IssuingAuthority"/>
				<xsl:text>, </xsl:text>
				<xsl:apply-templates select="sep:Date"/> 
			</simpara>
		</listitem>
		
	</xsl:template>

</xsl:stylesheet>
