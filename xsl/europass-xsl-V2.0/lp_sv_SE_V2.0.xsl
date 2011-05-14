<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_sv_SE_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_sv_SE_V2.0.xsl
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
					<span class="LabelBold">Europass Språkpass</span>
					<br/>
					<span class="Label">Ingår i den Europeiska språkportfolion, som har utvecklats av Europarådet</span>
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
							  <xsl:text>Efternamn </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Efternamn</xsl:text>
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
						<xsl:with-param name="label"><xsl:text>Födelsedatum</xsl:text></xsl:with-param>
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
					<xsl:with-param name="label"><xsl:text>Annat/andra språk</xsl:text></xsl:with-param>
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
					<td class="GridHeadingBold" colspan="10">Självbedömning av språkfärdigheter</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Förståelse</td>
					<td class="GridHeadingBold" colspan="4">Tala</td>
					<td class="GridHeadingBold" colspan="2">Skriva</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Höra</td>
					<td class="GridHeading" colspan="2">Läsa</td>
					<td class="GridHeading" colspan="2">Samtal/muntlig interaktion</td>
					<td class="GridHeading" colspan="2">Muntlig produktion</td>
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
		<xsl:if test="$element='a1'">Baspresterande språkanvändare</xsl:if>
		<xsl:if test="$element='b1'">Självständig språkanvändare</xsl:if>
		<xsl:if test="$element='c1'">Avancerad språkanvändare</xsl:if>
		<xsl:if test="$element='a2'">Baspresterande språkanvändare</xsl:if>
		<xsl:if test="$element='b2'">Självständig språkanvändare</xsl:if>
		<xsl:if test="$element='c2'">Avancerad språkanvändare</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Examensbevis eller slutbetyg</td>
			</tr>
			<tr>
				<td class="GridHeading">Benämning på examensbevis eller slutbetyg</td>
				<td class="GridHeading">Utfärdande institution</td>
				<td class="GridHeading">Datum</td>
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
				<td class="GridHeadingBold" colspan="3">Språkerfarenhet(er)</td>
			</tr>
			<tr>
				<td class="GridHeading">Beskrivning</td>
				<td class="GridHeading">Fr.o.m.</td>
				<td class="GridHeading">T.o.m.</td>
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
		(*)Rubriker märkta med en stjärna är valfria.
		(**)Se Skala för självbedömning på baksidan.
		(***)Nivå inom de gemensamma europeiska referensramarna (CEF) om denna anges på det ursprungliga slutbetyget eller examensbeviset.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Förklarande anmärkning</b><br/>
		Europass-språkpasset ingår i den Europeiska språkportfolion som har utvecklats av Europarådet. Den använder de 6 europeiska nivåerna i de gemensamma europeiska referensramarna för språk (CEF) för att i ett standardiserat format registrera nivån på uppnådda språkfärdigheter.<br/>
		Mer information om Europass-språkpasset: http://europass.cedefop.europa.eu - Mer information om den Europeiska språkportfolion: www.coe.int/portfolio<br/>
		Mallen till Europass-språkpasset kan laddas ner kostnadsfritt från ovanstående webbplatser.<br/>
		© Europarådet och Europeiska gemenskaperna, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">Europeiska nivåer – Skala för självbedömning</th>
			</tr>
			<tr class="level">
				<th>A1</th>
				<td>Jag kan känna igen vanliga ord och mycket enkla fraser som gäller mig själv, min familj och min direkta omgivning, men bara när man talar till mig sakta och tydligt.</td>
				<td>Jag kan förstå vanliga namn, ord och mycket enkla meningar, t.ex. på anslag och affischer eller i kataloger.</td>
				<td>Jag kan samtala på ett enkelt sätt under förutsättning att den andra personen är beredd att tala långsamt och upprepa eller formulera om vad som sagts eller hjälpa mig att formulera vad jag själv vill säga. Jag kan ställa och besvara enkla frågor av omedelbart intresse eller inom vanliga ämnesområden.</td>
				<td>Jag kan använda enkla fraser och meningar för att beskriva var jag bor och människor jag känner.</td>
				<td>Jag kan skriva korta, enkla meddelanden, t.ex. ett vykort med hälsningar. Jag kan fylla i personliga uppgifter som namn, adress och nationalitet i enklare formulär.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Jag kan förstå fraser och mycket vanliga ord som gäller mina personliga förhållanden, t.ex. information om mig själv och min familj, närmiljö och vardagliga sysselsättningar samt anställning. Jag kan uppfatta huvudinnehållet i korta, tydliga och enkla budskap och meddelanden.</td>
				<td>Jag kan läsa mycket korta och enkla texter. Jag kan hitta viss information jag behöver i enkelt och vardagligt material som annonser, prospekt, matsedlar och tidtabeller. Jag kan förstå korta och enkla personliga brev.</td>
				<td>Jag kan delta i samtal och rutinuppgifter som kräver ett enkelt och direkt utbyte av information om välkända ämnen och sysselsättningar. Jag kan fungera i mycket korta sociala samtal, men jag förstår i allmänhet inte tillräckligt för att själv hålla liv i samtalet.</td>
				<td>Jag kan använda en rad fraser och meningar för att med enkla medel beskriva min familj och andra människor, människors levnadsvillkor, min utbildning och mina nuvarande och tidigare arbetsuppgifter.</td>
				<td>Jag kan skriva korta, enkla meddelanden och föra enkla anteckningar. Jag kan skriva ett mycket enkelt personligt brev, t.ex. för att tacka någon för något.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Jag kan förstå huvudinnehållet i tydligt standardtal om välkända företeelser som man regelbundet stöter på i arbete, i skola, på fritid, osv. Om språket talas relativt långsamt och tydligt kan jag i stora drag förstå många radio- och TV-program om dagsaktuella frågor eller om ämnen av personligt intresse.</td>
				<td>Jag kan förstå texter som till största delen består av högfrekvent språk som hör till vardag och arbete. Jag kan förstå beskrivningar av händelser, känslor och önskemål i personliga brev.</td>
				<td>Jag kan fungera i de flesta situationer som kan uppstå vid resor i länder eller områden där språket talas. Jag kan utan förberedelser gå in i ett samtal om ämnen av personligt intresse eller med anknytning till vardagslivet, t.ex. familj, fritidsintressen, arbete, resor och aktuella händelser.</td>
				<td>Jag kan binda samman fraser på ett enkelt sätt för att beskriva erfarenheter och händelser, mina drömmar, förhoppningar och framtidsplaner. Jag kan kortfattat ge skäl och förklaringar för mina åsikter och planer. Jag kan berätta en historia eller återberätta händelseförloppet i en bok eller film och beskriva mina intryck.</td>
				<td>Jag kan skriva enkel, sammanhängande text om ämnen som är välkända för mig eller av personligt intresse. Jag kan skriva personliga brev som beskriver upplevelser och intryck.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Jag kan förstå längre framställningar i t.ex. föreläsningar samt följa med i mer komplicerad argumentation, dock under förutsättning att ämnet är någorlunda bekant. Jag kan förstå det mesta i nyheter och aktuella program på TV. Jag kan förstå de flesta filmer där det talas standardspråk.</td>
				<td>Jag kan läsa artiklar och rapporter som behandlar aktuella problem och som uttrycker attityder och åsikter. Jag kan förstå samtida litterär prosa.</td>
				<td>Jag kan samtala och diskutera så pass flytande och ledigt att jag kan umgås med infödda på ett naturligt sätt. Jag kan ta aktiv del i diskussioner om välkända ämnen och förklara och försvara mina åsikter.</td>
				<td>Jag kan klart och detaljerat beskriva förhållanden inom mina intresse- och erfarenhetsområden. Jag kan förklara en ståndpunkt och ange för- och nackdelar med olika alternativ.</td>
				<td>Jag kan skriva klar och detaljerad text inom mina intresseområden. Jag kan skriva en uppsats eller rapport som förmedlar information eller ger skäl för eller emot en viss ståndpunkt. Jag kan skriva brev som framhäver den personliga innebörden av händelser och erfarenheter.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Jag kan förstå mer utvecklat språk även när det inte är klart strukturerat och sammanhanget enbart antyds utan att klart uttryckas. Jag kan förstå TV-program och filmer utan alltför stor ansträngning.</td>
				<td>Jag kan förstå långa och komplicerade faktatexter liksom litterära texter och jag uppfattar skillnader i stil. Jag kan förstå fackartiklar och längre instruktioner även inom områden som ligger utanför mina intressen och erfarenheter.</td>
				<td>Jag kan uttrycka mig flytande och spontant utan att alltför tydligt söka efter rätt uttryck. Jag kan använda språket flexibelt och effektivt för sociala, intresse- och yrkesanknutna ändamål. 
Jag kan formulera idéer och åsikter med viss precision samt med viss skicklighet anpassa mig efter den person jag talar med.</td>
				<td>Jag kan klart och detaljerat beskriva komplicerade ämnesområden med sidoteman och anknytningar. Jag kan utveckla speciella aspekter samt runda av framställningen med en konsekvent slutsats.</td>
				<td>Jag kan uttrycka mig i klar och väl strukturerad text med utförligt angivna synpunkter och förklaringar. Jag kan skriva om komplicerade förhållanden i ett brev, en uppsats eller en rapport och argumentera för vad jag anser är viktigt. Jag kan välja en stil som är anpassad till den tänkte läsaren.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Jag har inga svårigheter att förstå något slags talat språk, vare sig i direktkontakt eller via radio, TV och film. Jag förstår även tal i högt tempo som det talas av en infödd under förutsättning att jag hunnit vänja mig vid den regionala variationen i språket.</td>
				<td>Jag kan utan ansträngning läsa praktiskt taget allt skrivet språk, även abstrakta texter som är strukturellt och språkligt komplicerade, t.ex. manualer, fackartiklar eller litterära verk.</td>
				<td>Jag kan utan ansträngning ta del i vilka samtal och diskussioner som helst och därvid effektivt välja vardagliga och idiomatiska uttryck. Jag kan uttrycka mig flytande och överföra nyanser med viss precision. 
Om jag ändå får svårigheter kan jag med omformuleringar kringgå dessa så smidigt att andra knappast märker det.</td>
				<td>Jag kan presentera en klar och flytande beskrivning eller argumentation som i stil passar sammanhanget. Jag kan presentera en effektiv logisk struktur som hjälper mottagaren att lägga märke till och minnas viktiga punkter.</td>
				<td>Jag kan skriva klar och flytande text i en stil som passar tillfället. Jag kan skriva komplexa brev, rapporter eller artiklar som presenterar ett ämne på ett logiskt och effektivt sätt som hjälper läsaren att lägga märke till och minnas viktiga punkter. Jag kan skriva sammanfattningar och översikter över facktexter eller litterära verk.</td>
			</tr>
	  </table>
  </xsl:template>
</xsl:stylesheet>
