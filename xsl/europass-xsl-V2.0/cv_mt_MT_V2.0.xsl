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
  # Name      : cv_mt_MT_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass CV in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/cv_mt_MT_V2.0.xsl
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
		<xsl:with-param name="heading"><xsl:text>Informazzjoni personali</xsl:text></xsl:with-param>
		<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="labelHeadingRow">
		<xsl:with-param name="label">
			<xsl:choose>
				<xsl:when test="$firstNameBefore=0">
				  <xsl:text>Kunjom(ijiet) Isem (Ismijiet)</xsl:text>
				</xsl:when>
				<xsl:otherwise>
				  <xsl:text>Isem (Ismijiet) Kunjom(ijiet)</xsl:text>
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
			<xsl:with-param name="label"><xsl:text>Indirizz(i)</xsl:text></xsl:with-param>
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
				<xsl:with-param name="label1"><xsl:text>Numru(i) tat-telefon(s)</xsl:text></xsl:with-param>
				<xsl:with-param name="label1content"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/telephone" /></xsl:with-param>
				<xsl:with-param name="label2"><xsl:text>Mowbajl</xsl:text></xsl:with-param>
				<xsl:with-param name="label2content"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/mobile" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="//field[@name='step1.telephone' and @keep='true'] and //field[@name='step1.mobile' and @keep='false'] ">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Numru(i) tat-telefon(s)</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/telephone" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="//field[@name='step1.telephone' and @keep='false'] and //field[@name='step1.mobile' and @keep='true'] ">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Mowbajl</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/mobile" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
	<xsl:if test="//field[@name='step1.fax' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Numru(i) tal-faks</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/fax" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.email' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>E-mail (s)</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/email" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.nationality' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Nazzjonalita' / jiet</xsl:text></xsl:with-param>
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
			<xsl:with-param name="label"><xsl:text>Data tat-twelid</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">
				<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.gender' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Sess</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">
				<xsl:if test="europass:learnerinfo/identification/demographics/gender='M'"><xsl:text>Raġel</xsl:text></xsl:if>
			  <xsl:if test="europass:learnerinfo/identification/demographics/gender='F'"><xsl:text>Mara</xsl:text></xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>
<xsl:template name="application">
	<xsl:if test="//field[@name='step1.application.label' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Impjieg mixtieq/Qasam ta' xogħol</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent"><xsl:value-of select="europass:learnerinfo/application/label" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>	
</xsl:template>
<xsl:template name="workexperience">
	<xsl:if test="//field[@name='step3List' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Esperjenza ta' xogħol</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
		</xsl:call-template>
		<xsl:for-each select="europass:learnerinfo/workexperiencelist/workexperience">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Dati</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:call-template name="perioddates"/></xsl:with-param>
			</xsl:call-template>
			<xsl:variable name="indexedStep3"><xsl:value-of select="concat('step3List[', position()-1, ']')" /></xsl:variable>
			<xsl:if test="//field[@name=concat($indexedStep3,'.position.label') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Impjieg jew pożizzjoni li kellek/għandek</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="position/label" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep3,'.activities') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Attivitajiet u responsabbilitajiet prinċipali</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="activities" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep3,'.company.name') and @keep='true']">
				<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Isem u indirizz ta' min iħaddem</xsl:text></xsl:with-param>
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
					<xsl:with-param name="label"><xsl:text>Tip ta' negozju jew ta' settur</xsl:text></xsl:with-param>
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
			<xsl:with-param name="heading"><xsl:text>Edukazzjoni u taħriġ</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
		</xsl:call-template>		
		<xsl:for-each select="europass:learnerinfo/educationlist/education">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Dati</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:call-template name="perioddates"/></xsl:with-param>
			</xsl:call-template>
			<xsl:variable name="indexedStep4"><xsl:value-of select="concat('step4List[', position()-1, ']')" /></xsl:variable>
			<xsl:if test="//field[@name=concat($indexedStep4,'.title') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Titlu tal-kwalifika miksuba</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="title" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep4,'.skills') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Suġġetti prinċipali/ ħiliet ta' xogħol miksuba</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="skills" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep4,'.educationalOrg.name') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Isem u tip tal-organizzazzjoni liipprovdiet l-edukazzjoni/t-taħriġ</xsl:text></xsl:with-param>
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
					<xsl:with-param name="label"><xsl:text>Klassifikazzjoni tal-livell nazzjonali / internazzjonali</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="level/label" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="emptyLabelRow"/>
		</xsl:for-each>
	</xsl:if>
</xsl:template>
<xsl:template name="personalskillscompetences">
	<xsl:call-template name="headingRow">
		<xsl:with-param name="heading"><xsl:text>Ħiliet u kompetenzi personali</xsl:text></xsl:with-param>
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
			<xsl:with-param name="label"><xsl:text>Ilsien / Isla nattiv(i)</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>
<xsl:template name="foreignlanguages">
	<xsl:if test="//field[@name='step5.foreignLanguageList' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Lingwa(i) oħra</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">&#160;</xsl:with-param>
		</xsl:call-template>
		<tr>
			<td class="Label"><xsl:text>Awtoassessjar</xsl:text></td>
			<xsl:call-template name="verticalline"/>
			<td class="Heading2Center" colSpan="4"><xsl:text>Fehim</xsl:text></td>
			<td class="Heading2Center" colSpan="4"><xsl:text>Taħdit</xsl:text></td>
			<td class="Heading2Center" colSpan="2"><xsl:text>Kitba</xsl:text></td>
			<td width="1%">&#160;</td>
		</tr>
		<tr>
			<td class="Label"><xsl:text>Livell Ewropew(***)</xsl:text></td>
			<xsl:call-template name="verticalline"/>
			<td class="NormalSmall" colSpan="2"><xsl:text>Smigħ</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Qari</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Taħdit interattiv</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Taħdit produttiv</xsl:text></td>
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
		<xsl:if test="$element='a1'">Użu bażiku</xsl:if>
		<xsl:if test="$element='b1'">Użu indipendenti</xsl:if>
		<xsl:if test="$element='c1'">Użu profiċjenti</xsl:if>
		<xsl:if test="$element='a2'">Użu bażiku</xsl:if>
		<xsl:if test="$element='b2'">Użu indipendenti</xsl:if>
		<xsl:if test="$element='c2'">Użu profiċjenti</xsl:if>
	</td>
</xsl:template>
<xsl:template name="skills">
	<xsl:if test="//field[@name='step6.socialSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Ħiliet soċjali u kompetenzi</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='social']" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.organisationalSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Ħiliet u kompetenzi organizzattivi</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='organisational']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.technicalSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Ħiliet u kompetenzi tekniċi</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='technical']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.computerSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Ħiliet u kompetenzi fl-użu tal-kompjuter</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='computer']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.artisticSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Ħiliet u kompetenzi artistiċi</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='artistic']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.otherSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Ħiliet u kompetenzi oħra</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='other']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.drivingLicences' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Liċenzja tas-sewqan</xsl:text></xsl:with-param>
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
			<xsl:with-param name="heading"><xsl:text>Informazzjoni oħra</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent"><xsl:value-of select="europass:learnerinfo/misclist/misc[@type='additional']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step7.annexes' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Annessi</xsl:text></xsl:with-param>
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
				<th colspan="6" class="title"><xsl:text>Livell Ewropew – tabella ta’ l-awto-assessjar</xsl:text></th>
			</tr>
		<tr class="level">
				<th>A1</th>
				<td>Kapaċi nifhem kliem familjari u xi frażijiet bażiċi fuqi nnifsi,fuq il-familja tiegħi u fuq l-ambjent ta’ madwari meta n-nies jitkellmu bil-mod u ċar.</td>
				<td>Kapaċi nifhem ismijiet u kliem familjari u sentenzi sempliċi ħafna bħal f’avviżi, f’kartelluni jew f’katalgi.</td>
				<td>Kapaċi nikkomunika b’mod sempliċi sakemm il-persuna l-oħra hija lesta li tirrepeti jew tbiddel il-kliem u titkellem b’mod inqas mgħaġġel u tgħinni ngħid dak li nkun qiegħed nipprova ngħid. Kapaċi nistaqsi u nwieġeb mistoqsijiet sempliċi fir-rigward ta’ bżonnijiet immedjati jew suġġetti familjari ħafna.</td>
				<td>Kapaċi nuża frażijiet u sentenzi sempliċi biex niddeskrivi fejn noqgħod u n-nies li naf.</td>
				<td>Kapaċi nikteb kartolina fil-qosor u b’mod sempliċi biex nibgħat tislijiet meta nkun bi btala. Nista’ nimla formoli b’dettalji personali bħal ismi, in-nazzjonalità u l-indirizz fuq formola ta’ reġistrazzjoni f’lukanda.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Kapaċi nifhem frażijiet u li jintużaw ta’ spiss u li huma relatati ma esperjenzi personali li jolqtu fil qrib il-familja (eż informazzjoni bażika ħafna dwari, ix-xiri, l-ambjent ta’ madwari u l-impjiegi). Kapaċi nifhem il-punt prinċipali f’messaġġi u avviżi qosra, ċari u sempliċi.</td>
				<td>Kapaċi naqra testi qosra ħafna u sempliċi. Kapaċi nsib informazzjoni speċifika u li tista’ tobsorha f’publikazzjonijiet sempliċi u ta’ kuljum bħal f’reklami, prospetti, menus, u timetables u nista’ nifhem ittri qosra, sempliċi u personali.</td>
				<td>Kapaċi nikkomunika b’xogħlijiet sempliċi u ta’ rutina li jesiġu bdil ta’ nformazzjoni sempliċi u diretta dwar suġġetti u attivitajiet familjari. Kapaċi nagħmel diskors qasir ħafna u soċjali iżda normalment ma nifhimx biżżejjed biex inżomm konverżazzjoni.</td>
				<td>Kapaċi nuża serje ta’ frażijiet u sentenzi biex niddeskrivi b’mod sempliċi, il-familja u nies oħra, il-kundizzjonijiet ta’ għijxien, l-edukazzjoni tiegħi u l-impjieg preżenti u l-aktar reċenti.</td>
				<td>Kapaċi nikteb noti u messaġġi qosra u sempliċi. Kapaċi nikteb ittra sempliċi u personali biex nirringrazzja lil xi ħadd għal xi ħaġa.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Kapaċi nifhem il-punti ewlenin ta’ taħdit ċar dwar temi familjari li niltaqgħu magħhom regolarment fix-xogħol, fl-iskola, waqt il-ħin liberu eċċ. Kapaċi nifhem il-punt ewlieni ta’ programmi ta’ ġrajjiet kurrenti fuq ir-radju u t-televiżjoni jew temi ta’ interess personali u professjonali meta d-diskors isir bil-mod u ċar.</td>
				<td>Kapaċi nifhem testi li jikkonsistu prinċipalment f’lingwaġġ użat ta’ spiss u ta’ kuljum jew li għandu x’jaqsam ma’ xogħol. Kapaċi nifhem id-deskrizzjoni ta’ avvenimenti, ħsus u xewqat f’ittri personali.</td>
				<td>Kapaċi niffaċċja ħafna sitwazzjonijiet li jistgħu jinqalgħu waqt vjaġġ f’post fejn il-lingwa tal-post hi mitkellma u nidħol mhux ippreparat f’konverżazzjoni fuq temi familjari ta’ interess personali jew pertinenti fil-ħajja ta’ kuljum. (eż. familja, passatempi, xogħol, vjaġġar u ġrajjiet kurrenti).</td>
				<td>Kapaċi ngħaqqad frażijiet b’mod sempliċi biex niddeskrivi esperjenzi u avvenimenti, il-ħolm tiegħi, ix-xewqat u l-ambizzjonijiet tiegħi. Kapaċi nagħti raġunijiet u spjegazzjonijiet fil-qosor u nispjega opinjonijiet u pjanijiet. Naf ngħid storja jew nitkellem dwar in-nisġa ta’ ktieb jew ta’ film u niddeskrivi r-reazzjonijiet tiegħi.</td>
				<td>Kapaċi nikteb test sempliċi u stilistikament konness dwar interessi familjari u personali. Kapaċi nikteb ittri personali li jiddeskrivu esperjenzi u impressjonijiet.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Kapaċi nifhem taħdidiet u ‘lectures’ twal u nifhem ukoll argumenti kumplessi sakemm it-tema tkun waħda familjari. Kapaċi nifhem il-biċċa l-kbira ta’ l-aħbarijiet u programmi ta’ ġrajjiet kurrenti fuq it-televiżjoni. Kapaċi nifhem il-biċċa l-kbira ta’ films bil-lingwa ‘standard’.</td>
				<td>Kapaċi naqra artikli u rapporti li għandhom x’jaqsmu ma’ problemi attwali li fihom il-kittieba jaddottaw attitudnijiet jew opinjonijiet partikulari. Kapaċi nifhem proża letterarja kontemporanja.</td>
				<td>Kapaċi nikkomunika b&apos;mod spontanju li tgħinni nikkomunika man-nies tal-lokal. Kapaċi nieħu parti attiva f’diskussjoni f’kuntest familjari u nsostni u nispjega l-opinjoni tieghi.</td>
				<td>Kapaċi niddeskrivi b’mod ċar u dettaljat firxa wiesgħa ta’ suġġetti relatati ma oqsma li jinteressawni. Kapaċi nispjega l-opinjoni tiegħi dwar il-vantaġġi u l-iżvantaġġi ta’ argumenti varji.</td>
				<td>Kapaċi nikteb b’mod dettaljat u ċar fuq suġġetti relatati ma’ l-interessi tiegħi. Kapaċi nikteb esej jew rapport fejn nagħti informazzjoni u raġunijiet biex insaħħaħ jew nikkontradixxi opinjoni partikulari. Kapaċi nikteb ittri u nagħmel enfasi fuq l-importanza personali ta’ avvenimenti u esperjenzi.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Kapaċi nifhem taħditiet twal anke meta l-istruttura tas-sentenza ma tkunx ċara u meta  r-relazzjonijiet ikunu biss implikati u ma jkunux spjegati b’mod ċar. Kapaċi nifhem programmi tat-televiżjoni u films mingħajr sforz żejjed.</td>
				<td>Kapaċi nifhem testi twal, kumplessi, fattwali u letterarji u napprezza d-diversità fl-istil. Kapaċi nifhem artikli speċjalizzati u struzzjonijiet tekniċi twal anke meta dawn m’għandhomx x’jaqsmu mal-linja tiegħi.</td>
				<td>Kapaċi nesprimi ruħi b’mod mexxej u spontanju mingħajr ħafna tlaqliq biex insib il-kelma. Kapaċi nuża l-lingwa b’mod flessibli u effettiv għal skopijiet soċjali u professjonali. Kapaċi nifformula ideat u opinjonijiet bi preċiżjoni u norbot b’sengħa l-kontribut tiegħi ma’ dawk ta’ kelliema oħra.</td>
				<td>Kapaċi nagħti deskrizzjonijiet ċari u dettaljati ta’ suġġetti kumplessi u ninkorpora temi sekondarji niżviluppa partikolari u nagħlaq b’mod adattat.</td>
				<td>Kapaċi nesprimi ruħi b’testi ċari u strutturati u li jesprimu opinjonijiet fit-tul. Kapaċi nikteb dwar suġġetti kumplessi f’ittra, esej jew f’rapport u nagħmel enfasi dwar x’inqis li jkunu l-punti ewlenin. Kapaċi nagħżel stil tajjeb għall-qarrej konċernat.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Ma nsib l-ebda diffikultà biex nifhem kull lingwa mitkellma sew jekk tkun diretta jew imxandra, anke jekk mitkellma bħala lingwa nattiva b’mod mgħaġġel sakemm ikolli ftit taż-żmien biex nidra l-aċċent.</td>
				<td>Kapaċi naqra faċilment kull forma tal-lingwa mitkellma nkluż testi astratti u kumplessi fl-istruttura u fil-lingwa bħal f’&apos;manwali, artikli speċjalizzati u xogħlijiet letterarji.</td>
				<td>Kapaċi nipparteċipa bla edba sforz żejjed f’kull konverżazzjoni jew diskussjoni u jkolli ħakma tajba ta’ l-espressjonijiet idjomatiċi u tal-lingwa mitkellma. Kapaċi nesprimi ruħi b’mod mexxej u nagħti tifsiriet preċiżi ħafna billi nirristruturha b’mod li ħadd ma jinduna. Jekk insib xi problema naf insib tarfha.</td>
				<td>Kapaċi noffri deskrizzjoni jew argument b’mod ċar u mexxej fl-istil xieraq għall-kuntest u bi struttura effettiva u loġika li tgħin lis-semmiegħ biex jagħraf u jiftakar il-punti l-aktar importanti.</td>
				<td>Kapaċi nikteb test ċar u mexxej bi stil adattat. Kapaċi nikteb ittri kumplessi, rapporti jew artikli li jippreżentaw każ, bi struttura effettiva u loġika li tgħin lill-qarrej jinnota u jiftakar l-punti mportanti. Kapaċi nikteb taqsiriet u xogħlijiet professjonali jew letterarji.</td>
			</tr>
		</table>
	</xsl:if>
</xsl:template>
</xsl:stylesheet>
