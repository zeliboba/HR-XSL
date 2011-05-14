<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_no_NO_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_no_NO_V2.0.xsl
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
					<span class="LabelBold">Europass språkpass</span>
					<br/>
					<span class="Label">– et dokument i den europeiske språkpermen utarbeidet av Europarådet</span>
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
							  <xsl:text>Etternavn </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Etternavn</xsl:text>
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
					<xsl:with-param name="label"><xsl:text>Morsmål</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Andre språk</xsl:text></xsl:with-param>
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
					<td class="GridHeadingBold" colspan="10">Egenvurdering av språkferdigheter</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Forståelse</td>
					<td class="GridHeadingBold" colspan="4">Tale</td>
					<td class="GridHeadingBold" colspan="2">Skrift</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Lytting</td>
					<td class="GridHeading" colspan="2">Lesing</td>
					<td class="GridHeading" colspan="2">Interaksjon</td>
					<td class="GridHeading" colspan="2">Muntlig produksjon</td>
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
		<xsl:if test="$element='a1'">Basisbruker</xsl:if>
		<xsl:if test="$element='b1'">Selvstendig bruker</xsl:if>
		<xsl:if test="$element='c1'">Dyktig bruker</xsl:if>
		<xsl:if test="$element='a2'">Basisbruker</xsl:if>
		<xsl:if test="$element='b2'">Selvstendig bruker</xsl:if>
		<xsl:if test="$element='c2'">Dyktig bruker</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Eksamensbevis / vitnemål</td>
			</tr>
			<tr>
				<td class="GridHeading">Tittel på vitnemål / bevis</td>
				<td class="GridHeading">Utstedt av</td>
				<td class="GridHeading">Dato</td>
				<td class="GridHeading">Europeisk nivå</td>
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
				<td class="GridHeadingBold" colspan="3">Erfaring med språket</td>
			</tr>
			<tr>
				<td class="GridHeading">Beskrivelse</td>
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
		(*)Titler merket med en stjerne er valgfrie
		(**)Se egenvurderings-skjema
		(***)Europeiske rammeverket (CEF)-nivå hvis spesifisert på originalen av vitnemålet eller beviset.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Forklarende note</b><br/>
		Europass språkpass er en del av europeiske språkpermen som er utviklet av Europarådet. De seks europeiske CEF-nivåene (CEF = Common European Framework of Reference for Languages) i egenvurderingsskjemaet angir brukerens språklige ferdighetsnivå på en standardisert måte.<br/>
		Flere opplysninger om Europass språkpass: http://europass.cedefop.europa.eu - Flere opplysninger om europeiske språkpermen: www.coe.int/portfolio<br/>
		Oppsett og mal for Europass språkpass kan lastes ned gratis fra nettsidene over.<br/>
		© Europarådet og De Europeiske Fellesskap, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">Europeiske nivåer – Egenvurderingsmatrise</th>
			</tr>
			<tr class="level">
				<th>A1</th>
				<td>Jeg kan kjenne igjen vanlige ord og svært enkle uttrykk som angår meg selv, min familie og mine nære omgivelser når man snakker langsomt og tydelig.</td>
				<td>Jeg kan forstå kjente navn, ord og svært enkle setninger, for eksempel i annonser, på plakater eller i kataloger.</td>
				<td>Jeg kan delta i en samtale på en enkel måte hvis samtalepartneren er villig til å gjenta, omformulere, snakke langsomt og hjelpe meg å formulere meg. Jeg kan stille og svare på enkle spørsmål knyttet til umiddelbare behov eller til svært kjente emner.</td>
				<td>Jeg kan bruke enkle uttrykk og setninger for å beskrive stedet der jeg bor og mennesker jeg kjenner.</td>
				<td>Jeg kan skrive et enkelt postkort, f.eks. et julekort. Jeg kan fylle ut skjemaer med personlige opplysninger, som navn, nasjonalitet og adresse.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Jeg kan forstå vanlige ord og ytringer knyttet til områder av umiddelbar personlig betydning (f.eks. svært enkel informasjon som gjelder meg selv, min familie, mitt nærmiljø, innkjøp og arbeidsliv). Jeg kan oppfatte hovedinnholdet i enkle, korte og tydelige beskjeder og meldinger.</td>
				<td>Jeg kan lese svært korte, enkle tekster. Jeg kan finne spesifikke, forutsigbare opplysninger i enkel, dagligdags informasjon som reklame, brosjyrer, menyer og rutetabeller. Jeg kan forstå korte, enkle, personlige brev.</td>
				<td>Jeg kan delta i enkle og rutinepregede samtalesituasjoner som innebærer enkel og direkte utveksling av informasjon om kjente emner og aktiviteter. Jeg kan bruke og forstå vanlige høflighetsfraser, men forstår som regel ikke nok til å holde samtalen gående.</td>
				<td>Jeg kan bruke en rekke uttrykk og setninger for på en enkel måte å beskrive familie og andre mennesker, boforhold, min utdanningsbakgrunn og min nåværende eller tidligere jobb.</td>
				<td>Jeg kan skrive korte, enkle notater og beskjeder. Jeg kan skrive et svært enkelt personlig brev, f.eks. et takkebrev.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Jeg kan forstå hovedinnholdet i klar, standard tale om kjente emner knyttet til bl.a. arbeid, skole og fritid. Jeg kan forstå hovedinnholdet i mange radio- og TV-programmer om aktuelle saker eller om emner som er av personlig eller faglig interesse for meg, når det snakkes relativt langsomt og tydelig.</td>
				<td>Jeg kan forstå tekster der språket i stor grad er preget av vanlige, dagligdagse ord og uttrykk eller vanlige ord knyttet til arbeidet mitt. Jeg kan forstå personlige brev med beskrivelser av hendelser, følelser og ønsker.</td>
				<td>Jeg kan klare meg språklig i de fleste situasjoner som kan oppstå når jeg reiser i et område der språket snakkes. Jeg kan uforberedt delta i samtaler om kjente emner, emner av personlig interesse eller som er viktige i dagliglivet (f.eks. familie, hobby, arbeid, reise, aktuelle hendelser).</td>
				<td>Jeg kan gi en enkel, sammenhengende framstilling av hendelser, erfaringer, drømmer, håp og planer. Jeg kan kort forklare og begrunne mine meninger og planer. Jeg kan fortelle en historie eller gjenfortelle handlingen i en bok eller film og beskrive reaksjonene mine.</td>
				<td>Jeg kan skrive en enkel og sammenhengende tekst om dagligdagse emner eller om emner som berører meg personlig. Jeg kan skrive personlige brev og beskrive opplevelser og inntrykk.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Jeg kan forstå lengre sammenhengende tale og foredrag og følge komplekse argumentasjonsrekker når emnet er forholdsvis kjent. Jeg kan forstå de fleste nyhets- og aktualitetsprogrammer på TV. Jeg kan forstå de aller fleste filmer der det brukes standard tale.</td>
				<td>Jeg kan lese artikler og rapporter om aktuelle problemstillinger, der forfatteren gir uttrykk for bestemte holdninger eller synspunkter. Jeg kan forstå prosalitteratur fra vår egen tid.</td>
				<td>Jeg kan bruke språket så flytende og spontant at samtaler med morsmålsbrukere ikke byr på særlige problemer. Jeg kan delta aktivt i diskusjoner i kjente sammenhenger, og jeg kan uttrykke og begrunne synspunktene mine.</td>
				<td>Jeg kan gi klare og detaljerte beskrivelser innenfor et vidt spekter av emner knyttet til mitt interessefelt. Jeg kan forklare et synspunkt på en gitt problemstilling og gjøre rede for fordeler og ulemper ved ulike alternativer.</td>
				<td>Jeg kan skrive klare, detaljerte tekster om et vidt spekter av emner knyttet til mine interesser. Jeg kan skrive en sammenhengende framstilling eller rapport for å formidle informasjon eller argumentere for eller imot et bestemt synspunkt. Jeg kan skrive brev som tydelig viser hvilken betydning visse hendelser og erfaringer har for meg.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Jeg kan forstå sammenhengende tale også når den ikke er tydelig strukturert, og når sammenhenger er underforståtte og ikke kommer tydelig fram. Jeg kan forstå TV-programmer og filmer uten altfor store anstrengelser.</td>
				<td>Jeg kan forstå lange, komplekse faktatekster og skjønnlitterære tekster, og legge merke til trekk som er typiske for ulike stilnivåer. Jeg kan forstå fagartikler og lengre, tekniske instruksjoner selv når de ligger utenfor mitt felt.</td>
				<td>Jeg kan uttrykke meg flytende og spontant uten at det i særlig grad merkes at jeg leter etter uttrykksmåter. Jeg kan bruke språket fleksibelt og effektivt både i sosiale og faglige sammenhenger. Jeg kan formulere idéer og meninger presist og forholde meg til samtalepartnere på en hensiktsmessig måte.</td>
				<td>Jeg kan gi klare og detaljerte beskrivelser av komplekse emner der jeg trekker inn delmomenter, utdyper enkelte punkter og runder av med en passende konklusjon.</td>
				<td>Jeg kan skrive klare og strukturerte tekster og gi uttrykk for mine synspunkter på en utfyllende måte. Jeg kan skrive om komplekse emner (i brev, rapporter, artikler eller essays) og understreke hva jeg mener er de viktigste punktene. Jeg kan velge en stil som passer til den som skal lese teksten.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Jeg forstår uten problemer alle former for muntlig språk både i det virkelige liv og i media, også når morsmålsbrukeren snakker i et naturlig og hurtig tempo, dersom jeg får litt tid til å gjøre meg kjent med dialekten.</td>
				<td>Jeg leser uten problemer praktisk talt alle former for tekst, inkludert tekster om abstrakte emner og tekster som er komplekse når det gjelder språk eller struktur, som instruksjoner, fagartikler og litterære verk.</td>
				<td>Jeg kan uten anstrengelse delta i alle former for samtale og diskusjon og har god kjennskap til faste uttrykk og alminnelige talemåter. Jeg kan uttrykke meg flytende og formidle finere meningsnyanser på en presis måte. Hvis jeg får et språklig problem, kan jeg omformulere meg slik at det nesten ikke merkes.</td>
				<td>Jeg kan beskrive, drøfte og argumentere på en klar og flytende måte, bruke et språk og en stil som passer i sammenhengen, og strukturere det jeg sier på en hensiktsmessig og logisk måte slik at den som lytter, kan legge merke til og huske viktige poenger.</td>
				<td>Jeg kan skrive klare tekster med god flyt i en passende stil. Jeg kan skrive komplekse brev, rapporter og artikler der jeg legger fram en sak med en hensiktsmessig og logisk struktur som hjelper mottakeren å legge merke til og huske viktige poenger. Jeg kan skrive sammendrag og anmeldelser både av faglige og litterære arbeider.</td>
			</tr>
	  </table>
  </xsl:template>
</xsl:stylesheet>
