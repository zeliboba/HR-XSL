<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_hu_HU_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_hu_HU_V2.0.xsl
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
					<span class="LabelBold">Europass Nyelvi útlevél</span>
					<br/>
					<span class="Label">Az Európa Tanács által kidolgozott Európai Nyelvtanulási napló része</span>
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
							  <xsl:text>Vezetéknév(nevek) </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Vezetéknév(nevek)</xsl:text>
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
						<xsl:with-param name="label"><xsl:text>Születési dátum</xsl:text></xsl:with-param>
						<xsl:with-param name="labelcontent"><xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				</xsl:if>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Anyanyelv(ek)</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Egyéb/beszélt nyelv(ek)</xsl:text></xsl:with-param>
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
					<td class="GridHeadingBold" colspan="10">Önértékelés</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Szövegértés</td>
					<td class="GridHeadingBold" colspan="4">Beszéd</td>
					<td class="GridHeadingBold" colspan="2">Írás</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Hallás utáni értés</td>
					<td class="GridHeading" colspan="2">Olvasás</td>
					<td class="GridHeading" colspan="2">Társalgás</td>
					<td class="GridHeading" colspan="2">Folyamatos beszéd</td>
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
		<xsl:if test="$element='a1'">alapszintű nyelvhasználó</xsl:if>
		<xsl:if test="$element='b1'">önálló nyelvhasználó</xsl:if>
		<xsl:if test="$element='c1'">mesterfokú nyelvhasználó</xsl:if>
		<xsl:if test="$element='a2'">alapszintű nyelvhasználó</xsl:if>
		<xsl:if test="$element='b2'">önálló nyelvhasználó</xsl:if>
		<xsl:if test="$element='c2'">mesterfokú nyelvhasználó</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Okelvel(ek) / bizonyítvány(ok)</td>
			</tr>
			<tr>
				<td class="GridHeading">Megnevezés</td>
				<td class="GridHeading">Kibocsátó szerv</td>
				<td class="GridHeading">Év</td>
				<td class="GridHeading">Európai szint</td>
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
				<td class="GridHeadingBold" colspan="3">Nyelvi tapasztalat(ok)</td>
			</tr>
			<tr>
				<td class="GridHeading">Leírás</td>
				<td class="GridHeading">-tól</td>
				<td class="GridHeading">-ig</td>
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
		(*)A csillaggal megjelölt rovatok kitöltése választható
		(**)Önértékelési táblázatot lásd túloldalt
		(***)Közös Európai Referenciakeret (CEF) szint, ha meghatározásra került az eredeti bizonyítávnyban vagy oklevélben.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Magyarázó jegyzet</b><br/>
		Az Europass nyelvi útlevél az Európa Tanács által fejlesztett Európai Nyelvtanulási napló részére. A formanyomtatványban a Közös Európai Referenciakeret 6 európai szintje szolgál a gyakorlati nyelvtudás bemutatására.<br/>
		További információk az Europass nyelvi útlevélről: http://europass.cedefop.europa.eu - További információk az Európai Nyelvtanuálsi naplóról: www.coe.int/portfolio<br/>
		A formanyomtatvány az Europass nyelvi útlevélhez térítésmentesen letötlhető a fenti honlapokról.<br/>
		© Európa Tanács és Európai Közösségek, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">A közös európai léptékre épülő értékelési táblázat</th>
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
  </xsl:template>
</xsl:stylesheet>
