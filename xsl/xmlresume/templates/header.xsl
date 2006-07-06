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

	<xsl:variable name="LF" select="'&#10;'"/>
	<xsl:variable name="CR" select="'&#13;'"/>

	<xsl:template match="res:header">
		<ContactInfo> 
			<xsl:apply-templates select="res:name"/> 
			<ContactMethod> 
				<xsl:apply-templates select="res:contact"/> 
				<xsl:apply-templates select="res:address"/> 
				<xsl:apply-templates select="res:birth"/> 
			</ContactMethod> 
		</ContactInfo> 
	</xsl:template>

	<xsl:template match="res:name">
		
		<xsl:if test="@id">
			<xsl:call-template name="comment">
				<xsl:with-param name="name">Name IDs not supported.</xsl:with-param>
			</xsl:call-template>						
		</xsl:if>
		
		<PersonName> 
			<GivenName>
				<xsl:value-of select="res:firstname"/>
			</GivenName> 
			
			<xsl:if test="res:middlenames">
				<MiddleName>
					<xsl:value-of select="res:middlenames"/>
				</MiddleName> 
			</xsl:if>
			
			<FamilyName>
				<xsl:value-of select="res:surname"/>
			</FamilyName> 
		</PersonName> 
		
	</xsl:template> 

	<xsl:template match="res:address">
		<PostalAddress>
			<xsl:choose>
				<xsl:when test="res:country">
					<xsl:call-template name="comment">
						<xsl:with-param name="name">Country element ignored; assumed to be US.</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="comment">
						<xsl:with-param name="name">Country not found; assumed to be US.</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
					
			<CountryCode>US</CountryCode>

			<!-- Is this an unformatted address? -->
			<xsl:choose>
				<!-- Unformatted; need to parse each line -->
				<xsl:when test="string-length(normalize-space(text())) != 0">
					<DeliveryAddress>
						<xsl:call-template name="addressLine">
							<!-- Handle Windows-style line separators by changing all CRs to LFs.    -->
							<!-- Duplicate LFs are not a problem because multiple LFs in a row are   -->
							<!-- handled correctly in the code below. (They're seen as a single LF.) -->
							<xsl:with-param name="text" select="translate(text(), $CR, $LF)"/>
						</xsl:call-template>
					</DeliveryAddress>
				</xsl:when>
				<!-- Formatted -->
				<xsl:otherwise>					
					<PostalCode>
						<xsl:value-of select="res:zip"/>
					</PostalCode> 
					<Region>
						<xsl:value-of select="res:state"/>
					</Region> 
					<Municipality>
						<xsl:value-of select="res:city"/>
					</Municipality> 
					<DeliveryAddress> 
						<AddressLine>
							<xsl:value-of select="res:street"/>
						</AddressLine> 
					</DeliveryAddress> 
				</xsl:otherwise>
			</xsl:choose>
		</PostalAddress> 
	</xsl:template> 

	<xsl:template name="addressLine">
		<xsl:param name="text"/>
		<xsl:variable name="listItem" select="substring-before($text, $LF)"/>

		<AddressLine>
			<xsl:choose>
				<!-- Special-case handling for single-line fields -->
				<!-- (i.e. without any newlines in them).         -->
				<xsl:when test="string-length(normalize-space($listItem)) = 0">
					<xsl:value-of select="normalize-space($text)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="normalize-space($listItem)"/>
				</xsl:otherwise>
			</xsl:choose>
		</AddressLine>

		<!-- Recursively call this function on the remaining text. -->
		<xsl:variable name="remainingText" select="substring-after($text, $LF)"/>
		<xsl:if test="string-length(normalize-space($remainingText)) != 0">
			<xsl:call-template name="addressLine">
				<xsl:with-param name="text" select="$remainingText"/>
			</xsl:call-template>
		</xsl:if>

	</xsl:template>

	<xsl:template match="res:birth"> 
		<xsl:call-template name="comment">
			<xsl:with-param name="name">Birth date not supported.</xsl:with-param>
		</xsl:call-template>
	</xsl:template> 

	<xsl:template match="res:contact"> 
		<xsl:apply-templates select="res:phone"/> 
		<xsl:apply-templates select="res:email"/> 
		<xsl:apply-templates select="res:url"/> 
		<xsl:apply-templates select="res:instantMessage"/> 
	</xsl:template> 

	<xsl:template match="res:email"> 
		<InternetEmailAddress> 
			<xsl:value-of select="."/> 
		</InternetEmailAddress> 
	</xsl:template> 

	<xsl:template match="res:url"> 
		<InternetWebAddress> 
			<xsl:value-of select="."/> 
		</InternetWebAddress> 
	</xsl:template> 

	<xsl:template match="res:phone"> 
		<xsl:choose>
			<xsl:when test="@location = 'mobile'">
				<Mobile>
					<FormattedNumber>
						<xsl:value-of select="."/>
					</FormattedNumber> 
				</Mobile>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="comment">
					<xsl:with-param name="name">Phone location not supported.</xsl:with-param>
				</xsl:call-template>
				<Telephone> 
					<FormattedNumber>
						<xsl:value-of select="."/>
					</FormattedNumber> 
				</Telephone> 
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template> 

	<xsl:template match="res:instantMessage">
		<xsl:call-template name="comment">
			<xsl:with-param name="name">Instant message not supported.</xsl:with-param>
		</xsl:call-template>
	</xsl:template> 

</xsl:stylesheet>
