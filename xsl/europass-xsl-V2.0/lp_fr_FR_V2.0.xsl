<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_fr_FR_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_fr_FR_V2.0.xsl
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
					<span class="LabelBold">Passeport de langues Europass</span>
					<br/>
					<span class="Label">Faisant partie du Portfolio européen des langues développé par le Conseil de l’Europe</span>
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
							  <xsl:text>Nom(s) </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Nom(s)</xsl:text>
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
						<xsl:with-param name="label"><xsl:text>Date de naissance</xsl:text></xsl:with-param>
						<xsl:with-param name="labelcontent"><xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				</xsl:if>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Langue(s) maternelle(s)</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Autre(s) langue(s)</xsl:text></xsl:with-param>
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
					<td class="GridHeadingBold" colspan="10">Auto-évaluation des compétences linguistiques</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Comprendre</td>
					<td class="GridHeadingBold" colspan="4">Parler</td>
					<td class="GridHeadingBold" colspan="2">Ecrire</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Ecouter</td>
					<td class="GridHeading" colspan="2">Lire</td>
					<td class="GridHeading" colspan="2">Prendre part à une conversation</td>
					<td class="GridHeading" colspan="2">S’exprimer oralement en continu</td>
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
		<xsl:if test="$element='a1'">Utilisateur élémentaire</xsl:if>
		<xsl:if test="$element='b1'">Utilisateur indépendant</xsl:if>
		<xsl:if test="$element='c1'">Utilisateur expérimenté</xsl:if>
		<xsl:if test="$element='a2'">Utilisateur élémentaire</xsl:if>
		<xsl:if test="$element='b2'">Utilisateur indépendant</xsl:if>
		<xsl:if test="$element='c2'">Utilisateur expérimenté</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Diplôme(s) ou certificat(s)</td>
			</tr>
			<tr>
				<td class="GridHeading">Intitulé(s)</td>
				<td class="GridHeading">Organisme certificateur</td>
				<td class="GridHeading">Date</td>
				<td class="GridHeading">Niveau européen</td>
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
				<td class="GridHeadingBold" colspan="3">Expérience(s) linguistique(s)</td>
			</tr>
			<tr>
				<td class="GridHeading">Description</td>
				<td class="GridHeading">De</td>
				<td class="GridHeading">Á</td>
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
		(*)Les rubriques signalées par un astérisque sont facultatives.
		(**)Voir grille d'auto-évaluation au verso.
		(***)Niveau du Cadre européen commun de référence (CECR) à préciser uniquement s'il figure sur le diplôme ou certificat.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Note explicative</b><br/>
		Le Passeport de langues Europass fait partie du Portfolio européen des langues développé par le Conseil de l'Europe. Il utilise les 6 niveaux européens du Cadre européen commun de référence pour les langues (CECR) pour la consignation standardisée des niveaux de compétence atteints en langues.<br/>
		Information sur le Passeport de langues Europass: http://europass.cedefop.europa.eu - Information sur le Portfolio européen des langues: www.coe.int/portfolio<br/>
		Le modèle du Passeport de langues Europass peut être téléchargé gratuitement à partir des sites ci-dessus.<br/>
		© Conseil de l'Europe et Communautés européennes, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">Niveaux européens - Grille d'autoévaluation</th>
			</tr>
			<tr class="level">
				<th>A1</th>
				<td>Je peux comprendre des mots familiers et des expressions très courantes au sujet de moi-même, de ma famille et de l'environnement concret et immédiat, si les gens parlent lentement et distinctement.</td>
				<td>Je peux comprendre des noms familiers, des mots ainsi que des phrases très simples, par exemple dans des annonces, des affiches ou des catalogues.</td>
				<td>Je peux communiquer, de façon simple, à condition que l'interlocuteur soit disposé à répéter ou à reformuler ses phrases plus lentement et à m'aider à formuler ce que j'essaie de dire. Je peux poser des questions simples sur des sujets familiers ou sur ce dont j’ai immédiatement besoin, ainsi que répondre à de telles questions.</td>
				<td>Je peux utiliser des expressions et des phrases simples pour décrire mon lieu d'habitation et les gens que je connais.</td>
				<td>Je peux écrire une courte carte postale simple, par exemple de vacances. Je peux porter des détails personnels dans un questionnaire, inscrire par exemple mon nom, ma nationalité et mon adresse sur une fiche d'hôtel.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Je peux comprendre des expressions et un vocabulaire très fréquent relatifs à ce qui me concerne de très près (par ex. moi-même, ma famille, les achats, l’environnement proche, le travail). Je peux saisir l'essentiel d'annonces et de messages simples et clairs.</td>
				<td>Je peux lire des textes courts très simples. Je peux trouver une information particulière prévisible dans des documents courants comme les petites publicités, les prospectus, les menus et les horaires et je peux comprendre des lettres personnelles courtes et simples.</td>
				<td>Je peux communiquer lors de tâches simples et habituelles ne demandant qu'un échange d'information simple et direct sur des sujets et des activités familiers. Je peux avoir des échanges très brefs même si, en règle générale, je ne comprends pas assez pour poursuivre une conversation.</td>
				<td>Je peux utiliser une série de phrases ou d'expressions pour décrire en termes simples ma famille et d'autres gens, mes conditions de vie, ma formation et mon activité professionnelle actuelle ou récente.</td>
				<td>Je peux écrire des notes et messages simples et courts. Je peux écrire une lettre personnelle très simple, par exemple de remerciements.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Je peux comprendre les points essentiels quand un langage clair et standard est utilisé et s’il s’agit de sujets familiers concernant le travail, l’école, les loisirs, etc. Je peux comprendre l'essentiel de nombreuses émissions de radio ou de télévision sur l'actualité ou sur des sujets qui m’intéressent à titre personnel ou professionnel si l’on parle d'une façon relativement lente et distincte.</td>
				<td>Je peux comprendre des textes rédigés essentiellement dans une langue courante ou relative à mon travail. Je peux comprendre la description d'événements, l'expression de sentiments et de souhaits dans des lettres personnelles.</td>
				<td>Je peux faire face à la majorité des situations que l'on peut rencontrer au cours d'un voyage dans une région où la langue est parlée. Je peux prendre part sans préparation à une conversation sur des sujets familiers ou d'intérêt personnel ou qui concernent la vie quotidienne (par exemple famille, loisirs, travail, voyage et actualité).</td>
				<td>Je peux articuler des expressions de manière simple afin de raconter des expériences et des événements, mes rêves, mes espoirs ou mes buts. Je peux brièvement donner les raisons et explications de mes opinions ou projets. Je peux raconter une histoire ou l'intrigue d'un livre ou d'un film et exprimer mes réactions.</td>
				<td>Je peux écrire un texte simple et cohérent sur des sujets familiers ou qui m’intéressent personnellement. Je peux écrire des lettres personnelles pour décrire expériences et impressions.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Je peux comprendre des conférences et des discours assez longs et même suivre une argumentation complexe si le sujet m'en est relativement familier. Je peux comprendre la plupart des émissions de télévision sur l'actualité et les informations. Je peux comprendre la plupart des films en langue standard.</td>
				<td>Je peux lire des articles et des rapports sur des questions contemporaines dans lesquels les auteurs adoptent une attitude particulière ou un certain point de vue. Je peux comprendre un texte littéraire contemporain en prose.</td>
				<td>Je peux communiquer avec un degré de spontanéité et d'aisance qui rende possible une interaction normale avec un locuteur natif. Je peux participer activement à une conversation dans des situations familières, présenter et défendre mes opinions.</td>
				<td>Je peux m'exprimer de façon claire et détaillée sur une grande gamme de sujets relatifs à mes centres d'intérêt. Je peux développer un point de vue sur un sujet d’actualité et expliquer les avantages et les inconvénients de différentes possibilités.</td>
				<td>Je peux écrire des textes clairs et détaillés sur une grande gamme de sujets relatifs à mes intérêts. Je peux écrire un essai ou un rapport en transmettant une information ou en exposant des raisons pour ou contre une opinion donnée. Je peux écrire des lettres qui mettent en valeur le sens que j’attribue personnellement aux événements et aux expériences.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Je peux comprendre un long discours même s'il n'est pas clairement structuré et que les articulations sont seulement implicites. Je peux comprendre les émissions de télévision et les films sans trop d'effort.</td>
				<td>Je peux comprendre des textes factuels ou littéraires longs et complexes et en apprécier les différences de style. Je peux comprendre des articles spécialisés et de longues instructions techniques même lorsqu'ils ne sont pas en relation avec mon domaine.</td>
				<td>Je peux m'exprimer spontanément et couramment sans trop apparemment devoir chercher mes mots. Je peux utiliser la langue de manière souple et efficace pour des relations sociales ou professionnelles. Je peux exprimer mes idées et opinions avec précision et lier mes interventions à celles de mes interlocuteurs.</td>
				<td>Je peux présenter des descriptions claires et détaillées de sujets complexes, en intégrant des thèmes qui leur sont liés, en développant certains points et en terminant mon intervention de façon appropriée.</td>
				<td>Je peux m'exprimer dans un texte clair et bien structuré et développer mon point de vue. Je peux écrire sur des sujets complexes dans une lettre, un essai ou un rapport, en soulignant les points que je juge importants. Je peux adopter un style adapté au destinataire.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Je n'ai aucune difficulté à comprendre le langage oral, que ce soit dans les conditions du direct ou dans les médias et quand on parle vite, à condition d'avoir du temps pour me familiariser avec un accent particulier.</td>
				<td>Je peux lire sans effort tout type de texte, même abstrait ou complexe quant au fond ou à la forme, par exemple un manuel, un article spécialisé ou une  littéraire.</td>
				<td>Je peux participer sans effort à toute conversation ou discussion et je suis aussi très à l’aise avec les expressions idiomatiques et les tournures courantes. Je peux m’exprimer couramment et exprimer avec précision de fines nuances de sens. En cas de difficulté, je peux faire marche arrière pour y remédier avec assez d'habileté et pour qu'elle passe presque inaperçue.</td>
				<td>Je peux présenter une description ou une argumentation claire et fluide dans un style adapté au contexte, construire une présentation de façon logique et aider mon auditeur à remarquer et à se rappeler les points importants.</td>
				<td>Je peux écrire un texte clair, fluide et stylistiquement adapté aux circonstances. Je peux rédiger des lettres, rapports ou articles complexes, avec une construction claire permettant au lecteur d’en saisir et de mémoriser les points importants. Je peux résumer et critiquer par écrit un ouvrage professionnel ou une œuvre littéraire.</td>
			</tr>
	  </table>
  </xsl:template>
</xsl:stylesheet>
