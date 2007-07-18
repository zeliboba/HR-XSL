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

	<xsl:template match="res:academics"> 
		<EducationHistory> 
			<xsl:apply-templates select="res:degrees/res:degree"/> 
		</EducationHistory> 
	</xsl:template> 

	<xsl:template match="res:degrees/res:degree"> 
		
		<xsl:call-template name="comment">
			<xsl:with-param name="name">All degrees assumed to be university-level.</xsl:with-param>
		</xsl:call-template>
		
		<SchoolOrInstitution schoolType="university"> 

			<School>
				<SchoolName>
					<xsl:value-of select="res:institution"/>
				</SchoolName> 
			</School>

			<xsl:apply-templates select="res:location"/>

			<Degree> 
				
				<DegreeName>
					<xsl:value-of select="res:level"/>
				</DegreeName> 
				
				<xsl:if test="res:major">
					<DegreeMajor>
						<Name>
							<xsl:value-of select="res:major"/>
						</Name>
					</DegreeMajor> 
				</xsl:if>
				
				<xsl:if test="res:gpa"> 
					<DegreeMeasure> 
						<EducationalMeasure> 
							<MeasureSystem>GPA</MeasureSystem> 
							<MeasureValue> 
								<NumericValue>
									<xsl:value-of select="res:gpa/res:score"/>
								</NumericValue> 
							</MeasureValue>
							<xsl:if test="res:gpa/res:possible">
								<HighestPossibleValue> 
									<NumericValue>
										<xsl:value-of select="res:gpa/res:possible"/>
									</NumericValue>
								</HighestPossibleValue>
							</xsl:if>
						</EducationalMeasure> 
					</DegreeMeasure> 
				</xsl:if> 
				
				<DatesOfAttendance> 

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

				</DatesOfAttendance>

				<xsl:if test="res:annotation or res:subjects">
					<Comments>
						<xsl:if test="res:annotation">
							<xsl:value-of select="normalize-space(res:annotation)"/>
						</xsl:if>
			
						<xsl:if test="res:subjects">
							<xsl:if test="res:annotation">
								<xsl:text>&#xa;</xsl:text>
							</xsl:if>
							<xsl:for-each select="res:subjects/res:subject">
								<xsl:value-of select="res:title"/>
								<xsl:text>: </xsl:text>
								<xsl:value-of select="res:result"/>
								<xsl:if test="position() != last()"> 
									<xsl:text>&#xa;</xsl:text>
								</xsl:if> 
							</xsl:for-each>
						</xsl:if>
					</Comments> 
				</xsl:if>
				
			</Degree> 

		</SchoolOrInstitution> 

	</xsl:template> 

</xsl:stylesheet>
