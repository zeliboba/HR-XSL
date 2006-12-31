<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<!-- HR-XSL parameters -->
	
	<!-- Month format options: short (default), long -->
	<xsl:param name="month.format" select="long"/> 

	<!-- Example of localization -->
	<!-- <xsl:param name="lang" select="it"/>  -->


	<!-- DocBook parameters -->

	<!-- Generate table of contents? 'article toc'=yes (default), 'article nop'=no -->
	<xsl:param name="generate.toc" select="'article nop'"/> 
	
	<!-- CSS stylesheet to use (HTML output only) -->
	<xsl:param name="html.stylesheet" select="'style.css'"/> 
	
	<!-- Display URLs after links? 1=yes (default), 0=no -->
	<xsl:param name="ulink.show" select="0"/> 

	<!-- Paper size: 'USletter' (default), 'A4', etc. -->
	<!-- <xsl:param name="paper.type" select="'A4'"/>  -->
	
	<!-- Paper orientation: 'portrait' (default), 'landscape' -->
	<!-- <xsl:param name="page.orientation" select="'landscape'"/>  -->

</xsl:stylesheet>
