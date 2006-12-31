<!--
	
	This file implements a customization layer allowing user-configurable parameters that must be
	specified as attribute sets (such as formal.title.properties) to be used. See:
	http://www.sagehill.net/docbookxsl/CustomMethods.html#CustomizationLayer

	Note that the href attributes in the <xsl:import> calls are not file names but rather XML catalog
	IDs that map to file names.

-->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:import href="stylesheet"/>
	<xsl:import href="parameters"/>  
			
</xsl:stylesheet>
