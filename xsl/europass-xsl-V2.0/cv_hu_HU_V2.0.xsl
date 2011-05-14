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
  # Name      : cv_hu_HU_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass CV in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/cv_hu_HU_V2.0.xsl
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
		<td class="Title"><xsl:text>Europass</xsl:text><br/><xsl:text>Önéletrajz</xsl:text></td>
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
		<xsl:with-param name="heading"><xsl:text>Személyi adatok</xsl:text></xsl:with-param>
		<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="labelHeadingRow">
		<xsl:with-param name="label">
			<xsl:choose>
				<xsl:when test="$firstNameBefore=0">
				  <xsl:text>Vezetéknév (nevek) Utónév (nevek)</xsl:text>
				</xsl:when>
				<xsl:otherwise>
				  <xsl:text>Utónév (nevek) Vezetéknév (nevek)</xsl:text>
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
			<xsl:with-param name="label"><xsl:text>Cím(ek)</xsl:text></xsl:with-param>
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
				<xsl:with-param name="label1"><xsl:text>Telefonszám(ok)</xsl:text></xsl:with-param>
				<xsl:with-param name="label1content"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/telephone" /></xsl:with-param>
				<xsl:with-param name="label2"><xsl:text>Mobil</xsl:text></xsl:with-param>
				<xsl:with-param name="label2content"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/mobile" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="//field[@name='step1.telephone' and @keep='true'] and //field[@name='step1.mobile' and @keep='false'] ">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Telefonszám(ok)</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/telephone" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="//field[@name='step1.telephone' and @keep='false'] and //field[@name='step1.mobile' and @keep='true'] ">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Mobil</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/mobile" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
	<xsl:if test="//field[@name='step1.fax' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Fax(ok)</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/fax" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.email' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>E-mail(ek)</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/email" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.nationality' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Állampolgárság</xsl:text></xsl:with-param>
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
			<xsl:with-param name="label"><xsl:text>Születési dátum</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">
				<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.gender' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Neme</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">
				<xsl:if test="europass:learnerinfo/identification/demographics/gender='M'"><xsl:text>férfi</xsl:text></xsl:if>
			  <xsl:if test="europass:learnerinfo/identification/demographics/gender='F'"><xsl:text>nő</xsl:text></xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>
<xsl:template name="application">
	<xsl:if test="//field[@name='step1.application.label' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Betölteni kívánt munkakör / foglalkozási terület</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent"><xsl:value-of select="europass:learnerinfo/application/label" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>	
</xsl:template>
<xsl:template name="workexperience">
	<xsl:if test="//field[@name='step3List' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Szakmai tapasztalat</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
		</xsl:call-template>
		<xsl:for-each select="europass:learnerinfo/workexperiencelist/workexperience">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Időtartam</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:call-template name="perioddates"/></xsl:with-param>
			</xsl:call-template>
			<xsl:variable name="indexedStep3"><xsl:value-of select="concat('step3List[', position()-1, ']')" /></xsl:variable>
			<xsl:if test="//field[@name=concat($indexedStep3,'.position.label') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Foglalkozás / beosztás</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="position/label" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep3,'.activities') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Főbb tevékenységek és feladatkörök</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="activities" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep3,'.company.name') and @keep='true']">
				<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>A munkáltató neve és címe</xsl:text></xsl:with-param>
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
					<xsl:with-param name="label"><xsl:text>Tevékenység típusa, ágazat</xsl:text></xsl:with-param>
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
			<xsl:with-param name="heading"><xsl:text>Tanulmányok</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
		</xsl:call-template>		
		<xsl:for-each select="europass:learnerinfo/educationlist/education">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Időtartam</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:call-template name="perioddates"/></xsl:with-param>
			</xsl:call-template>
			<xsl:variable name="indexedStep4"><xsl:value-of select="concat('step4List[', position()-1, ']')" /></xsl:variable>
			<xsl:if test="//field[@name=concat($indexedStep4,'.title') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Végzettség / képesítés</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="title" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep4,'.skills') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Főbb tárgyak / gyakorlati képzés</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="skills" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep4,'.educationalOrg.name') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Oktatást / képzést nyújtó intézmény neve és típusa</xsl:text></xsl:with-param>
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
					<xsl:with-param name="label"><xsl:text>Országos / nemzetközi besorolás</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="level/label" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="emptyLabelRow"/>
		</xsl:for-each>
	</xsl:if>
</xsl:template>
<xsl:template name="personalskillscompetences">
	<xsl:call-template name="headingRow">
		<xsl:with-param name="heading"><xsl:text>Egyéni készségek és kompetenciák</xsl:text></xsl:with-param>
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
			<xsl:with-param name="label"><xsl:text>Anyanyelv</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>
<xsl:template name="foreignlanguages">
	<xsl:if test="//field[@name='step5.foreignLanguageList' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Egyéb nyelv(ek)</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">&#160;</xsl:with-param>
		</xsl:call-template>
		<tr>
			<td class="Label"><xsl:text>Önértékelés</xsl:text></td>
			<xsl:call-template name="verticalline"/>
			<td class="Heading2Center" colSpan="4"><xsl:text>Szövegértés</xsl:text></td>
			<td class="Heading2Center" colSpan="4"><xsl:text>Beszéd</xsl:text></td>
			<td class="Heading2Center" colSpan="2"><xsl:text>Írás</xsl:text></td>
			<td width="1%">&#160;</td>
		</tr>
		<tr>
			<td class="Label"><xsl:text>Európai szint</xsl:text></td>
			<xsl:call-template name="verticalline"/>
			<td class="NormalSmall" colSpan="2"><xsl:text>Hallás utáni értés</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Olvasás</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Társalgás</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Folyamatos beszéd</xsl:text></td>
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
		<xsl:if test="$element='a1'">alapszintű nyelvhasználó</xsl:if>
		<xsl:if test="$element='b1'">önálló nyelvhasználó</xsl:if>
		<xsl:if test="$element='c1'">mesterfokú nyelvhasználó</xsl:if>
		<xsl:if test="$element='a2'">alapszintű nyelvhasználó</xsl:if>
		<xsl:if test="$element='b2'">önálló nyelvhasználó</xsl:if>
		<xsl:if test="$element='c2'">mesterfokú nyelvhasználó</xsl:if>
	</td>
</xsl:template>
<xsl:template name="skills">
	<xsl:if test="//field[@name='step6.socialSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Társas készségek és kompetenciák</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='social']" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.organisationalSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Szervezési készségek és kompetenciák</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='organisational']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.technicalSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Műszaki készségek és kompetenciák</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='technical']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.computerSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Számítógép-felhasználói készségek és kompetenciák</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='computer']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.artisticSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Művészi készségek és kompetenciák</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='artistic']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.otherSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Egyéb készségek és kompetenciák</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='other']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.drivingLicences' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Járművezetői engedély(ek)</xsl:text></xsl:with-param>
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
			<xsl:with-param name="heading"><xsl:text>Kiegészítő információk</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent"><xsl:value-of select="europass:learnerinfo/misclist/misc[@type='additional']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step7.annexes' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Mellékletek</xsl:text></xsl:with-param>
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
				<th colspan="6" class="title"><xsl:text>A közös európai léptékre épülő értékelési táblázat</xsl:text></th>
			</tr>
		<tr class="level">
				<th>A1</th>
				<td>Megértem a személyemre, a családomra, a közvetlen környezetemre vonatkozó, gyakran használt, egyszerű szavakat és szókapcsolatokat, ha lassan és tagoltan beszélnek hozzám.</td>
				<td>Megértem a nagyon egyszerű mondatokat, például hirdetésekben,  plakátokon vagy katalógusokban az ismert nevek vagy szavak segítségével.</td>
				<td>Képes vagyok egyszerű kapcsolatteremtésre, ha a másik személy kész mondanivalóját kissé lassabban vagy más kifejezésekkel megismételni illetve segíti  a mondanivalóm megformálását. Fel tudok tenni és meg tudok válaszolni olyan kérdéseket, amelyek a mindennapi szükségletek konkrét kifejezésére szolgálnak.</td>
				<td>Egyszerű kifejezésekkel és mondatokkal be tudom mutatni a lakóhelyemet és az ismerőseimet.</td>
				<td>Tudok képeslapra rövid és egyszerű (például nyaralási)  üdvözletet írni. Ki tudom tölteni egyszerű nyomtatványon a személyi adataimra vonatkozó részeket, például a szállodai bejelentőlapon a nevemet, az állampolgárságomat és a  címemet.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Megértem a személyemhez közvetlenül kapcsolódó, gyakran használt szavakat és kifejezéseket (pl. személyes adataim, családom, vásárlások, szűk környezet, tanulás, munka). Megértem az egyszerű és világos hirdetések és üzenetek lényegét.</td>
				<td>El tudok olvasni rövid, nagyon egyszerű szövegeket. Megtalálom a várható, konkrét információt a mindennapi, egyszerű szövegekben (pl. rövid hirdetés, prospektus, menü, menetrend), és megértem a rövid, egyszerű magánleveleket.</td>
				<td>Az egyszerű, rutinszerű helyzetekben egyszerű és közvetlen módon cserélek információt mindennapi tevékenységekről vagy témákról. A nagyon rövid információcserére még akkor is képes vagyok, ha egyébként nem értek meg eleget ahhoz, hogy a társalgásban folyamatosan részt vegyek.</td>
				<td>Egyszerű eszközökkel és mondatokkal tudok beszélni a családomról és más személyekről, életkörülményeimről, tanulmányaimról, jelenlegi vagy előző szakmai tevékenységemről.</td>
				<td>Tudok rövid, egyszerű jegyzetet, üzenetet, vagy magánjellegű, például köszönőlevelet írni.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Megértem a világos, mindennapi beszéd lényegét, ha olyan témákról esik szó, mint a munka, a tanulás, a szabadidő, stb. Ki tudom szűrni a lényeget azokból a rádió- és tévéadásokból, amelyek aktuális eseményekről, szakmai vagy érdeklődési körömnek megfelelő témákról szólnak, ha eléggé lassan és tagoltan beszélnek.</td>
				<td>Megértem a főként köznyelven, vagy a munkámhoz közvetlenül kapcsolódó szaknyelven megírt szövegeket. Magánlevélben megértem az események, érzelmek vagy kívánságok leírását.</td>
				<td>Elboldogulok a legtöbb olyan nyelvi helyzetben, amely utazás során adódik. Felkészülés nélkül részt tudok venni az ismert, az érdeklődési körömnek megfelelő, vagy a mindennapi témákról (pl. család, szabadidő, tanulás, munka, utazás, aktuális események) folyó társalgásban.</td>
				<td>Egyszerű kifejezésekkel tudok beszélni élményekről, eseményekről, álmaimról, reményeimről és céljaimról. Röviden is meg tudom magyarázni, indokolni véleményemet és terveimet.</td>
				<td>Egyszerű, folyamatos szövegeket tudok alkotni olyan témákban, amelyeket ismerek, vagy érdeklődési körömbe tartoznak. Élményeimről és benyomásaimról magánleveleket tudok írni.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Megértem a hosszabb beszédeket és előadásokat, illetve még a bonyolultabb érveléseket is követni tudom, amennyiben a téma számomra elég ismert. Többnyire megértem a híreket és az aktuális eseményekről szóló műsorokat a tévében. Általában értem a filmeket, ha a szereplők köznyelven beszélnek.</td>
				<td>El tudom olvasni azokat a cikkeket és beszámolókat, amelyek jelenkori problémákkal foglalkoznak, és szerzőjük véleményét, nézetét fejtik ki. Megértem a kortárs irodalmi prózát.</td>
				<td>Az anyanyelvi beszélővel természetes, könnyed és közvetlen kapcsolatteremtésre vagyok képes. Aktívan részt tudok venni az ismert témákról folyó társalgásban, úgy, hogy közben érvelve kifejtem a véleményemet.</td>
				<td>Világosan és kellő részletességgel fejezem ki magam számos, érdeklődési körömbe tartozó témában. Ki tudom fejteni a véleményemet valamely aktuális témáról úgy, hogy részletezem a különböző lehetőségek előnyeit és hátrányait.</td>
				<td>Világos és részletes szövegeket tudok alkotni az érdeklődési körömbe tartozó számos témáról. Tudok olyan dolgozatot vagy beszámolót írni, amely tájékoztat, érveket és ellenérveket sorakoztat fel valamiről. Levélben rá tudok világítani arra, hogy milyen jelentőséget tulajdonítok az eseményeknek, élményeknek.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Még a nem világosan szerkesztett és rejtett jelentéstartalmú, hosszú szöveget is megértem. Szinte erőfeszítés nélkül értem meg a tévéműsorokat és a filmeket.</td>
				<td>Megértem a hosszú, összetett, tényszerű és irodalmi szövegeket; érzékelem bennük a különböző stílusjegyeket. A szakmai cikkeket és a hosszú műszaki leírásokat akkor is megértem, ha nem kapcsolódnak szakterületemhez.</td>
				<td>Folyamatosan és gördülékenyen fejezem ki magam, ritkán keresek szavakat és kifejezéseket. A nyelvet könnyeden és hatékonyan használom a különböző társadalmi és szakmai kapcsolatokban. Gondolataimat, véleményemet pontosan ki tudom fejteni; hozzászólásaimat a beszélőtársakéhoz tudom kapcsolni.</td>
				<td>Világosan és részletesen tudok leírni bonyolult dolgokat úgy, hogy más kapcsolódó témaköröket is bevonok, egyes elemeket részletezek, és mondanivalómat megfelelően fejezem be.</td>
				<td>Képes vagyok arra, hogy álláspontomat világos, jól szerkesztett szövegben fogalmazzam meg. Levélben, dolgozatban, beszámolóban úgy tudok összetett témákról írni, hogy a fontosnak tartott dolgokat kiemelem. Stílusomat az olvasóhoz tudom igazítani.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Minden nehézség nélkül megértem az élőben hallott, médián keresztül sugárzott, vagy gyors tempójú beszédet, ha van időm megszokni az akcentust.</td>
				<td>Könnyedén elolvasok bármilyen tartalmú vagy formájú elvont, bonyolult szöveget, például kézikönyvet, szakcikket, irodalmi művet.</td>
				<td>Könnyedén részt tudok venni bármilyen társalgásban, vitában; nagy biztonsággal alkalmazom a sajátos kifejezéseket és a különböző nyelvi fordulatokat. Gördülékenyen, szabatosan, az árnyalatok finom kifejezésére is ügyelve beszélek. Ha elakadok, úgy kezdem újra és fogalmazom át a mondandómat, hogy az szinte fel sem tűnik.</td>
				<td>Világosan és folyamatosan, stílusomat a helyzethez igazítva írok le vagy fejtek ki bármit, előadásomat logikusan szerkesztem meg; segítem a hallgatót abban, hogy a lényeges pontokat kiragadja és megjegyezze.</td>
				<td>Tudok világos, gördülékeny, a körülményekhez stílusában illeszkedő szöveget írni. Meg tudok fogalmazni olyan bonyolult levelet, beszámolót és cikket, amelynek jó tagolása segíti az olvasót abban, hogy a lényeges pontokat kiragadja és megjegyezze. Össze tudok foglalni szakmai és irodalmi műveket, tudok róluk kritikai elemzést írni.</td>
			</tr>
		</table>
	</xsl:if>
</xsl:template>
</xsl:stylesheet>
