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
	xmlns:sep="http://ns.hr-xml.org/2006-02-28"
	exclude-result-prefixes="sep">
    
	<xsl:output method="xml" version="1.0" encoding="UTF-8"/>
	
	<!-- Don't pretty-print; the DocBook XSL sometimes generates <span>s, where  -->
	<!-- excess whitespace can mess things up.  -->
	<!-- <xsl:output indent="yes"/> -->
	
	<xsl:output doctype-public="-//OASIS//DTD DocBook XML V4.4//EN"/>
	<xsl:output doctype-system="http://www.oasis-open.org/docbook/xml/4.4/docbookx.dtd"/>

	<xsl:strip-space elements="*"/>

	<xsl:include href="../common/common.xsl"/>

	<xsl:include href="templates/ContactInfo.xsl"/>
	<xsl:include href="templates/EmploymentHistory.xsl"/>
	<xsl:include href="templates/EducationHistory.xsl"/>
	<xsl:include href="templates/PublicationHistory.xsl"/>
	<xsl:include href="templates/SpeakingEventsHistory.xsl"/>
	<xsl:include href="templates/Languages.xsl"/>
	<xsl:include href="templates/Qualifications.xsl"/>
	<xsl:include href="templates/Achievements.xsl"/>
	<xsl:include href="templates/Associations.xsl"/>
	<xsl:include href="templates/ResumeAdditionalItems.xsl"/>

	<xsl:template match="/sep:Resume/sep:StructuredXMLResume">
		<article>
			<xsl:apply-templates select="sep:ContactInfo"/> 
			
			<xsl:if test="sep:ExecutiveSummary">
				<abstract>
					<para>
						<xsl:value-of select="sep:ExecutiveSummary"/>
					</para>
				</abstract>
			</xsl:if>
			
			<xsl:if test="sep:Objective">
				<formalpara>
					<title>
						<xsl:call-template name="message">
							<xsl:with-param name="name">header.objective</xsl:with-param>
						</xsl:call-template>
					</title>
					<para>
						<xsl:value-of select="normalize-space(sep:Objective)"/>
					</para>
				</formalpara>
			</xsl:if>
			
			<xsl:apply-templates select="sep:EmploymentHistory"/>  
			<xsl:apply-templates select="sep:EducationHistory"/>  
			<xsl:apply-templates select="sep:PublicationHistory"/>  
			<xsl:apply-templates select="sep:SpeakingEventsHistory"/>  
			<xsl:apply-templates select="sep:Languages"/>  
			<xsl:apply-templates select="sep:Qualifications"/>  
			<xsl:apply-templates select="sep:Achievements"/>  
			<xsl:apply-templates select="sep:Associations"/>  
			<xsl:apply-templates select="sep:ResumeAdditionalItems"/>   
		</article>
    </xsl:template>

</xsl:stylesheet>