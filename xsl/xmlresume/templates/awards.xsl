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
	xmlns="http://ns.hr-xml.org/2007-04-15" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:res="http://xmlresume.sourceforge.net/resume/0.0"
	exclude-result-prefixes="res">

	<xsl:template match="res:awards"> 
		
		<xsl:if test="res:title">
			<xsl:call-template name="comment">
				<xsl:with-param name="name">Awards title not supported.</xsl:with-param>
			</xsl:call-template>						
		</xsl:if>
		
		<Achievements> 
			<xsl:apply-templates select="res:award"/> 
		</Achievements> 
	</xsl:template> 

	<xsl:template match="res:award"> 
		
		<xsl:if test="@targets">
			<xsl:call-template name="comment">
				<xsl:with-param name="name">Award targets not supported.</xsl:with-param>
			</xsl:call-template>						
		</xsl:if>
		
		<Achievement> 
			
			<Date>
				<xsl:choose>
					<xsl:when test="res:period">
						<StringDate> 
							<xsl:if test="res:period/res:from/res:date/res:month">
								<xsl:value-of select="res:period/res:from/res:date/res:month"/>
								<xsl:text> </xsl:text>
							</xsl:if>
							<xsl:value-of select="res:period/res:from/res:date/res:year"/>
							<xsl:text> - </xsl:text> 
							<xsl:choose> 
								<xsl:when test="res:period/res:to/res:present">
									<xsl:text>Present</xsl:text>
								</xsl:when> 
								<xsl:otherwise>
									<xsl:value-of select="res:period/res:to/res:date/res:year"/>
								</xsl:otherwise> 
							</xsl:choose> 
						</StringDate>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="res:date"/>
					</xsl:otherwise>
				</xsl:choose>
			</Date> 
			
			<Description> 
				<xsl:value-of select="res:title"/> 
				<xsl:if test="res:description">
					<xsl:text>: </xsl:text>
					<xsl:value-of select="res:description"/>
				</xsl:if> 
			</Description> 
			
			<IssuingAuthority>
				<xsl:value-of select="res:organization"/>
			</IssuingAuthority> 
			
		</Achievement> 
		
	</xsl:template> 
	
</xsl:stylesheet>
