<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_et_EE_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_et_EE_V2.0.xsl
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
					<span class="LabelBold">Europassi keelepass</span>
					<br/>
					<span class="Label">Osa Euroopa keelemapist, välja töötanud Euroopa Nõukogu</span>
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
							  <xsl:text>Perekonnanimi </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Perekonnanimi</xsl:text>
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
						<xsl:with-param name="label"><xsl:text>Sünniaeg</xsl:text></xsl:with-param>
						<xsl:with-param name="labelcontent"><xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				</xsl:if>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Emakeel(ed)</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Teised keel(ed)</xsl:text></xsl:with-param>
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
					<td class="GridHeadingBold" colspan="10">Keeleoskuse hindamine</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Mõistmine</td>
					<td class="GridHeadingBold" colspan="4">Rääkimine</td>
					<td class="GridHeadingBold" colspan="2">Kirjutamine</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Kuulamine</td>
					<td class="GridHeading" colspan="2">Lugemine</td>
					<td class="GridHeading" colspan="2">Suuline suhtlus</td>
					<td class="GridHeading" colspan="2">Suuline esitus</td>
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
		<xsl:if test="$element='a1'">Algeline keelekasutus</xsl:if>
		<xsl:if test="$element='b1'">Iseseisev keelekasutus</xsl:if>
		<xsl:if test="$element='c1'">Vaba keelekasutus</xsl:if>
		<xsl:if test="$element='a2'">Algeline keelekasutus</xsl:if>
		<xsl:if test="$element='b2'">Iseseisev keelekasutus</xsl:if>
		<xsl:if test="$element='c2'">Vaba keelekasutus</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Diplom(id) ja tunnistus(ed)</td>
			</tr>
			<tr>
				<td class="GridHeading">Diplomite või tunnistuste nimetused</td>
				<td class="GridHeading">Väljastanud asutus</td>
				<td class="GridHeading">Kuupäev</td>
				<td class="GridHeading">Euroopa tase</td>
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
				<td class="GridHeadingBold" colspan="3">Keelelised kogemused</td>
			</tr>
			<tr>
				<td class="GridHeading">Kirjeldus</td>
				<td class="GridHeading">Alates</td>
				<td class="GridHeading">Kuni</td>
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
		(*)Tärniga tähistatud lahtrid ei ole kohustuslikud.
		(**)Vaadake keeleoskuse enesehindamistabelit pöördel.
		(***)Euroopa ühtse keeleoskussüsteemi (CEF) tase, kui see on ära toodud tunnistuse või diplomi originaalil.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Selgitav märkus</b><br/>
		Europassi keelepass on üks osa Euroopa Nõukogu väljatöötatud Euroopa keelemapist. Keelepassi puhul kasutatakse Euroopa ühtse keeleoskussüsteemi (CEF) kuut (6) taset, et kirjeldada omandatud keeleoskuse taset standardiseeritud formaadis.<br/>
		Lisainformatsioon Europassi keelepassi kohta: http://europass.cedefop.europa.eu - Lisainformatsioon Euroopa keelemapi kohta: www.coe.int/portfolio<br/>
		Europassi keelepassi blanketi saab tasuta alla laadida ülalnimetatud veebilehtedelt.<br/>
		© Euroopa Nõukogu ja Euroopa Ühendused, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">Euroopa Nõukogu keeleoskussüsteem – Enesehindamisskaala</th>
			</tr>
			<tr class="level">
				<th>A1</th>
				<td>Saan aru tuttavatest sõnadest ja fraasidest, mis puudutavad mind, minu perekonda ja minu vahetut ümbrust, kui inimesed räägivad aeglaselt ja selgelt.</td>
				<td>Saan aru tuttavatest nimedest, sõnadest ja väga lihtsatest lausetest näiteks siltidel, plakatitel või kataloogides.</td>
				<td>Oskan lihtsal viisil suhelda tingimusel, et vestluspartner aeglaselt räägib, vajadusel öeldut kordab või ümber sõnastab ning mind vestlemisel aitab. Oskan küsida lihtsaid küsimusi ja neile vastata.</td>
				<td>Oskan kasutada lihtsaid fraase ja lauseid kirjeldamaks kohta, kus elan, ja inimesi, keda tunnen.</td>
				<td>Oskan kirjutada lühikest ja lihtsat teadet (näiteks postkaarti puhkusetervitustega) ning täita ankeete (näiteks hotelli registreerimislehte, kus küsitakse isikuandmeid: nime, aadressi, rahvust/kodakondsust).</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Saan aru fraasidest ja sageli kasutatavatest sõnadest, mis on vahetult seotud mulle oluliste valdkondadega (näiteks info minu ja mu perekonna kohta, sisse-ostude tegemine, kodukoht, töö). Saan aru lühikeste, lihtsate ja selgelt väljahääldatud ütluste põhisisust.</td>
				<td>Saan aru väga lühikestest lihtsatest tekstidest. Oskan leida eeldatavat spetsiifilist informatsiooni lihtsatest igapäevatekstidest (näiteks reklaamid, tööpakkumised, brošüürid, menüüd, sõiduplaanid), samuti saan aru lühikestest lihtsatest isiklikest kirjadest.</td>
				<td>Saan hakkama igapäevastes suhtlusolukordades, mis nõuavad otsest ja lihtsat infovahetust tuttavatel teemadel. Oskan kaasa rääkida, ehkki ma ei oska veel ise vestlust juhtida.</td>
				<td>Oskan kasutada mitmeid fraase ja lauseid, et kirjeldada oma perekonda ja teisi inimesi, elutingimusi, hariduslikku tagapõhja, praegust või eelmist tööd.</td>
				<td>Oskan teha märkmeid ja koostada väga lihtsat isiklikku kirja, näiteks kellegi tänamiseks.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Saan aru põhilisest infost selges tavakõnes tuttaval teemal: töö, kool, vaba aeg jne. Saan aru aeglaselt ja selgelt edastatud raadio- või telesaadete põhisisust, kui need käsitlevad päevateemasid või mulle huvitavaid teemasid.</td>
				<td>Saan aru tekstidest, mis koosnevad sagedamini esinevatest või minu tööga seotud sõnadest. Saan aru sündmuste, mõtete ja soovide kirjeldusest isiklikes kirjades.</td>
				<td>Saan enamasti keelega hakkama maal, kus see on kasutusel. Oskan ettevalmistuseta vestelda tuttaval, huvitaval või olulisel teemal: pere, hobid, töö, reisimine ja päevasündmused.</td>
				<td>Oskan lihtsate seostatud lausetega kirjeldada kogemusi, sündmusi, unistusi ja kavatsusi. Oskan lühidalt põhjendada ning selgitada oma seisukohti ja plaane. Oskan edasi anda jutu, raamatu ja filmi sisu ning kirjeldada muljeid.</td>
				<td>Oskan koostada lihtsat seostatud teksti tuttaval või mulle huvi pakkuval teemal. Oskan kirjutada isiklikku kirja, milles kirjeldan oma kogemusi ja muljeid.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Saan aru pikematest kõnedest ja ettekannetest ning tuttava teema puhul isegi nende keerukamatest nüanssidest. Saan aru enamiku teleuudiste, publitsistikasaadete ja filmide sisust.</td>
				<td>Saan aru aktuaalsetel teemadel kirjutatud artiklitest, kus autorid väljendavad mingeid kindlaid seisukohti või vaatenurki. Saan aru tänapäevasest proosast.</td>
				<td>Oskan vestelda piisavalt spontaanselt ja ladusalt, nii et suhtlemine keelt emakeelena kõnelevate inimestega on täiesti võimalik. Saan aktiivselt osaleda aruteludes tuttaval teemal, oskan oma seisukohti väljendada ja põhjendada.</td>
				<td>Oskan selgelt ja üksikasjalikult käsitleda ainest laias teemaderingis, mis puudutab minu huvialasid. Oskan selgitada oma seisukohti aktuaalsetel teemadel, tuues välja erinevate arvamuste poolt- ja vastuargumendid.</td>
				<td>Oskan kirjutada selgeid ja detailseid tekste mulle huvi pakkuvas teemaderingis. Oskan kirjutada esseed. Aruannet või referaati, edastamaks infot ning kommenteerides ja põhjendades oma seisukohti. Oskan kirjutada kirju, milles tõstan esile kogemuste ja sündmuste olulisi aspekte.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Saan aru pikemast tekstist isegi siis, kui see pole selgelt liigendatud ja seosed on esitatud kas kaudselt või vihjamisi. Saan suurema vaevata aru teleprogrammidest ja filmidest.</td>
				<td>Saan aru pikkadest ja keerulistest tekstidest, nii olustikulistest kui ka kirjanduslikest, tajudes nende stilistilist eripära. Saan aru erialastest artiklitest ja pikematest tehnilistest juhenditest isegi siis, kui need vahetult ei puuduta minu eriala.</td>
				<td>Oskan end mõistetavaks teha ladusalt ja spontaanselt, väljendeid eriti otsimata. Oskan kasutada keelt paindlikult ja tulemuslikult nii ühiskondlikel kui ka tööalastel eesmärkidel. Oskan avaldada mõtteid ja arvamusi ning vestluses teemat arendada.</td>
				<td>Oskan keerulisi teemasid täpselt ja üksikasjalikult kirjeldada, välja tuua alateemad ja olulisemad punktid ning teha kokkuvõtet.</td>
				<td>Oskan ennast väljendada selge, hästi liigendatud tekstiga, avaldades oma arvamust vajaliku põhjalikkusega. Oskan kirjutada kirja, esseed või aruannet keerukal teemal ja esile tõsta olulisemat. Oskan lugejast lähtuvalt kohandada oma stiili.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Saan vaevata aru igasugusest kõnest, olenemata sellest, kus seda esitatakse. Saan aru ka kiirkõnest, kui mulle antakse pisut aega hääldusviisiga harjumiseks.</td>
				<td>Saan vaevata aru kõigist kirjaliku teksti liikidest, sealhulgas abstraktsetest, struktuurilt ja/või keeleliselt keerulistest tekstidest, näiteks käsiraamatutest, erialastest artiklitest ja ilukirjandusest.</td>
				<td>Saan vaevata osaleda igas vestluses ja diskussioonis ning oskan kujundlikke ja kõnekeelseid väljendeid. Oskan täpselt edasi anda tähendus-varjundeid. Vajadusel oskan lausungi ümber sõnastada, nii et vestluses osalejad seda vaevalt märkavad.</td>
				<td>Oskan esitada selge ja ladusa, kontekstile vastavas stiilis kirjelduse või põhjenduse, millel on loogiline ülesehitus, mis aitab kuulajal märgata ja meelde jätta kõige olulisemat.</td>
				<td>Oskan kirjutada ladusalt ja selgelt vajalikus stiilis. Oskan koostada keerulisi kirju, aruandeid või artikleid, esitada ainest loogiliselt liigendatuna nii, et lugeja suudab eristada olulist. Oskan koostada erialaseid ja ilukirjanduslikke sisukokkuvõtteid, annotatsioone ning retsensioone.</td>
			</tr>
	  </table>
  </xsl:template>
</xsl:stylesheet>
