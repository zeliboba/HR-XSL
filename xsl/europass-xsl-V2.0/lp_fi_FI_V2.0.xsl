<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_fi_FI_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_fi_FI_V2.0.xsl
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
					<span class="LabelBold">Europass-kielipassi</span>
					<br/>
					<span class="Label">Osa Euroopan neuvoston kehittämää eurooppalaista kielisalkkua</span>
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
							  <xsl:text>Sukunimi </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Sukunimi</xsl:text>
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
						<xsl:with-param name="label"><xsl:text>Syntymäaika</xsl:text></xsl:with-param>
						<xsl:with-param name="labelcontent"><xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				</xsl:if>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Äidinkieli tai -kielet</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Muut kielet</xsl:text></xsl:with-param>
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
					<td class="GridHeadingBold" colspan="10">Kielitaidon itsearviointi</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Ymmärtäminen</td>
					<td class="GridHeadingBold" colspan="4">Puhuminen</td>
					<td class="GridHeadingBold" colspan="2">Kirjoittaminen</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Kuullun ymmärtäminen</td>
					<td class="GridHeading" colspan="2">Luetun ymmärtäminen</td>
					<td class="GridHeading" colspan="2">Suullinen vuorovaikutus</td>
					<td class="GridHeading" colspan="2">Puheen tuottaminen</td>
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
		<xsl:if test="$element='a1'">Peruskielitaito</xsl:if>
		<xsl:if test="$element='b1'">Itsenäisen kielenkäyttäjän kielitaito</xsl:if>
		<xsl:if test="$element='c1'">Taitavan kielenkäyttäjän kielitaito</xsl:if>
		<xsl:if test="$element='a2'">Peruskielitaito</xsl:if>
		<xsl:if test="$element='b2'">Itsenäisen kielenkäyttäjän kielitaito</xsl:if>
		<xsl:if test="$element='c2'">Taitavan kielenkäyttäjän kielitaito</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Todistukset</td>
			</tr>
			<tr>
				<td class="GridHeading">Todistus</td>
				<td class="GridHeading">Todistuksen myöntäjä</td>
				<td class="GridHeading">Päivämäärä</td>
				<td class="GridHeading">Eurooppalainen taitotaso</td>
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
				<td class="GridHeadingBold" colspan="3">Kielitaitoon liittyvät kokemukset</td>
			</tr>
			<tr>
				<td class="GridHeading">Kuvaus</td>
				<td class="GridHeading">Alkoi</td>
				<td class="GridHeading">Päättyi</td>
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
		(*)Tähdellä merkityt kohdat ovat vapaaehtoisia
		(**)Katso itsearviointilokerikko kääntöpuolella.
		(***)Yleiseurooppalainen viitekehystaso määritetään alkuperäisessä todistuksessa tai tutkintotodistuksessa.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Huomautus</b><br/>
		Europass-kielipassi on osa Euroopan neuvoston kehittämää eurooppalaista kielisalkkua. Siinä käytetään yleiseurooppalaisen kielten opetuksen ja oppimisen viitekehyksen kuusiportaista taitotasoasteikkoa kielitaidon saavutetun tason esittämiseksi standardimuodossa.<br/>
		Lisätietoja Europass-kielipassista: http://europass.cedefop.europa.eu - Lisätietoja eurooppalaisesta kielisalkusta: www.coe.int/portfolio<br/>
		Europass kielipassin kaavake on ilmaiseksi ladattavissa edellä mainituista osoitteista.<br/>
		© Euroopan neuvosto ja Euroopan yhteisöt, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">Eurooppalainen taso – Itsearviointilokerikko</th>
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
  </xsl:template>
</xsl:stylesheet>
