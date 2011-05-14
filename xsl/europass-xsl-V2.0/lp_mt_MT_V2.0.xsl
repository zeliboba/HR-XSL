<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_mt_MT_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_mt_MT_V2.0.xsl
</xsl:comment>
<html>
	<head>
	  <title>LP - HTML</title>
	  <link href="http://europass.cedefop.europa.eu/instruments/css/html.css" type="text/css" rel="stylesheet"/>
	</head>
	<body>
		<xsl:call-template name="logoheader"/>
		<xsl:call-template name="personalinformation"/>
		<xsl:call-template name="foreignlanguageinformation"/>
		<xsl:call-template name="footnoteasterisk"/>
		<xsl:if test="//field[@name='grid' and @keep='true']">
			<xsl:call-template name="grid"/>
		</xsl:if>
	</body>
</html>
</xsl:template>
<xsl:template name="logoheader">
	<table class="LP" cellSpacing="0" cellPadding="10" width="740" border="0">
		<tbody>
			<tr align="middle">
				<td width="20%"><img height="53" src="http://europass.cedefop.europa.eu/instruments/images/logos/logo_europass_lp.gif" width="95"/></td>
				<td style="text-align: center" width="60%">
					<span class="LabelBold">Passport tal-Lingwa Europass</span>
					<br/>
					<span class="Label">Parti mill-Portfolio Ewropew tal-Lingwa Żviluppat mill-Kunsill ta’ l-Ewropa</span>
				</td>
				<td width="20%"><img height="53" src="http://europass.cedefop.europa.eu/instruments/images/logos/otherlogo_lp.gif" width="95"/></td>
			</tr>
		</tbody>
	</table>
</xsl:template>
<xsl:template name="personalinformation">
	<xsl:variable name="firstNameBefore">
		<xsl:choose>
		  <xsl:when test="//field[@name='personal.firstName' and @before='personal.lastName']">1</xsl:when>
		  <xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<div class="VerLine_LP">
		<table class="LP" cellSpacing="0" cellPadding="0" width="710" border="0">
			<tbody>
				<xsl:call-template name="firstlinePersonalinformationtable"/>
				<xsl:call-template name="labelRowBold">
					<xsl:with-param name="label">
						<xsl:choose>
							<xsl:when test="$firstNameBefore=0">
							  <xsl:text>Kunjom(ijiet) </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Kunjom(ijiet)</xsl:text>
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
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:if test="//field[@name='personal.birthDate' and @keep='true']">
					<xsl:call-template name="labelRow">
						<xsl:with-param name="label"><xsl:text>Data tat-twelid</xsl:text></xsl:with-param>
						<xsl:with-param name="labelcontent"><xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				</xsl:if>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Ilsien / Isla nattiv(i)</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Lingwa(i) oħra(jn)</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent">
						<xsl:for-each select="europass:learnerinfo/languagelist/language[@xsi:type='europass:foreign']">
						  <xsl:if test="position() != 1">,&#160;</xsl:if>
						  <xsl:value-of select="label" />
						</xsl:for-each>
					</xsl:with-param>
				</xsl:call-template>
			</tbody>
		</table>
	</div>
</xsl:template>
<xsl:template name="foreignlanguageinformation">
	<xsl:for-each select="europass:learnerinfo/languagelist/language[@xsi:type='europass:foreign']">
		<xsl:call-template name="foreignlanguage"/>
	</xsl:for-each>
</xsl:template>
<xsl:template name="foreignlanguage">
	<br/>
	<div class="VerLine_LP">
		<table class="LP" cellSpacing="0" cellPadding="0" width="710" border="0">
			<tbody>
				<xsl:call-template name="firstlineForeignlanguageinformationtable"/>
				<tr>
					<td/>
					<td class="NormalHighlight"><xsl:value-of select="label" /> </td>
					<td/>
				</tr>
				<tr>
					<td/>
					<td>
						<xsl:call-template name="selfassessmenttable">
							<xsl:with-param name="indexedLang"><xsl:value-of select="concat('foreignLanguageList[', position()-1, ']')" /></xsl:with-param>
						</xsl:call-template>
					</td>
					<td/>
				</tr>    
				<xsl:call-template name="emptyTableRow"/>
				<tr>
					<td/>
					<td>
						<xsl:call-template name="linguisticdiplomatable">
							<xsl:with-param name="indexedLang"><xsl:value-of select="concat('foreignLanguageList[', position()-1, ']')" /></xsl:with-param>
						</xsl:call-template>
					</td>
					<td/>
				</tr> 
				<xsl:call-template name="emptyTableRow"/>
				<tr>
					<td/>
					<td>
						<xsl:call-template name="linguisticexperiencetable">
							<xsl:with-param name="indexedLang"><xsl:value-of select="concat('foreignLanguageList[', position()-1, ']')" /></xsl:with-param>
						</xsl:call-template>
					</td>
					<td/>
				</tr> 
				<xsl:call-template name="emptyTableRow"/>
			</tbody>
		</table>
	</div>
</xsl:template>
<xsl:template name="selfassessmenttable">
	<xsl:param name="indexedLang"/>
	<xsl:if test="//field[@name=concat($indexedLang,'.ass') and @keep='true']">
		<table>
			<tbody>
				<xsl:call-template name="firstlineSelfassessmenttable"/>
				<tr>
					<td class="GridHeadingBold" colspan="10">Awtoassessjar tal-ħiliet fil-lingwa</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Fehim</td>
					<td class="GridHeadingBold" colspan="4">Taħdit</td>
					<td class="GridHeadingBold" colspan="2">Kitba</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Smigħ</td>
					<td class="GridHeading" colspan="2">Qari</td>
					<td class="GridHeading" colspan="2">Taħdit interattiv</td>
					<td class="GridHeading" colspan="2">Taħdit produttiv</td>
					<td colspan="2"/>
				</tr>
				<tr>
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
				</tr>
			</tbody>
		</table>
	</xsl:if>
</xsl:template>
<xsl:template name="selfassessmentlevel">
	<xsl:param name="element"/>
	<td class="NormalCenter"><xsl:value-of select="$element" /></td>
	<td class="NormalCenter">
		<xsl:if test="$element='a1'">Użu bażiku</xsl:if>
		<xsl:if test="$element='b1'">Użu indipendenti</xsl:if>
		<xsl:if test="$element='c1'">Użu profiċjenti</xsl:if>
		<xsl:if test="$element='a2'">Użu bażiku</xsl:if>
		<xsl:if test="$element='b2'">Użu indipendenti</xsl:if>
		<xsl:if test="$element='c2'">Użu profiċjenti</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Diploma(i) jew Ċertifikat(i)</td>
			</tr>
			<tr>
				<td class="GridHeading">Isem tad-diploma(i) jew ċertifikat(i)</td>
				<td class="GridHeading">Organizzazzjoni minn fejn ħareġ(ħarġu) iċ-ċertifikat(i) u/jew diploma(i)</td>
				<td class="GridHeading">Sena</td>
				<td class="GridHeading">Livell Ewropew</td>
			</tr>
			<xsl:for-each select="diplomalist/diploma">
				<xsl:variable name="indexedDiploma">
					<xsl:value-of select="concat('.diplomaList[', position()-1, ']')" />
				</xsl:variable>
				<xsl:variable name="indexedBoth">
					<xsl:value-of select="concat('', $indexedLang, $indexedDiploma)" />
				</xsl:variable>
				<xsl:if test="//field[@name=$indexedBoth and @keep='true']">
					<tr>
						<td class="Normal"><xsl:value-of select="title" /></td>
						<td class="Normal"><xsl:value-of select="awardingBody" /></td>
						<td class="NormalCenter">
							<xsl:value-of select="translate(date/day,'-','')" /><xsl:if test="string-length(date/day) != 0">/</xsl:if><xsl:value-of select="translate(date/month,'-','')" /><xsl:if test="string-length(date/month) != 0">/</xsl:if><xsl:value-of select="translate(date/year,'-','')" />
						</td>
						<td class="NormalCenter"><xsl:value-of select="level" /> </td>
					</tr>
				</xsl:if>
			</xsl:for-each>
		</tbody>
	</table>
</xsl:template>
<xsl:template name="linguisticexperiencetable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticexperiencetable"/>
			<tr>
				<td class="GridHeadingBold" colspan="3">Esperjenza(i) fil-lingwa(i)</td>
			</tr>
			<tr>
				<td class="GridHeading">Deskrizzjoni</td>
				<td class="GridHeading">Minn</td>
				<td class="GridHeading">Sa</td>
			</tr>
			<xsl:for-each select="experiencelist/experience">
				<xsl:variable name="indexedExperience">
					<xsl:value-of select="concat('.experienceList[', position()-1, ']')" />
				</xsl:variable>
				<xsl:variable name="indexedBoth">
					<xsl:value-of select="concat('', $indexedLang, $indexedExperience)" />
				</xsl:variable>
				<xsl:if test="//field[@name=$indexedBoth and @keep='true']">
					<tr>
						<td class="Normal"><xsl:value-of select="description" /></td>
						<td class="NormalCenter">
							<xsl:value-of select="translate(period/from/day,'-','')" /><xsl:if test="string-length(period/from/day) != 0">/</xsl:if><xsl:value-of select="translate(period/from/month,'-','')" /><xsl:if test="string-length(period/from/month) != 0">/</xsl:if><xsl:value-of select="translate(period/from/year,'-','')" />
						</td>
						<td class="NormalCenter"><xsl:value-of select="translate(period/to/day,'-','')" /><xsl:if test="string-length(period/to/day) != 0">/</xsl:if><xsl:value-of select="translate(period/to/month,'-','')" /><xsl:if test="string-length(period/to/month) != 0">/</xsl:if><xsl:value-of select="translate(period/to/year,'-','')" />
						</td>
					</tr>
				</xsl:if>
			</xsl:for-each>
		</tbody>
	</table>
</xsl:template>
<xsl:template name="labelRow">
	<xsl:param name="label"/>
	<xsl:param name="labelcontent"/>
	<tr>
		<td class="Label"><xsl:value-of select="$label"/></td>
		<td class="Normal"><xsl:value-of select="$labelcontent"/></td>
		<td>&#160;</td>
	</tr>
</xsl:template>
<xsl:template name="labelRowBold">
	<xsl:param name="label"/>
	<xsl:param name="labelcontent"/>
	<tr>
		<td class="LabelBold"><xsl:value-of select="$label"/></td>
		<td class="Normal"><xsl:value-of select="$labelcontent"/></td>
		<td>&#160;</td>
	</tr>
</xsl:template>
<xsl:template name="emptyLabelRow">
	<tr>
		<td colSpan="3"/>
	</tr>
</xsl:template>  
<xsl:template name="emptyTableRow">
	<tr>
		<td colspan="3"/>
	</tr>
</xsl:template>  
<xsl:template name="firstlinePersonalinformationtable">
	<tr>
		<td width="173"/>
		<td width="516"/>
		<td width="21"/>
	</tr>
</xsl:template>
<xsl:template name="firstlineForeignlanguageinformationtable">
	<tr>
		<td width="20"/>
		<td width="670"/>
		<td width="20"/>
	</tr>
</xsl:template>
<xsl:template name="firstlineSelfassessmenttable">
	<tr>
		<td width="25"/>
		<td width="109"/>
		<td width="25"/>
		<td width="109"/>
		<td width="25"/>
		<td width="109"/>
		<td width="25"/>
		<td width="109"/>
		<td width="25"/>
		<td width="109"/>
	</tr>
</xsl:template>
<xsl:template name="firstlineLinguisticdiplomatable">
	<tr>
		<td width="270"/>
		<td width="230"/>
		<td width="85"/>
		<td width="85"/>
	</tr>
</xsl:template>
<xsl:template name="firstlineLinguisticexperiencetable">
	<tr>
		<td width="500"/>
		<td width="85"/>
		<td width="85"/>
	</tr>
</xsl:template>
<xsl:template name="footnoteasterisk">
	<div class="Asterix">
		(*)Imla' jekk trid fejn hu mmarkat b'asterisk
		(**)Ara t-taqsima ta' l-awtoassessjar fuq in-naħa ta' wara
		(***)Livell tal-"Common European Framework Reference" (CEF) jekk speċifikat fuq iċ-ċertifikat oriġinali jew diploma.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Nota ta' spjegazzjoni</b><br/>
		Il-Passport tal-Lingwa Europass huwa parti mill-Portafoll tal-Lingwa Ewropew li ġie żviluppat mill-Kunsill ta' l-Ewropa. Dan juża s-sitt livelli Ewropej tal-"Common European Framework of Reference for Languages" (CEF) biex jirrekordja l-livell ta' profiċjenza lingwistika miksub fil-format standardizzat.<br/>
		Aktar tagħrif dwar il-Passport tal-Lingwa Europass http://europass.cedefop.eu.int - Aktar tagħrif dwar il-Portfoll Ewropew tal-Lingwa : www.coe.int/portfolio<br/>
		It-"template" tal-Passport tal-Lingwa Europass jista' jitniżżel mingħajr ħlas mis-siti ta' l-internet li jidhru hawn fuq.<br/>
		© Kunsill ta' l-Ewropa u l-Komunitajiet Ewropej, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">Livell Ewropew – tabella ta’ l-awto-assessjar</th>
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
  </xsl:template>
</xsl:stylesheet>
