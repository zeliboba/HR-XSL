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

	<xsl:variable name="LF" select="'&#10;'"/>
	<xsl:variable name="CR" select="'&#13;'"/>

	<xsl:template match="sep:EmploymentHistory">

		<!-- Section title -->
		<xsl:variable name="title">
			<xsl:call-template name="message">
				<xsl:with-param name="name">header.employmentHistory</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>

		<!-- Is this a functional or chronological list? -->
		<xsl:choose>

			<xsl:when test="sep:EmployerOrg/sep:PositionHistory/sep:OrgIndustry">

				<!-- It's functional -->

				<sect1>

					<!-- Generate a section ID from the title -->
					<xsl:attribute name="id">
						<!-- Remove spaces from the title because IDs can't have them -->
						<xsl:value-of select="translate($title, ' ', '')"/>
					</xsl:attribute>

					<title>
						<xsl:value-of select="$title"/>
					</title>

					<xsl:for-each-group
						select="sep:EmployerOrg/sep:PositionHistory"
						group-by="sep:OrgIndustry/sep:IndustryDescription">
						
						<sect2>
							<xsl:variable name="subTitle">
								<xsl:value-of select="current-grouping-key()"/>
							</xsl:variable>

							<!-- Generate a section ID from the title -->
							<xsl:attribute name="id">
								<!-- Remove spaces from the title because IDs can't have them -->
								<xsl:value-of select="translate($subTitle, ' ', '')"/>
							</xsl:attribute>

							<title>
								<xsl:value-of select="$subTitle"/>
							</title>

							<xsl:apply-templates select="current-group()"/>						
						</sect2>
						
					</xsl:for-each-group>

				</sect1>

			</xsl:when>

			<xsl:otherwise>

				<!-- It's chronological -->
				
				<sect1>

					<!-- Generate a section ID from the title -->
					<xsl:attribute name="id">
						<!-- Remove spaces from the title because IDs can't have them -->
						<xsl:value-of select="translate($title, ' ', '')"/>
					</xsl:attribute>
					
					<title>
						<xsl:value-of select="$title"/>
					</title>

					<xsl:apply-templates select="sep:EmployerOrg/sep:PositionHistory"/> 
				</sect1>

			</xsl:otherwise>

		</xsl:choose>

	</xsl:template>

	<xsl:template match="sep:EmployerOrg/sep:PositionHistory">

		<!-- Setting rowsep and colsep to 0 turns off the internal table borders in PDF output -->
		<informaltable frame="none" pgwide="1" rowsep="0" colsep="0">
			<tgroup cols="2">
				<colspec colname="description"/>
				<colspec colname="date"/>
				<tbody>
					<row>
						
						<xsl:choose>
							<xsl:when test="sep:StartDate = 'notApplicable'">
								<!-- Position title -->
								<entry namest="description" nameend="date">
									<emphasis role="bold">
										<xsl:value-of select="sep:Title"/>
									</emphasis>
								</entry>
							</xsl:when>
							<xsl:otherwise>
								<!-- Position title -->
								<entry>
									<emphasis role="bold">
										<xsl:value-of select="sep:Title"/>
									</emphasis>
								</entry>

								<!-- Position date -->
								<entry align="right">
									<xsl:apply-templates select="sep:StartDate"/>

									<xsl:text> - </xsl:text>

									<xsl:choose>
										<xsl:when test="sep:EndDate">
											<xsl:apply-templates select="sep:EndDate"/>
										</xsl:when>
										<xsl:otherwise>
											<!-- If no end date, assume present -->
											<xsl:call-template name="message">
												<xsl:with-param name="name">date.present</xsl:with-param>
											</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
								</entry>
							</xsl:otherwise>
						</xsl:choose>
							
					</row>
			
					<xsl:if test="string-length(sep:OrgName/sep:OrganizationName) != 0 or string-length(../sep:EmployerOrgName) != 0">
				
						<row>
						
							<!-- Organization and employer name -->
							<entry namest="description" nameend="date">
						
								<emphasis>
									<!-- This field is required according to the spec, but we want it to be optional, -->
									<!-- so we check for an empty string instead of testing for existence.            -->
									<xsl:if test="string-length(sep:OrgName/sep:OrganizationName) != 0">
										<xsl:value-of select="sep:OrgName/sep:OrganizationName"/>
									</xsl:if>

									<!-- This field is required according to the spec, but we want it to be optional, -->
									<!-- so we check for an empty string instead of testing for existence.            -->
									<xsl:if test="string-length(../sep:EmployerOrgName) != 0">
										<xsl:if test="string-length(sep:OrgName/sep:OrganizationName) != 0">
											<xsl:text>, </xsl:text>
										</xsl:if>
										<xsl:value-of select="../sep:EmployerOrgName"/>
									</xsl:if>
								</emphasis>
						
							</entry>
						</row>
					</xsl:if>
			
				</tbody>
			</tgroup>
		</informaltable>

		<!-- This field is required according to the spec, but we want it to be optional, -->
		<!-- so we check for an empty string instead of testing for existence.            -->
		<xsl:if test="string-length(sep:Description) != 0">
			<xsl:choose>
				<xsl:when test="contains(sep:Description, $CR) or contains(sep:Description, $LF)">
					<!-- The description is on multiple lines; make each line a list item -->
					<itemizedlist>
						<xsl:apply-templates select="sep:Description"/>
					</itemizedlist>
				</xsl:when>
				<xsl:otherwise>
					<!-- The description doesn't contain any newlines, so don't put it in a list -->
					<blockquote>
						<para>
							<xsl:value-of select="normalize-space(sep:Description)"/>
						</para>
					</blockquote>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>

	</xsl:template>

	<xsl:template match="sep:Description">
		<xsl:variable name="text" select="."/>
		<xsl:call-template name="descriptionItem">
			<!-- Handle Windows-style line separators by changing all CRs to LFs.    -->
			<!-- Duplicate LFs are not a problem because multiple LFs in a row are   -->
			<!-- handled correctly in the code below. (They're seen as a single LF.) -->
			<xsl:with-param name="text" select="translate($text, $CR, $LF)"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="descriptionItem">
		<xsl:param name="text"/>
		<xsl:variable name="listItem" select="normalize-space(substring-before($text, $LF))"/>

		<xsl:if test="string-length($listItem) != 0">
			<listitem>
				<simpara>
					<xsl:value-of select="$listItem"/>
				</simpara>
			</listitem>
		</xsl:if>

		<!-- Recursively call this function on the remaining text. -->
		<xsl:variable name="remainingText" select="substring-after($text, $LF)"/>
		<xsl:if test="string-length(normalize-space($remainingText)) != 0">
			<xsl:call-template name="descriptionItem">
				<xsl:with-param name="text" select="$remainingText"/>
			</xsl:call-template>
		</xsl:if>

	</xsl:template>

</xsl:stylesheet>
