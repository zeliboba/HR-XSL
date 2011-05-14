<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_it_IT_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_it_IT_V2.0.xsl
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
					<span class="LabelBold">Passaporto delle lingue Europass</span>
					<br/>
					<span class="Label">
	Parte del Portafoglio linguistico europeo messo a punto dal Consiglio d'Europa</span>
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
							  <xsl:text>Cognome(i) </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Cognome(i)</xsl:text>
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
						<xsl:with-param name="label"><xsl:text>Data di nascita</xsl:text></xsl:with-param>
						<xsl:with-param name="labelcontent"><xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				</xsl:if>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Madrelingua(e)</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Altra(e) lingua(e)</xsl:text></xsl:with-param>
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
					<td class="GridHeadingBold" colspan="10">Autovalutazione delle competenze linguistiche</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Comprensione</td>
					<td class="GridHeadingBold" colspan="4">Parlato</td>
					<td class="GridHeadingBold" colspan="2">Scritto</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Ascolto</td>
					<td class="GridHeading" colspan="2">Lettura</td>
					<td class="GridHeading" colspan="2">Interazione</td>
					<td class="GridHeading" colspan="2">Produzione orale</td>
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
		<xsl:if test="$element='a1'">Utente base</xsl:if>
		<xsl:if test="$element='b1'">Utente autonomo</xsl:if>
		<xsl:if test="$element='c1'">Utente avanzato</xsl:if>
		<xsl:if test="$element='a2'">Utente base</xsl:if>
		<xsl:if test="$element='b2'">Utente autonomo </xsl:if>
		<xsl:if test="$element='c2'">Utente avanzato</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Diploma(i) o certificato(i)</td>
			</tr>
			<tr>
				<td class="GridHeading">Titolo del(i) diploma(i) o certificato(i)</td>
				<td class="GridHeading">Ente erogatore</td>
				<td class="GridHeading">Data</td>
				<td class="GridHeading">Livello europeo</td>
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
				<td class="GridHeadingBold" colspan="3">Esperienza(e) linguistica(che)</td>
			</tr>
			<tr>
				<td class="GridHeading">Descrizione</td>
				<td class="GridHeading">Da</td>
				<td class="GridHeading">A</td>
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
		(*)Le voci contraddistinte da un asterisco sono facoltative.
		(**)V. griglia di autovalutazione sul retro.
		(***)Il livello del Quadro europeo comune di riferimento (CEF) se specificato sul diploma originale.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Nota esplicativa</b><br/>
		Il Passaporto fa parte del Portfolio Europeo delle Lingue messo a punto dal Consiglio d'Europa. Si avvale dei 6 livelli europei del Quadro europeo comune di riferimento per le lingue (CEF) per registrare il livello di capacità linguistica raggiunto secondo un format standard.<br/>
		Per maggiori informazioni sul Passaporto Linguistico Europass: http://europass.cedefop.europa.eu - Per maggiori informazioni sul Portfolio Europeo delle Lingue: www.coe.int/portfolio<br/>
		Il modello del Passaporto Linguistico Europass può essere scaricato gratuitamente dai succitati siti web.<br/>
		© Consiglio d'Europa e Comunità europee, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">Griglia per l'autovalutazione</th>
			</tr>
			<tr class="level">
				<th>A1</th>
				<td>Riesco a riconoscere parole che mi sono familiari ed espressioni molto semplici riferite a me stesso, alla mia famiglia e al mio ambiente, purché le persone parlino lentamente e chiaramente.</td>
				<td>Riesco a capire i nomi e le persone che mi sono familiari e frasi molto semplici, per esempio quelle di annunci, cartelloni, cataloghi.</td>
				<td>Riesco a interagire in modo semplice se l’interlocutore é disposto a ripetere o a riformulare più lentamente certe cose e mi aiuta a formulare ciò che cerco di dire. Riesco a porre e a rispondere a domande semplici su argomenti molto familiari o che riguardano bisogni immediati.</td>
				<td>Riesco a usare espressioni e frasi semplici per descrivere il luogo dove abito e la gente che conosco.</td>
				<td>Riesco a scrivere una breve e semplice cartolina , ad esempio per mandare i saluti delle vacanze. Riesco a compilare moduli con dati personali scrivendo per esempio il mio nome, la nazionalità e l’indirizzo sulla scheda di registrazione di un albergo.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Riesco a capire espressioni e parole di uso molto frequente relative a ciò che mi riguarda direttamente (per esempio informazioni di base sulla mia persona e sulla mia famiglia, gli acquisti, l’ambiente circostante e il lavoro). Riesco ad afferrare l’essenziale di messaggi e annunci brevi, semplici e chiari.</td>
				<td>Riesco a leggere testi molto brevi e semplici e a trovare informazioni specifiche e prevedibili in materiale di uso quotidiano, quali pubblicità, programmi, menù e orari. Riesco a capire lettere personali semplici e brevi.</td>
				<td>Riesco a comunicare affrontando compiti semplici e di routine che richiedano solo uno scambio semplice e diretto di informazioni su argomenti e attività consuete. Riesco a partecipare a brevi conversazioni, anche se di solito non capisco abbastanza per riuscire a sostenere la conversazione.</td>
				<td>Riesco ad usare una serie di espressioni e frasi per descrivere con parole semplici la mia famiglia ed altre persone, le mie condizioni di vita, la carriera scolastica e il mio lavoro attuale o il più recente.</td>
				<td>Riesco a prendere semplici appunti e a scrivere brevi messaggi su argomenti riguardanti bisogni immediati. Riesco a scrivere una lettera personale molto semplice, per esempio per ringraziare qualcuno.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Riesco a capire gli elementi principali in un discorso chiaro in lingua standard su argomenti familiari, che affronto frequentemente al lavoro, a scuola, nel tempo libero ecc. Riesco a capire l’essenziale di molte trasmissioni radiofoniche e televisive su argomenti di attualità o temi di mio interesse personale o professionale, purché il discorso sia relativamente lento e chiaro.</td>
				<td>Riesco a capire testi scritti di uso corrente legati alla sfera quotidiana o al lavoro. Riesco a capire la descrizione di avvenimenti, di sentimenti e di desideri contenuta in lettere personali.</td>
				<td>Riesco ad affrontare molte delle situazioni che si possono presentare viaggiando in una zona dove si parla la lingua. Riesco a partecipare, senza essermi preparato, a conversazioni su argomenti familiari, di interesse personale o riguardanti la vita quotidiana ( per esempio la famiglia, gli hobby, il lavoro, i viaggi e i fatti di attualità).</td>
				<td>Riesco a descrivere, collegando semplici espressioni, esperienze ed avvenimenti, i miei sogni, le mie speranze e le mie ambizioni. Riesco a motivare e spiegare brevemente opinioni e progetti. Riesco a narrare una storia e la trama di un libro o di un film e a descrivere le mie impressioni.  .</td>
				<td>Riesco a scrivere testi semplici e coerenti su argomenti a me noti o di mio interesse. Riesco a scrivere lettere personali esponendo esperienze e impressioni.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Riesco a capire discorsi di una certa lunghezza e conferenze e a seguire argomentazioni anche complesse purché il tema mi sia relativamente familiare. Riesco a capire la maggior parte dei notiziari  e delle trasmissioni TV che riguardano fatti d’attualità e la maggior parte dei film in lingua standard.</td>
				<td>Riesco a leggere articoli e relazioni su questioni d’attualità in cui l’autore prende posizione ed esprime un punto di  vista determinato.  Riesco a comprendere un testo narrativo contemporaneo.</td>
				<td>Riesco a comunicare con un grado di spontaneità e scioltezza sufficiente per interagire in modo normale con parlanti nativi. Riesco a partecipare attivamente a una discussione in contesti familiari, esponendo e sostenendo le mie opinioni.</td>
				<td>Riesco a esprimermi in modo chiaro e articolato su una vasta gamma di argomenti che mi interessano. Riesco a esprimere un’ opinione su un argomento d’attualità, indicando vantaggi e svantaggi delle diverse opzioni.</td>
				<td>Riesco a scrivere testi chiari e articolati su un’ampia gamma di argomenti che mi interessano. Riesco a scrivere saggi e relazioni, fornendo informazioni e ragioni a favore o contro una determinata opinione. Riesco a scrivere lettere mettendo in evidenza il significato che attribuisco personalmente agli avvenimenti e alle esperienze.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Riesco a capire un discorso lungo anche se non é chiaramente strutturato e le relazioni non vengono segnalate, ma rimangono implicite. Riesco a capire senza troppo sforzo le trasmissioni televisive e i film.</td>
				<td>Riesco a capire testi letterari e informativi lunghi e complessi e so apprezzare le differenze di stile. Riesco a capire articoli specialistici e istruzioni tecniche piuttosto lunghe, anche quando non appartengono al mio settore.</td>
				<td>Riesco ad esprimermi in modo sciolto e spontaneo senza dover cercare troppo le parole. Riesco ad usare la lingua in modo flessibile ed efficace nelle relazioni sociali e professionali. Riesco a formulare idee e opinioni in modo preciso e a collegare abilmente i miei interventi con quelli di altri interlocutori.</td>
				<td>Riesco a presentare descrizioni chiare e articolate su argomenti complessi, integrandovi temi secondari, sviluppando punti specifici e concludendo il tutto in modo appropriato.</td>
				<td>Riesco a scrivere testi chiari e ben strutturati sviluppando analiticamente il mio punto di vista. Riesco a scrivere lettere, saggi e relazioni esponendo argomenti complessi, evidenziando i punti che ritengo salienti. Riesco a scegliere lo stile adatto ai lettori ai quali intendo rivolgermi.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Non ho nessuna difficoltà a capire qualsiasi  lingua parlata, sia dal vivo sia trasmessa, anche se il discorso é tenuto in modo veloce da un madrelingua, purché abbia il tempo di abituarmi all’ accento.</td>
				<td>Riesco a capire con facilità praticamente tutte le forme di lingua scritta inclusi i testi  teorici, strutturalmente o linguisticamante complessi, quali manuali, articoli specialistici e opere letterarie.</td>
				<td>Riesco a partecipare senza sforzi a qualsiasi conversazione e discussione ed ho familiarità con le espressioni idiomatiche e colloquiali. Riesco ad esprimermi con scioltezza e a rendere con precisione sottili sfumature di significato. In caso di difficoltà, riesco a ritornare sul discorso e a riformularlo in modo cosí scorrevole che difficilmente qualcuno se ne accorge.</td>
				<td>Riesco a presentare descrizioni o argomentazioni chiare e scorrevoli, in uno stile adeguato al contesto e con una struttura logica efficace, che possa aiutare il destinatario a identificare i  punti salienti da rammentare.</td>
				<td>Riesco a scrivere testi chiari, scorrevoli e stilisticamente appropriati. Riesco a scrivere lettere, relazioni e articoli complessi, supportando il contenuto con una struttura logica efficace che aiuti il destinatario a identificare i punti salienti da rammentare. Riesco a scrivere riassunti e recensioni di opere letterarie e di testi specialisti.</td>
			</tr>
	  </table>
  </xsl:template>
</xsl:stylesheet>
