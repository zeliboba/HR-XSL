<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_hr_HR_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_hr_HR_V2.0.xsl
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
					<span class="LabelBold">Europass jezična putovnica</span>
					<br/>
					<span class="Label">Dio Europskog jezičnog portfolija koji je osmislilo Vijeće Europe</span>
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
							  <xsl:text>Prezime(na) </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Prezime(na)</xsl:text>
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
						<xsl:with-param name="label"><xsl:text>Datum rođenja</xsl:text></xsl:with-param>
						<xsl:with-param name="labelcontent"><xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				</xsl:if>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Materinski jezik(ci)</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Drugi jezik(ci)</xsl:text></xsl:with-param>
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
					<td class="GridHeadingBold" colspan="10">Samoprocjena jezičnih vještina</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Razumijevanje</td>
					<td class="GridHeadingBold" colspan="4">Govor</td>
					<td class="GridHeadingBold" colspan="2">Pisanje</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Slušanje</td>
					<td class="GridHeading" colspan="2">Čitanje</td>
					<td class="GridHeading" colspan="2">Govorna interakcija</td>
					<td class="GridHeading" colspan="2">Govorna produkcija</td>
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
		<xsl:if test="$element='a1'">Temeljni korisnik</xsl:if>
		<xsl:if test="$element='b1'">Samostalni korisnik</xsl:if>
		<xsl:if test="$element='c1'">Iskusni korisnik</xsl:if>
		<xsl:if test="$element='a2'">Temeljni korisnik</xsl:if>
		<xsl:if test="$element='b2'">Samostalni korisnik</xsl:if>
		<xsl:if test="$element='c2'">Iskusni korisnik</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Diploma(e) ili svjedodžba(e)</td>
			</tr>
			<tr>
				<td class="GridHeading">Naziv diplome(a) ili svjedodžbe(i)</td>
				<td class="GridHeading">Tijelo koje izdaje dokument</td>
				<td class="GridHeading">Godina</td>
				<td class="GridHeading">Europska razina</td>
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
				<td class="GridHeadingBold" colspan="3">Jezično(a) iskustvo(a)</td>
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
		(*)Naslovi označeni zvjezdicom nisu obavezni.
		(**)Vidi ljestvicu za samoprocjenu na poleđini.
		(***)Razina Zajedničkog europskog referentnog okvira [Common European Framework of Reference - (CEF)] navedena je u originalnoj svjedodžbi ili diplomi.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Objašnjenje</b><br/>
		Europass jezična putovnica je dio Europskog jezičnog portfolija koji je osmislilo Vijeće Europe. Kako bi se u standardizirani format upisala postignuta razina jezičnog umijeća, koristi se 6 europskih razina Zajedničkog europskog referentnog okvira [Common European Framework of Reference (CEF)].<br/>
		Više informacija o Europass jezičnoj putovnici: http://europass.cedefop.europa.eu - Više informacija o Europskom jezičnom portfoliju: www.coe.int/portfolio.<br/>
		Obrazac Europass jezične putovnice može se besplatno učitati s gore navedenih web stranica.<br/>
		© Vijeće Europe i Europske zajednice, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">EUROPSKE RAZINE – LJESTVICA ZA SAMOPROCJENU</th>
			</tr>
			<tr class="level">
				<th>A1</th>
				<td>Mogu razumjeti poznate riječi i osnovne fraze koje se odnose na mene, moju obitelj i neposrednu konkretnu okolinu, ako sugovornik govori polako i razgovijetno.</td>
				<td>Mogu prepoznati poznata imena, riječi i vrlo jednostavne rečenice, npr. na oglasima postavljenim na javnim mjestima, plakatima ili u katalozima.</td>
				<td>Mogu voditi jednostavan razgovor uz uvjet da je sugovornik spreman sporije ponoviti ili preformulirati svoje rečenice te da mi je spreman pomoći da izrazim ono što želim reći. Mogu postavljati i odgovarati na jednostavna pitanja o dobro poznatim temama ili da bih zadovoljio svoje neposredne potrebe.</td>
				<td>Mogu koristiti jednostavne fraze i rečenice da bih opisao gdje živim i osobe koje poznajem.</td>
				<td>Mogu napisati kratku, jednostavnu razglednicu, npr. poslati pozdrave s ljetovanja. Mogu ispuniti formulare osobnim podacima, npr. unijeti svoje ime, državljanstvo i adresu u hotelsku prijavnicu.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Mogu razumjeti fraze i najčešće korištene riječi iz područja neposrednog osobnog interesa (npr. jednostavne podatke o sebi i obitelji, informacije vezane uz kupovanje, neposrednu okolinu, posao). Mogu shvatiti osnovno značenje kratkih, jasnih i jednostavnih poruka i javnih obavijesti.</td>
				<td>Mogu čitati vrlo kratke, jednostavne tekstove. Mogu pronaći određenu, predvidivu informaciju u jednostavnim, svakodnevnim pisanim materijalima kao što su oglasi, prospekti, jelovnici i vozni redovi, te mogu razumjeti kratka, jednostavna osobna pisma.</td>
				<td>Mogu komunicirati u jednostavnim i uobičajenim situacijama koje zahtijevaju jednostavnu i neposrednu razmjenu informacija o poznatim temama i aktivnostima. Mogu sudjelovati u vrlo kratkim razgovorima premda obično ne razumijem dovoljno da bih sam podržavao konverzaciju.</td>
				<td>
	Mogu koristiti niz fraza i rečenica da bih jednostavnim jezikom opisao svoju obitelj i druge ljude, svoje životne uvjete, svoje obrazovanje te svoje sadašnje ili prethodno radno mjesto.</td>
				<td>Mogu pisati kratke, jednostavne biIješke i poruke. Mogu napisati vrlo jednostavno osobno pismo, npr. pismo zahvale.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Mogu razumjeti glavne misli jasnog standardnog razgovora o poznatim temama s kojima se redovito susrećem na poslu, u školi, u slobodno vrijeme itd. Mogu razumjeti glavne poruke mnogih radijskih i televizijskih programa o tekućim događajima ili temama od osobnog i profesionalnog interesa ako su iskazane relativno polako i razumljivo.</td>
				<td>Mogu razumjeti tekstove koji su uglavnom pisani običnim jezikom ili jezikom moje struke. Mogu razumjeti opis događaja, osjećaja i želja u osobnim pismima.</td>
				<td>Mogu se snalaziti u većini situacija koje se mogu pojaviti tijekom putovanja kroz područje na kojemu se taj jezik govori. Mogu se, bez pripreme, uključiti u razgovor o temama koje su mi poznate, koje su od osobnog interesa ili se odnose na svakodnevni život (npr. na obitelj, hobi, posao, putovanja i tekuće događaje).</td>
				<td>Mogu jednostavno povezivati rečenice kako bih opisao doživljaje i događaje, svoje snove, nade i težnje. Mogu ukratko obrazložiti i objasniti svoja stajališta i planove. Mogu ispričati priču ili prepričati sadržaj knjige ili filma te opisati svoje reakcije.</td>
				<td>Mogu napisati jednostavan vezani tekst o poznatoj temi ili temi od osobnog interesa. Mogu napisati osobno pismo opisujući svoje doživljaje i dojmove.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Mogu razumjeti duže govore i predavanja te pratiti čak i složenu argumentaciju ako mi je tema barem donekle poznata. Mogu razumjeti veći dio TV vijesti i programa koji se bave tekućim događajima. Mogu razumjeti većinu filmova na standardnom jeziku.</td>
				<td>Mogu čitati članke i izvještaje koji obrađuju suvremene probleme u kojima pisac zauzima određena stajališta ili izražava određena mišljenja. Mogu razumjeti suvremenu književnu prozu.</td>
				<td>Mogu komunicirati dovoljno tečno i spontano, što omogućuje normalnu interakciju s izvornim govornikom. Mogu aktivno sudjelovati u raspravama unutar poznatih situacija obrazlažući i braneći svoja stajališta.</td>
				<td>
	Mogu jasno i podrobno govoriti o mnogim temama vezanim uz područje vlastitoga interesa. Mogu objasniti svoja stajališta o nekoj aktualnoj temi navodeći prednosti i nedostatke raznih pristupa.</td>
				<td>
	Mogu napisati jasan, podroban tekst o velikom broju tema s područja svog interesa. Mogu napisati sastav ili izvještaj prenoseći informaciju ili navodeći razloge za ili protiv određenog stajališta. Mogu napisati pismo u kojemu jasno izražavam značenje koje osobno pridajem određenim događajima i iskustvima.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Mogu razumjeti dugačak govor čak i kad nije jasno strukturiran i kad veze među rečenicama nisu jasno iskazane, već se samo podrazumijevaju. Mogu bez prevelika napora razumjeti televizijske programe i filmove.</td>
				<td>Mogu razumjeti dugačke i kompleksne činjenične i književne tekstove te prepoznati stilske različitosti. Mogu razumjeti specijalizirane članke i duže tehničke upute, čak i kad se ne odnose na moje područje.</td>
				<td>Mogu se tečno i spontano izražavati bez vrlo očitog traženja odgovarajućih riječi. Mogu fleksibilno i učinkovito koristiti jezik u društvenim i poslovnim situacijama. Mogu precizno izraziti svoje ideje i mišljenja te se svojim doprinosom spretno uključiti u raspravu drugih govornika.</td>
				<td>
	Mogu iznijeti jasan, podroban opis složenih činjenica, povezujući tematske cjeline, razvijajući određene misli i zaokružujući izlaganje odgovarajućim zaključkom.</td>
				<td>Mogu se izraziti jasnim, dobro strukturiranim tekstom te obrazlagati svoja stajališta. Mogu pisati o složenim temama u pismu, sastavu ili izvještaju naglašavajući ono što smatram važnim. Mogu odabrati stil koji odgovara čitatelju kojemu je to namijenjeno.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Nemam poteškoća u razumijevanju bilo koje varijante govornog jezika, bilo u izravnoj komunikaciji, bilo preko medija, čak ni kad se govori brzinom izvornog govornika, uz uvjet da imam vremena prilagoditi se određenom naglasku.</td>
				<td>Mogu bez poteškoća čitati sve vrste tekstova, uključivši apstraktne, strukturno ili lingvistički složene tekstove poput priručnika, specijaliziranih članaka i književnih djela.</td>
				<td>Mogu bez napora sudjelovati u bilo kakvom razgovoru ili raspravi uz dobro prepoznavanje i korištenje idiomatskih izraza i kolokvijalizama. Mogu se tečno izražavati i precizno prenositi i finije nijanse značenja. Ako ipak naiđem na problem, mogu se povući i preformuliranjem izražaja zaobići prepreku toliko spretno da to</td>
				<td>
	Mogu jasno i tečno iznositi činjenice ili argumente stilom koji odgovara kontekstu. Mogu učinkovito i logično strukturirati svoj prikaz na način koji slušatelju pomaže da uoči i zapamti glavne stavove.</td>
				<td>Mogu napisati jasan, tečan tekst primjerenim stilom. Mogu pisati složena pisma, izvještaje ili članke u kojima je određena tema jasno i logično iznesena kako bi primatelj mogao uočiti i zapamtiti bitne stavove. Mogu pisati sažetke i prikaze stručnih ili književnih djela.</td>
			</tr>
	  </table>
  </xsl:template>
</xsl:stylesheet>
