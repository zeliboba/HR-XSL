<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_nl_NL_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_nl_NL_V2.0.xsl
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
					<span class="LabelBold">Europass Taalpaspoort</span>
					<br/>
					<span class="Label">Deel van het Deel van het Europees Taalportfolio dat werd ontwikkeld door de Raad van Europa</span>
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
							  <xsl:text>Achternaam (-namen) </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Achternaam (-namen)</xsl:text>
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
						<xsl:with-param name="label"><xsl:text>Geboortedatum</xsl:text></xsl:with-param>
						<xsl:with-param name="labelcontent"><xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				</xsl:if>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Moedertaal (-talen)</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Andere taal (talen)</xsl:text></xsl:with-param>
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
					<td class="GridHeadingBold" colspan="10">Zelfbeoordeling van taalvaardigheden</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Begrijpen</td>
					<td class="GridHeadingBold" colspan="4">Spreken</td>
					<td class="GridHeadingBold" colspan="2">Schrijven</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Luisteren</td>
					<td class="GridHeading" colspan="2">Lezen</td>
					<td class="GridHeading" colspan="2">Interactie</td>
					<td class="GridHeading" colspan="2">Productie</td>
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
		<xsl:if test="$element='a1'">Basisgebruiker</xsl:if>
		<xsl:if test="$element='b1'">Onafhankelijke gebruiker</xsl:if>
		<xsl:if test="$element='c1'">
	Vaardige gebruiker</xsl:if>
		<xsl:if test="$element='a2'">Basisgebruiker</xsl:if>
		<xsl:if test="$element='b2'">Onafhankelijke gebruiker</xsl:if>
		<xsl:if test="$element='c2'">
	Vaardige gebruiker</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Diploma('s) of certificaat (certificaten)</td>
			</tr>
			<tr>
				<td class="GridHeading">Naam van diploma ('s) of certificaat (certificaten)</td>
				<td class="GridHeading">Naam van instantie die diploma/certificaat uitreikte</td>
				<td class="GridHeading">Datum</td>
				<td class="GridHeading">Europees niveau</td>
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
				<td class="GridHeadingBold" colspan="3">Taalleerervaring (-en)</td>
			</tr>
			<tr>
				<td class="GridHeading">Beschrijving</td>
				<td class="GridHeading">Van</td>
				<td class="GridHeading">Tot</td>
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
		(*)Invulvakken waar een asterisk bij staat zijn facultatief.
		(**)Zie de tabel voor zelfbeoordeling aan de achterzijde.
		(***)Niveau volgens Europees Referentiekader voor Talen (CEF) als dat vermeld staat op het originele certificaat of diploma.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Toelichting</b><br/>
		Het Europass Taalpaspoort is onderdeel van het Europees Taalportfolio dat werd ontwikkeld door de Raad van Europa. Het maakt gebruik van de 6 Europese niveaus van het Gemeenschappelijk Europees Referentiekader voor Talen om het bereikte taalvaardigheidsniveau in een gestandaardiseerd format vast te leggen.<br/>
		Meer informatie over het Europass Taalpaspoort: http://europass.cedefop.europa.eu - Meer informatie over het Europees Taalportfolio: www.coe.int/portfolio<br/>
		Het template van het Europass Taalpaspoort kan gratis worden gedownload van de bovengenoemde websites.<br/>
		© Raad van Europa en Europese Gemeenschappen, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">Europese niveaus – Beschrijvingsschema voor zelfbeoordeling</th>
			</tr>
			<tr class="level">
				<th>A1</th>
				<td>Ik kan vertrouwde woorden en basiszinnen begrijpen die mezelf, mijn familie en directe concrete omgeving betreffen, wanneer de mensen langzaam en duidelijk spreken.</td>
				<td>Ik kan vertrouwde namen, woorden en zeer eenvoudige zinnen begrijpen, bijvoorbeeld in mededelingen, op posters en in catalogi.</td>
				<td>Ik kan deelnemen aan een eenvoudig gesprek, wanneer de gesprekspartner bereid is om zaken in een langzamer spreektempo te herhalen of opnieuw te formuleren en mij helpt bij het formuleren van wat ik probeer te zeggen. Ik kan eenvoudige vragen stellen en beantwoorden die een directe behoefte of zeer vertrouwde onderwerpen betreffen.</td>
				<td>Ik kan eenvoudige uitdrukkingen en zinnen gebruiken om mijn woonomgeving en de mensen die ik ken, te beschrijven.</td>
				<td>Ik kan een korte, eenvoudige ansichtkaart schrijven, bijvoorbeeld voor het zenden van vakantiegroeten. Ik kan op formulieren persoonlijke details invullen, bijvoorbeeld mijn naam, nationaliteit en adres noteren op een hotelinschrijvingsformulier.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Ik kan zinnen en de meest frequente woorden begrijpen die betrekking hebben op gebieden die van direct persoonlijk belang zijn (bijvoorbeeld basisinformatie over mezelf en mijn familie, winkelen, plaatselijke omgeving, werk). Ik kan de belangrijkste punten in korte, duidelijke eenvoudige boodschappen en aankondigingen volgen.</td>
				<td>Ik kan zeer korte eenvoudige teksten lezen. Ik kan specifieke voorspelbare informatie vinden in eenvoudige, alledaagse teksten zoals advertenties, folders, menu's en dienstregelingen en ik kan korte, eenvoudige, persoonlijke brieven begrijpen.</td>
				<td>Ik kan communiceren over eenvoudige en alledaagse taken die een eenvoudige en directe uitwisseling van informatie over vertrouwde onderwerpen en activiteiten betreffen. Ik kan zeer korte sociale gesprekken aan, alhoewel ik gewoonlijk niet voldoende begrijp om het gesprek zelfstandig gaande te houden.</td>
				<td>Ik kan een reeks uitdrukkingen en zinnen gebruiken om in eenvoudige bewoordingen mijn familie en andere mensen, leefomstandigheden, mijn opleiding en mijn huidige of meest recente baan te beschrijven.</td>
				<td>Ik kan korte, eenvoudige notities en boodschappen opschrijven. Ik kan een zeer eenvoudige persoonlijke brief schrijven, bijvoorbeeld om iemand voor iets te bedanken.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Ik kan de hoofdpunten begrijpen wanneer in duidelijk uitgesproken standaarddialect wordt gesproken over vertrouwde zaken die ik regelmatig tegenkom op mijn werk, school, vrije tijd enz. Ik kan de hoofdpunten van veel radio- of tv-programmas over actuele zaken of over onderwerpen van persoonlijk of beroepsmatig belang begrijpen, wanneer er betrekkelijk langzaam en duidelijk gesproken wordt.</td>
				<td>Ik kan teksten begrijpen die hoofdzakelijk bestaan uit hoogfrequente, alledaagse of aan mijn werk gerelateerde taal. Ik kan de beschrijving van gebeurtenissen, gevoelens en wensen in persoonlijke brieven begrijpen.</td>
				<td>Ik kan de meeste situaties aan die zich kunnen voordoen tijdens een reis in een gebied waar de betreffende taal wordt gesproken. Ik kan onvoorbereid deelnemen aan een gesprek over onderwerpen die vertrouwd zijn, of mijn persoonlijke belangstelling hebben of die betrekking hebben op het dagelijks leven (bijvoorbeeld familie, hobby's, werk, reizen en actuele gebeurtenissen).</td>
				<td>Ik kan uitingen op een simpele manier aan elkaar verbinden, zodat ik ervaringen en gebeurtenissen, mijn dromen, verwachtingen en ambities kan beschrijven. Ik kan in het kort redenen en verklaringen geven voor mijn meningen en plannen. Ik kan een verhaal vertellen, of de plot van een boek of film weergeven en mijn reacties beschrijven.</td>
				<td>Ik kan eenvoudige samenhangende tekst schrijven over onderwerpen die vertrouwd of van persoonlijk belang zijn. Ik kan persoonlijke brieven schrijven waarin ik mijn ervaringen en indrukken beschrijf.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Ik kan een langer betoog en lezingen begrijpen en zelfs complexe redeneringen volgen, wanneer het onderwerp redelijk vertrouwd is. Ik kan de meeste nieuws- en actualiteitenprogramma's op de tv begrijpen. Ik kan het grootste deel van films in standaarddialect begrijpen.</td>
				<td>Ik kan artikelen en verslagen lezen die betrekking hebben op eigentijdse problemen, waarbij de schrijvers een bepaalde houding of standpunt innemen. Ik kan eigentijds literair proza begrijpen.</td>
				<td>Ik kan zodanig deelnemen aan een vloeiend en spontaan gesprek, dat normale uitwisseling met moeder­taalsprekers redelijk mogelijk is. Ik kan binnen een vertrouwde context actief deelnemen aan een discussie en hierin mijn standpunten uitleggen en ondersteunen.</td>
				<td>Ik kan duidelijke, gedetailleerde beschrijvingen presenteren over een breed scala van onderwerpen die betrekking hebben op mijn interessegebied. Ik kan een standpunt over een actueel onderwerp verklaren en de voordelen en nadelen van diverse opties uiteenzetten.</td>
				<td>Ik kan een duidelijke, gedetailleerde tekst schrijven over een breed scala van onderwerpen die betrekking hebben op mijn interesses. Ik kan een opstel of verslag schrijven, informatie doorgeven of redenen aanvoeren ter ondersteuning vóór of tégen een specifiek standpunt. Ik kan brieven schrijven waarin ik het persoonlijk belang van gebeurtenissen en ervaringen aangeef.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Ik kan een langer betoog begrijpen, zelfs wanneer dit niet duidelijk gestructureerd is en wanneer relaties slechts impliciet zijn en niet expliciet worden aangegeven. Ik kan zonder al te veel inspanning tv-programma’s en films begrijpen.</td>
				<td>Ik kan lange en complexe feitelijke en literaire teksten begrijpen, en het gebruik van verschillende stijlen waarderen. Ik kan gespecialiseerde artikelen en lange technische instructies begrijpen, zelfs wanneer deze geen betrekking hebben op mijn terrein.</td>
				<td>Ik kan mezelf vloeiend en spontaan uitdrukken zonder merkbaar naar uitdrukkingen te hoeven zoeken. Ik kan de taal flexibel en effectief gebruiken voor sociale en professionele doeleinden. Ik kan ideeën en meningen met precisie formuleren en mijn bijdrage vaardig aan die van andere sprekers relateren.</td>
				<td>Ik kan duidelijke, gedetailleerde beschrijvingen geven over complexe onderwerpen en daarbij subthemas integreren, specifieke standpunten ontwikkelen en het geheel afronden met een passende conclusie.</td>
				<td>Ik kan me in duidelijke, goed gestructureerde tekst uitdrukken en daarbij redelijk uitgebreid standpunten uiteenzetten. Ik kan in een brief, een opstel of een verslag schrijven over complexe onderwerpen en daarbij de voor mij belangrijke punten benadrukken. Ik kan schrijven in een stijl die is aangepast aan de lezer die ik in gedachten heb.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Ik kan moeiteloos gesproken taal begrijpen, in welke vorm dan ook, hetzij in direct contact, hetzij via radio of tv, zelfs wanneer in een snel moedertaaltempo gesproken wordt als ik tenminste enige tijd heb om vertrouwd te raken met het accent.</td>
				<td>Ik kan moeiteloos vrijwel alle vormen van de geschreven taal lezen, inclusief abstracte, structureel of linguïstisch complexe teksten, zoals handleidingen, specialistische artikelen en literaire werken.</td>
				<td>Ik kan zonder moeite deelnemen aan welk gesprek of discussie dan ook en ben zeer vertrouwd met idiomatische uitdrukkingen en spreektaal. Ik kan mezelf vloeiend uitdrukken en de fijnere betekenisnuances precies weergeven. Als ik een probleem tegenkom, kan ik mezelf hernemen en mijn betoog zo herstructureren dat andere mensen het nauwelijks merken.</td>
				<td>Ik kan een duidelijke, goedlopende beschrijving of redenering presenteren in een stijl die past bij de context en in een doeltreffende logische structuur, zodat de toehoorder in staat is de belangrijke punten op te merken en te onthouden.</td>
				<td>Ik kan een duidelijke en vloeiend lopende tekst in een gepaste stijl schrijven. Ik kan complexe brieven, verslagen of artikelen schrijven waarin ik een zaak weergeef in een doeltreffende, logische structuur, zodat de lezer de belangrijke punten kan opmerken en onthouden. Ik kan samenvattingen van en kritieken op professionele of literaire werken schrijven.</td>
			</tr>
	  </table>
  </xsl:template>
</xsl:stylesheet>
