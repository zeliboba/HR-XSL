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
	xmlns="http://ns.hr-xml.org/2006-02-28" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:res="http://xmlresume.sourceforge.net/resume/0.0"
	exclude-result-prefixes="res">

	<xsl:template name="comment">
		<xsl:param name="name"/>
		<xsl:text>&#xa;</xsl:text>
		<xsl:comment>
			<xsl:text> </xsl:text>
			<xsl:value-of select="$name"/>
			<xsl:text> </xsl:text>
		</xsl:comment>
	</xsl:template>	

	<xsl:template match="res:location"> 
	
		<xsl:if test="res:city or res:state">
			<LocationSummary> 
				<xsl:if test="res:city">
					<Municipality>
						<xsl:value-of select="res:city"/>
					</Municipality> 
				</xsl:if>
				<xsl:if test="res:state">
					<Region>
						<xsl:value-of select="res:state"/>
					</Region> 
				</xsl:if>
				<xsl:if test="res:country">
					<xsl:call-template name="comment">
						<xsl:with-param name="name">Country not supported.</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</LocationSummary> 
		</xsl:if>
	
	</xsl:template>

	<xsl:template match="res:date">
	
		<xsl:choose> 
			<xsl:when test="res:dayOfMonth"> 
				<AnyDate>
					<xsl:value-of select="res:year"/>
					<xsl:text>-</xsl:text>
					<xsl:apply-templates select="res:month"/>
					<xsl:text>-</xsl:text>
					<xsl:apply-templates select="res:dayOfMonth"/>
				</AnyDate> 
			</xsl:when> 
			<xsl:when test="res:month"> 
				<!-- Does the month have a value we recognize? -->
				<xsl:choose>
					<xsl:when test="res:month = 'January' or res:month = 'February' or res:month = 'March' or res:month = 'April' or res:month = 'May' or res:month = 'June' or res:month = 'July' or res:month = 'August' or res:month = 'September' or res:month = 'October' or res:month = 'November' or res:month = 'December'">
						<!-- Yes; translate it as a YearMonth  -->
						<YearMonth>
							<xsl:value-of select="res:year"/>
							<xsl:text>-</xsl:text>
							<xsl:apply-templates select="res:month"/>
						</YearMonth> 
					</xsl:when>
					<xsl:otherwise>
						<!-- No; translate it as an unformatted StringDate -->
						<StringDate>
							<xsl:value-of select="res:month"/>
							<xsl:text> </xsl:text>
							<xsl:value-of select="res:year"/>
						</StringDate>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when> 
			<xsl:otherwise> 
				<Year>
					<xsl:value-of select="res:year"/>
				</Year> 
			</xsl:otherwise> 
		</xsl:choose> 
		
	</xsl:template>
	
	<xsl:template match="res:month">
		<xsl:choose>
			<xsl:when test=". = 'January'">
				<xsl:text>01</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'February'">
				<xsl:text>02</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'March'">
				<xsl:text>03</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'April'">
				<xsl:text>04</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'May'">
				<xsl:text>05</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'June'">
				<xsl:text>06</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'July'">
				<xsl:text>07</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'August'">
				<xsl:text>08</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'September'">
				<xsl:text>09</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'October'">
				<xsl:text>10</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'November'">
				<xsl:text>11</xsl:text>
			</xsl:when>
			<xsl:when test=". = 'December'">
				<xsl:text>12</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>	
		
	</xsl:template>
	
	<xsl:template match="res:dayOfMonth">
		<!-- Pad with a leading zero if necessary -->
		<xsl:if test=". &lt; 10">
			<xsl:text>0</xsl:text>
		</xsl:if>
		<xsl:value-of select="."/>
	</xsl:template>

</xsl:stylesheet>
