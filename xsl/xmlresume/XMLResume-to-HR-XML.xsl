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

<!--
	
This stylesheet is designed to convert an XML resume in the XML Resume format (http://xmlresume.sourceforge.net/) into the HR-XML format (http://www.hr-xml.org/).

Notes:

For <job>, the <description>, <projects>, and <achievements> elements are merged into a single <Description> element for HR-XML.
For <degree>, the <subjects> element is flattened into the <Comment> element for HR-XML.
All educational institutions are assumed to be universities.
	
Unsupported top-level elements:

<misc>
<referees>
<keywords>
<clearances>
	
Unsupported inline elements (list may not be complete):

<emphasis>	
<link>
<url>
	
There are also several unsupported mid-level elements. In most cases, if the stylesheet encounters one of these unsupported elements, it prints a notice in the output as a comment.

-->

<xsl:stylesheet version="2.0"
	xmlns="http://ns.hr-xml.org/2007-04-15" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:res="http://xmlresume.sourceforge.net/resume/0.0"
	exclude-result-prefixes="res">
    
	<xsl:output method="xml" version="1.0" encoding="UTF-8"/> 
	<xsl:output indent="yes"/> 

	<xsl:strip-space elements="*"/> 
	
	<xsl:include href="templates/common.xsl"/>
	<xsl:include href="templates/header.xsl"/>
	<xsl:include href="templates/objective.xsl"/>
	<xsl:include href="templates/history.xsl"/>
	<xsl:include href="templates/academics.xsl"/>
	<xsl:include href="templates/pubs.xsl"/>
	<xsl:include href="templates/skillset.xsl"/>
	<xsl:include href="templates/awards.xsl"/>
	<xsl:include href="templates/memberships.xsl"/>
	<xsl:include href="templates/interests.xsl"/>
	<xsl:include href="templates/copyright.xsl"/>
	<xsl:include href="templates/misc.xsl"/>
	<xsl:include href="templates/referees.xsl"/>
	<xsl:include href="templates/keywords.xsl"/>
	<xsl:include href="templates/clearances.xsl"/>
	<xsl:include href="templates/lastModified.xsl"/>

	<xsl:template match="res:resume">  
		<Resume
			xmlns="http://ns.hr-xml.org/2007-04-15" 
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
			xsi:schemaLocation="http://ns.hr-xml.org/2007-04-15 Resume.xsd"> 
			
			<xsl:if test="@id">
				<ResumeId>
					<IdValue>
						<xsl:value-of select="@id"/>
					</IdValue>
				</ResumeId>
			</xsl:if>
			
			<StructuredXMLResume> 
				<xsl:apply-templates select="res:header"/>   
				<xsl:apply-templates select="res:objective"/> 
				<xsl:apply-templates select="res:history"/>    
				<xsl:apply-templates select="res:academics"/>   
				<xsl:apply-templates select="res:pubs"/>   
				
				<!-- Special handling for skillarea  -->
				<xsl:if test="res:skillarea"> 
					<Qualifications> 
						<xsl:for-each select="res:skillarea"> 
							<xsl:if test="@targets"> 
								<xsl:call-template name="comment"> 
									<xsl:with-param name="name">Skill area targets not supported.</xsl:with-param> 
								</xsl:call-template>					 
							</xsl:if> 
							<xsl:if test="res:title"> 
								<xsl:call-template name="comment"> 
									<xsl:with-param name="name">Skill area title not supported (unless no skill set title is given).</xsl:with-param> 
								</xsl:call-template>					 
							</xsl:if> 
							<xsl:apply-templates select="res:skillset"/> 
						</xsl:for-each> 
					</Qualifications> 
				</xsl:if> 
				
				<xsl:apply-templates select="res:awards"/>  
				<xsl:apply-templates select="res:memberships"/>  
				<xsl:apply-templates select="res:interests"/>  
				<xsl:apply-templates select="res:copyright"/> 
				<xsl:apply-templates select="res:misc"/> 
				<xsl:apply-templates select="res:referees"/> 
				<xsl:apply-templates select="res:keywords"/> 
				<xsl:apply-templates select="res:clearances"/> 
				<xsl:apply-templates select="res:lastModified"/> 
				
			</StructuredXMLResume> 
		</Resume> 
    </xsl:template> 

</xsl:stylesheet>
