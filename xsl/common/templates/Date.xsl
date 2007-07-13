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
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:sep="http://ns.hr-xml.org/2006-02-28">

	<xsl:template match="sep:YearMonth">
		<xsl:variable name="month" select="substring-after(., '-')"/>
		<xsl:call-template name="message">
			<xsl:with-param name="name">
				<xsl:value-of select="concat('month.', $month.format, '.', $month)"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:text> </xsl:text>
		<xsl:value-of select="substring-before(., '-')"/>
	</xsl:template>
	
	<xsl:template match="sep:AnyDate | sep:RevisionDate">
		
		<xsl:choose>

			<!-- notApplicable literal -->
			<xsl:when test=". = 'notApplicable'">
				<xsl:call-template name="message">
					<xsl:with-param name="name">notApplicable</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<!-- notKnown literal -->
			<xsl:when test=". = 'notKnown'">
				<xsl:call-template name="message">
					<xsl:with-param name="name">notKnown</xsl:with-param>
				</xsl:call-template>
			</xsl:when>

			<!-- YYYY-MM-DD format -->
			<xsl:when test="matches(., '^\d\d\d\d-\d\d-\d\d$')">
				<xsl:variable name="tokens" select="tokenize(., '-')"/>
				
				<!-- Month -->
				<xsl:variable name="month" select="$tokens[2]"/> 
				<xsl:call-template name="message">
					<xsl:with-param name="name">
						<xsl:value-of select="concat('month.', $month.format, '.', $month)"/>
					</xsl:with-param>
				</xsl:call-template>
				
				<!-- Day -->
				<xsl:text> </xsl:text>
				<!-- Here, the replace function removes any leading zero from the month -->
				<xsl:value-of select="replace($tokens[3], '^0', '')"/>
				
				<!-- Year -->
				<xsl:text>, </xsl:text>
				<xsl:value-of select="$tokens[1]"/>
			</xsl:when>

			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>

		</xsl:choose>				
		
	</xsl:template>
	
	<!-- Converts a sep:Date value to an xs:date value -->
	<xsl:template name="getDate">
		<xsl:param name="date"/>
		
		<xsl:choose>
			<xsl:when test="$date/sep:Year">
				<xsl:value-of select="xs:date(concat($date/sep:Year, '-01-01'))"/>
			</xsl:when>
			<xsl:when test="$date/sep:YearMonth">
				<xsl:value-of select="xs:date(concat($date/sep:YearMonth, '-01'))"/>
			</xsl:when>
			<xsl:when test="$date/sep:AnyDate">
				<xsl:value-of select="xs:date($date/sep:AnyDate)"/>
			</xsl:when>
		</xsl:choose>
		
	</xsl:template>

</xsl:stylesheet>
