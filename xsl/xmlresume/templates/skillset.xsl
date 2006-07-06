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

	<xsl:template match="res:skillset"> 

		<Competency>
			
			<xsl:attribute name="name">
				<xsl:choose>
					<xsl:when test="res:title">
						<xsl:value-of select="res:title"/>
					</xsl:when>
					<xsl:otherwise>
						<!-- If no title is specified for the skillset, use the skillarea title. -->
						<xsl:value-of select="../res:title"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>

			<xsl:for-each select="res:skill">
				
				<xsl:if test="@level">
					<xsl:call-template name="comment">
						<xsl:with-param name="name">Skill level not supported.</xsl:with-param>
					</xsl:call-template>						
				</xsl:if>
				
				<Competency>
					<xsl:attribute name="name">
						<xsl:value-of select="normalize-space(.)"/>
					</xsl:attribute>
				</Competency>
			</xsl:for-each>
			
		</Competency>

	</xsl:template> 
	
</xsl:stylesheet>
