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
	xmlns:sep="http://ns.hr-xml.org/2007-04-15"
	exclude-result-prefixes="sep">

	<xsl:template match="sep:ContactInfo">

		<title>
			<xsl:apply-templates select="sep:PersonName"/>
		</title>

		<xsl:apply-templates select="sep:ContactMethod"/> 
		
	</xsl:template>

	<xsl:template match="sep:ContactMethod"> 

		<!-- Setting rowsep and colsep to 0 turns off the internal table borders in PDF output -->
		<informaltable frame="none" rowsep="0" colsep="0">
			<tgroup cols="2">
				<tbody>

					<!-- Address -->
					<xsl:if test="sep:PostalAddress">
						<row>
							<entry align="right" valign="top">
								<emphasis role="bold">
									<xsl:call-template name="message">
										<xsl:with-param name="name">contactMethod.PostalAddress</xsl:with-param>
									</xsl:call-template>
								</emphasis>
							</entry>
							<xsl:apply-templates select="sep:PostalAddress"/>
						</row>
					</xsl:if>
	
					<!-- Telephone -->
					<xsl:if test="sep:Telephone">
						<row>
							<entry align="right">
								<emphasis role="bold">
									<xsl:call-template name="message">
										<xsl:with-param name="name">contactMethod.Telephone</xsl:with-param>
									</xsl:call-template>
								</emphasis>
							</entry>
							<entry>
								<xsl:apply-templates select="sep:Telephone"/>
							</entry>
						</row>
					</xsl:if>
	
					<!-- Fax -->
					<xsl:if test="sep:Fax">
						<row>
							<entry align="right">
								<emphasis role="bold">
									<xsl:call-template name="message">
										<xsl:with-param name="name">contactMethod.Fax</xsl:with-param>
									</xsl:call-template>
								</emphasis>
							</entry>
							<entry>
								<xsl:apply-templates select="sep:Fax"/>
							</entry>	
						</row>
					</xsl:if>

					<!-- Pager -->
					<xsl:if test="sep:Pager">
						<row>
							<entry align="right">
								<emphasis role="bold">
									<xsl:call-template name="message">
										<xsl:with-param name="name">contactMethod.Pager</xsl:with-param>
									</xsl:call-template>
								</emphasis>
							</entry>
							<entry>
								<xsl:apply-templates select="sep:Pager"/>
							</entry>
						</row>
					</xsl:if>

					<!-- TTY/TDD -->
					<xsl:if test="sep:TTYTDD">
						<row>
							<entry align="right">
								<emphasis role="bold">
									<xsl:call-template name="message">
										<xsl:with-param name="name">contactMethod.TTYTDD</xsl:with-param>
									</xsl:call-template>
								</emphasis>
							</entry>
							<entry valign="top">
								<xsl:apply-templates select="sep:TTYTDD"/>
							</entry>
						</row>
					</xsl:if>

					<!-- Mobile -->
					<xsl:if test="sep:Mobile">
						<row>
							<entry align="right">
								<emphasis role="bold">
									<xsl:call-template name="message">
										<xsl:with-param name="name">contactMethod.Mobile</xsl:with-param>
									</xsl:call-template>
								</emphasis>
							</entry>
							<entry>
								<xsl:apply-templates select="sep:Mobile"/>
							</entry>
						</row>
					</xsl:if>

					<!-- E-mail -->
					<xsl:if test="sep:InternetEmailAddress">
						<row>
							<entry align="right">
								<emphasis role="bold">
									<xsl:call-template name="message">
										<xsl:with-param name="name">contactMethod.InternetEmailAddress</xsl:with-param>
									</xsl:call-template>
								</emphasis>
							</entry>
							<entry>
								<ulink>
									<xsl:attribute name="url">
										<xsl:text>mailto:</xsl:text>
										<xsl:value-of select="normalize-space(sep:InternetEmailAddress)"/>
									</xsl:attribute>
									<xsl:value-of select="normalize-space(sep:InternetEmailAddress)"/>
								</ulink>
							</entry>
						</row>
					</xsl:if>

					<!-- URL -->
					<xsl:if test="sep:InternetWebAddress">
						<row>
							<entry align="right">
								<emphasis role="bold">
									<xsl:call-template name="message">
										<xsl:with-param name="name">contactMethod.InternetWebAddress</xsl:with-param>
									</xsl:call-template>
								</emphasis>
							</entry>
							<entry>
								<ulink>
									<xsl:attribute name="url">
										<xsl:value-of select="normalize-space(sep:InternetWebAddress)"/>
									</xsl:attribute>
									<xsl:value-of select="normalize-space(sep:InternetWebAddress)"/>
								</ulink>
							</entry>
						</row>
					</xsl:if>

				</tbody>
			</tgroup>
		</informaltable>
		
	</xsl:template> 
	
	<xsl:template match="sep:PostalAddress">

		<entrytbl cols="1">	 
			<tbody>
		 
				<xsl:for-each select="sep:Recipient/sep:AdditionalText"> 
					<row> 
						<entry>
							<xsl:value-of select="."/> 
						</entry>
					</row>
				</xsl:for-each> 
		 
				<xsl:if test="sep:Recipient/sep:PersonName"> 
					<row> 
						<entry>
						<xsl:apply-templates select="sep:Recipient/sep:PersonName"/> 
						</entry>
					</row>
				</xsl:if> 
		 
				<xsl:if test="sep:Recipient/sep:OrganizationName"> 
					<row> 
						<entry>
						<xsl:value-of select="sep:Recipient/sep:OrganizationName"/> 
						</entry>
					</row>
				</xsl:if> 
			 
				<xsl:for-each select="sep:DeliveryAddress/sep:AddressLine">  
					<row> 
						<entry>
						<xsl:value-of select="."/> 
						</entry>
					</row>
				</xsl:for-each> 
		 
				<xsl:if test="sep:DeliveryAddress/sep:PostOfficeBox">  
					<row> 
						<entry>
						<xsl:call-template name="message"> 
							<xsl:with-param name="name">contactMethod.POBox</xsl:with-param> 
						</xsl:call-template> 
						<xsl:text> </xsl:text> 
						<xsl:value-of select="sep:DeliveryAddress/sep:PostOfficeBox"/> 
						</entry>
					</row>
				</xsl:if> 
			 
				<xsl:if test="sep:DeliveryAddress/sep:StreetName or sep:DeliveryAddress/sep:BuildingNumber or sep:DeliveryAddress/sep:Unit"> 
			 
					<row> 
						<entry>
		 
						<xsl:if test="sep:DeliveryAddress/sep:BuildingNumber"> 
							<xsl:value-of select="sep:DeliveryAddress/sep:BuildingNumber"/> 
						</xsl:if> 
				 
						<xsl:if test="sep:DeliveryAddress/sep:StreetName"> 
							<xsl:text> </xsl:text> 
							<xsl:value-of select="sep:DeliveryAddress/sep:StreetName"/> 
						</xsl:if> 
				 
						<xsl:if test="sep:DeliveryAddress/sep:Unit"> 
							<xsl:text> </xsl:text> 
							<xsl:value-of select="sep:DeliveryAddress/sep:Unit"/> 
						</xsl:if> 
			 
						</entry>
					</row>
		 
				</xsl:if> 
		 
				<row> 
					<entry>

						<xsl:if test="sep:Municipality"> 
							<xsl:value-of select="sep:Municipality"/> 
							<xsl:text>, </xsl:text> 
						</xsl:if> 

						<xsl:for-each select="sep:Region"> 
							<xsl:value-of select="."/> 
							<xsl:text> </xsl:text> 
						</xsl:for-each> 
		 
						<xsl:if test="sep:PostalCode"> 
							<xsl:value-of select="sep:PostalCode"/> 
						</xsl:if> 
					
					</entry>
				</row>
				 
				<xsl:if test="sep:CountryCode"> 
					<row> 
						<entry>
							<xsl:call-template name="message"> 
								<xsl:with-param name="name">countryCode.<xsl:value-of select="sep:CountryCode"/></xsl:with-param> 
							</xsl:call-template> 
						</entry>
					</row>
				</xsl:if> 
			 
			</tbody>
		</entrytbl>
		
	</xsl:template>

</xsl:stylesheet>
