<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_pl_PL_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_pl_PL_V2.0.xsl
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
					<span class="LabelBold">Europass - Paszport Językowy</span>
					<br/>
					<span class="Label">
	Część Europejskiego Portfolio Językowego opracowanego przez Radę Europy</span>
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
							  <xsl:text>Nazwisko(a) </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Nazwisko(a)</xsl:text>
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
						<xsl:with-param name="label"><xsl:text>Data urodzenia</xsl:text></xsl:with-param>
						<xsl:with-param name="labelcontent"><xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				</xsl:if>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Język(i) ojczysty(e)</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Inne języki</xsl:text></xsl:with-param>
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
					<td class="GridHeadingBold" colspan="10">Samoocena umiejętności językowych</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Rozumienie</td>
					<td class="GridHeadingBold" colspan="4">Mówienie</td>
					<td class="GridHeadingBold" colspan="2">Pisanie</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Słuchanie</td>
					<td class="GridHeading" colspan="2">Czytanie</td>
					<td class="GridHeading" colspan="2">Porozumiewanie się</td>
					<td class="GridHeading" colspan="2">Samodzielne wypowiadanie się</td>
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
		<xsl:if test="$element='a1'">Poziom podstawowy</xsl:if>
		<xsl:if test="$element='b1'">Poziom samodzielności</xsl:if>
		<xsl:if test="$element='c1'">Poziom biegłości</xsl:if>
		<xsl:if test="$element='a2'">Poziom podstawowy</xsl:if>
		<xsl:if test="$element='b2'">Poziom samodzielności</xsl:if>
		<xsl:if test="$element='c2'">Poziom biegłości</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Dyplomy, zaświadczenia lub certyfikaty</td>
			</tr>
			<tr>
				<td class="GridHeading">Nazwa dyplomu, zaświadczenia lub certyfikatu</td>
				<td class="GridHeading">Nazwa instytucji wydającej</td>
				<td class="GridHeading">Rok</td>
				<td class="GridHeading">Poziom europejski</td>
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
				<td class="GridHeadingBold" colspan="3">Doświadczenia językowe</td>
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
		(*)Wypełnianie rubryk oznaczonych gwiazdką nie jest obowiązkowe
		(**)Patrz Tabela Samooceny na odwrocie
		(***)Poziom biegłości językowej Europejskiego Systemu Opisu Kształcenia Językowego (CEF), o ile został podany na dyplomie, zaświadczeniu lub certyfikacie.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Nota objaśniająca</b><br/>
		Europass - Paszport Językowy stanowi część Europejskiego Portfolio Językowego opracowanego przez Radę Europy. Wykorzystuje się w nim sześciostopniową skalę poziomów biegłości Europejskiego Systemu Opisu Kształcenia Językowego, by, w ujednoliconej formie, określić uzyskany poziom znajomości języka.<br/>
		Więcej informacji na temat Europass - Paszport Językowy znajdziesz na stronie internetowej http://europass.cedefop.europa.eu. Więcej informacji na temat Europejskiego Portfolio Językowego - www.coe.int/portfolio.<br/>
		Formularz Europass - Paszport Językowy można pobrać bezpłatnie z powyższych stron internetowych.<br/>
		© Rada Europy i Wspólnoty Europejskie, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">Europejskie poziomy biegłości językowej – tabela samooceny</th>
			</tr>
			<tr class="level">
				<th>A1</th>
				<td>Potrafię zrozumieć znane mi słowa i bardzo podstawowe wyrażenia dotyczące mnie osobiście, mojej rodziny i bezpośredniego otoczenia, gdy tempo wypowiedzi jest wolne a wymowa wyraźna.</td>
				<td>Rozumiem znane nazwy, słowa i bardzo proste zdania, np.: na tablicach informacyjnych i plakatach lub w katalogach.</td>
				<td>Potrafię brać udział w rozmowie pod warunkiem, że rozmówca jest gotów powtarzać lub inaczej formułować swoje myśli, mówiąc wolniej oraz pomagając mi ująć w słowa to, co usiłuję opowiedzieć. Potrafię formułować proste pytania dotyczące najlepiej mi znanych tematów lub najpotrzebniejszych spraw – i odpowiadać na tego typu pytania.</td>
				<td>Potrafię używać prostych wyrażeń i zdań, aby opisać miejsce, gdzie mieszkam oraz ludzi, których znam.</td>
				<td>Potrafię napisać krótki, prosty tekst na widokówce, np. z pozdrowieniami z wakacji. Potrafię wypełniać formularze (np. w hotelu) z danymi osobowymi, takimi jak nazwisko, adres, obywatelstwo.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Potrafię zrozumieć wyrażenia i najczęściej używane słowa, związane ze sprawami dla mnie ważnymi (np. podstawowe informacje dotyczące mnie i mojej rodziny, zakupów, miejsca i regionu zamieszkania, zatrudnienia). Potrafię zrozumieć główny sens zawarty w krótkich, prostych komunikatach i ogłoszeniach.</td>
				<td>Potrafię czytać bardzo krótkie, proste teksty. Potrafię znaleźć konkretne, przewidywalne informacje w prostych tekstach dotyczących życia codziennego, takich jak ogłoszenia, reklamy, prospekty, karty dań, rozkłady jazdy. Rozumiem krótkie, proste listy prywatne.</td>
				<td>Potrafię brać udział w zwykłej, typowej rozmowie wymagającej prostej i bezpośredniej wymiany informacji na znane mi tematy. Potrafię sobie radzić w bardzo krótkich rozmowach towarzyskich, nawet jeśli nie rozumiem wystarczająco dużo, by samemu podtrzymać rozmowę.</td>
				<td>Potrafię posłużyć się ciągiem wyrażeń i zdań, by w prosty sposób opisać swoją rodzinę, innych ludzi, warunki życia, swoje wykształcenie, swoją obecną i poprzednią pracę.</td>
				<td>Potrafię pisać krótkie i proste notatki lub wiadomości wynikające z doraźnych potrzeb. Potrafię napisać bardzo prosty list prywatny, na przykład dziękując komuś za coś.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Potrafię zrozumieć główne myśli zawarte w jasnej, sformułowanej w standardowej odmianie języka wypowiedzi na znane mi tematy, typowe dla domu, szkoły, czasu wolnego itd. Potrafię zrozumieć główne wątki wielu programów radiowych i telewizyjnych traktujących o sprawach bieżących lub o sprawach interesujących mnie prywatnie lub zawodowo – wtedy, kiedy te informacje są podawane stosunkowo wolno i wyraźnie.</td>
				<td>Rozumiem teksty składające się głównie ze słów najczęściej występujących, dotyczących życia codziennego lub zawodowego. Rozumiem opisy wydarzeń, uczuć i pragnień zawarte w prywatnej korespondencji.</td>
				<td>Potrafię  sobie radzić w większości sytuacji, w których można się znaleźć w czasie podróży po kraju lub regionie, gdzie mówi się danym językiem. Potrafię - bez uprzedniego przygotowania – włączać się do rozmów na znane mi tematy prywatne lub dotyczące życia codziennego (np. rodziny, zainteresowań, pracy, podróżowania i wydarzeń bieżących).</td>
				<td>Potrafię łączyć wyrażenia w prosty sposób, by opisywać przeżycia i zdarzenia, a także swoje marzenia, nadzieje i ambicje. Potrafię krótko uzasadniać i objaśniać własne poglądy i plany. Potrafię relacjonować wydarzenia i opowiadać przebieg akcji książek czy filmów, opisując własne reakcje i wrażenia.</td>
				<td>Potrafię pisać proste teksty na znane mi lub związane z moimi zainteresowaniami tematy. Potrafię pisać prywatne listy, opisując swoje przeżycia i wrażenia.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Potrafię zrozumieć dłuższe wypowiedzi i wykłady oraz nadążać za skomplikowanymi nawet wywodami – pod warunkiem, że temat jest mi w miarę znany. Rozumiem większość wiadomości telewizyjnych i programów o sprawach bieżących. Rozumiem większość filmów w standardowej odmianie języka.</td>
				<td>Czytam ze zrozumieniem artykuły i reportaże dotyczące problemów współczesnego świata, w których piszący prezentują określone stanowiska i poglądy. Rozumiem współczesną prozę literacką.</td>
				<td>Potrafię się porozumiewać na tyle płynnie i spontanicznie, że mogę prowadzić dość swobodne rozmowy z rodzimymi użytkownikami języka. Potrafię brać czynny udział w dyskusjach na znane mi tematy, przedstawiając swoje zdanie i broniąc swoich poglądów.</td>
				<td>Potrafię formułować przejrzyste, rozbudowane wypowiedzi na różne tematy związane z dziedzinami, które mnie interesują. Potrafię wyjaśnić swój punkt widzenia w danej kwestii oraz podać argumenty za i przeciw względem możliwych rozwiązań.</td>
				<td>Potrafię pisać zrozumiałe, szczegółowe teksty na dowolne tematy związane z moimi zainteresowaniami. Potrafię napisać rozprawkę lub opracowanie, przekazując informacje lub rozważając argumenty za i przeciw. Potrafię pisać listy, podkreślając znaczenie, jakie mają dla mnie dane wydarzenia i przeżycia.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Rozumiem dłuższe wypowiedzi, nawet jeśli nie są one jasno skonstruowane i kiedy związki logiczne są w nich jedynie implikowane, a nie wyrażone bezpośrednio. Bez większych trudności rozumiem programy telewizyjne i filmy.</td>
				<td>Rozumiem długie i złożone teksty informacyjne i literackie, dostrzegając i doceniając ich zróżnicowanie pod względem stylu. Rozumiem artykuły specjalistyczne i dłuższe instrukcje techniczne, nawet te niezwiązane z moją dziedziną.</td>
				<td>Potrafię się wypowiadać płynnie i spontanicznie, bez zbyt widocznego namyślania się w celu znalezienia właściwych sformułowań. Potrafię skutecznie porozumiewać się w kontaktach towarzyskich i sprawach zawodowych. Potrafię precyzyjnie formułować swoje myśli i poglądy, zręcznie nawiązując do wypowiedzi rozmówców.</td>
				<td>Potrafię formułować przejrzyste i szczegółowe wypowiedzi dotyczące skomplikowanych zagadnień, rozwijać w nich wybrane podtematy lub poszczególne kwestie i kończyć je odpowiednią konkluzją.</td>
				<td>Potrafię się wypowiadać w zrozumiałych i dobrze zbudowanych tekstach, dosyć szeroko przedstawiając swój punkt widzenia. Potrafię pisać o złożonych zagadnieniach w prywatnym liście, w rozprawce czy opracowaniu, podkreślając kwestie, które uważam za najistotniejsze. Potrafię dostosować styl tekstu do potencjalnego czytelnika..</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Nie mam żadnych trudności ze zrozumieniem jakiejkolwiek wypowiedzi mówionej – słuchanej „na żywo” czy odbieranej za pośrednictwem mediów – nawet przy szybkim tempie mówienia rodzimego użytkownika języka, pod warunkiem jednak, iż mam trochę czasu, by przyzwyczaić się do nowego akcentu.</td>
				<td>Rozumiem z łatwością praktycznie wszystkie formy języka pisanego, włączając w to abstrakcyjne lub językowo skomplikowane teksty, takie jak podręczniki, artykuły specjalistyczne i dzieła literackie.</td>
				<td>Potrafię bez żadnego wysiłku brać udział w każdej rozmowie czy dyskusji. Dobrze znam i odpowiednio stosuję wyrażenia idiomatyczne i potoczne. Wyrażam się płynnie, subtelnie różnicując odcienie znaczeń. Jeśli nawet miewam pewne problemy z wyrażeniem czegoś, potrafię tak przeformułowywać swoje wypowiedzi, że rozmówcy są właściwie nieświadomi moich braków.</td>
				<td>Potrafię przedstawić płynny, klarowny wywód lub opis sformułowany w stylu właściwym dla danego kontekstu w sposób logiczny i skuteczny, ułatwiając odbiorcy odnotowanie i zapamiętanie najważniejszych kwestii.</td>
				<td>Potrafię pisać płynne, zrozumiałe teksty, stosując odpowiedni w danym przypadku styl. Potrafię pisać o złożonych zagadnieniach w listach, opracowaniach lub artykułach, prezentując poruszane problemy logicznie i skutecznie, tak by ułatwić odbiorcy zrozumienie i zapamiętanie najważniejszych kwestii. Potrafię pisać streszczenia i recenzje prac specjalistycznych i utworów literackich.</td>
			</tr>
	  </table>
  </xsl:template>
</xsl:stylesheet>
