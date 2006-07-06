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

	<xsl:template match="sep:Qualifications">

		<xsl:variable name="title">
			<xsl:call-template name="message">
				<xsl:with-param name="name">header.qualifications</xsl:with-param>
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
				<xsl:apply-templates select="sep:Competency"/>
			</itemizedlist>
		</sect1>

	</xsl:template>

	<xsl:template match="sep:Competency">
	
		<listitem>
			<simpara>

				<xsl:choose>
					<xsl:when test="sep:Competency">
						<emphasis role="bold">
							<xsl:value-of select="@name"/>
							<xsl:text>: </xsl:text>
						</emphasis>
			
						<xsl:for-each select="sep:Competency">
							<xsl:value-of select="@name"/>
				
							<xsl:if test="position() != last()">
								<xsl:text>, </xsl:text>
							</xsl:if>
				
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@name"/>
					</xsl:otherwise>
				</xsl:choose>

			</simpara>
		</listitem>		
		
	</xsl:template>

</xsl:stylesheet>
