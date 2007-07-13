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

	<xsl:template match="sep:EducationHistory">

		<xsl:variable name="title">
			<xsl:call-template name="message">
				<xsl:with-param name="name">header.educationHistory</xsl:with-param>
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

			<xsl:for-each select="sep:SchoolOrInstitution/sep:Degree">
		
				<!-- Setting rowsep and colsep to 0 turns off the internal table borders in PDF output -->
				<informaltable frame="none" pgwide="1" rowsep="0" colsep="0">
					<tgroup cols="2">
						<colspec colname="description"/>
						<colspec colname="date"/>
						<tbody>
							<row>
								
								<entry>

									<emphasis role="bold">

										<!-- If the DegreeName element is specified, use it. Otherwise, generate the degree name -->
										<!-- automatically according to the degreeType attribute. -->
										<xsl:choose> 
											<xsl:when test="sep:DegreeName"> 
												<xsl:value-of select="sep:DegreeName"/> 
											</xsl:when> 
											<xsl:otherwise> 
												<xsl:apply-templates select="@degreeType"/>
											</xsl:otherwise> 
										</xsl:choose> 

										<!-- Major -->
										<xsl:if test="@degreeType and sep:DegreeMajor/sep:Name">
											<xsl:text> </xsl:text>
											<xsl:call-template name="message">
												<xsl:with-param name="name">educationHistory.degreeIn</xsl:with-param>
											</xsl:call-template>
											<xsl:text> </xsl:text>
											<xsl:value-of select="sep:DegreeMajor/sep:Name"/>
										</xsl:if>
									
									</emphasis>
									
									<!-- Academic honors -->
									<xsl:if test="sep:DegreeName/@academicHonors">
										<xsl:text> (</xsl:text>
										<xsl:value-of select="sep:DegreeName/@academicHonors"/>
										<xsl:text>)</xsl:text>
									</xsl:if>

								</entry>
								
								<!-- Degree date -->
								<entry align="right">
									<xsl:if test="sep:DegreeDate">
										<xsl:apply-templates select="sep:DegreeDate"/>
										
										<xsl:variable name="degreeDate">
											<xsl:call-template name="getDate">
												<xsl:with-param name="date" select="sep:DegreeDate"/>
											</xsl:call-template>
										</xsl:variable>
										
										<xsl:if test="string-length($degreeDate) and ($degreeDate &gt; current-date())">
											<xsl:text> </xsl:text>
											<emphasis>
												<xsl:text>(</xsl:text>
												<xsl:call-template name="message">
													<xsl:with-param name="name">educationHistory.expected</xsl:with-param>
												</xsl:call-template>
												<xsl:text>)</xsl:text>
											</emphasis>
										</xsl:if>
										
									</xsl:if>
								</entry>

							</row>
							
							<!-- School -->
							<row>
								<entry namest="description" nameend="date">
									<emphasis>
										<xsl:value-of select="../sep:School/sep:SchoolName"/>
										<xsl:if test="../sep:LocationSummary">
											<xsl:text> (</xsl:text>
											<xsl:apply-templates select="../sep:LocationSummary"/>
											<xsl:text>)</xsl:text>
										</xsl:if>
									</emphasis>
								</entry>
							</row>

							<!-- Concentration -->
							<xsl:if test="sep:DegreeMajor/sep:DegreeConcentration">
								<row>
									<entry namest="description" nameend="date">
										<xsl:call-template name="message">
											<xsl:with-param name="name">educationHistory.concentrationIn</xsl:with-param>
										</xsl:call-template>
										<xsl:text> </xsl:text>
										<xsl:value-of select="sep:DegreeMajor/sep:DegreeConcentration"/>
									</entry>
								</row>
							</xsl:if>

							<!-- Honors -->
							<xsl:if test="sep:OtherHonors">
								<row>
									<entry namest="description" nameend="date">
										<itemizedlist>
											<xsl:for-each select="sep:OtherHonors">
												<listitem>
													<simpara>
														<xsl:value-of select="."/>
													</simpara>
												</listitem>
											</xsl:for-each>
										</itemizedlist>
									</entry>
								</row>
							</xsl:if>

							<!-- Comments -->
							<xsl:if test="sep:Comments">
								<row>
									<entry namest="description" nameend="date">
										<xsl:value-of select="sep:Comments"/>
									</entry>
								</row>
							</xsl:if>

						</tbody>
					</tgroup>
				</informaltable>

				<!-- Ugly hack to add some vertical space between the entries so they're not squished together -->
				<para/>

			</xsl:for-each> 
			
		</sect1>
	
	</xsl:template>

	<xsl:template match="@degreeType">
		<xsl:choose>
			<xsl:when test=". = 'high school or equivalent'">					 
				<xsl:call-template name="message"> 
					<xsl:with-param name="name">educationHistory.highschool</xsl:with-param> 
				</xsl:call-template> 
			</xsl:when> 
			<xsl:when test=". = 'associates'">					 
				<xsl:call-template name="message"> 
					<xsl:with-param name="name">educationHistory.associates</xsl:with-param> 
				</xsl:call-template> 
			</xsl:when> 
			<xsl:when test=". = 'bachelors'">					 
				<xsl:call-template name="message"> 
					<xsl:with-param name="name">educationHistory.bachelors</xsl:with-param> 
				</xsl:call-template> 
			</xsl:when> 
			<xsl:when test=". = 'masters'">					 
				<xsl:call-template name="message"> 
					<xsl:with-param name="name">educationHistory.masters</xsl:with-param> 
				</xsl:call-template> 
			</xsl:when> 
			<xsl:when test=". = 'doctorate'">					 
				<xsl:call-template name="message"> 
					<xsl:with-param name="name">educationHistory.doctorate</xsl:with-param> 
				</xsl:call-template> 
			</xsl:when> 
			<xsl:when test=". = 'international'">					 
				<xsl:call-template name="message"> 
					<xsl:with-param name="name">educationHistory.international</xsl:with-param> 
				</xsl:call-template> 
			</xsl:when> 
		</xsl:choose> 
	</xsl:template>

	<xsl:template match="sep:LocationSummary">

		<xsl:value-of select="sep:Municipality"/>
		
		<xsl:if test="sep:Region">
			<xsl:text>, </xsl:text>
			<xsl:value-of select="sep:Region"/>
		</xsl:if>
		
		<xsl:if test="sep:CountryCode">
			<xsl:text>, </xsl:text>
			<xsl:call-template name="message"> 
				<xsl:with-param name="name">countryCode.<xsl:value-of select="sep:CountryCode"/></xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		
	</xsl:template>

</xsl:stylesheet>
