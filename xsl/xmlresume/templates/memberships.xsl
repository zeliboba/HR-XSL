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

	<xsl:template match="res:memberships"> 
		
		<xsl:call-template name="comment">
			<xsl:with-param name="name">All memberships are assumed to be professional societies. Memberships title is ignored.</xsl:with-param>
		</xsl:call-template>						

		<Associations>			
			<xsl:apply-templates select="res:membership"/>
		</Associations>

	</xsl:template> 
	
	<xsl:template match="res:membership">
		
		<Association>
			
			<Name>
				<xsl:value-of select="res:organization"/>
			</Name>
			
			<xsl:choose>
				<xsl:when test="res:period">
					<StartDate>
						<xsl:apply-templates select="res:period/res:from/res:date"/>
					</StartDate>
					<xsl:if test="not(res:period/res:to/res:present)">
						<EndDate>
							<xsl:apply-templates select="res:period/res:to/res:date"/>
						</EndDate>
					</xsl:if>
				</xsl:when>
				<xsl:when test="res:date">
					<StartDate>
						<xsl:apply-templates select="res:date"/>
					</StartDate>
				</xsl:when>
			</xsl:choose>
			
			<xsl:if test="res:title">
				<Role>
					<Name>
						<xsl:value-of select="res:title"/>
					</Name>
				</Role>
			</xsl:if>
			
			<xsl:if test="res:description">
				<Comments>
					<xsl:value-of select="normalize-space(res:description)"/>
				</Comments>
			</xsl:if>						
			
		</Association>
		
	</xsl:template>
	
</xsl:stylesheet>
