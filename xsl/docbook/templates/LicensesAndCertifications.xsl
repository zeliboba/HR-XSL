<?xml version="1.0" encoding="UTF-8"?>

<!--

   Copyright 2007 Trevor Harmon

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

	<xsl:template match="sep:LicensesAndCertifications">

		<xsl:variable name="title">
			<xsl:call-template name="message">
				<xsl:with-param name="name">header.licensesAndCertifications</xsl:with-param>
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
				<xsl:apply-templates select="sep:LicenseOrCertification"/> 
			</itemizedlist> 
			
		</sect1>

	</xsl:template>

	<xsl:template match="sep:LicenseOrCertification">
	
		<listitem>
			<simpara>

				<emphasis role="bold">

					<xsl:value-of select="sep:Name"/>
				
					<xsl:if test="sep:IssuingAuthority">
						<xsl:text>, </xsl:text>
						<xsl:value-of select="sep:IssuingAuthority"/>
					</xsl:if>

				</emphasis>
				
				<xsl:if test="sep:EffectiveDate">

					<emphasis>
						
						<!-- The #160 code (non-breaking space) is used to force a space to appear. If a simple space is used, it is lost for some reason during the DocBook XSL translation. -->
						<xsl:text>&#160;(</xsl:text>
				
						<xsl:if test="sep:EffectiveDate/sep:ValidFrom">
							<xsl:call-template name="message">
								<xsl:with-param name="name">licensesAndCertifications.validity</xsl:with-param>
							</xsl:call-template>
							<xsl:text>: </xsl:text>
							<xsl:apply-templates select="sep:EffectiveDate/sep:ValidFrom"/>
							<xsl:if test="sep:EffectiveDate/sep:ValidTo">
								<xsl:text> - </xsl:text>
								<xsl:apply-templates select="sep:EffectiveDate/sep:ValidTo"/>
							</xsl:if>
						</xsl:if>
				
						<xsl:if test="sep:EffectiveDate/sep:FirstIssuedDate">
							<xsl:if test="sep:EffectiveDate/sep:ValidFrom">
								<xsl:text>, </xsl:text>
							</xsl:if>
							<xsl:call-template name="message">
								<xsl:with-param name="name">licensesAndCertifications.firstIssued</xsl:with-param>
							</xsl:call-template>
							<xsl:text>: </xsl:text>
							<xsl:apply-templates select="sep:EffectiveDate/sep:FirstIssuedDate"/>
						</xsl:if>
				
						<xsl:text>)</xsl:text>
						
					</emphasis>

				</xsl:if>

				<xsl:if test="sep:Description">
					<xsl:text>: </xsl:text>
					<xsl:value-of select="sep:Description"/>
				</xsl:if>
			
			</simpara>
		</listitem>		
		
	</xsl:template>

</xsl:stylesheet>
