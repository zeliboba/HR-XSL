<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_sk_SK_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_sk_SK_V2.0.xsl
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
					<span class="LabelBold">Europass - Jazykový pas</span>
					<br/>
					<span class="Label">Súčasť Európskeho jazykového portfólia vyvinutého Radou Európy</span>
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
							  <xsl:text>Priezvisko(á) </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Priezvisko(á)</xsl:text>
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
						<xsl:with-param name="label"><xsl:text>Dátum narodenia</xsl:text></xsl:with-param>
						<xsl:with-param name="labelcontent"><xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				</xsl:if>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Materinský(é) jazyk(y)</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Ďalší(ie) jazyk(y)</xsl:text></xsl:with-param>
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
					<td class="GridHeadingBold" colspan="10">Sebahodnotenie jazykových zručností</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Porozumenie</td>
					<td class="GridHeadingBold" colspan="4">Hovorenie</td>
					<td class="GridHeadingBold" colspan="2">Písanie</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Počúvanie</td>
					<td class="GridHeading" colspan="2">Čítanie</td>
					<td class="GridHeading" colspan="2">Ústna interakcia</td>
					<td class="GridHeading" colspan="2">Samostatný ústny prejav</td>
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
		<xsl:if test="$element='a1'">Používateľ základného jazyka</xsl:if>
		<xsl:if test="$element='b1'">Samostatný používateľ</xsl:if>
		<xsl:if test="$element='c1'">Skúsený používateľ</xsl:if>
		<xsl:if test="$element='a2'">Používateľ základného jazyka</xsl:if>
		<xsl:if test="$element='b2'">Samostatný používateľ</xsl:if>
		<xsl:if test="$element='c2'">Skúsený používateľ</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Diplom(y), vysvedčenie(ia)/osvedčenie(ia)</td>
			</tr>
			<tr>
				<td class="GridHeading">Názov diplomu(ov), vysvedčenia(í)/osvedčenia(í)</td>
				<td class="GridHeading">Vydávajúca inštitúcia</td>
				<td class="GridHeading">Rok</td>
				<td class="GridHeading">Európska úroveň</td>
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
				<td class="GridHeadingBold" colspan="3">Jazyková(é) skúsenosť(ti)</td>
			</tr>
			<tr>
				<td class="GridHeading">Opis</td>
				<td class="GridHeading">Od</td>
				<td class="GridHeading">Do</td>
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
		(*)Vyplnenie kolónok označených hviezdičkou nie je povinné.
		(**)Pozrite tabuľku sebahodnotenia na opačnej strane.
		(***)Úroveň podľa Spoločného európskeho referenčného rámca (CEF) je uvedená v origináli vysvedčenia/osvedčenia alebo diplomu.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Vysvetľujúca poznámka</b><br/>
		Europass - jazykový pas je súčasťou Európskeho jazykového portfólia vyvinutého Radou Európy. Na zaznamenanie úrovne jazykovej spôsobilosti v štandardizovanej forme používa 6 úrovní Spoločného európskeho referenčného rámca pre jazyky (CEF).<br/>
		Viac informácií o dokumente Europass - jazykový pas nájdete na http://europass.cedefop.europa.eu - Viac informácií o Európskom jazykovom portfóliu na www.coe.int/portfolio<br/>
		Formulár dokumentu Europass - jazykový pas si možno bezplatne stiahnuť z vyššie uvedených webových stránok.<br/>
		© Rada Európy a Európske spoločenstvá, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">Európske úrovne – tabuľka sebahodnotenia</th>
			</tr>
			<tr class="level">
				<th>A1</th>
				<td>Dokážem rozoznať známe slová a veľmi základné frázy týkajúce sa mňa a mojej rodiny a bezprostredného konkrétneho okolia, keď ľudia hovoria pomaly  a jasne.</td>
				<td>Rozumiem známym menám, slovám a veľmi jednoduchým vetám, napríklad na oznámeniach a plagátoch alebo v katalógoch.</td>
				<td>Dokážem komunikovať jednoduchým spôsobom za predpokladu, že môj partner v komunikácii je pripravený zopakovať alebo preformulovať svoju výpoveď pri pomalšej rýchlosti reči a že mi pomôže sformulovať, čo ja sa pokúšam povedať. Dokážem klásť a odpovedať na jednoduché otázky v oblasti mojich základných potrieb alebo na veľmi známe témy.</td>
				<td>Dokážem využívať jednoduché frázy a vetami opísať miesto, kde žijem a ľudí, ktorých poznám.</td>
				<td>Dokážem napísať krátku jednoduchú pohľadnicu, napríklad dokážem poslať pozdravy z dovolenky. Dokážem vyplniť formuláre s osobnými údajmi, napríklad uviesť svoje meno, štátnu príslušnosť a adresu na registračnom formulári v hoteli.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Dokážem porozumieť frázam a najbežnejšej slovnej zásobe vo vzťahu k oblastiam, ktoré sa ma  bezprostredne týkajú (napríklad základné informácie o mne a rodine, nakupovaní, miestnej oblasti, zamestnaní). Dokážem pochopiť zmysel  v krátkych, jasných a jednoduchých správach a oznámeniach.</td>
				<td>Dokážem čítať veľmi krátke jednoduché texty. Dokážem nájsť konkrétne predvídateľné  informácie v jednoduchom každodennom materiáli, ako sú napríklad inzeráty, prospekty, jedálne lístky a časové harmonogramy a dokážem porozumieť krátkymi jednoduchým osobným listom.</td>
				<td>Dokážem komunikovať v jednoduchých a bežných situáciách vyžadujúcich jednoduchú a priamu výmenu informácií o známych témach a činnostiach. Dokážem zvládnuť veľmi krátke spoločenské kontakty, dokonca aj keď zvyčajne nerozumiem dostatočne na to, aby som sám udržiaval konverzáciu.</td>
				<td>Dokážem použiť sériu fráz a viet na jednoduchý opis mojej rodiny a ostatných ľudí, životných podmienok, môjho vzdelania a mojej terajšej alebo nedávnej práce.</td>
				<td>Dokážem napísať krátke jednoduché oznámenia a správy vzťahujúce sa na moje bezprostredné potreby. Dokážem napísať veľmi jednoduchý osobný list, napríklad poďakovanie.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Dokážem pochopiť hlavné body jasnej štandardnej reči o známych veciach, s ktorými sa pravidelne stretávam v škole, práci, vo voľnom čase atď. Rozumiem zmyslu mnohých rozhlasových alebo televíznych programov o aktuálnych udalostiach a témach osobného či odborného záujmu, keď je prejav relatívne pomalý a jasný.</td>
				<td>Rozumiem textom, ktoré pozostávajú z každodennej slovnej zásoby často používanej v každodennom živote alebo ktoré sa vzťahujú sa na moju prácu. Dokážem porozumieť opisom udalostí, pocitov a prianí v osobných listoch.</td>
				<td>Dokážem zvládnuť väčšinu situácií, ktoré sa môžu vyskytnúť počas cestovania v oblasti, kde sa hovorí týmto jazykom. Môžem nepripravený vstúpiť do konverzácie na témy, ktoré sú známe, ktoré ma osobne zaujímajú, alebo ktoré sa týkajú osobného každodenného života (napríklad rodina, koníčky, práca, cestovanie, súčasné udalosti).</td>
				<td>Dokážem spájať frázy jednoduchým spôsobom, aby som opísal skúsenosti a udalosti, svoje sny, nádeje a ambície. Stručne dokážem uviesť dôvody a vysvetlenia názorov a plánov. Dokážem vyrozprávať príbeh alebo zápletku knihy či filmu a opísať svoje reakcie.</td>
				<td>Dokážem napísať jednoduchý súvislý text na témy, ktoré sú mi známe alebo ma osobne zaujímajú. Dokážem napísať osobné listy opisujúce skúsenosti a dojmy.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Dokážem porozumieť dlhšej reči a prednáškam a sledovať aj zložitú argumentačnú líniu za predpokladu, že téma mi je dostatočne známa. Dokážem pochopiť väčšinu televíznych správ a programov o aktuálnych udalostiach. Dokážem porozumieť väčšine filmov v spisovnom jazyku.</td>
				<td>Dokážem prečítať články a správy týkajúce sa aktuálnych problémov, v ktorých pisatelia alebo autori adoptujú konkrétne postoje alebo názory. Rozumiem súčasnej literárnej próze.</td>
				<td>Dokážem komunikovať na takej úrovni plynulosti a spontánnosti, ktorá mi celkom umožňuje viesť bežný rozhovor s rodenými hovoriacimi. Dokážem sa aktívne zúčastniť na diskusii na známe témy, pričom vyjadrujem a presadzujem svoje názory.</td>
				<td>Dokážem prezentovať jasné podrobné opisy celého radu predmetov vzťahujúcich sa na moju oblasť záujmu. Dokážem vysvetliť svoje stanovisko na aktuálne otázky s uvedením výhod a nevýhod rozličných možností.</td>
				<td>Dokážem napísať podrobný text o širokom rozsahu tém vzťahujúcich sa na moje záujmy. Dokážem napísať referát alebo správu, odovzdávať informácie alebo poskytnúť dôkazy na podporu konkrétneho názoru alebo proti nemu. Dokážem napísať listy, ktoré objasňujú, prečo sú niektoré  udalosti a skúsenosti pre mňa osobne dôležité.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Rozumiem dlhšej reči aj keď nie je jasne štruktúrovaná a keď vzťahy sú iba naznačené, nie explicitne signalizované. Dokážem bez väčšej námahy porozumieť televíznym programom a filmom.</td>
				<td>
	Rozumiem dlhým a zložitým faktickým a literárnym textom, pričom rozoznávam rozdiely v štýle. Rozumiem odborným článkom a dlhším návodom, dokonca aj keď sa nevzťahujú na moju oblasť.</td>
				<td>Dokážem sa vyjadrovať plynulo a spontánne bez zjavného hľadania výrazov. Dokážem využívať jazyk pružne a účinne pre spoločenské a  profesijné účely. Dokážem presne sformulovať svoje myšlienky a názory a dokážem vhodne nadviazať na príspevky ostatných hovoriacich.</td>
				<td>Dokážem jasne a podrobne opísať zložité témy, rozširovať ich o vedľajšie témy, rozvíjať konkrétne body a zakončiť reč vhodným záverom.</td>
				<td>Dokážem sa jasne vyjadriť, dobre usporiadať text a odborne vyjadriť svoje stanoviská. Dokážem písať o zložitých predmetoch v liste, referáte, či správe a zdôrazniť, čo pokladám za najdôležitejšie. Dokážem zvoliť štýl podľa čitateľa, ktorému je text určený.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Nemám žiadne ťažkosti pri pochopení akéhokoľvek druhu hovoreného jazyka, či už je to naživo alebo z vysielania, dokonca aj keď je prejav rodeného hovoriaceho veľmi rýchly za predpokladu, že mám dosť času na to, aby som sa si zvykol na jeho výslovnosť.</td>
				<td>Ľahko čítam v podstate všetky formy písaného jazyka vrátane abstraktných textov náročných svojou stavbou a jazykom, ako sú napríklad  príručky, odborné články a literárne diela.</td>
				<td>Bez námahy sa dokážem zúčastniť na akejkoľvek konverzácii alebo diskusii a  dobre ovládam idiomatické a hovorové výrazy. Dokážem sa vyjadrovať plynulo a  presne vyjadrovať jemné odtienky významu. Ak pri vyjadrovaní sa narazím na problém, dokážem sa vrátiť a preformulovať danú pasáž tak ľahko, že ostatní to ani nepostrehnú.</td>
				<td>Dokážem podať jasný a plynulý opis alebo zdôvodnenie v štýle, ktorý sa hodí pre daný kontext a s efektívnou logickou štruktúrou, ktorá pomôže príjemcovi všimnúť si dôležité body a zapamätať si ich.</td>
				<td>Dokážem napísať hladko plynúci text v príslušnom štýle. Dokážem napísať zložité listy, správy alebo články, ktoré prezentujú prípad s efektívnou logickou štruktúrou, ktorá pomôže príjemcovi všimnúť si dôležité body a zapamätať si ich. Dokážem napísať zhrnutia a recenzie o odborných prácach alebo literárnych dielach.</td>
			</tr>
	  </table>
  </xsl:template>
</xsl:stylesheet>
