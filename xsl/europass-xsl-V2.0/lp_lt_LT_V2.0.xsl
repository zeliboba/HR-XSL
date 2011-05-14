<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_lt_LT_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_lt_LT_V2.0.xsl
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
					<span class="LabelBold">Europass kalbų pasas</span>
					<br/>
					<span class="Label">Europos kalbų aplanko, kurį parengė Europos Taryba, dalis</span>
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
							  <xsl:text>Pavardė (-ės) </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Pavardė (-ės)</xsl:text>
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
						<xsl:with-param name="label"><xsl:text>Gimimo data</xsl:text></xsl:with-param>
						<xsl:with-param name="labelcontent"><xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				</xsl:if>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Gimtoji kalba (-os)</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Kita kalba (-os)</xsl:text></xsl:with-param>
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
					<td class="GridHeadingBold" colspan="10">Kalbos mokėjimo įsivertinimas</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Supratimas</td>
					<td class="GridHeadingBold" colspan="4">Kalbėjimas</td>
					<td class="GridHeadingBold" colspan="2">Rašymas</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Klausymas</td>
					<td class="GridHeading" colspan="2">Skaitymas</td>
					<td class="GridHeading" colspan="2">Bendravimas žodžiu</td>
					<td class="GridHeading" colspan="2">Informacijos pateikimas žodžiu</td>
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
		<xsl:if test="$element='a1'">Pradedantis vartotojas</xsl:if>
		<xsl:if test="$element='b1'">Pažengęs vartotojas</xsl:if>
		<xsl:if test="$element='c1'">Įgudęs vartotojas</xsl:if>
		<xsl:if test="$element='a2'">Pradedantis vartotojas</xsl:if>
		<xsl:if test="$element='b2'">Pažengęs vartotojas</xsl:if>
		<xsl:if test="$element='c2'">Įgudęs vartotojas</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Diplomai ar pažymėjimai</td>
			</tr>
			<tr>
				<td class="GridHeading">Diplomo (-ų) ar pažymėjimo (-ų) pavadinimas</td>
				<td class="GridHeading">Išduodanti institucija</td>
				<td class="GridHeading">Metai</td>
				<td class="GridHeading">Europos lygmuo</td>
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
				<td class="GridHeadingBold" colspan="3">Bendravimo patirtis</td>
			</tr>
			<tr>
				<td class="GridHeading">Apibūdinimas</td>
				<td class="GridHeading">Nuo</td>
				<td class="GridHeading">Iki</td>
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
		(*)Informacija žvaigždute pažymėtose eilutėse yra neprivaloma
		(**)Žr. įsivertinimo lentelę kitame puslapyje
		(***)Lygmuo pagal Bendruosius kalbų metmenis Europoje, jei nurodyta pažymėjimo ar diplomo originale.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Paaiškinimas</b><br/>
		Europass kalbų pasas yra Europos kalbų aplanko, kurį parengė Europos Taryba, dalis. Siekiant kalbinius gebėjimus apibūdinti standartine forma, naudojama 6 Europinių lygių skalė, kuri yra pateikta dokumente "Bendrieji kalbų metmenys Europoje".<br/>
		Daugiau informacijos apie Europass kalbų pasą pateikiama adresu: http://europass.cedefop.europa.eu - Daugiau informacijos apie Europos kalbų aplanką pateikiama adresu: www.coe.int/portfolio<br/>
		Europass kalbų paso formą galima nemokamai parsisiųsti iš minėtų tinklalapių.<br/>
		© Europos Taryba ir Europos Bendrijos, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">Europos  lygmenys – įsivertinimo lentelė</th>
			</tr>
			<tr class="level">
				<th>A1</th>
				<td>Gebu suprasti žinomus žodžius ir pačias bendriausias frazes apie save, šeimą bei artimiausią aplinką, jeigu žmonės kalba lėtai ir aiškiai.</td>
				<td>Gebu suprasti įprastinius pavadinimus, žodžius ir labai paprastus sakinius, pvz., iš skelbimų, plakatų ar katalogų.</td>
				<td>Gebu bendrauti paprasta kalba, jeigu pašnekovas pasirengęs pakartoti ar perfrazuoti, pasakyti lėčiau ir padėti suformuluoti mintį. Gebu klausti ir atsakyti į paprastus klausimus apie būtiniausius poreikius arba gerai žinomus dalykus.</td>
				<td>Gebu vartoti paprastas frazes ir sakinius gyvenamajai vietai ir pažįstamiems žmonėms apibūdinti.</td>
				<td>Gebu užrašyti paprastą, trumpą tekstą ant atviruko, pvz., šventinį sveikinimą. Gebu į nustatytos formos dokumentus įrašyti asmens duomenis, pvz., viešbučio registracijos lapelyje įrašyti savo pavardę, tautybę, adresą.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Gebu suprasti frazes ir dažniausiai vartojamus žodžius, susijusius su būtiniausiomis reikmėmis, pvz.:  paprastą informaciją apie asmenį ir šeimą, apsipirkimą,  gyvenamąją vietą, įsidarbinimą. Suprantu trumpų, aiškių ir paprastų žinučių bei skelbimų prasmę.</td>
				<td>Gebu skaityti labai trumpus, paprastus tekstus. Gebu rasti specifinę, numatomą informaciją paprastuose kasdieniuose tekstuose: skelbimuose, reklaminiuose lapeliuose, meniu, tvarkaraščiuose, ir gebu suprasti trumpus, paprastus asmeninius laiškus.</td>
				<td>Gebu bendrauti atlikdamas (-a) įprastines nesudėtingas užduotis, kai reikia tiesiogiai pasikeisti informacija gerai žinomomis temomis. Gebu kalbėti trumpais sakiniais buitinėmis temomis, nors ne visada suprantu tiek, kad galėčiau palaikyti pokalbį.</td>
				<td>
	Gebu vartoti paprastų frazių ir sakinių rinkinį apibūdindamas (-a) savo šeimą ir kitus žmones, gyvenimo sąlygas, savo išsilavinimą ir dabartinį arba buvusį darbą.</td>
				<td>Gebu rašyti trumpas, paprastas pastabas ar žinutes. Gebu parašyti labai paprastą asmeninį laišką, pvz., kam nors už ką nors padėkoti.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>
	Gebu suprasti esmę, kai aiškiai kalbama bendrine kalba gerai žinomomis temomis, kuriomis tenka bendrauti darbe, mokykloje, poilsiaujant ir pan. Gebu suprasti daugelio radijo ir televizijos laidų apie kasdienius dalykus, asmeninėmis ar profesinėmis temomis esmę, kai kalbėjimo tempas santykinai lėtas, o tarimas aiškus.</td>
				<td>
	Gebu suprasti tekstus, kuriuose daug dažnai vartojamų žodžių ir gramatinių formų bei konstrukcijų, susijusių su kasdieniu gyvenimu ar darbu. Gebu suprasti įvykių, jausmų ir norų aprašymus asmeniniuose laiškuose.</td>
				<td>Gebu bendrauti daugelyje situacijų, į kurias galiu patekti keliaudamas po šalį, kurioje kalbama ta kalba. Gebu nepasirengęs įsitraukti į pokalbį žinomomis, dominančiomis arba kasdienio gyvenimo temomis, pvz., apie šeimą, pomėgius, darbą, keliones ir naujausius įvykius.</td>
				<td>Gebu paprastai sieti frazes, kad apibūdinčiau patirtį, įvykius, svajones, viltis ir siekius. Gebu trumpai pateikti nuomonių ir planų priežastis ir paaiškinimus. Gebu pasakoti arba atpasakoti knygos ar filmo siužetą, išreikšti savo požiūrį.</td>
				<td>Gebu parašyti paprastą rišlų tekstą gerai žinomomis ar dominančiomis temomis. Gebu rašyti asmeninius laiškus, apibūdinti patirtį ir įspūdžius.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>
	Gebu suprasti išplėtotą kalbą ir paskaitas bei sekti net sudėtingą samprotavimą, jeigu tema neblogai žinoma. Gebu suprasti daugumą TV žinių ir laidų apie kasdienius dalykus. Gebu suprasti daugumą filmų bendrine kalba.</td>
				<td>Gebu skaityti straipsnius ir pranešimus, kuriuose keliamos šiuolaikinės problemos, reiškiamas tam tikras rašytojo požiūris ir nuomonė. Gebu suprasti šiuolaikinę prozą.</td>
				<td>Gebu gana laisvai ir spontaniškai bendrauti, todėl galiu normaliai bendrauti su asmenimis, kuriems ta kalba yra gimtoji. Gebu aktyviai dalyvauti diskusijose, kurių kontekstas gerai žinomas, pateikti ir pagrįsti savo nuomonę.</td>
				<td>Gebu aiškiai, detaliai apibūdinti daug dalykų, susijusių su savo interesų sfera. Gebu paaiškinti požiūrį į tam tikrą sritį, pateikti įvairių nuomonių privalumus ir trūkumus.</td>
				<td>
	Gebu parašyti aiškų detalų tekstą daugeliu temų, susijusių su mano interesais. Gebu parašyti rašinį ar ataskaitą ir pateikti duomenis ar priežastis, kurios paremia ar paneigia tam tikrą požiūrį. Gebu rašyti laiškus ir pabrėžti įvykių ir patirties svarbą man.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Gebu suprasti išplėtotą kalbą, net jei jos struktūra nėra visiškai aiški, o ryšiai tik numanomi, bet nepateikiami akivaizdžiai. Gebu be didelių pastangų suprasti televizijos programas ir filmus.</td>
				<td>Gebu suprasti ilgus ir sudėtingus informacinius ar grožinės literatūros tekstus, suvokti stilių skirtumus. Gebu suprasti specializuotus straipsnius ir ilgesnes technines instrukcijas, net jei jie nesusiję su mano veiklos sritimi.</td>
				<td>Gebu bendrauti laisvai ir spontaniškai beveik neieškodamas (-a)  posakių. Gebu veiksmingai ir lanksčiai vartoti kalbą socialiniais ir profesiniais tikslais. Gebu tiksliai formuluoti idėjas ir nuomones, sumaniai susieti savo ir  pašnekovų nuomones.</td>
				<td>
	Gebu aiškiai, detaliai apibūdinti sudėtingus reiškinius, sujungti smulkesnes temas, išskirti specifinius aspektus bei apibendrinti, pateikdamas atitinkamas išvadas.</td>
				<td>
	Gebu išreikšti savo mintis aiškiais ir gerai struktūrizuotais tekstais bei gana išsamiai apibūdinti savo požiūrį. Gebu rašyti apie sudėtingus dalykus laiškuose, rašiniuose ir ataskaitose, pabrėžti, mano nuomone, svarbiausius dalykus. Gebu rašyti įvairius tekstus, atsižvelgdamas (-a) į skaitytoją.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Nesunkiai suprantu bet kokią sakytinės kalbos atmainą, tiek girdimą tiesiogiai, tiek transliuojamą, net kai kalbama natūraliai greitu tempu, jeigu turiu šiek tiek laiko priprasti prie akcento.</td>
				<td>
	Gebu lengvai skaityti beveik visų rašytinės kalbos atmainų tekstus: santraukas, struktūriškai ar kalbos atžvilgiu sudėtingus tekstus, pvz.: vadovėlius, specialybės straipsnius ar grožinės literatūros tekstus.</td>
				<td>Gebu be pastangų dalyvauti bet kuriame pokalbyje ir diskutuoti vartodamas (-a) idiomas ir šnekamosios kalbos posakius. Gebu laisvai reikšti mintis, tiksliai perteikti reikšmių atspalvius. Jei iškyla sunkumų, gebu pradėti iš naujo ir lengvai persakyti kitaip, kad pašnekovas net nepastebėtų sutrikimo.</td>
				<td>Gebu aiškiai ir sklandžiai apibūdinti ar argumentuoti, pasirinkdamas stilių, kuris atitinka situaciją ir tinkamą, logišką struktūrą, todėl pašnekovas gali pastebėti ir įsiminti svarbiausius dalykus.</td>
				<td>Gebu parašyti aiškų, sklandų tinkamo stiliaus tekstą. Gebu rašyti sudėtingus laiškus, ataskaitas ar straipsnius, kuriuose aiškiai išdėstyta tema, jie yra tinkamos, logiškos struktūros, todėl skaitytojas gali pastebėti ir įsiminti svarbiausius dalykus. Gebu rašyti specialybės ar grožinės literatūros tekstų santraukas ir apžvalgas.</td>
			</tr>
	  </table>
  </xsl:template>
</xsl:stylesheet>
