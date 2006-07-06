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

	<xsl:template match="sep:Languages">

		<xsl:variable name="title">
			<xsl:call-template name="message">
				<xsl:with-param name="name">header.languages</xsl:with-param>
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
				<xsl:apply-templates select="sep:Language"/> 
			</itemizedlist> 
		</sect1>

	</xsl:template>

	<xsl:template match="sep:Language">
		
		<listitem>
			<simpara>
				
				<xsl:call-template name="message">
					<xsl:with-param name="name">language.<xsl:value-of select="sep:LanguageCode"/></xsl:with-param>
				</xsl:call-template>
				
				<xsl:if test="sep:Read or sep:Write or sep:Speak or sep:Comments">
					<xsl:text>: </xsl:text>
				</xsl:if>
				
				<xsl:if test="sep:Read or sep:Write or sep:Speak">

					<xsl:call-template name="message">
						<xsl:with-param name="name">languages.abilityTo</xsl:with-param>
					</xsl:call-template>
					<xsl:text> </xsl:text>

					<xsl:variable name="abilities">
						<xsl:if test="sep:Read">
							<xsl:call-template name="message">
								<xsl:with-param name="name">languages.read</xsl:with-param>
							</xsl:call-template>
							<xsl:text>, </xsl:text>
						</xsl:if>
						
						<xsl:if test="sep:Write">
							<xsl:call-template name="message">
								<xsl:with-param name="name">languages.write</xsl:with-param>
							</xsl:call-template>
							<xsl:text>, </xsl:text>
						</xsl:if>
						
						<xsl:if test="sep:Speak">
							<xsl:call-template name="message">
								<xsl:with-param name="name">languages.speak</xsl:with-param>
							</xsl:call-template>
							<xsl:text>, </xsl:text>
						</xsl:if>
					</xsl:variable>
					
					<xsl:variable name="and">						
						<xsl:text> </xsl:text>
						<xsl:call-template name="message">
							<xsl:with-param name="name">and</xsl:with-param>
						</xsl:call-template>
						<xsl:text> </xsl:text>
					</xsl:variable>

					<!-- Remove trailing comma -->
					<xsl:variable name="abilities" select="replace($abilities, '(.+), $', '$1')"/>    
					<xsl:choose>  
						<xsl:when test="matches($abilities, '^\w+$')">    
							<xsl:value-of select="replace($abilities, '(.+), ', '$1')"/>    
						</xsl:when>					    
						<xsl:when test="matches($abilities, '^\w+, \w+$')">  
							<xsl:variable name="abilities" select="replace($abilities, '(\w+), (\w+)', '$1 AND $2')"/>   
							<xsl:variable name="abilities" select="replace($abilities, 'AND', $and)"/>     
							<xsl:value-of select="normalize-space($abilities)"/>  
						</xsl:when>  
						<xsl:when test="matches($abilities, '^\w+, \w+, \w+$')">  
							<xsl:variable name="abilities" select="replace($abilities, '(\w+)$', 'AND $1')"/>     
							<xsl:variable name="abilities" select="replace($abilities, 'AND', $and)"/>     
							<xsl:value-of select="normalize-space($abilities)"/>  
						</xsl:when> 
					</xsl:choose>  
					
					<xsl:text>.</xsl:text>
						
					<xsl:if test="sep:Comments">
						<xsl:text> </xsl:text>
					</xsl:if>
					
				</xsl:if>
				
				<xsl:if test="sep:Comments">
					<xsl:value-of select="sep:Comments"/>
				</xsl:if>

			</simpara>
		</listitem>
		
	</xsl:template>

</xsl:stylesheet>
