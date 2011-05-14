<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_de_DE_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_de_DE_V2.0.xsl
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
					<span class="LabelBold">Europass-Sprachenpass</span>
					<br/>
					<span class="Label">Bestandteil des vom Europarat entwickelten Europäischen Sprachenportfolios</span>
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
							  <xsl:text>Nachname(n) </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Nachname(n)</xsl:text>
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
						<xsl:with-param name="label"><xsl:text>Geburtsdatum</xsl:text></xsl:with-param>
						<xsl:with-param name="labelcontent"><xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				</xsl:if>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Muttersprache(n)</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Sonstige Sprache(n)</xsl:text></xsl:with-param>
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
					<td class="GridHeadingBold" colspan="10">Selbstbeurteilung der Sprachkenntnisse</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Verstehen</td>
					<td class="GridHeadingBold" colspan="4">Sprechen</td>
					<td class="GridHeadingBold" colspan="2">Schreiben</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Hören</td>
					<td class="GridHeading" colspan="2">Lesen</td>
					<td class="GridHeading" colspan="2">An Gesprächen teilnehmen</td>
					<td class="GridHeading" colspan="2">Zusammenhängendes Sprechen</td>
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
		<xsl:if test="$element='a1'">Elementare Sprachverwendung</xsl:if>
		<xsl:if test="$element='b1'">Selbstständige Sprachverwendung</xsl:if>
		<xsl:if test="$element='c1'">Kompetente Sprachverwendung</xsl:if>
		<xsl:if test="$element='a2'">Elementare Sprachverwendung</xsl:if>
		<xsl:if test="$element='b2'">Selbstständige Sprachverwendung</xsl:if>
		<xsl:if test="$element='c2'">Kompetente Sprachverwendung</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Diplom(e) oder Zertifikat(e)</td>
			</tr>
			<tr>
				<td class="GridHeading">Bezeichnung des (der) Diplome(s) oder Zertifikate(s)</td>
				<td class="GridHeading">Ausstellende Stelle</td>
				<td class="GridHeading">Datum</td>
				<td class="GridHeading">Europ. Kompetenzstufe</td>
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
				<td class="GridHeadingBold" colspan="3">Sprachliche Erfahrung(en)</td>
			</tr>
			<tr>
				<td class="GridHeading">Beschreibung</td>
				<td class="GridHeading">Von</td>
				<td class="GridHeading">Bis</td>
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
		(*)Angaben zu den mit einem Sternchen versehenen Rubriken sind freiwillig.
		(**)Siehe Raster zur Selbstbeurteilung auf der Rückseite.
		(***)Kompetenzstufe des gemeinsamen europäischen Referenzrahmens, sofern auf dem Originalzertifikat oder -diplom angegeben.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Erläuterung</b><br/>
		Der Europass-Sprachenpass ist Teil des vom Europarat entwickelten Europäischen Sprachenportfolios. Er erfasst und dokumentiert das Niveau der Sprachkenntnisse des Passinhabers in einem normierten Standardformat unter Verwendung der 6 Kompetenzstufen des gemeinsamen europäischen Referenzrahmens für Sprachen.<br/>
		Weitere Informationen zum Europass-Sprachenpass: http://europass.cedefop.europa.eu - Weitere Informationen zum Europäischen Sprachenportfolio: www.coe.int/portfolio<br/>
		Das Formular für den Europass-Sprachenpass lässt sich von den oben genannten Websites kostenlos herunterladen.<br/>
		© Europarat und Europäischen Gemeinschaften, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">Europäische Kompetenzstufen – Raster Zur Selbstbeurteilung</th>
			</tr>
			<tr class="level">
				<th>A1</th>
				<td>Ich kann vertraute Wörter und ganz einfache Sätze verstehen, die sich auf mich selbst, meine Familie oder auf konkrete Dinge um mich herum beziehen, vorausgesetzt es wird langsam und deutlich gesprochen.</td>
				<td>Ich kann einzelne vertraute Namen, Wörter und ganz einfache Sätze verstehen, z. B. auf Schildern, Plakaten oder in Katalogen.</td>
				<td>Ich kann mich auf einfache Art verständigen, wenn mein Gesprächspartner bereit ist, etwas langsamer zu wiederholen oder anders zu sagen, und mir dabei hilft zu formulieren, was ich zu sagen versuche. Ich kann einfache Fragen stellen und beantworten, sofern es sich um unmittelbar notwendige Dinge und um sehr vertraute Themen handelt.</td>
				<td>Ich kann einfache Wendungen und Sätze gebrauchen, um Leute, die ich kenne, zu beschreiben und um zu beschreiben, wo ich wohne.</td>
				<td>Ich kann eine kurze einfache Postkarte schreiben, z. B. Feriengrüsse. Ich kann auf Formularen, z. B. in Hotels, Namen, Adresse, Nationalität usw. eintragen.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Ich kann einzelne Sätze und die gebräuchlichsten Wörter verstehen, wenn es um für mich wichtige Dinge geht (z. B. sehr einfache Informationen zur Person und zur Familie, Einkaufen, Arbeit, nähere Umgebung). Ich verstehe das Wesentliche von kurzen, klaren und einfachen Mitteilungen und Durchsagen.</td>
				<td>Ich kann ganz kurze, einfache Texte lesen. Ich kann in einfachen Alltagstexten (z. B. Anzeigen, Prospekten, Speisekarten oder Fahrplänen) konkrete, vorhersehbare Informationen auffinden und ich kann kurze, einfache persönliche Briefe verstehen.</td>
				<td>Ich kann mich in einfachen, routinemässigen Situationen verständigen, in denen es um einen einfachen, direkten Austausch von Informationen und um vertraute Themen und Tätigkeiten geht. Ich kann ein sehr kurzes Kontaktgespräch führen, verstehe aber normalerweise nicht genug, um selbst das Gespräch in Gang zu halten.</td>
				<td>Ich kann mit einer Reihe von Sätzen und mit einfachen Mitteln z. B. meine Familie, andere Leute, meine Wohnsituation meine Ausbildung und meine gegenwärtige oder letzte berufliche Tätigkeit beschreiben.</td>
				<td>Ich kann kurze, einfache Notizen und Mitteilungen schreiben. Ich kann einen ganz einfachen persönlichen Brief schreiben, z. B. um mich für etwas zu bedanken.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Ich kann die Hauptpunkte verstehen, wenn klare Standardsprache verwendet wird und wenn es um vertraute Dinge aus Arbeit, Schule, Freizeit usw. geht. Ich kann vielen Radio- oder Fernsehsendungen über aktuelle Ereignisse und über Themen aus meinem Berufs- oder Interessengebiet die Hauptinformation entnehmen, wenn relativ langsam und deutlich gesprochen wird.</td>
				<td>Ich kann Texte verstehen, in denen vor allem sehr gebräuchliche Alltags oder Berufssprache vorkommt. Ich kann private Briefe verstehen, in denen von Ereignissen, Gefühlen und Wünschen berichtet wird.</td>
				<td>Ich kann die meisten Situationen bewältigen, denen man auf Reisen im Sprachgebiet begegnet. Ich kann ohne Vorbereitung an Gesprächen über Themen teilnehmen, die mir vertraut sind, die mich persönlich interessieren oder die sich auf Themen des Alltags wie Familie, Hobbys, Arbeit, Reisen, aktuelle Ereignisse beziehen.</td>
				<td>Ich kann in einfachen zusammenhängenden Sätzen sprechen, um Erfahrungen und Ereignisse oder meine Träume, Hoffnungen und Ziele zu beschreiben. Ich kann kurz meine Meinungen und Pläne erklären und begründen. Ich kann eine Geschichte erzählen oder die Handlung eines Buches oder Films wiedergeben und meine Reaktionen beschreiben.</td>
				<td>Ich kann über Themen, die mir vertraut sind oder mich persönlich interessieren, einfache zusammenhängende Texte schreiben. Ich kann persönliche Briefe schreiben und darin von Erfahrungen und Eindrücken berichten.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Ich kann längere Redebeiträge und Vorträge verstehen und auch komplexer Argumentation folgen, wenn mir das Thema einigermassen vertraut ist. Ich kann im Fernsehen die meisten Nachrichtensendungen und aktuellen Reportagen verstehen. Ich kann die meisten Spielfilme verstehen, sofern Standardsprache gesprochen wird.</td>
				<td>Ich kann Artikel und Berichte über Probleme der Gegenwart lesen und verstehen, in denen die Schreibenden eine bestimmte Haltung oder einen bestimmten Standpunkt vertreten. Ich kann zeitgenössische literarische Prosatexte verstehen.</td>
				<td>Ich kann mich so spontan und fliessend verständigen, dass ein normales Gespräch mit einem Muttersprachler recht gut möglich ist. Ich kann mich in vertrauten Situationen aktiv an einer Diskussion beteiligen und meine Ansichten begründen und verteidigen.</td>
				<td>Ich kann zu vielen Themen aus meinen Interessengebieten eine klare und detaillierte Darstellung geben. Ich kann einen Standpunkt zu einer aktuellen Frage erläutern und Vor- und Nachteile verschiedener Möglichkeiten angeben.</td>
				<td>Ich kann über eine Vielzahl von Themen, die mich interessieren, klare und detaillierte Texte schreiben. Ich kann in einem Aufsatz oder Bericht Informationen wiedergeben oder Argumente und Gegenargumente für oder gegen einen bestimmten Standpunkt darlegen. Ich kann Briefe schreiben und darin die persönliche Bedeutung von Ereignissen und Erfahrungen deutlich machen.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Ich kann längeren Redebeiträgen folgen, auch wenn diese nicht klar strukturiert sind und wenn Zusammenhänge nicht explizit ausgedrückt sind. Ich kann ohne allzu grosse Mühe Fernsehsendungen und Spielfilme verstehen.</td>
				<td>Ich kann lange, komplexe Sachtexte und literarische Texte verstehen und Stilunterschiede wahrnehmen. Ich kann Fachartikel und längere technische Anleitungen verstehen, auch wenn sie nicht in meinem Fachgebiet liegen.</td>
				<td>Ich kann mich spontan und fliessend ausdrücken, ohne öfter deutlich erkennbar nach Worten suchen zu müssen. Ich kann die Sprache im gesellschaftlichen und beruflichen Leben wirksam und flexibel gebrauchen. Ich kann meine Gedanken und Meinungen präzise ausdrücken und meine eigenen Beiträge geschickt mit denen anderer verknüpfen.</td>
				<td>Ich kann komplexe Sachverhalte ausführlich darstellen und dabei Themenpunkte miteinander verbinden, bestimmte Aspekte besonders ausführen und meinen Beitrag angemessen abschliessen.</td>
				<td>Ich kann mich schriftlich klar und gut strukturiert ausdrücken und meine Ansicht ausführlich darstellen. Ich kann in Briefen, Aufsätzen oder Berichten über komplexe Sachverhalte schreiben und die für mich wesentlichen Aspekte hervorheben. Ich kann in meinen schriftlichen Texten den Stil wählen, der für die jeweiligen Leser angemessen ist.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Ich habe keinerlei Schwierigkeit, gesprochene Sprache zu verstehen, gleichgültig ob "live" oder in den Medien, und zwar auch, wenn schnell gesprochen wird. Ich brauche nur etwas Zeit, mich an einen besonderen Akzent zu gewöhnen.</td>
				<td>Ich kann praktisch jede Art von geschriebenen Texten mühelos lesen, auch wenn sie abstrakt oder inhaltlich und sprachlich komplex sind, z. B. Handbücher, Fachartikel und literarische Werke.</td>
				<td>Ich kann mich mühelos an allen Gesprächen und Diskussionen beteiligen und bin auch mit Redewendungen und umgangssprachlichen Wendungen gut vertraut. Ich kann fliessend sprechen und auch feinere Bedeutungsnuancen genau ausdrücken. Bei Ausdrucksschwierigkeiten kann ich so reibungslos wieder ansetzen und umformulieren, dass man es kaum merkt.</td>
				<td>Ich kann Sachverhalte klar, flüssig und im Stil der jeweiligen Situation angemessen darstellen und erörtern; ich kann meine Darstellung logisch aufbauen und es so den Zuhörern erleichtern, wichtige Punkte zu erkennen und sich diese zu merken.</td>
				<td>Ich kann klar, flüssig und stilistisch dem jeweiligen Zweck angemessen schreiben. Ich kann anspruchsvolle Briefe und komplexe Berichte oder Artikel verfassen, die einen Sachverhalt gut strukturiert darstellen und so dem Leser helfen, wichtige Punkte zu erkennen und sich diese zu merken. Ich kann Fachtexte und literarische Werke schriftlich zusammenfassen und besprechen.</td>
			</tr>
	  </table>
  </xsl:template>
</xsl:stylesheet>
