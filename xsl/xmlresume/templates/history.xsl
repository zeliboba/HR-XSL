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

	<xsl:template match="res:history"> 
		<EmploymentHistory> 
			<xsl:apply-templates select="res:job"/> 
		</EmploymentHistory> 
	</xsl:template> 

	<xsl:template match="res:job"> 

		<EmployerOrg> 
			
			<xsl:if test="res:job/@targets">
				<xsl:call-template name="comment">
					<xsl:with-param name="name">Job targets not supported.</xsl:with-param>
				</xsl:call-template>
			</xsl:if>

			<!-- Employer name -->
			<EmployerOrgName>
				<xsl:value-of select="res:employer"/>
			</EmployerOrgName> 
			
			<!-- Employer location -->
			<EmployerContactInfo> 
				<xsl:apply-templates select="res:location"/>
			</EmployerContactInfo>
			
			<PositionHistory> 
				
				<!-- Job title -->
				<Title>
					<xsl:value-of select="res:jobtitle"/>
				</Title>

				<!-- The OrgName entity is required in HR-XML, but there's no analog to it -->
				<!-- in XML Resume, so we just leave it blank. -->
				<xsl:call-template name="comment">
					<xsl:with-param name="name">HR-XML OrgName required but not supported (no equivalent for it in XML Resume).</xsl:with-param>
				</xsl:call-template>
				
				<OrgName>
					<OrganizationName/>
				</OrgName>

				<Description>  
					
					<!-- Description -->
					<xsl:for-each select="res:description/res:para">
						<xsl:value-of select="normalize-space(.)"/>
						<xsl:if test="position() != last() and not(res:projects)"> 
							<xsl:text>&#xa;</xsl:text>
						</xsl:if> 
					</xsl:for-each>
					
					<!-- Projects -->
					<xsl:if test="res:projects">
						<xsl:if test="res:description">
							<xsl:text>&#xa;</xsl:text>
						</xsl:if>
						<xsl:for-each select="res:projects/res:project">
							<xsl:if test="@title">
								<xsl:call-template name="comment">
									<xsl:with-param name="name">Project titles not supported.</xsl:with-param>
								</xsl:call-template>
							</xsl:if>

							<xsl:value-of select="normalize-space(.)"/>
							<xsl:if test="position() != last()"> 
								<xsl:text>&#xa;</xsl:text>
							</xsl:if> 
						</xsl:for-each>
					</xsl:if>							

					<!-- Achievements -->
					<xsl:if test="res:achievements">
						<xsl:if test="res:description or res:projects">
							<xsl:text>&#xa;</xsl:text>
						</xsl:if>
						<xsl:for-each select="res:achievements/res:achievement">
							<xsl:value-of select="normalize-space(.)"/>
							<xsl:if test="position() != last()"> 
								<xsl:text>&#xa;</xsl:text>
							</xsl:if> 
						</xsl:for-each>
					</xsl:if>	
											
				</Description>  

				<!-- Start date -->
				<StartDate> 
					<xsl:choose>
						<xsl:when test="res:period/res:from/res:date">
							<xsl:apply-templates select="res:period/res:from/res:date"/>				
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="res:date"/>
						</xsl:otherwise>
					</xsl:choose>
				</StartDate>
				
				<!-- End date - skip this if the date for "to" = <present/> -->
				<xsl:if test="res:period/res:to/res:date">
					<EndDate> 
						<xsl:apply-templates select="res:period/res:to/res:date"/>				
					</EndDate> 
				</xsl:if>

			</PositionHistory> 

		</EmployerOrg> 

	</xsl:template> 

</xsl:stylesheet>
