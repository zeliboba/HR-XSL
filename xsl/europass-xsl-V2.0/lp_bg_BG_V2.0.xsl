<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_bg_BG_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_bg_BG_V2.0.xsl
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
					<span class="LabelBold">Europass eзиков паспорт</span>
					<br/>
					<span class="Label">
	Част от Европейското езиково портфолио, разработено от Съвета на Европа</span>
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
							  <xsl:text>Фамилия(и) </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Фамилия(и)</xsl:text>
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
						<xsl:with-param name="label"><xsl:text>Дата на раждане</xsl:text></xsl:with-param>
						<xsl:with-param name="labelcontent"><xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				</xsl:if>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Майчин (и) език (езици)</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Чужд (и) език (езици)</xsl:text></xsl:with-param>
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
					<td class="GridHeadingBold" colspan="10">Самооценка на езиковите умения </td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Разбиране</td>
					<td class="GridHeadingBold" colspan="4">Говорене</td>
					<td class="GridHeadingBold" colspan="2">Писане</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Слушане</td>
					<td class="GridHeading" colspan="2">Четене</td>
					<td class="GridHeading" colspan="2">Участие в разговор</td>
					<td class="GridHeading" colspan="2">Самостоятелно устно изложение</td>
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
		<xsl:if test="$element='a1'">Основно ниво на владеене</xsl:if>
		<xsl:if test="$element='b1'">Самостоятелно ниво на владеене</xsl:if>
		<xsl:if test="$element='c1'">Свободно ниво на владеене</xsl:if>
		<xsl:if test="$element='a2'">Основно ниво на владеене</xsl:if>
		<xsl:if test="$element='b2'">Самостоятелно ниво на владеене</xsl:if>
		<xsl:if test="$element='c2'">Свободно ниво на владеене</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Диплома(и) или сертификат(и) </td>
			</tr>
			<tr>
				<td class="GridHeading">Название на диплома(и) или сертификат(и)</td>
				<td class="GridHeading">Издаваща оранизация</td>
				<td class="GridHeading">Година</td>
				<td class="GridHeading">Европейско ниво</td>
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
				<td class="GridHeadingBold" colspan="3">Езиков опит</td>
			</tr>
			<tr>
				<td class="GridHeading">Описание</td>
				<td class="GridHeading">От</td>
				<td class="GridHeading">До</td>
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
		(*)Заглавията, отбелязани със звездичка, не са задължителни за попълване.
		(**)Виж Матрицата за самооценка
		(***)Ниво според Общата Европейска езикова рамка (CEF) ако е посочено в оригиналния сертификат или диплома.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Пояснение</b><br/>
		Europass езиковият паспорт е част от езиково портфолио, разработено от Съвета на Европа. В него са използвани 6 Европейски нива на владеене според Общата Европейска езикова рамка (CEF) за определяне степента на езикова компетентност в стандартен формат.<br/>
		Повече информация за Europass езиков паспорт на адрес: http://europass.cedefop.europa.eu - Повече информация за Европейското езиково портфолио на адрес: www.coe.int/portfolio<br/>
		Формуляр за попълване на Europass езиков паспорт може да бъде изтеглен безплатно от посочените по-горе страници.<br/>
		© Европейски Общности и Съвет на Европа, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">ЕВРОПЕЙСКИ НИВА – МАТРИЦА ЗА САМООЦЕНКА</th>
			</tr>
			<tr class="level">
				<th>A1</th>
				<td>Мога да разбирам познати думи и често употребявани изрази, свързани с мен, моето семейство и конкретно непосредственото ми обкръжение, когато се говори бавно и отчетливо.</td>
				<td>Мога да разбирам познати имена, думи и съвсем прости изречения, напр. в обяви, плакати или каталози.</td>
				<td>Мога да общувам по прост начин, при условие, че събеседникът е готов да повтори или по-бавно да преформулира казаното и да ми помогне да изразя, това, което се опитвам да кажа. Мога да задавам и отговарям на прости въпроси по познати теми или за това, от което имам непосредствена нужда.</td>
				<td>Мога да използвам прости изрази и изречения, за да опиша мястото, където живея, и хората, които познавам. </td>
				<td>Мога да напиша кратък лесен текст върху пощенска картичка (напр. от почивка). Мога да попълня личните си данни във въпросник (напр. името, националността и адреса си в хотелски формуляр). </td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Мога да разбирам най-често употребявани думи и изрази, свързани с това, което най-пряко ме засяга (основна информация за мен, моето семейство, покупки, близко обкръжение, работа). Мога да схващам същественото в кратки и ясни обяви и съобщения. </td>
				<td>Мога да чета кратки и съвсем прости текстове. Мога да откривам точно определена и предвидима информация в често срещани текстове, като реклами, проспекти, менюта и разписания. Мога да разбирам кратки и лесни лични писма.</td>
				<td>Мога да общувам при изпълнението на лесни и обичайни задачи, които изискват само лесен и пряк обмен на информация по познати теми и дейности. Мога да участвам с кратки реплики, дори и да не разбирам достатъчно, за да водя като цяло последователен разговор.</td>
				<td>Мога да използвам набор от изречения или изрази, за да опиша с прости думи семейството си и други хора, условията си на живот, образованието си и настоящата си и предходна професионална дейност.</td>
				<td>Мога да пиша кратки и лесни бележки и съобщения. Мога да напиша просто лично писмо, напр. за да изразя благодарност на някого. </td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Мога да разбирам съществените моменти, когато се използва ясен и стандартен език и става дума за познати теми, свързани с работата, училището, свободното време и т.н. Мога да схвана основното от различни радио- и телевизионни предавания за актуални събития или теми, които ме интересуват лично или професионално, когато се говори сравнително бавно и отчетливо.</td>
				<td>Мога да разбирам текстове, написани предимно на всекидневен език или отнасящи се до работата ми. Мога да разбирам описания на събития, изразяване на чувства и пожелания в лични писма.</td>
				<td>Мога да се справям с повечето ситуации, в които се оказвам в страна, където се говори съответният език. Мога да участвам без предварителна подготовка в разговори по теми, които са ми познати, лично ме интересуват или се отнасят до всекидневието ми (напр. семейство, свободно време, работа, пътуване, актуални събития). </td>
				<td>Мога да се изразявам по прост начин, за да разкажа преживявания и събития, мечтите, надеждите или целите си. Мога накратко да посоча причини и да дам обяснения за мненията или намеренията си. Мога да разкажа случка, книга или филм и да изразя отношението си.</td>
				<td>Мога да напиша лесен свързан текст по теми, които са ми познати или ме интересуват лично. Мога да пиша лични писма , за да опиша преживени случки и впечатления. </td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Мога да разбирам сравнително дълга лекция или слово и дори да следя сложна аргументация, ако темата ми е относително позната. Мога да разбирам телевизионни предавания и филми без много затруднения.</td>
				<td>Мога да чета статии и доклади по съвременни теми, в които авторите изразяват особено отношение или гледна точка. Мога да разбирам съвременен художествен текст в проза.</td>
				<td>Мога да общувам с известна непринуденост и лекота, които ми позволяват нормален контакт с автентичен носител на езика. Мога да участвам активно в разговор по познати теми, да представям и защитавам мненията си. </td>
				<td>Мога да се изразявам ясно и подробно по широк кръг от теми, които съответстват на моите интереси. Мога да развия гледната си точка по актуален въпрос и да обясня предимствата и недостатъците на различни възможности. </td>
				<td>Мога да пиша ясни и подробни текстове по широк кръг от теми, които съответстват на моите интереси. Мога да напиша есе или доклад, като предавам информация или излагам причини &quot;за&quot; или &quot;против&quot; дадено мнение. Мога да пиша писма, като подчертавам смисъла, който лично придавам на събития и преживени случки.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Мога да разбирам дълга реч, дори когато не е ясно структурирана и логическите връзки не са ясно назовани. Мога да разбирам телевизионни предавания и филми без много усилия.</td>
				<td>Мога да разбирам дълги и сложни нехудожествени и художествени текстове и да преценявам стилистичните им особености. Мога да разбирам специализирани статии и дълги технически инструкции дори когато не са свързани с моята сфера на дейност.</td>
				<td>Мога да се изразявам непринудено и свободно без видимо затруднение в подбора на думите. Мога да използвам езика гъвкаво и ефикасно за социални или професионални контакти. Мога точно да изразявам идеите и мненията си и да свързвам изказванията си с тези на моите събеседници. </td>
				<td>Мога да правя ясни и подробни описания по сложни въпроси, като включвам свързани с тях теми, да развивам определени моменти и приключвам изказването си по подходящ начин. </td>
				<td>Мога да създавам ясен и добре структуриран текст и да представям гледната си точка. Мога да пиша по сложни теми в писмо, есе или доклад, като подчертавам съществените за мен моменти. Мога да избера съобразен с ответната страна стил. </td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Мога да разбирам без никакво затруднение говоримия език, както при пряко общуване, така и по медиите, и когато се говори бързо, при условие, че имам време да свикна с особеностите на произношението.</td>
				<td>Мога да чета без усилие всякакъв вид текст, дори абстрактен или сложен по съдържание или форма, напр. учебник, специализирана статия или литературна творба.</td>
				<td>Мога да участвам без усилие във всякакъв разговор или дискусия и да си служа свободно с идиоматични и разговорни изрази. Мога да се изказвам свободно и да изразявам точно нюансите на мисълта си. Ако срещна затруднение, намирам начин да изляза от ситуацията умело, така че другите да не го забележат. </td>
				<td>Мога да представя ясно и гладко описание или аргументация в съобразен с контекста стил. Мога да построя логично изказване и да помогна на слушателя да долови и запомни важните моменти. </td>
				<td>Мога да създавам ясен, гладък и стилистично съответстващ на обстоятелствата текст. Мога да пиша сложни писма, доклади или статии с ясна структура, така че читателят да схване и запомни същественото. Мога да резюмирам и анализирам професионални текстове или художествена творба. </td>
			</tr>
	  </table>
  </xsl:template>
</xsl:stylesheet>
