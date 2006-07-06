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
	xmlns:sep="http://ns.hr-xml.org/2006-02-28">

	<xsl:template match="sep:Telephone">
		<xsl:call-template name="TelecomNumberType">
			<xsl:with-param name="number" select="."/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="sep:Fax">
		<xsl:call-template name="TelecomNumberType">
			<xsl:with-param name="number" select="."/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="sep:Pager">
		<xsl:call-template name="TelecomNumberType">
			<xsl:with-param name="number" select="."/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="sep:TTYTDD">
		<xsl:call-template name="TelecomNumberType">
			<xsl:with-param name="number" select="."/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="sep:Mobile">
		<xsl:call-template name="TelecomNumberType">
			<xsl:with-param name="number" select="."/>
		</xsl:call-template>
		<xsl:if test="@smsEnabled='true' or @smsEnabled='1'">
			<xsl:text> </xsl:text>
			<xsl:call-template name="message">
				<xsl:with-param name="name">mobile.smsEnabled</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="TelecomNumberType">
		<xsl:param name="number"/>
		<xsl:choose>
			<xsl:when test="string-length($number/sep:FormattedNumber) != 0">
				<xsl:value-of select="$number/sep:FormattedNumber"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>(</xsl:text>
				<xsl:value-of select="$number/sep:AreaCityCode"/>
				<xsl:text>) </xsl:text>
				<xsl:value-of select="$number/sep:SubscriberNumber"/>
				<xsl:if test="string-length($number/sep:Extension) != 0">
					<xsl:text> </xsl:text>
					<xsl:call-template name="message">
						<xsl:with-param name="name">telecomNumber.extension</xsl:with-param>
					</xsl:call-template>
					<xsl:text> </xsl:text>
					<xsl:value-of select="$number/sep:Extension"/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
