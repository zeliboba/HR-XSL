<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_sl_SI_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_sl_SI_V2.0.xsl
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
					<span class="LabelBold">Europass jezikovna izkaznica</span>
					<br/>
					<span class="Label">Del Evropskega jezikovnega listovnika, ki so ga oblikovali pri Svetu Evrope.</span>
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
							  <xsl:text>Priimek </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Priimek</xsl:text>
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
						<xsl:with-param name="label"><xsl:text>Datum rojstva</xsl:text></xsl:with-param>
						<xsl:with-param name="labelcontent"><xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				</xsl:if>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Materni jezik(i)</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Drugi jezik(i)</xsl:text></xsl:with-param>
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
					<td class="GridHeadingBold" colspan="10">Samoocenjevanje jezikovnih znanj</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Razumevanje</td>
					<td class="GridHeadingBold" colspan="4">Govorjenje</td>
					<td class="GridHeadingBold" colspan="2">Pisanje</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Slušno razumevanje</td>
					<td class="GridHeading" colspan="2">Bralno razumevanje</td>
					<td class="GridHeading" colspan="2">Govorno sporazumevanje</td>
					<td class="GridHeading" colspan="2">Govorno sporočanje</td>
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
		<xsl:if test="$element='a1'">Osnovni uporabnik</xsl:if>
		<xsl:if test="$element='b1'">Samostojni uporabnik</xsl:if>
		<xsl:if test="$element='c1'">Usposobljeni uporabnik</xsl:if>
		<xsl:if test="$element='a2'">Osnovni uporabnik</xsl:if>
		<xsl:if test="$element='b2'">Samostojni uporabnik</xsl:if>
		<xsl:if test="$element='c2'">Usposobljeni uporabnik</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Diplome, spričevala ali certifikati</td>
			</tr>
			<tr>
				<td class="GridHeading">Naziv diplome, spričevala ali certifikata</td>
				<td class="GridHeading">Ustanova podeljevalka</td>
				<td class="GridHeading">Obdobje</td>
				<td class="GridHeading">Evropska raven</td>
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
				<td class="GridHeadingBold" colspan="3">Jezikovne izkušnje</td>
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
		(*)Rubrike z zvezdico so neobvezne
		(**)Glejte samoocenjevalno lestvico na drugi strani
		(***)Stopnja po Skupnem evropskem referenčnem okviru, če se navaja v izvirnem spričevalu, certifikatu ali diplomi.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Pojasnilo</b><br/>
		Europass jezikovna izkaznica je del Evropskega jezikovnega listovnika, ki so ga oblikovali pri Svetu Evrope. Za ocenjevanje jezikovne usposobljenosti se uporablja standardizirana 6-stopenjska lestvica, o kateri govori Skupni evropski referenčni okvir za jezike.<br/>
		Več informacij o Europass jezikovni izkaznici je na voljo na spletni strani: http://europass.cedefop.europa.eu - Več informacij o Evropskem jezikovnem listovniku je na voljo na spletni strani: www.coe.int/portfolio<br/>
		Vzorčno predlogo Europass jezikovne izkaznice lahko brezplačno prenesete iz zgoraj omenjenih spletnih strani.<br/>
		© Svet Evrope in Evropske skupnosti, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">Evropske stopnje – samoocenjevcalna lestvica</th>
			</tr>
			<tr class="level">
				<th>A1</th>
				<td>Pri počasnem in razločnem govoru razumem posamezne pogosto rabljene besede in najosnovnejše besedne zveze, ki se nanašajo name, na mojo družino in neposredno življenjsko okolje.</td>
				<td>Razumem posamezna pogosto rabljena poimenovanja, besede in preproste povedi, npr. na obvestilih, plakatih in v katalogih.</td>
				<td>Znam se preprosto pogovarjati, če je sogovornik pripravljen svoje izjave ponoviti počasneje ali jih pojasniti in če mi je pripravljen pomagati pri izražanju misli. Znam postavljati in odgovarjati na preprosta vprašanja, ki se nanašajo na trenutne potrebe ali splošne teme.</td>
				<td>Uporabljati znam preproste besedne zveze in povedi, s katerimi lahko opišem, kje živim, in ljudi, ki jih poznam.</td>
				<td>Pisati znam kratka, preprosta sporočila na razglednice, npr. s počitniškimi pozdravi. Izpolnjevati znam obrazce, ki zahtevajo osebne podatke, npr. vnesti ime, državljanstvo in naslov na hotelski obrazec.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Razumem besedne zveze in pogosto besedišče, ki se nanaša na najbolj temeljne reči (npr. najosnovnejši osebni in družinski podatki, nakupovanje, neposredno življenjsko okolje, zaposlitev). Sposoben/sposobna sem ujeti glavno misel kratkih, jasno oblikovanih sporočil in obvestil.</td>
				<td>Sposoben/sposobna sem brati zelo kratka, preprosta, vsakdanja besedila, kot so reklame, prospekti, jedilniki in urniki. V njih znam poiskati natančno določen, predvidljiv podatek. Razumem kratka in preprosta osebna pisma.</td>
				<td>Sposoben/sposobna sem se sporazumevati v preprostih situacijah, kadar gre za neposredno izmenjavo informacij o splošnih vsakodnevnih stvareh. Znajdem se v krajših družabnih pogovorih, čeprav ponavadi ne razumem dovolj, da bi se lahko samostojno pogovarjal-a.</td>
				<td>Uporabiti znam vrsto besednih zvez in povedi, s katerimi lahko na preprost način opišem svojo družino in druge ljudi, življenjske pogoje ali svojo izobrazbo in predstavim svojo trenutno ali prejšnjo zaposlitev.</td>
				<td>Sestavljati znam kratka, preprosta obvestila in sporočila, ki se nanašajo na trenutne potrebe. Pisati znam zelo preprosta osebna pisma, npr. se komu za kaj zahvaliti.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Pri razločnem govorjenju v standardnem jeziku razumem glavne točke, kadar gre za znane reči, s katerimi se redno srečujem na delu, v šoli, prostem času itd. Če je govor razmeroma počasen in razločen, razumem tudi glavne misli mnogih radijskih in televizijskih oddaj, ki se ukvarjajo s sodobnimi problemi in temami, ki me osebno ali poklicno zanimajo.</td>
				<td>Razumem besedila, katerih jezik je pretežno vsakdanji ali povezan z mojim delom. Razumem opise dogodkov, občutij in želja/ tudi v osebnih pismih.</td>
				<td>Znajdem se v večini situacij, ki se pogosto pojavljajo na potovanju po deželi, kjer se ta jezik govori. Sposoben/sposobna sem se tudi nepripravljen-a vključiti v pogovor, povezan s splošnimi temami, temami, ki me osebno zanimajo, ali takimi, ki se tičejo vsakdanjega življenja (npr. družine, hobijev, dela, potovanj in aktualnih dogodkov).</td>
				<td>Tvoriti znam preproste povedi iz besednih zvez, s katerimi lahko opišem svoje izkušnje in dogodke, sanje, želje in ambicije. Na kratko znam razložiti svoje poglede in načrte. Sposoben/sposobna sem pripovedovati zgodbo ali obnoviti vsebino knjige oziroma filma in opisati svoje odzive.</td>
				<td>Pisati znam preprosta, povezana besedila v zvezi s splošnimi temami ali temami s področja osebnega zanimanja. Pisati znam osebna pisma in v njih opisati izkušnje in vtise.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Razumem daljše govorjenje in predavanja in sem sposoben/sposobna slediti celo bolj zahtevnim pogovorom, pod pogojem, da je tema dovolj splošna. Razumem večino televizijskih poročil in oddaj o aktualnih zadevah. Razumem večino filmov v standardnem jeziku.</td>
				<td>Berem in razumem članke in poročila, v katerih pisci zastopajo določena stališča ali poglede. Razumem sodobno literarno prozo.</td>
				<td>Sposoben/sposobna sem se precej tekoče in spontano izražati, tako da se brez večjih težav sporazumevam z rojenimi govorci. Lahko se vključim v razprave o splošnih temah in z utemeljitvami zagovarjam svoje stališče.</td>
				<td>Jasno in natančno znam opisati mnogo stvari s področij, ki me zanimajo. Razložiti znam svoj pogled na določen problem in podati prednosti in pomanjkljivosti različnih možnosti.</td>
				<td>Pisati znam jasna in natančna besedila v zvezi s številnimi temami in vprašanji, ki me zanimajo. Pisati znam eseje ali poročila, v katerih moram podati informacije ali zagovarjati oziroma zavračati določena stališča. Pisati znam pisma, v katerih moram poudariti pomen določenih dogodkov in izkušenj.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Razumem daljše govorjenje, četudi ni natančno razčlenjeno in razmerja niso izražena jasno, temveč so samo nakazana. Brez posebnega napora razumem televizijske oddaje in filme.</td>
				<td>Razumem dolga zahtevna besedila z veliko podatki, pa tudi literarna besedila ter zaznavam slogovno različnost. Razumem strokovne članke in daljša tehnična navodila, četudi se ne nanašajo na moje strokovno področje.</td>
				<td>Sposoben/sposobna sem se tekoče in naravno izražati, ne da bi pri tem preveč očitno iskal-a primerne izraze. Jezik znam uporabljati učinkovito in prilagodljivo tako v družabne kot tudi poklicne ali učne namene. Znam natančno izražati svoje misli in poglede ter svoj prispevek spretno povezovati s prispevki drugih.</td>
				<td>Sposoben/sposobna sem jasno in natančno opisati zahtevne vsebine, pri tem smiselno povezati tematske točke, razviti in poudariti posamezne vidike ter napraviti ustrezen zaključek.</td>
				<td>Sposoben/sposobna sem tvoriti jasna, slogovno dobra besedila in obširneje izraziti svoja stališča. V pismih, esejih ali poročilih znam natančno razložiti zahtevne vsebine in pri tem primerno poudariti tista dejstva, ki se mi zdijo najpomembnejša. Oblikovati znam različne vrste besedil v prepričljivem in osebnem slogu, primernem za bralca, ki mu je tako besedilo namenjeno.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Nimam težav pri razumevanju jezika, govorjenega v živo ali posredovanega preko medijev, četudi je tempo govorjenja hiter. Potrebujem zgolj nekaj časa, da se navadim na narečje.</td>
				<td>Z lahkoto berem vse vrste zapisanih besedil, tudi ko gre za abstraktna, po jeziku in zgradbi zahtevna besedila, npr. priročnike, strokovne članke in literarna dela.</td>
				<td>Z lahkoto sodelujem v vsakem pogovoru in razpravi. Dobro poznam pogovorni jezik in besedne zveze. Govorim tekoče in znam natančno izraziti tudi majhne pomenske odtenke. Če pri sporazumevanju naletim na kakšno težavo, jo znam spretno zaobiti in preoblikovati težavno mesto tako, da sogovorniki to malo verjetno opazijo.</td>
				<td>Sposoben/sposobna sem jasno in tekoče podajati tudi daljše opise ali razlage. Govoru znam dati logično obliko, ki poslušalca opozarja na pomembna mesta. Slog govorjenja znam prilagoditi situaciji in poslušalcem.</td>
				<td>Tvoriti znam jasna, tekoča, slogovno primerna besedila. Sestaviti znam zahtevna pisma, poročila in članke v zvezi z zahtevnimi vsebinami, ki morajo imeti logično zgradbo in bralca voditi tako, da dojame pomembne točke. Pisati znam povzetke in kritike strokovnih in literarnih del.</td>
			</tr>
	  </table>
  </xsl:template>
</xsl:stylesheet>
