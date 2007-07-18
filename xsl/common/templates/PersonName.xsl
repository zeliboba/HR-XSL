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
	xmlns:sep="http://ns.hr-xml.org/2007-04-15">

	<!--
	If PreferredGivenName is specified, it is used in place of GivenName.
	
	Ignored entities:
		LegalName
		AlternateScript
		FamilyName/@primary
	-->
	<xsl:template match="sep:PersonName | sep:Name">
		<xsl:variable name="personName"> 
			<xsl:call-template name="getUnnormalizedPersonName">  
				<xsl:with-param name="personNameElement" select="."/>  
			</xsl:call-template>  
		</xsl:variable>
		<xsl:value-of select="normalize-space($personName)"/> 
	</xsl:template>

	<xsl:template name="getUnnormalizedPersonName">
		<xsl:param name="personNameElement"/> 
		<xsl:choose>
			<!-- If a formatted name is specified, use it instead of the elements. -->
			<xsl:when test="$personNameElement/sep:FormattedName"> 
				<xsl:value-of select="$personNameElement/sep:FormattedName"/> 
			</xsl:when> 
			<!-- If a formatted name is not specified, construct one from the given elements. -->
			<xsl:otherwise> 

				<!-- Form of address -->
				<xsl:if test="$personNameElement/sep:Affix[@type='formOfAddress']">
					<xsl:apply-templates select="$personNameElement/sep:Affix[@type='formOfAddress']"/> 
					<xsl:text> </xsl:text> 
				</xsl:if>
				
				<!-- Aristocratic title -->
				<xsl:for-each select="$personNameElement/sep:Affix[@type='aristocraticTitle']"> 
					<xsl:value-of select="."/>
					<xsl:text> </xsl:text> 
				</xsl:for-each> 
				
				<!-- Given name -->
				<xsl:choose> 
					<xsl:when test="$personNameElement/sep:PreferredGivenName"> 
						<xsl:value-of select="$personNameElement/sep:PreferredGivenName"/> 
						<xsl:text> </xsl:text> 
					</xsl:when> 
					<xsl:otherwise> 
						<xsl:for-each select="$personNameElement/sep:GivenName"> 
							<xsl:value-of select="."/> 
							<xsl:text> </xsl:text> 
						</xsl:for-each> 
					</xsl:otherwise> 
				</xsl:choose> 
				
				<!-- Middle name -->
				<xsl:for-each select="$personNameElement/sep:MiddleName"> 
					<xsl:value-of select="."/> 
					<xsl:text> </xsl:text> 
				</xsl:for-each> 
				
				<!-- Family name -->
				<xsl:for-each select="$personNameElement/sep:FamilyName"> 
					<xsl:if test="@prefix">
						<xsl:apply-templates select="@prefix"/> 
						<xsl:text> </xsl:text> 
					</xsl:if>
					<xsl:value-of select="."/> 
					<xsl:if test="position() != last()">
						<xsl:text> </xsl:text> 
					</xsl:if>
				</xsl:for-each> 
				
				<!-- Generation -->
				<xsl:for-each select="$personNameElement/sep:Affix[@type='generation']"> 
					<xsl:text> </xsl:text> 
					<xsl:value-of select="."/> 
				</xsl:for-each> 
				
				<!-- Qualification -->
				<xsl:for-each select="$personNameElement/sep:Affix[@type='qualification']"> 
					<xsl:text>, </xsl:text> 
					<xsl:value-of select="."/> 
				</xsl:for-each> 
				
			</xsl:otherwise> 
		</xsl:choose>

		<!-- Role -->
		<xsl:if test="@role = 'editor' or @role = 'illustrator' or @role = 'contributor'">   <!-- Ignore 'author' -->
			<xsl:text> (</xsl:text>
			<xsl:call-template name="message">
				<xsl:with-param name="name">publicationHistory.role.<xsl:value-of select="@role"/></xsl:with-param>
			</xsl:call-template>
			<xsl:text>)</xsl:text>
		</xsl:if>
		
	</xsl:template>

</xsl:stylesheet>
