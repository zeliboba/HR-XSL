<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_pt_PT_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_pt_PT_V2.0.xsl
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
					<span class="LabelBold">Passaporte de Línguas Europass</span>
					<br/>
					<span class="Label">Parte do Portfólio Europeu de Línguas desenvolvido pelo Conselho da Europa</span>
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
							  <xsl:text>Apelido(s) </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Apelido(s)</xsl:text>
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
						<xsl:with-param name="label"><xsl:text>Data de nascimento</xsl:text></xsl:with-param>
						<xsl:with-param name="labelcontent"><xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				</xsl:if>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Língua(s) materna(s)</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Outra(s) língua(s)</xsl:text></xsl:with-param>
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
					<td class="GridHeadingBold" colspan="10">Auto-avaliação das competências linguísticas</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Compreensão</td>
					<td class="GridHeadingBold" colspan="4">Conversação</td>
					<td class="GridHeadingBold" colspan="2">Escrita</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Compreensão oral</td>
					<td class="GridHeading" colspan="2">Leitura</td>
					<td class="GridHeading" colspan="2">Interacção oral</td>
					<td class="GridHeading" colspan="2">Produção oral</td>
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
		<xsl:if test="$element='a1'">Utilizador básico</xsl:if>
		<xsl:if test="$element='b1'">Utilizador independente</xsl:if>
		<xsl:if test="$element='c1'">Utilizador avançado</xsl:if>
		<xsl:if test="$element='a2'">Utilizador básico</xsl:if>
		<xsl:if test="$element='b2'">Utilizador independente</xsl:if>
		<xsl:if test="$element='c2'">Utilizador avançado</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Diploma(s) ou certificado(s)</td>
			</tr>
			<tr>
				<td class="GridHeading">Título(s) do(s) diploma(s) ou certificado(s)</td>
				<td class="GridHeading">Organismo outorgante</td>
				<td class="GridHeading">Data</td>
				<td class="GridHeading">Nível europeu</td>
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
				<td class="GridHeadingBold" colspan="3">Experiência(s) linguística(s)</td>
			</tr>
			<tr>
				<td class="GridHeading">Descrição</td>
				<td class="GridHeading">De</td>
				<td class="GridHeading">Para</td>
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
		(*)As rubricas assinaladas com um asterisco são opcionais.
		(**)Ver grelha de auto-avaliação no verso.
		(***)O nível do Quadro Europeu Comum de Referência (CECR) deverá ser incluído apenas em caso de constar do diploma ou certificado.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Nota explicativa</b><br/>
		O Passaporte de Línguas Europass faz parte do Portfólio Europeu de Línguas desenvolvido pelo Conselho da Europa. Os 6 níveis europeus do Quadro Europeu Comum de Referência para as Línguas (CECR) destinam-se a definir, num formato normalizado, o grau de conhecimento de uma língua.<br/>
		Informações sobre o Passaporte de Línguas Europass: http://europass.cedefop.europa.eu  -  Informações sobre o Portfólio Europeu de Línguas: www.coe.int/portfolio<br/>
		O modelo do Passaporte de Línguas Europass pode ser descarregado, gratuitamente, dos sítios web acima indicados.<br/>
		© Conselho da Europa e Comunidades Europeias, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">Níveis europeus – Grelha de auto-avaliação</th>
			</tr>
			<tr class="level">
				<th>A1</th>
				<td>Sou capaz de reconhecer palavras e expressões simples de uso corrente relativas a mim próprio, à minha família e aos contextos em que estou inserido, quando me falam de forma clara e pausada.</td>
				<td>Sou capaz de compreender nomes conhecidos, palavras e frases muito simples, por exemplo, em avisos, cartazes ou folhetos.</td>
				<td>Sou capaz de comunicar de forma simples, desde que o meu interlocutor se disponha a repetir ou dizer por outras palavras, num ritmo mais lento, e me ajude a formular aquilo que eu gostaria de dizer. Sou capaz de perguntar e de responder a perguntas simples sobre assuntos conhecidos ou relativos a áreas de necessidade imediata.</td>
				<td>Sou capaz de utilizar expressões e frases simples para descrever o local onde vivo e pessoas que conheço.</td>
				<td>Sou capaz de escrever um postal simples e curto, por exemplo, na altura de férias. Sou capaz de preencher uma ficha com dados pessoais, por exemplo, num hotel, com nome, morada, nacionalidade.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Sou capaz de compreender expressões e vocabulário de uso mais frequente relacionado com aspectos de interesse pessoal como, por exemplo, família, compras, trabalho e meio em que vivo. Sou capaz de compreender o essencial de um anúncio e de mensagens simples, curtas e claras.</td>
				<td>Sou capaz de ler textos curtos e simples. Sou capaz de encontrar uma informação previsível e concreta em textos simples de uso corrente, por exemplo, anúncios, folhetos, ementas, horários. Sou capaz de compreender cartas pessoais curtas e simples.</td>
				<td>Sou capaz de comunicar em situações simples, de rotina do dia-a-dia, sobre assuntos e actividades habituais que exijam apenas uma troca de informação simples e directa. Sou capaz de participar em breves trocas de palavras, apesar de não compreender o suficiente para manter a conversa.</td>
				<td>Sou capaz de utilizar uma série de expressões e frases para falar, de forma simples, da minha família, de outras pessoas, das condições de vida, do meu percurso escolar e do meu trabalho actual ou mais recente.</td>
				<td>Sou capaz de escrever notas e mensagens curtas e simples sobre assuntos de necessidade imediata. Sou capaz de escrever uma carta pessoal muito simples, por exemplo, para agradecer alguma coisa a alguém.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Sou capaz de compreender os pontos essenciais de uma sequência falada que incida sobre assuntos correntes do trabalho, da escola, dos tempos livres, etc. Sou capaz de compreender os pontos principais de muitos programas de rádio e televisão sobre temas actuais ou assuntos de interesse pessoal ou profissional, quando o débito da fala é relativamente lento e claro.</td>
				<td>Sou capaz de compreender textos em que predomine uma linguagem corrente do dia-a-dia ou relacionada com o trabalho. Sou capaz de compreender descrições de acontecimentos, sentimentos e desejos, em cartas pessoais.</td>
				<td>Sou capaz de lidar com a maior parte das situações que podem surgir durante uma viagem a um local onde a língua é falada. Consigo entrar, sem preparação prévia, numa conversa sobre assuntos conhecidos, de interesse pessoal ou pertinentes para o dia-a-dia (por exemplo, família, passatempos, trabalho, viagens e assuntos da actualidade).</td>
				<td>Sou capaz de articular expressões de forma simples para descrever experiências e acontecimentos, sonhos, desejos e ambições. Sou capaz de explicar ou justificar opiniões e planos. Sou capaz de contar uma história, de relatar o enredo de um livro ou de um filme e de descrever as minhas reacções.</td>
				<td>Sou capaz de escrever um texto articulado de forma simples sobre assuntos conhecidos ou de interesse pessoal. Sou capaz de escrever cartas pessoais para descrever experiências e impressões.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Sou capaz de compreender exposições longas e palestras e até seguir partes mais complexas da argumentação, desde que o tema me seja relativamente familiar. Consigo compreender a maior parte dos noticiários e outros programas informativos na televisão. Sou capaz de compreender a maior parte dos filmes, desde que seja utilizada a língua padrão.</td>
				<td>Sou capaz de ler artigos e reportagens sobre assuntos contemporâneos em relação aos quais os autores adoptam determinadas atitudes ou pontos de vista particulares. Sou capaz de compreender textos literários contemporâneos em prosa.</td>
				<td>Sou capaz de conversar com a fluência e espontaneidade suficientes para tornar possível a interacção normal com falantes nativos. Posso tomar parte activa numa discussão que tenha lugar em contextos conhecidos, apresentando e defendendo os meus pontos de vista.</td>
				<td>Sou capaz de me exprimir de forma clara e pormenorizada sobre uma vasta gama de assuntos relacionados com os meus centros de interesse. Sou capaz de explicar um ponto de vista sobre um dado assunto, apresentando as vantagens e desvantagens de diferentes opções.</td>
				<td>Sou capaz de escrever um texto claro e pormenorizado sobre uma vasta gama de assuntos relacionados com os meus centros de interesse. Sou capaz de redigir um texto expositivo ou um relatório, transmitindo informação ou apresentando razões a favor ou contra um determinado ponto de vista. Consigo escrever cartas evidenciando o significado que determinados acontecimentos ou experiências têm para mim</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Sou capaz de compreender uma exposição longa, mesmo que não esteja claramente estruturada ou quando a articulação entre as ideias esteja apenas implícita. Consigo compreender programas de televisão e filmes sem grande dificuldade.</td>
				<td>Sou capaz de compreender textos longos e complexos, literários e não literários, e distinguir estilos. Sou capaz de compreender artigos especializados e instruções técnicas longas, mesmo quando não se relacionam com a minha área de conhecimento.</td>
				<td>Sou capaz de me exprimir de forma espontânea e fluente, sem dificuldade aparente em encontrar as expressões adequadas. Sou capaz de utilizar a língua de maneira flexível e eficaz para fins sociais e profissionais. Formulo ideias e opiniões com precisão e adequo o meu discurso ao dos meus interlocutores.</td>
				<td>Sou capaz de apresentar descrições claras e pormenorizadas sobre temas complexos que integrem subtemas, desenvolvendo aspectos particulares e chegando a uma conclusão apropriada.</td>
				<td>Sou capaz de me exprimir de forma clara e bem estruturada, apresentando os meus pontos de vista com um certo grau de elaboração. Sou capaz de escrever cartas, comunicações ou relatórios sobre assuntos complexos, pondo em evidência os aspectos que considero mais importantes. Sou capaz de escrever no estilo que considero apropriado para o leitor que tenho em mente.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Não tenho nenhuma dificuldade em compreender qualquer tipo de enunciado oral, tanto face a face como através dos meios de comunicação, mesmo quando se fala depressa, à velocidade dos falantes nativos, sendo apenas necessário algum tempo para me familiarizar com o sotaque.</td>
				<td>Sou capaz de ler com facilidade praticamente todas as formas de texto escrito, incluindo textos mais abstractos, linguística ou estruturalmente complexos, tais como manuais, artigos especializados e obras literárias.</td>
				<td>Sou capaz de participar sem esforço em qualquer conversa ou discussão e mesmo utilizar expressões idiomáticas e coloquiais. Sou capaz de me exprimir fluentemente e de transmitir com precisão pequenas diferenças de sentido. Sempre que tenho um problema, sou capaz de voltar atrás, contornar a dificuldade e reformular, sem que tal seja notado.</td>
				<td>Sou capaz de, sem dificuldade e fluentemente, fazer uma exposição oral ou desenvolver uma argumentação num estilo apropriado ao contexto e com uma estrutura lógica tal que ajude o meu interlocutor a identificar e a memorizar os aspectos mais importantes.</td>
				<td>Sou capaz de escrever textos num estilo fluente e apropriado. Sou capaz de redigir de forma estruturada cartas complexas, relatórios ou artigos que apresentem um caso com uma tal estrutura lógica que ajude o leitor a aperceber-se dos pontos essenciais e a memorizá‑los. Sou capaz de fazer resumos e recensões de obras literárias e de âmbito profissional.</td>
			</tr>
	  </table>
  </xsl:template>
</xsl:stylesheet>
