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
  # Name      : cv_fi_FI_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass CV in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/cv_fi_FI_V2.0.xsl
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
		<td class="Title"><xsl:text>Europass-ansioluettelo</xsl:text><br/><xsl:text></xsl:text></td>
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
		<xsl:with-param name="heading"><xsl:text>Henkilötiedot</xsl:text></xsl:with-param>
		<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="labelHeadingRow">
		<xsl:with-param name="label">
			<xsl:choose>
				<xsl:when test="$firstNameBefore=0">
				  <xsl:text>Sukunimi Etunimet</xsl:text>
				</xsl:when>
				<xsl:otherwise>
				  <xsl:text>Etunimet Sukunimi</xsl:text>
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
			<xsl:with-param name="label"><xsl:text>Osoitteet</xsl:text></xsl:with-param>
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
				<xsl:with-param name="label1"><xsl:text>Puhelinnumero(t)</xsl:text></xsl:with-param>
				<xsl:with-param name="label1content"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/telephone" /></xsl:with-param>
				<xsl:with-param name="label2"><xsl:text>Matkapuhelin</xsl:text></xsl:with-param>
				<xsl:with-param name="label2content"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/mobile" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="//field[@name='step1.telephone' and @keep='true'] and //field[@name='step1.mobile' and @keep='false'] ">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Puhelinnumero(t)</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/telephone" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="//field[@name='step1.telephone' and @keep='false'] and //field[@name='step1.mobile' and @keep='true'] ">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Matkapuhelin</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/mobile" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
	<xsl:if test="//field[@name='step1.fax' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Faksinumero(t)</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/fax" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.email' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Sähköposti</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/email" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.nationality' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Kansalaisuus</xsl:text></xsl:with-param>
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
			<xsl:with-param name="label"><xsl:text>Syntymäaika</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">
				<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.gender' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Sukupuoli</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">
				<xsl:if test="europass:learnerinfo/identification/demographics/gender='M'"><xsl:text>mies</xsl:text></xsl:if>
			  <xsl:if test="europass:learnerinfo/identification/demographics/gender='F'"><xsl:text>nainen</xsl:text></xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>
<xsl:template name="application">
	<xsl:if test="//field[@name='step1.application.label' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Haettu työpaikka / ammattiala</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent"><xsl:value-of select="europass:learnerinfo/application/label" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>	
</xsl:template>
<xsl:template name="workexperience">
	<xsl:if test="//field[@name='step3List' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Työkokemus</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
		</xsl:call-template>
		<xsl:for-each select="europass:learnerinfo/workexperiencelist/workexperience">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Päivämäärät</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:call-template name="perioddates"/></xsl:with-param>
			</xsl:call-template>
			<xsl:variable name="indexedStep3"><xsl:value-of select="concat('step3List[', position()-1, ']')" /></xsl:variable>
			<xsl:if test="//field[@name=concat($indexedStep3,'.position.label') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Toimi tai tehtävä</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="position/label" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep3,'.activities') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Keskeiset tehtävät ja vastuualat</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="activities" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep3,'.company.name') and @keep='true']">
				<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Työnantajan nimi ja osoite</xsl:text></xsl:with-param>
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
					<xsl:with-param name="label"><xsl:text>Ansiotoiminnan tyyppi tai toimiala</xsl:text></xsl:with-param>
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
			<xsl:with-param name="heading"><xsl:text>Yleissivistävä ja ammatillinen koulutus</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
		</xsl:call-template>		
		<xsl:for-each select="europass:learnerinfo/educationlist/education">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Päivämäärät</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:call-template name="perioddates"/></xsl:with-param>
			</xsl:call-template>
			<xsl:variable name="indexedStep4"><xsl:value-of select="concat('step4List[', position()-1, ']')" /></xsl:variable>
			<xsl:if test="//field[@name=concat($indexedStep4,'.title') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Tutkinnon nimi</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="title" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep4,'.skills') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Tärkeimmät oppiaineet tai ammattitaidot</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="skills" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep4,'.educationalOrg.name') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Oppilaitoksen nimi ja tyyppi</xsl:text></xsl:with-param>
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
					<xsl:with-param name="label"><xsl:text>Koulutuksen taso kansallisessa tai kansainvälisessä luokituksessa</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="level/label" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="emptyLabelRow"/>
		</xsl:for-each>
	</xsl:if>
</xsl:template>
<xsl:template name="personalskillscompetences">
	<xsl:call-template name="headingRow">
		<xsl:with-param name="heading"><xsl:text>Henkilökohtaiset tiedot ja taidot</xsl:text></xsl:with-param>
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
			<xsl:with-param name="label"><xsl:text>Äidinkieli tai -kielet</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>
<xsl:template name="foreignlanguages">
	<xsl:if test="//field[@name='step5.foreignLanguageList' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Muut kielet</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">&#160;</xsl:with-param>
		</xsl:call-template>
		<tr>
			<td class="Label"><xsl:text>Itsearviointi</xsl:text></td>
			<xsl:call-template name="verticalline"/>
			<td class="Heading2Center" colSpan="4"><xsl:text>Ymmärtäminen</xsl:text></td>
			<td class="Heading2Center" colSpan="4"><xsl:text>Puhuminen</xsl:text></td>
			<td class="Heading2Center" colSpan="2"><xsl:text>Kirjoittaminen</xsl:text></td>
			<td width="1%">&#160;</td>
		</tr>
		<tr>
			<td class="Label"><xsl:text>Eurooppalainen taitotaso</xsl:text></td>
			<xsl:call-template name="verticalline"/>
			<td class="NormalSmall" colSpan="2"><xsl:text>Kuuntelu</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Lukeminen</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Suullinen vuorovaikutus</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Suullinen tuottaminen</xsl:text></td>
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
		<xsl:if test="$element='a1'">Peruskielitaito</xsl:if>
		<xsl:if test="$element='b1'">Itsenäisen kielenkäyttäjän kielitaito</xsl:if>
		<xsl:if test="$element='c1'">Taitavan kielenkäyttäjän kielitaito</xsl:if>
		<xsl:if test="$element='a2'">Peruskielitaito</xsl:if>
		<xsl:if test="$element='b2'">Itsenäisen kielenkäyttäjän kielitaito</xsl:if>
		<xsl:if test="$element='c2'">Taitavan kielenkäyttäjän kielitaito</xsl:if>
	</td>
</xsl:template>
<xsl:template name="skills">
	<xsl:if test="//field[@name='step6.socialSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Sosiaaliset taidot</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='social']" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.organisationalSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Organisatoriset taidot</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='organisational']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.technicalSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Tekniset tiedot ja taidot</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='technical']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.computerSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Tietotekniset taidot</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='computer']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.artisticSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Taiteelliset taidot</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='artistic']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.otherSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Muut tiedot ja taidot</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='other']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.drivingLicences' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Ajokortti</xsl:text></xsl:with-param>
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
			<xsl:with-param name="heading"><xsl:text>Lisätietoa</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent"><xsl:value-of select="europass:learnerinfo/misclist/misc[@type='additional']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step7.annexes' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Liitteet</xsl:text></xsl:with-param>
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
				<th colspan="6" class="title"><xsl:text>Eurooppalainen taso – Itsearviointilokerikko</xsl:text></th>
			</tr>
		<tr class="level">
				<th>A1</th>
				<td>Tunnistan tuttuja sanoja ja kaikkein tavallisimpia sanontoja, jotka koskevat minua itseäni, perhettäni ja lähiympäristöäni, kun minulle puhutaan hitaasti ja selvästi.</td>
				<td>Ymmärrän tuttuja nimiä, sanoja ja hyvin yksinkertaisia lauseita esimerkiksi ilmoituksissa, julisteissa ja luetteloissa.</td>
				<td>Selviydyn kaikkein yksinkertaisimmista keskusteluista, jos puhekumppanini on valmis toistamaan sanottavansa tai ilmaisemaan asian toisin, puhumaan tavallista hitaammin ja auttamaan minua muotoilemaan sen, mitä yritän sanoa. Pystyn esittämään yksinkertaisia kysymyksiä ja vastaamaan sellaisiin arkisia tarpeita tai hyvin tuttuja aiheita käsittelevissä keskusteluissa.</td>
				<td>Osaan käyttää yksinkertaisia sanontoja ja lauseita kuvaamaan, missä asun ja keitä tunnen.</td>
				<td>Pystyn kirjoittamaan lyhyen, yksinkertaisen postikortin, esimerkiksi lomaterveiset. Pystyn täyttämään lomakkeita, joissa kysytään henkilötietoa, esimerkiksi kirjoittamaan nimeni, kansallisuuteni ja osoitteeni hotellin majoittumislomakkeeseen.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Ymmärrän muutamia sanontoja ja kaikkein tavallisinta sanastoa, joka liittyy läheisesti omaan elämääni; esimerkiksi aivan keskeinen tieto itsestäni ja perheestäni, ostosten tekeminen, asuinpaikka ja työpaikka. Ymmärrän lyhyiden, selkeiden, yksinkertaisten viestien ja kuulutusten ydinsisällön.</td>
				<td>Pystyn lukemaan hyvin lyhyitä, yksinkertaisia tekstejä. Pystyn löytämään tiettyä, ennustettavissa olevaa tietoa jokapäiväisistä yksinkertaisista teksteistä, esimerkiksi mainoksista, esitteistä, ruokalistoista ja aikatauluista. Ymmärrän lyhyitä, yksinkertaisia henkilökohtaisia kirjeitä.</td>
				<td>Pystyn kommunikoimaan yksinkertaisissa ja rutiininomaisissa tehtävissä, jotka edellyttävät yksinkertaista ja suoraa tiedonvaihtoa tutuista aiheista ja toiminnoista. Selviydyn hyvin lyhyistä keskusteluista, mutta ymmärrän harvoin kylliksi pitääkseni keskustelua itse yllä.</td>
				<td>Pystyn kuvaamaan perhettäni ja muita ihmisiä, elinolojani, koulutustaustaani ja nykyistä tai edellistä työpaikkaani käyttäen, usein luettelomaisesti, aivan yksinkertaisia ilmauksia ja lauseita.</td>
				<td>Pystyn kirjoittamaan lyhyitä, yksinkertaisia muistiinpanoja ja viestejä asioista, jotka liittyvät arkisiin tarpeisiini. Pystyn kirjoittamaan hyvin yksinkertaisen henkilökohtaisen kirjeen esimerkiksi kiittääkseni jotakuta jostakin.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Ymmärrän pääkohdat selkeästä yleiskielisestä puheesta, jossa käsitellään esimerkiksi työssä, koulussa tai vapaa-aikana säännöllisesti esiintyviä ja minulle tuttuja aiheita. Tavoitan pääkohdat monista radio- ja tv-ohjelmista, joissa käsitellään ajankohtaisia tai minua henkilökohtaisesti tai ammatillisesti kiinnostavia asioita, kun puhe on melko hidasta ja selvää.</td>
				<td>Ymmärrän tekstejä, joissa on pääasiassa hyvin tavallista arkipäivän kieltä tai työhön liittyvää kieltä. Ymmärrän tapahtumien, tunteiden ja toiveiden kuvaukset henkilökohtaisissa kirjeissä.</td>
				<td>Selviydyn useimmista tilanteista, joita syntyy kohdekielisillä alueilla matkustettaessa. Pystyn osallistumaan valmistautumatta keskusteluun aiheista, jotka ovat tuttuja, itseäni kiinnostavia tai jotka liittyvät arkielämään, esimerkiksi perheeseen, harrastuksiin, työhön, matkustamiseen ja ajankohtaisiin asioihin.</td>
				<td>Osaan liittää yhteen ilmauksia yksinkertaisella tavalla kuvatakseni kokemuksia ja tapahtumia, unelmiani, toiveitani ja pyrkimyksiäni. Pystyn perustelemaan ja selittämään lyhyesti mielipiteitäni ja suunnitelmiani. Pystyn kertomaan tarinan tai selittämään kirjan tai elokuvan juonen sekä kuvailemaan omia reaktioitani.</td>
				<td>Pystyn kirjoittamaan yksinkertaista, yhtenäistä tekstiä aiheista, jotka ovat tuttuja tai itseäni kiinnostavia. Pystyn kirjoittamaan henkilökohtaisia kirjeitä, joissa kuvailen kokemuksia ja vaikutelmia.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Ymmärrän pitkähköä puhetta ja luentoja. Pystyn jopa seuraamaan monipolvista perustelua, jos aihe on suhteellisen tuttu. Ymmärrän useimmat tv-uutiset ja ajankohtaisohjelmat. Ymmärrän useimmat yleispuhekielellä esitetyt elokuvat</td>
				<td>Pystyn lukemaan ajankohtaisia ongelmia käsitteleviä artikkeleita ja raportteja ja havaitsemaan niissä kirjoittajien näkökulmat ja kannanotot. Ymmärrän oman aikani kaunokirjallisuutta.</td>
				<td>Pystyn viestimään niin sujuvasti ja spontaanisti, että säännöllinen yhteydenpito syntyperäisten puhujien kanssa on mahdollista ilman että kumpikaan osapuoli kokee sen hankalaksi. Pystyn osallistumaan aktiivisesti tutuista aihepiireistä käytävään keskusteluun, esittämään näkemyksiäni ja puolustamaan niitä.</td>
				<td>Pystyn esittämään selkeitä, yksityiskohtaisia kuvauksia hyvinkin erilaisista minua kiinnostavista aiheista. Pystyn selittämään näkökantani johonkin ajankohtaiseen kysymykseen ja esittämään eri vaihtoehtojen edut ja haitat.</td>
				<td>Pystyn kirjoittamaan selkeitä, myös yksityiskohtia sisältäviä selvityksiä hyvinkin erilaisista aiheista, jotka kiinnostavat minua. Pystyn laatimaan kirjoitelman tai raportin, jossa välitän tietoa tai esitän perusteluja jonkin tietyn näkökannan puolesta tai sitä vastaan. Pystyn kirjoittamaan kirjeitä, joissa korostan tapahtumien tai kokemusten henkilökohtaista merkitystä.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Ymmärrän pitkähköä puhetta silloinkin, kun sitä ei ole muotoiltu selkeästi ja kun asioiden välisiin suhteisiin vain viitataan eikä niitä ilmaista täsmällisesti. Ymmärrän tv-ohjelmia ja elokuvia ilman erityisiä ponnistuksia</td>
				<td>Ymmärrän pitkiä ja monipolvisia asia- ja kirjallisuustekstejä ja huomaan tyylieroja. Ymmärrän erityisalojen artikkeleita ja melko pitkiä teknisiä ohjeita silloinkin, kun ne eivät liity omaan alaani.</td>
				<td>Pystyn ilmaisemaan ajatuksiani sujuvasti ja spontaanisti ilman että minun juurikaan tarvitsee hakea ilmauksia. Osaan käyttää kieltä joustavasti ja tehokkaasti sosiaalisiin ja ammatillisiin tarkoituksiin. Osaan muotoilla ajatuksia ja mielipiteitä täsmällisesti ja liittää oman puheenvuoroni taitavasti muiden puhujien puheenvuoroihin.</td>
				<td>Pystyn esittämään selkeitä ja yksityiskohtaisia kuvauksia monipolvisista aiheista ja kehittelemään keskeisiä näkökohtia sekä päättämään esitykseni sopivaan lopetukseen.</td>
				<td>Pystyn ilmaisemaan ajatuksiani ja näkökantojani varsin laajasti selkeässä, hyvin jäsennetyssä tekstissä. Pystyn kirjoittamaan yksityiskohtaisia selvityksiä monipolvisista aiheista kirjeessä, esseessä/kirjoitelmassa tai raportissa sekä korostamaan tärkeimpinä pitämiäni seikkoja. Osaan valita oletetulle lukijalle sopivan tyylin.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Ymmärrän vaikeuksitta kaikenlaista elävää ja nauhoitettua puhetta silloinkin, kun on kyse syntyperäisen kielenpuhujan nopeasta puheesta, jos minulla on hiukan aikaa tutustua puhetapaan.</td>
				<td>Pystyn lukemaan vaivatta käytännöllisesti katsoen kaikenlaista kirjoitettua kieltä, myös abstrakteja, rakenteellisesti tai kielellisesti monimutkaisia tekstejä, kuten ohjekirjoja, erityisalojen artikkeleita ja kaunokirjallisuutta.</td>
				<td>Pystyn ottamaan vaivatta osaa asioiden käsittelyyn ja kaikkiin keskusteluihin. Tunnen hyvin kielelle tyypilliset, idiomaattiset ilmaukset ja puhekieliset ilmaukset. Pystyn tuomaan esille ajatuksiani sujuvasti ja välittämään täsmällisesti hienojakin merkitysvivahteita. Osaan perääntyä ja kiertää mahdolliset ongelmat niin sujuvasti, että muut tuskin havaitsevat olleenkaan ongelmia.</td>
				<td>Pystyn esittämään selkeän ja sujuvan kuvauksen tai perustelun asiayhteyteen sopivalla tyylillä. Esityksessäni on tehokas looginen rakenne, joka auttaa vastaanottajaa havaitsemaan ja muistamaan tärkeitä seikkoja.</td>
				<td>Osaan kirjoittaa selkeää, sujuvaa tekstiä asiaankuuluvalla tyylillä. Pystyn kirjoittamaan monimutkaisia kirjeitä, raportteja tai artikkeleita, jotka esittelevät jonkin yksittäisen tapauksen. Käytän tehokkaasti loogisia rakenteita, jotka auttavat vastaanottajaa löytämään ja muistamaan keskeiset seikat. Pystyn kirjoittamaan koosteita ja katsauksia ammattiin tai kaunokirjallisuuteen liittyvistä julkaisuista.</td>
			</tr>
		</table>
	</xsl:if>
</xsl:template>
</xsl:stylesheet>
