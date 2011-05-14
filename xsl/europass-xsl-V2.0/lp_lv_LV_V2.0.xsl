<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_lv_LV_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_lv_LV_V2.0.xsl
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
					<span class="LabelBold">Europass Valodu pase</span>
					<br/>
					<span class="Label">Daļa no Eiropas Padomes izstrādātā Eiropas Valodu portfeļa</span>
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
							  <xsl:text>Uzvārds </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Uzvārds</xsl:text>
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
						<xsl:with-param name="label"><xsl:text>Dzimšanas datums</xsl:text></xsl:with-param>
						<xsl:with-param name="labelcontent"><xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				</xsl:if>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Dzimtā(s) valoda(s)</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Citas valodas</xsl:text></xsl:with-param>
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
					<td class="GridHeadingBold" colspan="10">Valodas prasmju pašnovērtējums</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Sapratne</td>
					<td class="GridHeadingBold" colspan="4">Runāšana</td>
					<td class="GridHeadingBold" colspan="2">Rakstīšana</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Klausīšanās</td>
					<td class="GridHeading" colspan="2">Lasīšana</td>
					<td class="GridHeading" colspan="2">Dialogs</td>
					<td class="GridHeading" colspan="2">Monologs</td>
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
		<xsl:if test="$element='a1'">Pamatlīmenis</xsl:if>
		<xsl:if test="$element='b1'">Vidējais līmenis</xsl:if>
		<xsl:if test="$element='c1'">Augstākais līmenis</xsl:if>
		<xsl:if test="$element='a2'">Pamatlīmenis</xsl:if>
		<xsl:if test="$element='b2'">Vidējais līmenis</xsl:if>
		<xsl:if test="$element='c2'">Augstākais līmenis</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Diplomi un apliecības</td>
			</tr>
			<tr>
				<td class="GridHeading">Diploma vai apliecības nosaukums</td>
				<td class="GridHeading">Piešķīrējiestāde</td>
				<td class="GridHeading">Gads</td>
				<td class="GridHeading">Eiropas līmenis</td>
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
				<td class="GridHeadingBold" colspan="3">Lingvistiskā pieredze</td>
			</tr>
			<tr>
				<td class="GridHeading">Apraksts</td>
				<td class="GridHeading">No</td>
				<td class="GridHeading">Līdz</td>
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
		(*)Ar zvaigznīti apzīmētās iedaļas aizpildīt nav obligāti.
		(**)Skatīt pašnovērtējuma tabulu otrā pusē
		(***)Eiropas kopīgo pamatnostādņu līmenis, ja tas ir minēts apliecības vai diploma oriģinālā.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Paskaidrojoša piezīme</b><br/>
		Europass Valodu pase ir daļa no Eiropas Padomes izstrādātā Eiropas Valodu portfeļa. Tur tiek lietota no Eiropas kopīgajām pamatnostādnēm valodu apguvei pārņemtā 6 līmeņu sistēma, kas ļauj standartizētā veidā aprakstīt sasniegto valodas prasmes līmeni.<br/>
		Vairāk informācijas par Europass Valodu pasi:http://europass.cedefop.europa.eu - Vairāk informācijas par Eiropas Valodu portfeli: www.coe.int/portfolio<br/>
		Europass Valodu pases veidlapu bez maksas var lejupielādēt no augstāk minētajām vietnēm.<br/>
		© Eiropas Padome un Eiropas Kopienas, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">EIROPAS VALODU PRASMES LĪMEŅI  –  PAŠNOVĒRTĒJUMA TABULA</th>
			</tr>
			<tr class="level">
				<th>A1</th>
				<td>Es saprotu pazīstamus vārdus un dažas ļoti  vienkāršas frāzes, kad lēni un skaidri runā  par mani, manu ģime­ni un tuvāko apkārtni.</td>
				<td>Es saprotu pazīstamus vārdus  un nosauku­mus, kā arī ļoti vien­kāršus teikumus, pie­mēram, paziņoju­mos, plakātos, katalo­gos.</td>
				<td>Es varu vienkāršā veidā sazināties, ja sarunu biedrs teikto  var lēnām atkārtot vai pateikt citiem vārdiem un palīdz man formu­lēt to, ko es cenšos pasacīt. Es varu uzdot vienkāršus jautājumus  un atbildēt uz tiem sarunā par man ļoti labi zināmām tēmām.</td>
				<td>Es varu vienkāršos  tei­kumos pastāstīt par savu dzīvesvietu un cil­vēkiem, kurus pa­zīstu.</td>
				<td>Es protu uzrakstīt īsu, vienkāršu tekstu, pie­mēram, nosūtīt ap­svei­kuma pastkarti. Es protu aizpildīt veid­la­pas ar personas da­tiem, piemēram, ierak­stīt savu vārdu, pilso­nī­bu un adresi vies­nī­cas reģistrācijas lapā.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Es saprotu atsevišķas frāzes un biežāk lietotos vārdus izteikumos, kam ir saistība ar mani (pie­mēram, vienkāršu infor­māciju par sevi un ģimeni, iepirkšanos, dzī­vesvietu, darbu). Es varu uztvert galveno domu īsos, vienkāršos un  skaidri izrunātos pa­zi­ņojumos, sludinā­ju­mos.</td>
				<td>Es varu izlasīt ļoti īsus un vienkāršus tekstus. Es varu sameklēt kon­krētu informāciju vien­kāršos, ar ikdienas dzīvi saistītos  tekstos:  sludi­nājumos, reklām­izde­vumos, ēdienkartēs, sa­rak­stos. Es varu saprast  īsas un vienkār­šas  pri­vātās vēstules.</td>
				<td>Es varu sazināties parastās ikdienišķās si­tuācijās, kur notiek vienkārša informācijas apmaiņa  par man zinā­miem tematiem vai dar­bībām. Es varu iesais­tīties ļoti īsā sarunā par sadzīviskiem jautāju­miem, tomēr ma­na va­lo­das prasme ir nepie­tiekama, lai  pat­stā­vīgi veidotu dialogu.</td>
				<td>Es varu vienkāršos tei­ku­mos pastāstīt par  savu ģimeni un citiem cilvēkiem, dzīves ap­stāk­ļiem, savu izglītību un pašreizējo vai iepriek­šējo darbu.</td>
				<td>Es varu uzrakstīt īsas zīmītes un vienkāršus paziņojumus.  Es protu uzrakstīt ļoti vienkāršu vēstuli, piemēram, izsa­kot kādam pateicību.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Es saprotu galveno saturu skaidrā un  literāri pareizā runā par pazīstamām tē­mām, ar kurām es sa­skaros darbā, skolā, brīvajā laikā utt. Es saprotu radio un televīzijas raidījumu saturu  tad, kad samērā lēni un skaidri runā  par aktuāliem notikumiem vai tematiem, kuri mani interesē perso­nīgi vai profesionāli.</td>
				<td>Es saprotu tekstus, kuros izmantota  ikdienā bieži lietota  vai ar manu darbu saistīta valoda. Es varu saprast privātajās  vēstulēs aprakstītos  notikumus, izjūtas un vēlmes.</td>
				<td>Es spēju ārzemju ceļojuma laikā sazināties situācijās, kur nepieciešams runāt. Es varu bez iepriekšējas sagatavošanās iesaistīties sarunā par man zināmiem vai mani interesējošiem, kā arī ar  ikdienas dzīvi saistītiem tematiem (pie­mēram, “ģimene”, “vaļas­prieks”, “darbs”,  “ceļo­ša­na”, “jaunākie notiku­mi”).</td>
				<td>Es protu veidot un saistīt kopā izteikumus, lai pa­stāstītu par pieredzēto un dažādiem notikumiem, sa­viem sapņiem, cerībām un vēlmēm. Es varu īsi  pa­matot un paskaidrot savus uzskatus un nodomus. Es varu pastāstīt stāstu, iz­klās­tīt grāmatas vai filmas saturu un izteikt par to savu attieksmi.</td>
				<td>Es protu uzrakstīt vien­kāršu, saistītu tekstu par jautājumiem, kas man ir zināmi vai mani interesē. Es varu uzrakstīt vēstuli, aprakstot  tajā savus pār­dzī­vojumus un iespaidus.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Es varu saprast garāku runu un lekcijas, sekot līdzi  pat sarežģītai argu­mentācijai, ja temats ir pietiekami  pazīstams. Es saprotu gandrīz visu televīzijas ziņās un repor­tāžās par jaunāka­jiem notikumiem. Es saprotu gandrīz visas filmas literārajā runā.</td>
				<td>Es varu izlasīt pārskatus un rakstus par aktuālām problēmām, kuros autors pauž noteiktu  attieksmi vai viedokli. Es varu saprast mūsdienu prozas darbus.</td>
				<td>Es varu  diezgan brīvi un bez sagatavošanās sazi­nāties ar dzimtās valodas runātājiem. Es varu aktīvi piedalīties dis­ku­­­­si­jās par man zināmām problēmām, pamatojot un aizstāvot savu  viedokli.</td>
				<td>Es varu skaidru un  vispusīgu dažādu tēmu izklāstu, kas ietilpst ma­nā interešu lokā. Es varu pamatot savus uz­ska­tus par kādu strīdīgu jautā­jumu, izvērtējot at­šķi­rīgos viedokļus.</td>
				<td>Es varu uzrakstīt skaidru, detalizētu tekstu par da­žādiem jautājumiem, kas skar manu interešu loku. Es varu uzrakstīt eseju vai ziņojumu, dot rak­stisku informāciju, kā arī argumentēt vienu vai otru viedokli. Es protu uz­rak­stīt vēstules, izceļot man nozīmīgākos notikumus un  iespaidus.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Es varu saprast garāku runu arī tad, ja tai  nav  skaidra uzbūve un ir vāji izteiktas loģiskās sakarības.  Es bez pū­lēm saprotu televīzi­jas raidījumus un filmas.</td>
				<td>Es varu saprast garus un sarežģītus dažāda tipa tekstus, izprotot stila atšķirības. Es varu sa­prast speciālos rak­stus un garākas teh­niskās instrukcijas, pat tad, ja tās neattiecas uz manu darbības jomu.</td>
				<td>Es varu veikli un brīvi izteikties,  piemērotus vārdus un izteicienus īpaši nemeklējot. Es protu prasmīgi lietot valodu gan ikdienas situācijās, gan darba vajadzībām. Es protu precīzi formulēt savas domas un uzskatus un prasmīgi uzturēt sarunu.</td>
				<td>Es varu skaidru un vispusīgu sarežģītu  tēmu izklāstu , iekļaut tajā pakārtotus jautā­jumus, izvērst atse­višķas tēzes un nobeigt ar atbilstošiem  secinā­jumiem.</td>
				<td>Es protu skaidri un loģiski  uzrakstīt savas domas, izteikt savu viedokli. Es varu uzrak­stīt vēstuli, eseju vai ziņojumu par sarežģī­tiem jautājumiem, iz­ceļot to, ko es uzskatu par nozīmīgu un sva­rīgu. Es protu rakstīt konkrētam lasītājam pie­­­mē­rotā  stilā.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Es bez grūtībām  sa­pro­tu jebkuru runas veidu – gan tiešā sa­ziņā  teikto, gan pār­raidīto pat tad, ja ātrā tempā runā dzimtās valodas lieto­tājs. Es varu saprast runātājus ar dažādām izrunas īpatnībām.</td>
				<td>Es bez grūtībām varu izlasīt dažāda tipa, uzbūves vai valodas ziņā sarežģītus tek­stus: rokasgrāmatas, speciālos rakstus, lite­rāros darbus.</td>
				<td>Es varu bez grūtībām piedalīties jebkurā sa­runā vai diskusijā, labi pārzinu idiomā­tiskos izteicienus un sarun­valodas vārdus. Es varu runāt pilnīgi brīvi un precīzi izteikt  nozīmes smal­kā­kās nianses. Ja valodas lietojumā man rodas grūtības, es protu tik veikli pār­veidot sacī­to, ka citi to nemana.</td>
				<td>Es varu pilnīgi brīvi, skaidri un argumen­tēti, konkrētajai situā­cijai atbilstošā veidā sniegt kādas tēmas izklāstu.  Es protu vei­dot savu stāstījumu tā, lai klausītājam būtu vieglāk uztvert un iegau­mēt nozīmīgākos jautājumus.</td>
				<td>Es protu uzrakstīt skaidru, loģisku tekstu atbilstošā stilā. Es varu uzrakstīt sarež­ģītas vēstules, referā­tus vai rakstus tā, lai  lasītājam būtu viegli pamanīt un atcerēties svarīgākās  vietas. Es varu uzrakstīt pārska­tus un recenzijas gan par  literārajiem, gan speciālās literatūras dar­biem.</td>
			</tr>
	  </table>
  </xsl:template>
</xsl:stylesheet>
