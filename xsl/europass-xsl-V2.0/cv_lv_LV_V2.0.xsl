<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : cv_lv_LV_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass CV in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/cv_lv_LV_V2.0.xsl
</xsl:comment>
<xsl:variable name="step3Before">
	<xsl:choose>
		<xsl:when test="//field[@name='step3List' and @before='step4List']">1</xsl:when>
		<xsl:when test="//field[@name='step4List' and @before='step3List']">0</xsl:when>
	</xsl:choose>
</xsl:variable>
<html>
  <head>
    <title>CV - HTML</title>
    <link href="http://europass.cedefop.europa.eu/instruments/css/html.css" type="text/css" rel="stylesheet"/>
  </head>
	<body>
		<table width="700" border="0" cellspacing="0" cellpadding="0" class="CV">
		  <xsl:call-template name="logoheader"/>
		  <xsl:call-template name="personalinformation"/>
		  <xsl:call-template name="application"/>
		  <xsl:choose>
			<xsl:when test="$step3Before=1">
				<xsl:call-template name="workexperience"/>
				<xsl:call-template name="educationalexperience"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="educationalexperience"/>				
				<xsl:call-template name="workexperience"/>
			</xsl:otherwise>
		  </xsl:choose>
		  <xsl:call-template name="personalskillscompetences" />
		  <xsl:call-template name="annexes"/>
		</table>
		<br/>
		<xsl:call-template name="grid"/>
	</body>
</html>
</xsl:template>
<xsl:template name="logoheader">
	<tr>
		<td><img src="http://europass.cedefop.europa.eu/instruments/images/logospace.gif" height="1" width="190"/></td>
		<td><img src="http://europass.cedefop.europa.eu/instruments/images/logospace.gif" height="1" width="7"/></td>
		<td><img src="http://europass.cedefop.europa.eu/instruments/images/logospace.gif" height="1" width="8"/></td>
		<td colspan="11"><img src="http://europass.cedefop.europa.eu/instruments/images/logospace.gif" height="1" width="495"/></td>
	</tr>
	<tr>
		<td class="Logo" rowspan="2">&#160;</td>
		<td style="height:42px;">&#160;</td>
		<td colspan="12" rowspan="2">&#160;</td>
	</tr>
	<tr>
		<td class="Corner">&#160;</td>
	</tr>
	<xsl:call-template name="headingRow">
		<xsl:with-param name="heading">&#160;</xsl:with-param>
		<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
	</xsl:call-template>
	<tr>
		<td class="Title"><xsl:text>Europass</xsl:text><br/><xsl:text>Curriculum Vitae</xsl:text></td>
		<xsl:call-template name="verticalline"/>
		<td class="Normal" colSpan="11">&#160;</td>
	</tr>
	<xsl:call-template name="headingRow">
		<xsl:with-param name="heading">&#160;</xsl:with-param>
		<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="personalinformation">
	<xsl:variable name="firstNameBefore">
		<xsl:choose>
		  <xsl:when test="//field[@name='step1.firstName' and @before='step1.lastName']">1</xsl:when>
		  <xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:call-template name="headingRow">
		<xsl:with-param name="heading"><xsl:text>Personas dati</xsl:text></xsl:with-param>
		<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="labelHeadingRow">
		<xsl:with-param name="label">
			<xsl:choose>
				<xsl:when test="$firstNameBefore=0">
				  <xsl:text>Uzvārds Vārds</xsl:text>
				</xsl:when>
				<xsl:otherwise>
				  <xsl:text>Vārds Uzvārds</xsl:text>
				</xsl:otherwise>
			  </xsl:choose>
		</xsl:with-param>
		<xsl:with-param name="labelcontent">
			<xsl:choose>
				<xsl:when test="$firstNameBefore=0">
				  <xsl:value-of select="europass:learnerinfo/identification/lastname" />&#160;<xsl:value-of select="europass:learnerinfo/identification/firstname" />
				</xsl:when>
				<xsl:otherwise>
				  <xsl:value-of select="europass:learnerinfo/identification/firstname" />&#160;<xsl:value-of select="europass:learnerinfo/identification/lastname" />
				</xsl:otherwise>
			  </xsl:choose>
		</xsl:with-param>
	</xsl:call-template>	
	<xsl:if test="//field[@name='step1.addressInfo' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Adrese</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">
				<xsl:for-each select="europass:learnerinfo/identification/contactinfo/address/addressLine">
				<xsl:value-of select="current()" /><br/>
			  </xsl:for-each>
			  <xsl:if test="string-length(europass:learnerinfo/identification/contactinfo/address/postalCode) != 0">
			  <xsl:value-of select="europass:learnerinfo/identification/contactinfo/address/postalCode" />, </xsl:if>
			  <xsl:value-of select="europass:learnerinfo/identification/contactinfo/address/municipality" />
			  <xsl:if test="string-length(europass:learnerinfo/identification/contactinfo/address/country/label) != 0"> (<xsl:value-of select="europass:learnerinfo/identification/contactinfo/address/country/label" />)</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:choose>
		<xsl:when test="//field[@name='step1.telephone' and @keep='true'] and //field[@name='step1.mobile' and @keep='true']">
			<xsl:call-template name="labelRowTwoCells">
				<xsl:with-param name="label1"><xsl:text>Tālrunis</xsl:text></xsl:with-param>
				<xsl:with-param name="label1content"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/telephone" /></xsl:with-param>
				<xsl:with-param name="label2"><xsl:text>Mobilais tālrunis</xsl:text></xsl:with-param>
				<xsl:with-param name="label2content"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/mobile" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="//field[@name='step1.telephone' and @keep='true'] and //field[@name='step1.mobile' and @keep='false'] ">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Tālrunis</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/telephone" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="//field[@name='step1.telephone' and @keep='false'] and //field[@name='step1.mobile' and @keep='true'] ">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Mobilais tālrunis</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/mobile" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
	<xsl:if test="//field[@name='step1.fax' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Fakss</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/fax" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.email' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>E-pasts</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/email" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.nationality' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Pilsonība</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">
				<xsl:for-each select="europass:learnerinfo/identification/demographics/nationality/label">
					<xsl:if test="position() != 1">,&#160;</xsl:if>
					<xsl:value-of select="current()"/>
				</xsl:for-each>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.birthDate' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Dzimšanas datums</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">
				<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.gender' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Dzimums</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">
				<xsl:if test="europass:learnerinfo/identification/demographics/gender='M'"><xsl:text>Vīrietis</xsl:text></xsl:if>
			  <xsl:if test="europass:learnerinfo/identification/demographics/gender='F'"><xsl:text>Sieviete</xsl:text></xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>
<xsl:template name="application">
	<xsl:if test="//field[@name='step1.application.label' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Vēlamā nodarbošanās/ profesionālā joma</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent"><xsl:value-of select="europass:learnerinfo/application/label" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>	
</xsl:template>
<xsl:template name="workexperience">
	<xsl:if test="//field[@name='step3List' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Darba pieredze</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
		</xsl:call-template>
		<xsl:for-each select="europass:learnerinfo/workexperiencelist/workexperience">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Laika periods</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:call-template name="perioddates"/></xsl:with-param>
			</xsl:call-template>
			<xsl:variable name="indexedStep3"><xsl:value-of select="concat('step3List[', position()-1, ']')" /></xsl:variable>
			<xsl:if test="//field[@name=concat($indexedStep3,'.position.label') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Profesija vai ieņemamais amats</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="position/label" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep3,'.activities') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Galvenie pienākumi</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="activities" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep3,'.company.name') and @keep='true']">
				<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Darba vietas nosaukums un adrese</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent">
					<xsl:value-of select="employer/name" />
					<xsl:if test="//field[@name=concat($indexedStep3,'.company.addressInfo') and @keep='true']">
						&#160;
						<xsl:call-template name="address">
							<xsl:with-param name="element" select="employer/address"/>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep3,'.company.sector.label') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Nozare</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="employer/sector/label" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="emptyLabelRow"/>
		</xsl:for-each>
	</xsl:if>
</xsl:template>
<xsl:template name="educationalexperience">
	<xsl:if test="//field[@name='step4List' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Izglītība</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
		</xsl:call-template>		
		<xsl:for-each select="europass:learnerinfo/educationlist/education">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Laika periods</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:call-template name="perioddates"/></xsl:with-param>
			</xsl:call-template>
			<xsl:variable name="indexedStep4"><xsl:value-of select="concat('step4List[', position()-1, ']')" /></xsl:variable>
			<xsl:if test="//field[@name=concat($indexedStep4,'.title') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Piešķirtā izglītības dokumenta nosaukums/ Piešķirtā kvalifikācija</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="title" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep4,'.skills') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Galvenie mācību priekšmeti / iegūtās profesionālās prasmes</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="skills" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep4,'.educationalOrg.name') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Izglītības iestādes nosaukums un veids</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent">
						<xsl:value-of select="organisation/name" />
						<xsl:if test="string-length(organisation/type) != 0"><xsl:text> (</xsl:text><xsl:value-of select="organisation/type" /><xsl:text>) </xsl:text></xsl:if>
						<xsl:if test="//field[@name=concat($indexedStep4,'.educationalOrg.addressInfo') and @keep='true']">
							&#160;
							<xsl:call-template name="address">
								<xsl:with-param name="element" select="organisation/address"/>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep4,'.level.label') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Līmenis nacionālajā vai starptautiskajā klasifikācijas sistēmā</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="level/label" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="emptyLabelRow"/>
		</xsl:for-each>
	</xsl:if>
</xsl:template>
<xsl:template name="personalskillscompetences">
	<xsl:call-template name="headingRow">
		<xsl:with-param name="heading"><xsl:text>Prasmes</xsl:text></xsl:with-param>
		<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="motherlanguages" />
	<xsl:call-template name="foreignlanguages" />
	<xsl:call-template name="emptyLabelRow"/>
	<xsl:call-template name="skills" />
</xsl:template>
<xsl:template name="motherlanguages">
	<xsl:if test="//field[@name='step5.motherLanguages' and @keep='true']">
		<xsl:call-template name="labelHeadingRow">
			<xsl:with-param name="label"><xsl:text>Dzimtā valoda</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>
<xsl:template name="foreignlanguages">
	<xsl:if test="//field[@name='step5.foreignLanguageList' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Citas valodas</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">&#160;</xsl:with-param>
		</xsl:call-template>
		<tr>
			<td class="Label"><xsl:text>Pašnovērtējums</xsl:text></td>
			<xsl:call-template name="verticalline"/>
			<td class="Heading2Center" colSpan="4"><xsl:text>Sapratne</xsl:text></td>
			<td class="Heading2Center" colSpan="4"><xsl:text>Runāšana</xsl:text></td>
			<td class="Heading2Center" colSpan="2"><xsl:text>Rakstīšana</xsl:text></td>
			<td width="1%">&#160;</td>
		</tr>
		<tr>
			<td class="Label"><xsl:text>Eiropas līmenis</xsl:text></td>
			<xsl:call-template name="verticalline"/>
			<td class="NormalSmall" colSpan="2"><xsl:text>Klausīšanās</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Lasīšana</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Dialogs</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Monologs</xsl:text></td>
			<td class="NormalSmall" colSpan="2">&#160;</td>
			<td width="1%">&#160;</td>
		</tr>
		<xsl:for-each select="europass:learnerinfo/languagelist/language[@xsi:type='europass:foreign']">
			<xsl:variable name="indexedLang"><xsl:value-of select="concat('step5.foreignLanguageList[', position()-1, ']')" /></xsl:variable>
			<xsl:if test="//field[@name=$indexedLang and @keep='true']">
				<tr>
					<td class="Heading1Box"><xsl:value-of select="label" /></td>
					<td class="VerticalLineBox">&#160;</td>
					<td>&#160;</td>
					<xsl:call-template name="selfassessmentlevel">
						<xsl:with-param name="element"><xsl:value-of select="level/listening" /></xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="selfassessmentlevel">
						<xsl:with-param name="element"><xsl:value-of select="level/reading" /></xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="selfassessmentlevel">
						<xsl:with-param name="element"><xsl:value-of select="level/spokeninteraction" /></xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="selfassessmentlevel">
						<xsl:with-param name="element"><xsl:value-of select="level/spokenproduction" /></xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="selfassessmentlevel">
						<xsl:with-param name="element"><xsl:value-of select="level/writing" /></xsl:with-param>
					</xsl:call-template>
					<td width="1%">&#160;</td>
				</tr>
			</xsl:if>
		</xsl:for-each>
	</xsl:if>
</xsl:template>
<xsl:template name="selfassessmentlevel">
	<xsl:param name="element"/>
	<td class="NormalSmall" width="5%"><xsl:value-of select="$element" /></td>
	<td class="NormalSmall">
		<xsl:if test="$element='a1'">Pamatlīmenis</xsl:if>
		<xsl:if test="$element='b1'">Vidējais līmenis</xsl:if>
		<xsl:if test="$element='c1'">Augstākais līmenis</xsl:if>
		<xsl:if test="$element='a2'">Pamatlīmenis</xsl:if>
		<xsl:if test="$element='b2'">Vidējais līmenis</xsl:if>
		<xsl:if test="$element='c2'">Augstākais līmenis</xsl:if>
	</td>
</xsl:template>
<xsl:template name="skills">
	<xsl:if test="//field[@name='step6.socialSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Sociālās prasmes</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='social']" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.organisationalSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Organizatoriskas prasmes</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='organisational']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.technicalSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Tehniskas prasmes</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='technical']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.computerSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Datora lietošanas prasmes</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='computer']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.artisticSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Mākslinieciskas prasmes</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='artistic']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.otherSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Citas prasmes</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='other']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.drivingLicences' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Vadītāja apliecība</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">
				<xsl:for-each select="europass:learnerinfo/skilllist/structured-skill[@xsi:type='europass:driving']/drivinglicence">
					<xsl:if test="position() != 1">,&#160;</xsl:if>
					<xsl:value-of select="current()" />
				</xsl:for-each>
			</xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	 
</xsl:template>
<xsl:template name="annexes">
	<xsl:if test="//field[@name='step7.additionalInfo' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Papildu informācija</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent"><xsl:value-of select="europass:learnerinfo/misclist/misc[@type='additional']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step7.annexes' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Pielikumi</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent"><xsl:value-of select="europass:learnerinfo/misclist/misc[@type='annexes']" /></xsl:with-param>
		</xsl:call-template>	
	</xsl:if>
</xsl:template>
<xsl:template name="address">
	<xsl:param name="element"/>
	<xsl:for-each select="$element/addressLine">
		<xsl:value-of select="current()" /><br/>
	</xsl:for-each>
	<xsl:if test="string-length($element/postalCode) != 0"><xsl:value-of select="$element/postalCode" />, </xsl:if>
	<xsl:value-of select="$element/municipality" />
	<xsl:if test=" string-length($element/country/label) != 0"> (<xsl:value-of select="$element/country/label" />)</xsl:if>
</xsl:template>
<xsl:template name="perioddates">
	<xsl:value-of select="translate(period/from/day,'-','')" />
	<xsl:if test="string-length(period/from/day) != 0">/</xsl:if>
	<xsl:value-of select="translate(period/from/month,'-','')" />
	<xsl:if test="string-length(period/from/month) != 0">/</xsl:if>
	<xsl:value-of select="translate(period/from/year,'-','')" />
	<xsl:if test="string-length(period/to/day) != 0 or string-length(period/to/month) != 0 or string-length(period/to/year) != 0">-</xsl:if>
	<xsl:value-of select="translate(period/to/day,'-','')" />
	<xsl:if test="string-length(period/to/day) != 0">/</xsl:if>
	<xsl:value-of select="translate(period/to/month,'-','')" />
	<xsl:if test="string-length(period/to/month) != 0">/</xsl:if>
	<xsl:value-of select="translate(period/to/year,'-','')" />
</xsl:template>
<xsl:template name="labelRow">
	<xsl:param name="label"/>
	<xsl:param name="labelcontent"/>
	<tr>
		<td class="Label"><xsl:value-of select="$label"/></td>
		<xsl:call-template name="verticalline"/>
		<td class="Normal" colSpan="11"><xsl:value-of select="$labelcontent"/></td>
	</tr>
</xsl:template>
<xsl:template name="labelHeadingRow">
	<xsl:param name="label"/>
	<xsl:param name="labelcontent"/>
	<tr>
		<td class="Label"><xsl:value-of select="$label"/></td>
		<xsl:call-template name="verticalline"/>
		<td class="Heading2" colSpan="11"><xsl:value-of select="$labelcontent"/></td>
	</tr>
</xsl:template>
<xsl:template name="labelRowTwoCells">
	<xsl:param name="label1"/>
	<xsl:param name="label1content"/>
	<xsl:param name="label2"/>
	<xsl:param name="label2content"/>
	<tr>
		<td class="Label"><xsl:value-of select="$label1"/></td>
		<xsl:call-template name="verticalline"/>
		<td class="Normal" colSpan="5"><xsl:value-of select="$label1content"/></td>
		<td class="Label" width="15%" colSpan="2"><xsl:value-of select="$label2"/></td>
		<td class="Normal" colSpan="4"><xsl:value-of select="$label2content"/></td>
	</tr>
</xsl:template>
<xsl:template name="emptyLabelRow">
	<tr>
		<td class="Label">&#160;</td>
		<xsl:call-template name="verticalline"/>
		<td class="Normal" colSpan="11">&#160;</td>
	</tr>
</xsl:template>
<xsl:template name="headingRow">
	<xsl:param name="heading"/>
	<xsl:param name="headingcontent"/>
	<tr>
		<td class="Heading1"><xsl:value-of select="$heading"/></td>
		<xsl:call-template name="verticalline"/>
		<td class="Normal" colspan="11"><xsl:value-of select="$headingcontent"/></td>
	</tr>
</xsl:template>
<xsl:template name="verticalline">
	<td class="VerticalLine">&#160;</td>
	<td>&#160;</td>
</xsl:template>
<xsl:template name="grid">
	<xsl:if test="//field[@name='grid' and @keep='true']">
		<table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<td colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title"><xsl:text>EIROPAS VALODU PRASMES LĪMEŅI  –  PAŠNOVĒRTĒJUMA TABULA</xsl:text></th>
			</tr>
		<tr class="level">
				<th>A1</th>
				<td>Es saprotu pazīstamus vārdus un dažas ļoti  vienkāršas frāzes, kad lēni un skaidri runā  par mani, manu ģime­ni un tuvāko apkārtni.</td>
				<td>Es saprotu pazīstamus vārdus  un nosauku­mus, kā arī ļoti vien­kāršus teikumus, pie­mēram, paziņoju­mos, plakātos, katalo­gos.</td>
				<td>Es varu vienkāršā veidā sazināties, ja sarunu biedrs teikto  var lēnām atkārtot vai pateikt citiem vārdiem un palīdz man formu­lēt to, ko es cenšos pasacīt. Es varu uzdot vienkāršus jautājumus  un atbildēt uz tiem sarunā par man ļoti labi zināmām tēmām.</td>
				<td>Es varu vienkāršos  tei­kumos pastāstīt par savu dzīvesvietu un cil­vēkiem, kurus pa­zīstu.</td>
				<td>Es protu uzrakstīt īsu, vienkāršu tekstu, pie­mēram, nosūtīt ap­svei­kuma pastkarti. Es protu aizpildīt veid­la­pas ar personas da­tiem, piemēram, ierak­stīt savu vārdu, pilso­nī­bu un adresi vies­nī­cas reģistrācijas lapā.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Es saprotu atsevišķas frāzes un biežāk lietotos vārdus izteikumos, kam ir saistība ar mani (pie­mēram, vienkāršu infor­māciju par sevi un ģimeni, iepirkšanos, dzī­vesvietu, darbu). Es varu uztvert galveno domu īsos, vienkāršos un  skaidri izrunātos pa­zi­ņojumos, sludinā­ju­mos.</td>
				<td>Es varu izlasīt ļoti īsus un vienkāršus tekstus. Es varu sameklēt kon­krētu informāciju vien­kāršos, ar ikdienas dzīvi saistītos  tekstos:  sludi­nājumos, reklām­izde­vumos, ēdienkartēs, sa­rak­stos. Es varu saprast  īsas un vienkār­šas  pri­vātās vēstules.</td>
				<td>Es varu sazināties parastās ikdienišķās si­tuācijās, kur notiek vienkārša informācijas apmaiņa  par man zinā­miem tematiem vai dar­bībām. Es varu iesais­tīties ļoti īsā sarunā par sadzīviskiem jautāju­miem, tomēr ma­na va­lo­das prasme ir nepie­tiekama, lai  pat­stā­vīgi veidotu dialogu.</td>
				<td>Es varu vienkāršos tei­ku­mos pastāstīt par  savu ģimeni un citiem cilvēkiem, dzīves ap­stāk­ļiem, savu izglītību un pašreizējo vai iepriek­šējo darbu.</td>
				<td>Es varu uzrakstīt īsas zīmītes un vienkāršus paziņojumus.  Es protu uzrakstīt ļoti vienkāršu vēstuli, piemēram, izsa­kot kādam pateicību.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Es saprotu galveno saturu skaidrā un  literāri pareizā runā par pazīstamām tē­mām, ar kurām es sa­skaros darbā, skolā, brīvajā laikā utt. Es saprotu radio un televīzijas raidījumu saturu  tad, kad samērā lēni un skaidri runā  par aktuāliem notikumiem vai tematiem, kuri mani interesē perso­nīgi vai profesionāli.</td>
				<td>Es saprotu tekstus, kuros izmantota  ikdienā bieži lietota  vai ar manu darbu saistīta valoda. Es varu saprast privātajās  vēstulēs aprakstītos  notikumus, izjūtas un vēlmes.</td>
				<td>Es spēju ārzemju ceļojuma laikā sazināties situācijās, kur nepieciešams runāt. Es varu bez iepriekšējas sagatavošanās iesaistīties sarunā par man zināmiem vai mani interesējošiem, kā arī ar  ikdienas dzīvi saistītiem tematiem (pie­mēram, “ģimene”, “vaļas­prieks”, “darbs”,  “ceļo­ša­na”, “jaunākie notiku­mi”).</td>
				<td>Es protu veidot un saistīt kopā izteikumus, lai pa­stāstītu par pieredzēto un dažādiem notikumiem, sa­viem sapņiem, cerībām un vēlmēm. Es varu īsi  pa­matot un paskaidrot savus uzskatus un nodomus. Es varu pastāstīt stāstu, iz­klās­tīt grāmatas vai filmas saturu un izteikt par to savu attieksmi.</td>
				<td>Es protu uzrakstīt vien­kāršu, saistītu tekstu par jautājumiem, kas man ir zināmi vai mani interesē. Es varu uzrakstīt vēstuli, aprakstot  tajā savus pār­dzī­vojumus un iespaidus.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Es varu saprast garāku runu un lekcijas, sekot līdzi  pat sarežģītai argu­mentācijai, ja temats ir pietiekami  pazīstams. Es saprotu gandrīz visu televīzijas ziņās un repor­tāžās par jaunāka­jiem notikumiem. Es saprotu gandrīz visas filmas literārajā runā.</td>
				<td>Es varu izlasīt pārskatus un rakstus par aktuālām problēmām, kuros autors pauž noteiktu  attieksmi vai viedokli. Es varu saprast mūsdienu prozas darbus.</td>
				<td>Es varu  diezgan brīvi un bez sagatavošanās sazi­nāties ar dzimtās valodas runātājiem. Es varu aktīvi piedalīties dis­ku­­­­si­jās par man zināmām problēmām, pamatojot un aizstāvot savu  viedokli.</td>
				<td>Es varu skaidru un  vispusīgu dažādu tēmu izklāstu, kas ietilpst ma­nā interešu lokā. Es varu pamatot savus uz­ska­tus par kādu strīdīgu jautā­jumu, izvērtējot at­šķi­rīgos viedokļus.</td>
				<td>Es varu uzrakstīt skaidru, detalizētu tekstu par da­žādiem jautājumiem, kas skar manu interešu loku. Es varu uzrakstīt eseju vai ziņojumu, dot rak­stisku informāciju, kā arī argumentēt vienu vai otru viedokli. Es protu uz­rak­stīt vēstules, izceļot man nozīmīgākos notikumus un  iespaidus.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Es varu saprast garāku runu arī tad, ja tai  nav  skaidra uzbūve un ir vāji izteiktas loģiskās sakarības.  Es bez pū­lēm saprotu televīzi­jas raidījumus un filmas.</td>
				<td>Es varu saprast garus un sarežģītus dažāda tipa tekstus, izprotot stila atšķirības. Es varu sa­prast speciālos rak­stus un garākas teh­niskās instrukcijas, pat tad, ja tās neattiecas uz manu darbības jomu.</td>
				<td>Es varu veikli un brīvi izteikties,  piemērotus vārdus un izteicienus īpaši nemeklējot. Es protu prasmīgi lietot valodu gan ikdienas situācijās, gan darba vajadzībām. Es protu precīzi formulēt savas domas un uzskatus un prasmīgi uzturēt sarunu.</td>
				<td>Es varu skaidru un vispusīgu sarežģītu  tēmu izklāstu , iekļaut tajā pakārtotus jautā­jumus, izvērst atse­višķas tēzes un nobeigt ar atbilstošiem  secinā­jumiem.</td>
				<td>Es protu skaidri un loģiski  uzrakstīt savas domas, izteikt savu viedokli. Es varu uzrak­stīt vēstuli, eseju vai ziņojumu par sarežģī­tiem jautājumiem, iz­ceļot to, ko es uzskatu par nozīmīgu un sva­rīgu. Es protu rakstīt konkrētam lasītājam pie­­­mē­rotā  stilā.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Es bez grūtībām  sa­pro­tu jebkuru runas veidu – gan tiešā sa­ziņā  teikto, gan pār­raidīto pat tad, ja ātrā tempā runā dzimtās valodas lieto­tājs. Es varu saprast runātājus ar dažādām izrunas īpatnībām.</td>
				<td>Es bez grūtībām varu izlasīt dažāda tipa, uzbūves vai valodas ziņā sarežģītus tek­stus: rokasgrāmatas, speciālos rakstus, lite­rāros darbus.</td>
				<td>Es varu bez grūtībām piedalīties jebkurā sa­runā vai diskusijā, labi pārzinu idiomā­tiskos izteicienus un sarun­valodas vārdus. Es varu runāt pilnīgi brīvi un precīzi izteikt  nozīmes smal­kā­kās nianses. Ja valodas lietojumā man rodas grūtības, es protu tik veikli pār­veidot sacī­to, ka citi to nemana.</td>
				<td>Es varu pilnīgi brīvi, skaidri un argumen­tēti, konkrētajai situā­cijai atbilstošā veidā sniegt kādas tēmas izklāstu.  Es protu vei­dot savu stāstījumu tā, lai klausītājam būtu vieglāk uztvert un iegau­mēt nozīmīgākos jautājumus.</td>
				<td>Es protu uzrakstīt skaidru, loģisku tekstu atbilstošā stilā. Es varu uzrakstīt sarež­ģītas vēstules, referā­tus vai rakstus tā, lai  lasītājam būtu viegli pamanīt un atcerēties svarīgākās  vietas. Es varu uzrakstīt pārska­tus un recenzijas gan par  literārajiem, gan speciālās literatūras dar­biem.</td>
			</tr>
		</table>
	</xsl:if>
</xsl:template>
</xsl:stylesheet>
