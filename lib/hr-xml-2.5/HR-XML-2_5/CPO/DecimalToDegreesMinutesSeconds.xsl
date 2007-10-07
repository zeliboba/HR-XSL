<!-- 
This is an example stylesheet showing the transformation of coordinates from a decimal representation to one using degrees, minutes, and seconds. Apply this stylesheet to  the accompanying DecimalToDegreesMinutesSeconds.xml to see the results. This type of transformation may be useful to those working with the HR-XML's PhysicalLocation schema.

Copyright 2007 HR-XML Consortium, Inc.
http://ns.hr-xml.org/2_5/HR-XML-2_5/license.txt
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template name="decimalToDegreesMinutesSeconds">
		<xsl:param name="latlongdecimal"/>
		<xsl:param name="negativesign"/>
		<xsl:param name="positivesign"/>
		<xsl:variable name="baseval">
			<xsl:value-of select="round($latlongdecimal * 3600) div 3600"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$baseval &lt; 0">
				<xsl:variable name="integer">
					<xsl:value-of select="floor(-$baseval)"/>
				</xsl:variable>
				<xsl:variable name="decimal">
					<xsl:value-of select="-$baseval - floor(-$baseval)"/>
				</xsl:variable>
				<xsl:variable name="minutes">
					<xsl:value-of select="floor($decimal * 60)"/>
				</xsl:variable>
				<xsl:variable name="decimalSeconds">
					<xsl:value-of select="($decimal * 60) - $minutes"/>
				</xsl:variable>
				<xsl:variable name="seconds">
					<xsl:value-of select="round($decimalSeconds * 60)"/>
				</xsl:variable>
				<xsl:value-of select="$integer"/>&#176; <xsl:value-of select="$minutes"/>&#39; <xsl:value-of select="$seconds"/>&#34;
			<xsl:value-of select="$negativesign"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="integer">
					<xsl:value-of select="floor($baseval)"/>
				</xsl:variable>
				<xsl:variable name="decimal">
					<xsl:value-of select="$baseval - floor($baseval)"/>
				</xsl:variable>
				<xsl:variable name="minutes">
					<xsl:value-of select="floor($decimal * 60)"/>
				</xsl:variable>
				<xsl:variable name="decimalSeconds">
					<xsl:value-of select="($decimal * 60) - $minutes"/>
				</xsl:variable>
				<xsl:variable name="seconds">
					<xsl:value-of select="round($decimalSeconds * 60)"/>
				</xsl:variable>
				<xsl:value-of select="$integer"/>&#176; <xsl:value-of select="$minutes"/>&#39; <xsl:value-of select="$seconds"/>&#34;
			<xsl:value-of select="$positivesign"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="/">
		<xsl:call-template name="decimalToDegreesMinutesSeconds">
			<xsl:with-param name="latlongdecimal" select="Location/longitude"/>
			<xsl:with-param name="negativesign" select="string('E')"/>
			<xsl:with-param name="positivesign" select="string('W')"/>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
