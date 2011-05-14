<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_da_DK_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_da_DK_V2.0.xsl
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
					<span class="LabelBold">Europass-sprogpas</span>
					<br/>
					<span class="Label">er en del af Den Europæiske Sprogmappe (European Language Portfolio), som er udviklet af Europarådet</span>
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
							  <xsl:text>Efternavn(e) </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Efternavn(e)</xsl:text>
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
						<xsl:with-param name="label"><xsl:text>Fødselsdato</xsl:text></xsl:with-param>
						<xsl:with-param name="labelcontent"><xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				</xsl:if>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Modersmål</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Andre sprog</xsl:text></xsl:with-param>
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
					<td class="GridHeadingBold" colspan="10">Selvevaluering af sprogfærdigheder</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Forstå</td>
					<td class="GridHeadingBold" colspan="4">Tale</td>
					<td class="GridHeadingBold" colspan="2">Skrive</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Lytte</td>
					<td class="GridHeading" colspan="2">Læse</td>
					<td class="GridHeading" colspan="2">Samtale</td>
					<td class="GridHeading" colspan="2">Redegøre</td>
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
		<xsl:if test="$element='a1'">Sprogbruger med basiskundskaber</xsl:if>
		<xsl:if test="$element='b1'">Selvstændig sprogbruger</xsl:if>
		<xsl:if test="$element='c1'">Kompetent sprogbruger</xsl:if>
		<xsl:if test="$element='a2'">Sprogbruger med basiskundskaber</xsl:if>
		<xsl:if test="$element='b2'">Selvstændig sprogbruger</xsl:if>
		<xsl:if test="$element='c2'">Kompetent sprogbruger</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Uddannelses- eller eksamensbevis(er)</td>
			</tr>
			<tr>
				<td class="GridHeading">Betegnelse på uddannelses- eller eksamensbevis(er)</td>
				<td class="GridHeading">Udstedende institution</td>
				<td class="GridHeading">Dato</td>
				<td class="GridHeading">Europ. niveau</td>
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
				<td class="GridHeadingBold" colspan="3">Sproglig erfaring</td>
			</tr>
			<tr>
				<td class="GridHeading">Beskrivelse (*)</td>
				<td class="GridHeading">Fra</td>
				<td class="GridHeading">Til</td>
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
		(*)Rubrikker markeret med asterisk (*) er valgfri.
		(**)Se skema over egen bedømmelse af sprogfærdigheder.
		(***)Kompetenceniveau fra den fælles europæiske referenceramme for sprog (CEF), hvis det fremgår af originalbeviset.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Forklarende note</b><br/>
		Europass-sprogpasset er en del af Den Europæiske Sprogmappe, som er udarbejdet af Europarådet. Det registrerer pasindehaverens sprogkundskabers niveau i et standardformat under anvendelse af de seks kompetenceniveauer fra den fælles europæiske referenceramme for sprog (CEF).<br/>
		Yderligere oplysninger om Europass-sprogpas findes på: http://europass.cedefop.europa.eu. Yderligere oplysninger om Den Europæiske Sprogmappe findes på: www.coe.int/portfolio.<br/>
		Skabelonen til Europass-sprogpas kan downloades gratis fra ovennævnte websteder.<br/>
		© Europarådet og De Europæiske Fællesskaber, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">Europæiske niveauer - Selvevaluieringsskala</th>
			</tr>
			<tr class="level">
				<th>A1</th>
				<td>Jeg kan forstå meget enkle ytringer om mig selv, mennesker jeg kender og ting omkring mig, når folk taler langsomt og tydeligt.</td>
				<td>Jeg kan forstå dagligdags navne, ord og meget enkle sætninger, fx i annoncer, på opslag og plakater eller i brochurer.</td>
				<td>Jeg kan føre enkle samtaler hvis min samtalepartner er indstillet på at gentage eller at omformulere sine sætninger og  tale langsommeret, samt hjælpe mig med at formulere det, jeg prøver på at sige.
Jeg kan stille og besvare enkle spørgsmål omkring dagligdags emner.</td>
				<td>Jeg kan med enkle sætninger og et begrænset ordforråd beskrive hvor jeg bor og fortælle om folk, jeg kender.</td>
				<td>Jeg kan skrive korte, enkle postkort, fx sende feriehilsner. Jeg kan udfylde formularer med personlige oplysninger, fx skrive navn, nationalitet og  adresse på en hotelregistrering.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Jeg kan forstå de mest almindelige ord og udtryk for ting, der er vigtige for mig, fx oplysninger om mig selv, om min familie, om indkøb, mit nærmiljø og mit arbejde. Jeg kan forstå hovedindholdet i korte og klare  beskeder og meddelelser.</td>
				<td>Jeg kan læse meget korte og enkle tekster. Jeg kan finde bestemte oplysninger, jeg leder efter i dagligdags tekster såsom reklamer, brochurer, spisekort og fartplaner, og jeg kan forstå korte, enkle personlige breve.</td>
				<td>Jeg kan deltage i samtale om enkle  hverdagssituationer, der kun lægger op til en udveksling af informationer. 
Jeg kan deltage i en kort meningsudveksling, skønt jeg normalt endnu ikke forstår nok til at kunne uddybe samtalen.</td>
				<td>Jeg kan bruge en række udtryk og enkle vendinger til at beskrive min familie og andre omkring mig, min dagligdag, min uddannelsesmæssige baggrund og mit arbejde – nu eller tidligere.</td>
				<td>Jeg kan skrive korte, enkle notater og beskeder. 
Jeg kan skrive et meget enkelt, personligt brev, fx et takkebrev.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Jeg kan forstå hovedindholdet når der er tale om dagligdags emner som fx arbejde, skole, fritid etc. og sproget er klart og præcist.</td>
				<td>Jeg kan forstå tekster, der er skrevet i et dagligdags sprog eller relaterer sig til mit arbejde. Jeg kan forstå indholdet af personlige breve, hvor afsenderen  beskriver sine oplevelser, følelser og ønsker.</td>
				<td>Jeg kan klare de fleste situationer, der opstår ved  rejse i lande eller områder, hvor sproget tales. Jeg kan uforberedt indgå i en samtale om emner af personlig interesse eller  generelle hverdagsemner som fx familie, fritid, arbejde, rejse og aktuelle begivenheder.</td>
				<td>Jeg kan bruge udtryk og vendinger til at redegøre for oplevelser, mine drømme, håb og forventninger. Jeg kan kort  forklare og begrunde mine meninger og planer. Jeg kan fortælle en historie, give et resume af en bog eller af en film og beskrive mine indtryk af dem.</td>
				<td>Jeg kan skrive en enkel og sammenhængende tekst om dagligdags temaer eller om emner, som interesserer mig personligt. 
Jeg kan skrive personlige breve, hvor jeg beskriver oplevelser og indtryk.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Jeg kan forstå længere sammenhængende tale og foredrag og kan følge med i en indviklet ordveksling, forudsat at jeg har rimelig indsigt i emnet. Jeg kan forstå de fleste nyhedsudsendelser på tv. Jeg kan forstå de fleste film, hvor sproget forekommer i en standard version.</td>
				<td>Jeg kan læse artikler og rapporter om aktuelle emner i hvilke forfatteren indtager en bestemt holdning til et problem eller udtrykker et bestemt synspunkt. Jeg kan forstå de fleste moderne noveller og lettilgængelige romaner.</td>
				<td>Jeg kan samtale og diskutere så pas flydende og frit, at jeg forholdsvis utvungent kan føre en samtale med ’native speakers’ 
Jeg kan tage aktivt del i diskussioner om dagligdags emner, samt forklare og forsvare mine synspunkter.</td>
				<td>Jeg kan klart og detaljeret redegøre for forhold vedrørende mine interesse- og erfaringsområder. Jeg kan fremlægge et synspunkt om et aktuelt emne og angive fordele og ulemper ved forskellige løsningsmuligheder.</td>
				<td>Jeg kan skrive klare og detaljerede tekster om en lang række emner der interesserer mig. Jeg kan skrive en opgave eller en rapport hvor jeg formidler oplysninger og argumenterer for eller imod et bestemt synspunkt. Jeg kan skrive breve hvor jeg giver udtryk for hændelsers og oplevelsers betydning for mig personligt.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Jeg kan forstå et langt foredrag selv når det ikke er klart struktureret, og  ideer og tanker ikke udtrykkes direkte. Jeg kan forstå tv-udsendelser og film uden større besvær.</td>
				<td>Jeg kan forstå lange og indviklede sagprosatekster og litterære tekster og opfatte forskelle i stil. Jeg kan forstå fagsprog i artikler og tekniske instruktioner, også når det ikke er inden for mit fagområde.</td>
				<td>Jeg kan udtrykke mig flydende og spontant uden alt for tydeligt at lede efter ordene. Jeg kan bruge sproget fleksibelt og effektivt i sociale og arbejdsmæssige situationer. 
Jeg kan forholdsvis præcist udtrykke mine synspunkter og ideer på en måde, der er tilpasset efter, hvilken person, jeg taler med.</td>
				<td>Jeg kan klart og detaljeret redegøre for komplekse emner med forgrenede problemfelter. Jeg kan fremføre specielle problemfelter samt afrunde fremstillingen med en konklusion.</td>
				<td>Jeg kan skrive en klar og velstruktureret tekst, hvori jeg kan udtrykke mine synspunkter i detaljer. Jeg kan skrive om indviklede emner i et brev, en opgave eller en rapport og fremhæve det jeg mener er det væsentligste indhold. Jeg kan skrive  tekster i forskellige genrer, tilpasset modtageren.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Jeg kan forstå alle former for talesprog, både når jeg hører det i direkte kommunikation, og når jeg hører det i medierne. Jeg kan også forstå en indfødt, der taler hurtigt, hvis jeg har haft tid til at vænne mig til vedkommendes måde at tale på.</td>
				<td>Jeg kan uden problemer læse næsten alle former for tekster, også abstrakte tekster der indeholder svære ord og sætningsstrukturer, f.eks. manualer, fagtekster og litterære tekster.</td>
				<td>Jeg kan uden anstrengelse tage del i hvilken som helst samtale og diskussion og vælge det passende ordforråd og udtryk. Jeg kan udtrykke mig flydende og  nuanceret med en stor grad af præcision. Hvis jeg alligevel har problemer, kan jeg med omformuleringer klare mig så godt, at min samtalepartner næppe lægger mærke til det.</td>
				<td>Jeg kan fremføre en klar og flydende redegørelse eller argumentation med et sprog, som passer til situationen i stil og niveau. Jeg kan redegøre med en effektiv, logisk struktur, som hjælper modtageren med at lægge mærke til og huske vigtige punkter.</td>
				<td>Jeg kan skrive klart og flydende, i en stil der er tilpasset formålet. Jeg kan skrive indviklede breve, rapporter eller artikler på en sådan måde at det hjælper læseren til at lægge mærke til og huske vigtige punkter. Jeg kan skrive sammenfatninger og anmeldelser af faglige eller litterære tekster.</td>
			</tr>
	  </table>
  </xsl:template>
</xsl:stylesheet>
