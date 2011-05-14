<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_is_IS_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_is_IS_V2.0.xsl
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
					<span class="LabelBold">Europass Tungumálapassi</span>
					<br/>
					<span class="Label">
	Hluti evrópsku tungumálamöppunnar sem hönnuð er af Evrópuráðinu</span>
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
							  <xsl:text>Nafn </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Nafn</xsl:text>
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
						<xsl:with-param name="label"><xsl:text>Fæðingardagur</xsl:text></xsl:with-param>
						<xsl:with-param name="labelcontent"><xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				</xsl:if>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Móðurmál (eitt eða fleiri)</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Annað/önnur tungumál</xsl:text></xsl:with-param>
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
					<td class="GridHeadingBold" colspan="10">Sjálfsmat á tungumálakunnáttu</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Skilningur</td>
					<td class="GridHeadingBold" colspan="4">Talað mál</td>
					<td class="GridHeadingBold" colspan="2">Ritun</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Hlustun</td>
					<td class="GridHeading" colspan="2">Lestur</td>
					<td class="GridHeading" colspan="2">Samskipti</td>
					<td class="GridHeading" colspan="2">Frásögn</td>
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
		<xsl:if test="$element='a1'">Lágmarkskunnátta</xsl:if>
		<xsl:if test="$element='b1'">Sjálfstæður notandi</xsl:if>
		<xsl:if test="$element='c1'">Fær notandi</xsl:if>
		<xsl:if test="$element='a2'">Lágmarkskunnátta</xsl:if>
		<xsl:if test="$element='b2'">Sjálfstæður notandi</xsl:if>
		<xsl:if test="$element='c2'">Fær notandi</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Prófskírteini og viðurkenningar</td>
			</tr>
			<tr>
				<td class="GridHeading">Nafn skírteinis(-a) eða viðenningarskjals (-skjala)</td>
				<td class="GridHeading">Útgáfustofnun</td>
				<td class="GridHeading">Ár</td>
				<td class="GridHeading">Evrópustaðall</td>
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
				<td class="GridHeadingBold" colspan="3">Tungumálareynsla</td>
			</tr>
			<tr>
				<td class="GridHeading">Lýsing</td>
				<td class="GridHeading">Frá</td>
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
		(*)Fyrirsagnir merktar stjörnu eru val
		(**)Sálfsmatið er á bakhliðinni
		(***)Þrep sameiginlegs tilvísunarramms fyrir tungumál (CEF) er tilgreint á upprunalegu skírteini eða viðurkenningarskjali<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Skýringar</b><br/>
		Europass tungumálapassinn er hluti af evrópsku tungumálamöppunni sem Evrópuráðið hefur hannað. Það byggir á 6 evrópskum þrepum sameiginlegs tilvísunarramma fyrir tungumál (CEF) sem gerður er til að skrá tungumálafærni á samhæfðu formi.<br/>
		Frekari upplýsingar um starfsmenntavegabrérfið: http://europass.cedefop.eu.int - Frekari upplýsingar um the Evrópsku tungumálamöppuna: www.coe.int/portfolio<br/>
		Hægt er að sækja Europass tungumálapassann ókeypis á fyrrnefnda vefi.<br/>
		© Evrópuráðið og Evrópusambandið, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">SJÁLFSMATSRAMMI</th>
			</tr>
			<tr class="level">
				<th>A1</th>
				<td>Ég get skilið algeng orð og einfaldar setningar um sjálfa(n) mig, fjölskyldu mína og nánasta umhverfi þegar fólk talar hægt og skýrt.</td>
				<td>Ég get lesið kunnugleg nöfn, orð og mjög einfaldar setningar, t.d. á skiltum og veggspjöldum eða í bæklingum.</td>
				<td>Ég get tekið þátt í einföldum samræðum ef hinn aðilinn er reiðubúinn að endurtaka eða umorða hluti hægt og hjálpa mér að koma orðum að því sem ég er að reyna að segja. Ég get spurt og svarað einföldum, algengum spurningum og spurningum um kunnug málefni.</td>
				<td>Ég get notað einföld orðasambönd og setningar til þess að segja frá búsetu  minni og fólki sem ég þekki.</td>
				<td>Ég get skrifað stutt, einfalt póstkort, t.d. sent stuttar kveðjur út leyfi. Ég get fyllt út eyðublöð með persónulegum upplýsingum eins og nafni, þjóðerni og heimilisfangi á skráningareyðublöðum hótela.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Ég get skilið setningar og algeng orð sem tengjast mér persónulega (t.d. persónulegar upplýsingar um mig og fjölskyldu mína, innkaup, nánasta umhverfi og atvinnu). Ég get skilið aðalatriðin í stuttum, skýrum og einföldum skilaboðum og tilkynningum</td>
				<td>Ég get lesið stutta og einfalda texta. Ég get fundið tilteknar, fyrirsjáanlegar upplýsingar í einföldu, hversdagslegu efni, t.d. í auglýsingum, kynningarbæklingum, matseðlum og tímatöflum. Ég líka lesið stutt og einföld bréf.</td>
				<td>Ég get tjáð mig um einföld og fastmótuð verkefni sem þarfnast einfaldra og beinna tjáskipta um efni sem ég þekki. Ég get átt í einföldum orðaskiptum á félagslegum vettvangi, jafnvel þótt ég skilji ekki nóg til að halda samræðum gangandi sjálf(ur).</td>
				<td>Ég get myndað nokkrar setningar til þess að lýsa fjölskyldu minni og öðru fólki á einfaldan hátt, sagt frá búsetu minni, menntun og þeirri vinnu sem ég stunda eða hef stundað.</td>
				<td>Ég get skrifað stutta minnispunkta og skilaboð. Ég get skrifað mjög einfalt bréf, t.d. þakkarbréf.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Ég get skilið aðalatriði venjulegs talmáls um efni sem ég þekki og tengjast vinnu minni, skóla, frístundum o.þ.h. Ég get skilið í grófum dráttum aðalatriði í mörgum útvarps- og sjónvarpsþáttum um málefni líðandi stundar eða efni sem tengjast mér persónulega eða faglega þegar talað er tiltölulega hægt og skýrt.</td>
				<td>Ég get lesið texta sem innihalda aðallega algeng orð úr daglegu lífi eða orðaforða sem tengist atvinnu minni. Ég skil lýsingar á atburðum, tilfinningum og óskum í persónulegum bréfum.</td>
				<td>Ég get tekist á við flestar aðstæður sem geta komið upp á ferðalagi um svæði þar sem málið er talað. Ég get óundirbúin(n) tekið þátt í samræðum um efni sem ég þekki, hef áhuga á eða tengjast daglegu lífi (t.d. fjölskyldu, áhugamálum, starfi, ferðalögum og málefnum líðandi stundar.)</td>
				<td>Ég get tengt saman orðasambönd á einfaldan hátt til þess að lýsa reynslu og atburðum, draumum mínum, væntingum og framtíðaráformum. Ég get rökstutt stuttlega og útskýrt ákvarðanir mínar og fyrirætlanir. Ég get sagt sögu eða sagt frá söguþræði í bók eða kvikmynd og lýst viðbrögðum mínum.</td>
				<td>Ég get skrifað einfaldan samfelldan texta um efni sem ég þekki eða hef áhuga á. Ég get skrifað bréf sem lýsa reynslu og hughrifum.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Ég get skilið langan málflutning og fyrirlestra, og get fylgst með frekar flóknum rökræðum ef efnið er mér kunnugt. Ég get skilið fréttir og flesta sjónvarpsþætti með fréttatengdu efni. Ég get skilið flestar kvikmyndir á stöðluðum mállýskum.</td>
				<td>Ég get lesið greinar og skýrslur sem tengjast vandamálum samtímans þar sem fram koma ákveðin viðhorf eða skoðanir. Ég skil nútíma bókmenntatexta.</td>
				<td>
	Ég get tekið þátt í samræðum af nokkru öryggi og án mikillar umhugsunar í reglulegum samskiptum við þá sem hafa málið að móðurmáli. Ég get tekið virkan þátt í umræðum um kunnugleg málefni, gert grein fyrir og haldið mínum skoðunum á lofti.</td>
				<td>
	Ég get gefið skýra, nákvæma lýsingu um ýmsum hlutum sem tengjast mínu áhugasviði. Ég get útskýrt skoðanir mínar á málefnum sem eru ofarlega á baugi og lýst bæði kostum og göllum við mismunandi valkosti.</td>
				<td>Ég get skrifað skýra, nákvæma texta um ýmis efni sem tengjast áhugasviði mínu. Ég get skrifað ritgerð eða skýrslu, komið upplýsingum á framfæri eða fært rök fyrir eða gegn ákveðnu sjónarhorni. Ég get skrifað bréf og lagt áherslu á mikilvægi ýmissa atburða og reynslu.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Ég get skilið langan málflutning jafnvel þegar talað er óskipulega og þegar samhengi er einungis gefið í skyn en ekki nákvæmlega skýrt tilgreint. Ég get skilið sjónvarpsþætti og kvikmyndir án mikilla erfiðleika.</td>
				<td>Ég get lesið langa og flókna texta og bókmenntaverk, og get greint stílbrigði. Ég get lesið sérfræðigreinar og lengri tæknileiðbeiningar, jafnvel þótt það tengist ekki mínu sérsviði.</td>
				<td>Ég get tjáð mig af öryggi og án mikillar umhugsunar eða orðaleitar. Ég get notað málið á sveigjanlegan og áhrifaríkan hátt bæði í félagslegum og faglegum tilgangi. Ég get sett fram hugmyndir mínar og skoðanir af nákvæmni og komið þeim kunnáttusamlega til annarra.</td>
				<td>Ég get gefið skýrar, nákvæmar lýsingar á flóknum málefnum í mörgum liðum, rætt ákveðin atriði og dregið saman í viðeigandi niðurstöður.</td>
				<td>Ég get tjáð mig skriflega með skýrum og vel samsettum texta af tiltekinni lengd og komið þannig ákveðinni skoðun á framfæri. Ég get skrifað um flókin efni í bréfi, ritgerð eða skýrslu og lagt áherslu á það sem ég tel vera mikilvæg málefni. Ég get valið mér ritstíl sem hentar þeim lesendahópi sem ég hef í huga.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Ég á ekki í neinum erfiðleikum með að skilja fólk hvort heldur þegar það talar eða þegar talað er í útvarpi / sjónvarpi, jafnvel þegar talað er hratt af þeim sem hafa tungumálið að móðurmáli, svo fremi sem ég hef fengið tíma til að venjast málhreimnum.</td>
				<td>
	Ég get auðveldlega lesið nánast allar gerðir skrifaðs máls, þar með talið fræðilega texta, setningafræðilega eða málfræðilega flókna texta eins og handbækur, sérfræðigreinar og bókmenntaverk.</td>
				<td>Ég get auðveldlega tekið þátt í öllum samræðum og umræðum með því að beita orðatiltækjum. Ég get tjáð mig af öryggi og komið fínni merkingartilbrigðum til skila. Ef ég lendi í vandræðum get ég farið til baka og umorðað setninguna á svo hárfínan hátt að varla sé eftir því tekið.</td>
				<td>Ég get á skýran hátt og reiprennandi gefið lýsingu á eða rökrætt á þann hátt sem hentar samhenginu og … notað málið á áhrifaríkan hátt til að hjálpa þeim sem hlustar að taka eftir og leggja mikilvæg atriði á minnið.</td>
				<td>Ég get skrifað skýran og lipran texta í ritstíl sem hæfir tilefninu. Ég get skrifað flókin bréf, skýrslur eða greinar þar sem áhrifarík uppbygging er notuð til að setja málið fram á þann hátt að það hjálpi lesandanum að taka eftir og muna aðalatriði. Ég get skrifað úrdrætti og ritdóma um sérfræðitexta eða bókmenntaverk.</td>
			</tr>
	  </table>
  </xsl:template>
</xsl:stylesheet>
