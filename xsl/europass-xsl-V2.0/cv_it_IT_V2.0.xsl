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
  # Name      : cv_it_IT_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass CV in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/cv_it_IT_V2.0.xsl
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
		<td class="Title"><xsl:text>Curriculum Vitae</xsl:text><br/><xsl:text>Europass</xsl:text></td>
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
		<xsl:with-param name="heading"><xsl:text>Informazioni personali</xsl:text></xsl:with-param>
		<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="labelHeadingRow">
		<xsl:with-param name="label">
			<xsl:choose>
				<xsl:when test="$firstNameBefore=0">
				  <xsl:text>Cognome(i) Nome(i)</xsl:text>
				</xsl:when>
				<xsl:otherwise>
				  <xsl:text>Nome(i) Cognome(i)</xsl:text>
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
			<xsl:with-param name="label"><xsl:text>Indirizzo(i)</xsl:text></xsl:with-param>
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
				<xsl:with-param name="label1"><xsl:text>Telefono(i)</xsl:text></xsl:with-param>
				<xsl:with-param name="label1content"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/telephone" /></xsl:with-param>
				<xsl:with-param name="label2"><xsl:text>Cellulare</xsl:text></xsl:with-param>
				<xsl:with-param name="label2content"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/mobile" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="//field[@name='step1.telephone' and @keep='true'] and //field[@name='step1.mobile' and @keep='false'] ">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Telefono(i)</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/telephone" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="//field[@name='step1.telephone' and @keep='false'] and //field[@name='step1.mobile' and @keep='true'] ">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Cellulare</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/mobile" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
	<xsl:if test="//field[@name='step1.fax' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Fax</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/fax" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.email' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>E-mail</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/email" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.nationality' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Cittadinanza</xsl:text></xsl:with-param>
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
			<xsl:with-param name="label"><xsl:text>Data di nascita</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">
				<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.gender' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Sesso</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">
				<xsl:if test="europass:learnerinfo/identification/demographics/gender='M'"><xsl:text>Maschile</xsl:text></xsl:if>
			  <xsl:if test="europass:learnerinfo/identification/demographics/gender='F'"><xsl:text>Femminile</xsl:text></xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>
<xsl:template name="application">
	<xsl:if test="//field[@name='step1.application.label' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Occupazione desiderata / Settore professionale</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent"><xsl:value-of select="europass:learnerinfo/application/label" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>	
</xsl:template>
<xsl:template name="workexperience">
	<xsl:if test="//field[@name='step3List' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Esperienza professionale</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
		</xsl:call-template>
		<xsl:for-each select="europass:learnerinfo/workexperiencelist/workexperience">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Date</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:call-template name="perioddates"/></xsl:with-param>
			</xsl:call-template>
			<xsl:variable name="indexedStep3"><xsl:value-of select="concat('step3List[', position()-1, ']')" /></xsl:variable>
			<xsl:if test="//field[@name=concat($indexedStep3,'.position.label') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Lavoro o posizione ricoperti</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="position/label" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep3,'.activities') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Principali attività e responsabilità</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="activities" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep3,'.company.name') and @keep='true']">
				<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Nome e indirizzo del datore di lavoro</xsl:text></xsl:with-param>
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
					<xsl:with-param name="label"><xsl:text>Tipo di attività o settore</xsl:text></xsl:with-param>
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
			<xsl:with-param name="heading"><xsl:text>Istruzione e formazione</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
		</xsl:call-template>		
		<xsl:for-each select="europass:learnerinfo/educationlist/education">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Date</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:call-template name="perioddates"/></xsl:with-param>
			</xsl:call-template>
			<xsl:variable name="indexedStep4"><xsl:value-of select="concat('step4List[', position()-1, ']')" /></xsl:variable>
			<xsl:if test="//field[@name=concat($indexedStep4,'.title') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Titolo della qualifica rilasciata</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="title" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep4,'.skills') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Principali tematiche/competenza professionali possedute</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="skills" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep4,'.educationalOrg.name') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Nome e tipo d'organizzazione erogatrice dell'istruzione e formazione</xsl:text></xsl:with-param>
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
					<xsl:with-param name="label"><xsl:text>Livello nella classificazione nazionale o internazionale</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="level/label" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="emptyLabelRow"/>
		</xsl:for-each>
	</xsl:if>
</xsl:template>
<xsl:template name="personalskillscompetences">
	<xsl:call-template name="headingRow">
		<xsl:with-param name="heading"><xsl:text>Capacità e competenze personali</xsl:text></xsl:with-param>
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
			<xsl:with-param name="label"><xsl:text>Madrelingua(e)</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>
<xsl:template name="foreignlanguages">
	<xsl:if test="//field[@name='step5.foreignLanguageList' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Altra(e) lingua(e)</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">&#160;</xsl:with-param>
		</xsl:call-template>
		<tr>
			<td class="Label"><xsl:text>Autovalutazione</xsl:text></td>
			<xsl:call-template name="verticalline"/>
			<td class="Heading2Center" colSpan="4"><xsl:text>Comprensione</xsl:text></td>
			<td class="Heading2Center" colSpan="4"><xsl:text>Parlato</xsl:text></td>
			<td class="Heading2Center" colSpan="2"><xsl:text>Scritto</xsl:text></td>
			<td width="1%">&#160;</td>
		</tr>
		<tr>
			<td class="Label"><xsl:text>Livello europeo</xsl:text></td>
			<xsl:call-template name="verticalline"/>
			<td class="NormalSmall" colSpan="2"><xsl:text>Ascolto</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Lettura</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Interazione orale</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Produzione orale</xsl:text></td>
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
		<xsl:if test="$element='a1'">Utente base</xsl:if>
		<xsl:if test="$element='b1'">Utente autonomo</xsl:if>
		<xsl:if test="$element='c1'">Utente avanzato</xsl:if>
		<xsl:if test="$element='a2'">Utente base</xsl:if>
		<xsl:if test="$element='b2'">Utente autonomo </xsl:if>
		<xsl:if test="$element='c2'">Utente avanzato</xsl:if>
	</td>
</xsl:template>
<xsl:template name="skills">
	<xsl:if test="//field[@name='step6.socialSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Capacità e competenze sociali</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='social']" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.organisationalSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Capacità e competenze organizzative</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='organisational']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.technicalSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Capacità e competenze tecniche</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='technical']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.computerSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Capacità e competenze informatiche</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='computer']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.artisticSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Capacità e competenze artistiche</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='artistic']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.otherSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Altre capacità e competenze</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='other']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.drivingLicences' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Patente</xsl:text></xsl:with-param>
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
			<xsl:with-param name="heading"><xsl:text>Ulteriori informazioni</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent"><xsl:value-of select="europass:learnerinfo/misclist/misc[@type='additional']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step7.annexes' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Allegati</xsl:text></xsl:with-param>
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
				<th colspan="6" class="title"><xsl:text>Griglia per l'autovalutazione</xsl:text></th>
			</tr>
		<tr class="level">
				<th>A1</th>
				<td>Riesco a riconoscere parole che mi sono familiari ed espressioni molto semplici riferite a me stesso, alla mia famiglia e al mio ambiente, purché le persone parlino lentamente e chiaramente.</td>
				<td>Riesco a capire i nomi e le persone che mi sono familiari e frasi molto semplici, per esempio quelle di annunci, cartelloni, cataloghi.</td>
				<td>Riesco a interagire in modo semplice se l’interlocutore é disposto a ripetere o a riformulare più lentamente certe cose e mi aiuta a formulare ciò che cerco di dire. Riesco a porre e a rispondere a domande semplici su argomenti molto familiari o che riguardano bisogni immediati.</td>
				<td>Riesco a usare espressioni e frasi semplici per descrivere il luogo dove abito e la gente che conosco.</td>
				<td>Riesco a scrivere una breve e semplice cartolina , ad esempio per mandare i saluti delle vacanze. Riesco a compilare moduli con dati personali scrivendo per esempio il mio nome, la nazionalità e l’indirizzo sulla scheda di registrazione di un albergo.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Riesco a capire espressioni e parole di uso molto frequente relative a ciò che mi riguarda direttamente (per esempio informazioni di base sulla mia persona e sulla mia famiglia, gli acquisti, l’ambiente circostante e il lavoro). Riesco ad afferrare l’essenziale di messaggi e annunci brevi, semplici e chiari.</td>
				<td>Riesco a leggere testi molto brevi e semplici e a trovare informazioni specifiche e prevedibili in materiale di uso quotidiano, quali pubblicità, programmi, menù e orari. Riesco a capire lettere personali semplici e brevi.</td>
				<td>Riesco a comunicare affrontando compiti semplici e di routine che richiedano solo uno scambio semplice e diretto di informazioni su argomenti e attività consuete. Riesco a partecipare a brevi conversazioni, anche se di solito non capisco abbastanza per riuscire a sostenere la conversazione.</td>
				<td>Riesco ad usare una serie di espressioni e frasi per descrivere con parole semplici la mia famiglia ed altre persone, le mie condizioni di vita, la carriera scolastica e il mio lavoro attuale o il più recente.</td>
				<td>Riesco a prendere semplici appunti e a scrivere brevi messaggi su argomenti riguardanti bisogni immediati. Riesco a scrivere una lettera personale molto semplice, per esempio per ringraziare qualcuno.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Riesco a capire gli elementi principali in un discorso chiaro in lingua standard su argomenti familiari, che affronto frequentemente al lavoro, a scuola, nel tempo libero ecc. Riesco a capire l’essenziale di molte trasmissioni radiofoniche e televisive su argomenti di attualità o temi di mio interesse personale o professionale, purché il discorso sia relativamente lento e chiaro.</td>
				<td>Riesco a capire testi scritti di uso corrente legati alla sfera quotidiana o al lavoro. Riesco a capire la descrizione di avvenimenti, di sentimenti e di desideri contenuta in lettere personali.</td>
				<td>Riesco ad affrontare molte delle situazioni che si possono presentare viaggiando in una zona dove si parla la lingua. Riesco a partecipare, senza essermi preparato, a conversazioni su argomenti familiari, di interesse personale o riguardanti la vita quotidiana ( per esempio la famiglia, gli hobby, il lavoro, i viaggi e i fatti di attualità).</td>
				<td>Riesco a descrivere, collegando semplici espressioni, esperienze ed avvenimenti, i miei sogni, le mie speranze e le mie ambizioni. Riesco a motivare e spiegare brevemente opinioni e progetti. Riesco a narrare una storia e la trama di un libro o di un film e a descrivere le mie impressioni.  .</td>
				<td>Riesco a scrivere testi semplici e coerenti su argomenti a me noti o di mio interesse. Riesco a scrivere lettere personali esponendo esperienze e impressioni.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Riesco a capire discorsi di una certa lunghezza e conferenze e a seguire argomentazioni anche complesse purché il tema mi sia relativamente familiare. Riesco a capire la maggior parte dei notiziari  e delle trasmissioni TV che riguardano fatti d’attualità e la maggior parte dei film in lingua standard.</td>
				<td>Riesco a leggere articoli e relazioni su questioni d’attualità in cui l’autore prende posizione ed esprime un punto di  vista determinato.  Riesco a comprendere un testo narrativo contemporaneo.</td>
				<td>Riesco a comunicare con un grado di spontaneità e scioltezza sufficiente per interagire in modo normale con parlanti nativi. Riesco a partecipare attivamente a una discussione in contesti familiari, esponendo e sostenendo le mie opinioni.</td>
				<td>Riesco a esprimermi in modo chiaro e articolato su una vasta gamma di argomenti che mi interessano. Riesco a esprimere un’ opinione su un argomento d’attualità, indicando vantaggi e svantaggi delle diverse opzioni.</td>
				<td>Riesco a scrivere testi chiari e articolati su un’ampia gamma di argomenti che mi interessano. Riesco a scrivere saggi e relazioni, fornendo informazioni e ragioni a favore o contro una determinata opinione. Riesco a scrivere lettere mettendo in evidenza il significato che attribuisco personalmente agli avvenimenti e alle esperienze.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Riesco a capire un discorso lungo anche se non é chiaramente strutturato e le relazioni non vengono segnalate, ma rimangono implicite. Riesco a capire senza troppo sforzo le trasmissioni televisive e i film.</td>
				<td>Riesco a capire testi letterari e informativi lunghi e complessi e so apprezzare le differenze di stile. Riesco a capire articoli specialistici e istruzioni tecniche piuttosto lunghe, anche quando non appartengono al mio settore.</td>
				<td>Riesco ad esprimermi in modo sciolto e spontaneo senza dover cercare troppo le parole. Riesco ad usare la lingua in modo flessibile ed efficace nelle relazioni sociali e professionali. Riesco a formulare idee e opinioni in modo preciso e a collegare abilmente i miei interventi con quelli di altri interlocutori.</td>
				<td>Riesco a presentare descrizioni chiare e articolate su argomenti complessi, integrandovi temi secondari, sviluppando punti specifici e concludendo il tutto in modo appropriato.</td>
				<td>Riesco a scrivere testi chiari e ben strutturati sviluppando analiticamente il mio punto di vista. Riesco a scrivere lettere, saggi e relazioni esponendo argomenti complessi, evidenziando i punti che ritengo salienti. Riesco a scegliere lo stile adatto ai lettori ai quali intendo rivolgermi.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Non ho nessuna difficoltà a capire qualsiasi  lingua parlata, sia dal vivo sia trasmessa, anche se il discorso é tenuto in modo veloce da un madrelingua, purché abbia il tempo di abituarmi all’ accento.</td>
				<td>Riesco a capire con facilità praticamente tutte le forme di lingua scritta inclusi i testi  teorici, strutturalmente o linguisticamante complessi, quali manuali, articoli specialistici e opere letterarie.</td>
				<td>Riesco a partecipare senza sforzi a qualsiasi conversazione e discussione ed ho familiarità con le espressioni idiomatiche e colloquiali. Riesco ad esprimermi con scioltezza e a rendere con precisione sottili sfumature di significato. In caso di difficoltà, riesco a ritornare sul discorso e a riformularlo in modo cosí scorrevole che difficilmente qualcuno se ne accorge.</td>
				<td>Riesco a presentare descrizioni o argomentazioni chiare e scorrevoli, in uno stile adeguato al contesto e con una struttura logica efficace, che possa aiutare il destinatario a identificare i  punti salienti da rammentare.</td>
				<td>Riesco a scrivere testi chiari, scorrevoli e stilisticamente appropriati. Riesco a scrivere lettere, relazioni e articoli complessi, supportando il contenuto con una struttura logica efficace che aiuti il destinatario a identificare i punti salienti da rammentare. Riesco a scrivere riassunti e recensioni di opere letterarie e di testi specialisti.</td>
			</tr>
		</table>
	</xsl:if>
</xsl:template>
</xsl:stylesheet>
