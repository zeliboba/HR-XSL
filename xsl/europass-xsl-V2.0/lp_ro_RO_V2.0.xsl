<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_ro_RO_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_ro_RO_V2.0.xsl
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
					<span class="LabelBold">Paşaportul Lingvistic Europass</span>
					<br/>
					<span class="Label">Parte a Portofoliului Lingvistic European elaborat de Consiliul Europei</span>
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
							  <xsl:text>Nume </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Nume</xsl:text>
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
						<xsl:with-param name="label"><xsl:text>Data naşterii</xsl:text></xsl:with-param>
						<xsl:with-param name="labelcontent"><xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				</xsl:if>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Limba(i) maternă(e)</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Limba(i) străină(e) cunoscută(e)</xsl:text></xsl:with-param>
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
					<td class="GridHeadingBold" colspan="10">Autoevaluarea abilităţilor lingvistice</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Înţelegere</td>
					<td class="GridHeadingBold" colspan="4">Vorbire</td>
					<td class="GridHeadingBold" colspan="2">Scriere</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Ascultare</td>
					<td class="GridHeading" colspan="2">Citire</td>
					<td class="GridHeading" colspan="2">Participare la conversaţie</td>
					<td class="GridHeading" colspan="2">Discurs oral</td>
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
		<xsl:if test="$element='a1'">Utilizator elementar</xsl:if>
		<xsl:if test="$element='b1'">Utilizator independent</xsl:if>
		<xsl:if test="$element='c1'">Utilizator experimentat</xsl:if>
		<xsl:if test="$element='a2'">Utilizator elementar</xsl:if>
		<xsl:if test="$element='b2'">Utilizator independent</xsl:if>
		<xsl:if test="$element='c2'">Utilizator experimentat</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Diploma(-ele) sau cetificatul(-ele)</td>
			</tr>
			<tr>
				<td class="GridHeading">Titlul diplomei(elor) sau certificatului(elor)</td>
				<td class="GridHeading">Instituţia emitentă</td>
				<td class="GridHeading">An</td>
				<td class="GridHeading">Nivel european</td>
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
				<td class="GridHeadingBold" colspan="3">Experienţa(-ele) lingvistică(-e)</td>
			</tr>
			<tr>
				<td class="GridHeading">Descriere</td>
				<td class="GridHeading">Din</td>
				<td class="GridHeading">Până în</td>
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
		(*)Rubricile marcate cu un asterisc sunt facultative
		(**)Vezi Grila de autoevaluare de pe verso
		(***)Nivel al Cadrului European Comun de Referinţă (CEF) dacă este specificat pe certificatul sau diploma în original.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Notă explicativă</b><br/>
		Paşaportul Lingvistic Europass este parte a Portofoliului Lingvistic European elaborat de Consiliul Europei. Acesta utilizează cele 6 niveluri europene ale Cadrului Comun de Referinţă pentru Limbi Străine (CEF), pentru a înregistra nivelul de stăpânire a limbii străine într-un format standard.<br/>
		Mai multe informaţii despre Paşaportul Lingvistic Europass: http://europass.cedefop.eu.int - Mai multe informaţii despre Portofoliul Lingvistic European: www.coe.int/portfolio<br/>
		Modelul paşaportului lingvistic Europass poate fi descărcat gratis de pe site-urile sus menţionate.<br/>
		© Consiliul Europei şi Comunităţile Europene, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">NIVELURI EUROPENE – GRILA DE AUTO-EVALUARE</th>
			</tr>
			<tr class="level">
				<th>A1</th>
				<td>Pot să înţeleg expresii cunoscute si propoziţii foarte simple referitoare la mine, la familie şi la împrejurări concrete, când se vorbeşte rar şi cu claritate.</td>
				<td>Pot să înţeleg nume cunoscute, cuvinte şi propoziţii foarte simple, de exemplu, din anunţuri, afişe sau cataloage.</td>
				<td>Pot să comunic într-o conversaţie simplă, cu condiţia ca interlocutorul să fie dispus să repete sau să reformuleze frazele sale într-un ritm mai lent şi să mă ajute să formulez ceea ce încerc să spun. Pot să formulez întrebări simple pe teme cunoscute sau de necesitate imediată şi să răspund la asemenea întrebări.</td>
				<td>Pot să utilizez expresii şi fraze simple pentru a descrie unde locuiesc şi oamenii pe care îi cunosc.</td>
				<td>Pot să scriu o carte poştală scurtă şi simplă, de exemplu, cu salutări din vacantă. Pot să completez formulare cu detalii personale, de exemplu, numele, naţionalitatea şi adresa mea pe un formular de hotel.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Pot să înţeleg expresii şi cuvinte uzuale frecvent întâlnite pe teme ce au relevanţă imediată pentru mine personal (de ex., informaţii simple despre mine şi familia mea, cumpărături, zona unde locuiesc , activitatea profesională). Pot să înţeleg punctele esenţiale din anunţuri şi mesaje scurte, simple şi clare.</td>
				<td>Pot să citesc texte foarte scurte şi simple. Pot să găsesc anumite informaţii previzibile în diverse materiale cotidiene (de ex., reclame, prospecte, meniuri, orare) şi pot să înţeleg scrisori personale scurte şi simple.</td>
				<td>Pot să comunic în situaţii simple şi uzuale care presupun un schimb de informaţii simplu şi direct pe teme şi despre activităţi familiare. Pot să particip la discuţii foarte scurte, chiar dacă, în general, nu înţeleg suficient pentru a întreţine o conversaţie.</td>
				<td>Pot să utilizez o serie de expresii şi fraze pentru o descriere simplă a familiei mele şi a altor persoane, a condiţiilor de viată, a studiilor şi a activităţii mele profesionale prezente sau recente.</td>
				<td>Pot să scriu  mesaje scurte şi simple. Pot să scriu o scrisoare personală foarte simplă, de exemplu, de mulţumire.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Pot să înţeleg punctele esenţiale în vorbirea standard clară pe teme familiare referitoare la activitatea profesională, scoală, petrecerea timpului liber etc. Pot să înţeleg ideea principală din multe programe radio sau TV pe teme de actualitate sau de interes personal sau profesional, dacă sunt prezentate într-o manieră relativ clară şi lentă.</td>
				<td>Pot să înţeleg texte redactate, în principal, într-un limbaj uzual sau referitor la activitatea mea profesională. Pot să înţeleg descrierea evenimentelor, exprimarea sentimentelor şi a urărilor din scrisori personale.</td>
				<td>Pot să fac faţă în majoritatea situaţiilor care pot să apară în cursul unei călătorii printr-o regiune unde este vorbită limba. Pot să particip fără pregătire prealabilă la o conversaţie pe teme familiare, de interes personal sau referitoare la viata cotidiană (de ex. familie, petrecerea timpului liber, călătoriile, activitatea profesională şi actualităţi).</td>
				<td>Pot să leg expresii şi să mă exprim coerent într-o manieră simplă pentru a descrie experienţe şi evenimente, visele mele, speranţele şi obiectivele mele. Pot să îmi argumentez şi explic pe scurt opiniile şi planurile. Pot să povestesc o întâmplare sau să relatez intriga unei cărţi sau a unui film şi să-mi exprim reacţiile.</td>
				<td>Pot să scriu un text simplu şi coerent pe teme familiare sau de interes personal. Pot să scriu scrisori personale descriind experienţe şi impresii.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Pot să înţeleg conferinţe şi discursuri destul de lungi şi să urmăresc chiar şi o argumentare complexă, dacă subiectul îmi este relativ cunoscut. Pot să înţeleg majoritatea emisiunilor TV de ştiri şi a programelor de actualităţi. Pot să înţeleg majoritatea filmelor în limbaj standard. </td>
				<td>Pot să citesc articole şi rapoarte pe teme contemporane, în care autorii adoptă anumite atitudini şi puncte de vedere. Pot să înţeleg proză literară contemporană.</td>
				<td>Pot să comunic cu un grad de spontaneitate şi de fluentă care fac posibilă participarea normală la o conversaţie cu interlocutori nativi. Pot să particip activ la o conversaţie în situaţii familiare, exprimându-mi şi susţinându-mi opiniile.</td>
				<td>Pot să prezint descrieri clare şi detaliate într-o gamă vastă de subiecte legate de domeniul meu de interes. Pot să dezvolt un punct de vedere pe o temă de actualitate, arătând avantajele şi dezavantajele diferitelor opţiuni.</td>
				<td>Pot să scriu texte clare şi detaliate într-o gamă vastă de subiecte legate de domeniul meu de interes. Pot să scriu un eseu sau un raport, transmiţând informaţii sau argumentând în favoarea sau împotriva unui punct de vedere. Pot să scriu scrisori subliniind semnificaţia pe care o atribui personal evenimentelor sau experienţelor.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Pot să înţeleg un discurs lung, chiar dacă nu este clar structurat, iar conexiunile sunt numai implicite şi nu semnalate în mod explicit. Pot să înţeleg programe de televiziune şi filme fără prea mare efort.</td>
				<td>Pot să înţeleg texte faptice şi literare lungi şi complexe, sesizând diferenţele stilistice. Pot să înţeleg articolele specializate şi instrucţiunile tehnice lungi, chiar dacă nu se referă la domeniul meu.</td>
				<td>Pot să mă exprim fluent şi spontan, fără a fi nevoie să-mi caut cuvintele în mod prea vizibil. Pot să utilizez limba în mod flexibil şi eficient în relaţii sociale şi în scopuri profesionale. Pot să-mi formulez ideile şi punctele de vedere cu precizie şi să-mi conectez intervenţiile bine de cele ale interlocutorilor mei.</td>
				<td>Pot să prezent descrieri clare şi detaliate pe teme complexe, integrând subtemele, dezvoltând anumite puncte şi terminându-mi intervenţia cu o concluzie adecvată.</td>
				<td>Pot să ms exprim prin texte clare, bine structurate, dezvoltând punctele de vedere. Pot să tratez subiecte complexe într-o scrisoare, un eseu sau un raport, subliniind aspectele pe care le consider importante. Pot să selectez un stil adecvat destinatarului.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Nu am nici o dificultate în a înţelege limba vorbită, indiferent dacă este vorba despre comunicarea directă sau în transmisiuni radio, sau TV, chiar dacă ritmul este cel rapid al vorbitorilor nativi, cu condiţia de a avea timp să  mă familiarizez cu un anumit accent.</td>
				<td>Pot să citesc cu uşurinţă orice tip de text, chiar dacă este abstract sau complex din punct de vedere lingvistic sau al structurii, de exemplu,  manuale, articole specializate şi opere literare.</td>
				<td>Pot să particip fără efort la orice conversaţie sau discuţie şi sunt familiarizat(ă) cu expresiile idiomatice şi colocviale. Pot să mă exprim fluent şi să exprim cu precizie nuanţe fine de sens. În caz de dificultate, pot să reiau ideea şi să-mi restructurez formularea cu abilitate, în aşa fel încât dificultatea să nu fie sesizată.</td>
				<td>Pot să prezint o descriere sau o argumentaţie cu claritate şi fluentă, într-un un stil adaptat contextului; cu o structură logică eficientă, care să ajute auditoriul să sesizeze şi să retină punctele semnificative.</td>
				<td>Pot să scriu texte clare, cursive, adaptate stilistic contextului. Pot să redactez scrisori, rapoarte sau articole complexe, cu o structură logică clară, care să-l ajute pe cititor să sesizeze şi să retină aspectele semnificative. Pot să redactez rezumate sau recenzii ale unor lucrări de specialitate sau opere literare.</td>
			</tr>
	  </table>
  </xsl:template>
</xsl:stylesheet>
