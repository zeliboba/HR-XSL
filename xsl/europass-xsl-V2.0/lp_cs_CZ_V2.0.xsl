<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_cs_CZ_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_cs_CZ_V2.0.xsl
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
					<span class="LabelBold">Europass - jazykový pas</span>
					<br/>
					<span class="Label">Součást Evropského jazykového portfolia, které zpracovala Rada Evropy</span>
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
							  <xsl:text>Příjmení </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Příjmení</xsl:text>
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
						<xsl:with-param name="label"><xsl:text>Datum narození</xsl:text></xsl:with-param>
						<xsl:with-param name="labelcontent"><xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				</xsl:if>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Mateřský jazyk(y)</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Jiný jazyk(y)</xsl:text></xsl:with-param>
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
					<td class="GridHeadingBold" colspan="10">Určení jazykových schopností na základě sebehodnocení</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Porozumění</td>
					<td class="GridHeadingBold" colspan="4">Mluvení</td>
					<td class="GridHeadingBold" colspan="2">Psaní</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Poslech</td>
					<td class="GridHeading" colspan="2">Čtení</td>
					<td class="GridHeading" colspan="2">Ústní interakce</td>
					<td class="GridHeading" colspan="2">Samostatný ústní projev</td>
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
		<xsl:if test="$element='a1'">uživatel základů jazyka</xsl:if>
		<xsl:if test="$element='b1'">samostatný uživatel</xsl:if>
		<xsl:if test="$element='c1'">zkušený uživatel</xsl:if>
		<xsl:if test="$element='a2'">uživatel základů jazyka</xsl:if>
		<xsl:if test="$element='b2'">samostatný uživatel</xsl:if>
		<xsl:if test="$element='c2'">zkušený uživatel</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Diplom(y) nebo osvědčení</td>
			</tr>
			<tr>
				<td class="GridHeading">Název diplomu nebo osvědčení</td>
				<td class="GridHeading">Organizace, která diplom (osvědčení) udělila</td>
				<td class="GridHeading">Rok</td>
				<td class="GridHeading">Evropská úroveň</td>
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
				<td class="GridHeadingBold" colspan="3">Praktické zkušenosti s jazykem</td>
			</tr>
			<tr>
				<td class="GridHeading">Popis</td>
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
		(*)Kolonky označené hvězdičkou jsou nepovinné.
		(**)Viz stupnice pro sebehodnocení na další straně
		(***)Úroveň společného evropského referenčního rámce (CEF), pokud je uvedena v původním osvědčení nebo diplomu.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Poznámka</b><br/>
		Europass - jazykový pas je součást Evropského jazykového portfolia, které zpracovala Rada Evropy. Používá se zde 6 evropských úrovní Společného evropského referenčního rámce pro jazyky (CEF) k zaznamenání dosažené úrovně jazykových dovedností ve standardizovaném formátu.<br/>
		Další informace o Europass - jazykovém pasu naleznete zde: http://europass.cedefop.europa.eu – Další informace o Evropském jazykovém portfoliu zde: www.coe.int/portfolio<br/>
		Formulář Europass - jazykového pasu si můžete z uvedených webových stránek zdarma stáhnout.<br/>
		© Rada Evropy a Evropská společenství, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">EVROPSKÉ ÚROVNĚ – STUPNICE PRO SEBEHODNOCENÍ</th>
			</tr>
			<tr class="level">
				<th>A1</th>
				<td>Rozumím známým slovům a zcela základním frázím týkajícím se mé osoby, mé rodiny a bezprostředního konkrétního okolí, pokud lidé hovoří pomalu a zřetelně.</td>
				<td>Rozumím známým jménům, slovům a velmi jednoduchým větám, například na vývěskách, plakátech nebo v katalozích.</td>
				<td>Umím se jednoduchým způsobem domluvit, je-li můj partner ochoten zopakovat  pomaleji svou výpověď nebo ji  přeformulovat a pomoci mi formulovat, co se snažím říci. Umím klást jednoduché otázky a na podobné otázky odpovídat, pokud se týkají mých   základních potřeb, nebo jde-li o věci, jež jsou mi důvěrně známé.</td>
				<td>Umím jednoduchými frázemi a větami popsat místo, kde žiji, a lidi, které znám.</td>
				<td>Umím napsat stručný jednoduchý text na pohlednici,  například pozdrav z dovolené. Umím vyplnit formuláře obsahující osobní údaje, například své jméno, státní příslušnost a adresu při přihlašování v hotelu.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Rozumím frázím a nejběžnější slovní zásobě vztahující se k oblastem, které se mě bezprostředně týkají (např. základní  informace o mně a mé rodině, o nakupování, místopisu, zaměstnání). Dokážu pochopit smysl krátkých jasných  jednoduchých zpráv a hlášení.</td>
				<td>Umím číst krátké jednoduché texty. Umím vyhledat konkrétní předvídatelné informace  v jednoduchých každodenních materiálech, např. v  inzerátech, prospektech, jídelních lístcích a jízdních řádech. Rozumím krátkým jednoduchým osobním dopisům.</td>
				<td>Umím komunikovat v jednoduchých běžných  situacích vyžadujících jednoduchou přímou výměnu  informací o známých tématech a činnostech. Zvládnu velmi  krátkou společenskou konverzaci, i když obvykle  nerozumím natolik, abych konverzaci sám/sama dokázal(a) udržet .</td>
				<td>Umím použít řadu frází a vět, abych jednoduchým způsobem popsal(a)  vlastní rodinu a další lidi, životní podmínky, dosažené vzdělání a své současné nebo předchozí  zaměstnání.</td>
				<td>Umím napsat krátké jednoduché poznámky a zprávy týkající se mých základních potřeb. Umím napsat velmi jednoduchý osobní dopis, například poděkování.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Rozumím  hlavním myšlenkám  vysloveným spisovným jazykem o běžných tématech, se kterými se setkávám v práci, ve škole, ve volném čase, atd. Rozumím smyslu mnoha  rozhlasových a televizních programů týkajících se současných událostí nebo témat souvisejících s oblastmi mého osobního či pracovního  zájmu, pokud jsou vysloveny  poměrně pomalu a zřetelně.</td>
				<td>Rozumím textům, které obsahují slovní zásobu často užívanou v každodenním životě nebo které  se vztahují k mé práci. Rozumím popisům událostí, pocitů a přáním  v osobních dopisech.</td>
				<td>Umím si poradit s většinou situací, které mohou nastat při cestování v oblasti, kde se tímto jazykem mluví. Dokážu se bez přípravy zapojit do hovoru o tématech, která jsou mi známá, o něž se zajímám nebo která se týkají každodenního života (např. rodiny, koníčků, práce, cestování a aktuálních událostí).</td>
				<td>Umím jednoduchým způsobem spojovat fráze, abych popsal(a) své zážitky a události, své sny, naděje a cíle. Umím stručně odůvodnit a vysvětlit své názory a plány. Umím vyprávět příběh nebo přiblížit obsah knihy nebo filmu a vylíčit  své reakce.</td>
				<td>Umím napsat  jednoduché souvislé texty na témata, která dobře znám nebo která mě osobně zajímají. Umím psát osobní dopisy popisující zážitky a dojmy.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Rozumím delším promluvám a přednáškám a dokážu sledovat i složitou výměnu  názorů, pokud téma dostatečně znám. Rozumím většině televizních zpráv a programů týkajících se aktuálních témat. Rozumím většině filmů ve spisovném jazyce.</td>
				<td>Rozumím článkům a zprávám zabývajícím se současnými  problémy, v nichž autoři zaujímají konkrétní  postoje či stanoviska. Rozumím textům současné prózy.</td>
				<td>Dokážu se účastnit rozhovoru natolik plynule a spontánně, že  mohu vést běžný  rozhovor  s rodilými mluvčími. Dokážu se  aktivně zapojit do diskuse o známých tématech, vysvětlovat a obhajovat své názory.</td>
				<td>Dokážu  se srozumitelně a podrobně vyjadřovat k široké škále  témat, která se vztahují k oblasti mého zájmu. Umím vysvětlit své  stanovisko k aktuálním otázkám a uvést výhody a nevýhody různých  řešení.</td>
				<td>Umím  napsat srozumitelné   podrobné texty na širokou škálu  témat souvisejících s mými zájmy. Umím napsat pojednání nebo zprávy, předávat informace, obhajovat nebo vyvracet určitý názor. V dopise dovedu  zdůraznit, čím jsou pro mě události a zážitky osobně důležité.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Rozumím delším promluvám, i když nemají jasnou stavbu a vztahy jsou vyjádřeny pouze v náznacích. Bez větší námahy rozumím televizním programům a filmům.</td>
				<td>Rozumím dlouhým složitým textům, a to jak faktografickým, tak  beletristickým a jsem schopen/ schopna ocenit rozdíly v jejich stylu. Rozumím odborným článkům a delším technickým instrukcím, a to i tehdy, když se nevztahují k mému oboru.</td>
				<td>Umím se vyjadřovat plynule a pohotově bez příliš zjevného hledání výrazů. Umím používat jazyk pružně a efektivně pro  společenské a pracovní  účely. Umím přesně formulovat své myšlenky a názory a vhodně navazovat na příspěvky ostatních  mluvčích.</td>
				<td>Umím jasně a podrobně popsat složitá témata, rozšiřovat je o témata vedlejší, rozvíjet konkrétní body a zakončit svou řeč vhodným  závěrem.</td>
				<td>Umím se jasně vyjádřit, dobře uspořádat text a podrobně vysvětlit svá stanoviska. Umím psát podrobné dopisy, pojednání nebo zprávy o složitých tématech a zdůraznit to, co považuji za nejdůležitější. Umím zvolit styl textu podle toho, jakému typu čtenáře je určen.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Bez potíží rozumím jakémukoli druhu mluveného projevu, živého či vysílaného. Pokud mám trochu času zvyknout si na specifické rysy výslovnosti rodilého mluvčího, nemám potíže porozumět mu ani tehdy, mluví-li rychle.</td>
				<td>Snadno čtu všechny formy písemného projevu, včetně abstraktních textů náročných svou stavbou i jazykem, jako jsou např. příručky, odborné články a krásná  literatura.</td>
				<td>Dokážu se zapojit do jakékoli konverzace nebo diskuse. Znám dobře idiomatické a hovorové výrazy. Umím se plynule vyjadřovat a přesně sdělovat  jemnější významové odstíny.  Narazím-li při vyjadřování na nějaký problém, dokážu svou výpověď přeformulovat tak hladce, že to ostatní ani nepostřehnou.</td>
				<td>Umím podat jasný plynulý popis nebo zdůvodnění stylem vhodným pro daný kontext a opírajícím se o efektivní logickou strukturu, která pomáhá posluchači všimnout si důležitých bodů a zapamatovat si je.</td>
				<td>Umím napsat jasný plynulý text vhodným stylem. Dokážu napsat složité dopisy, zprávy nebo články a vystavět text logicky tak, aby pomáhal čtenáři všimnout si důležitých bodů a zapamatovat si je. Umím psát resumé a recenze odborných nebo literárních  prací.</td>
			</tr>
	  </table>
  </xsl:template>
</xsl:stylesheet>
