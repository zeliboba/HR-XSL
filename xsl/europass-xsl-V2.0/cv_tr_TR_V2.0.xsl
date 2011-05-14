<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : cv_tr_TR_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass CV in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/cv_tr_TR_V2.0.xsl
</xsl:comment>
<xsl:variable name="step3Before">
	<xsl:choose>
		<xsl:when test="//field[@name='step3List' and @before='step4List']">1</xsl:when>
		<xsl:when test="//field[@name='step4List' and @before='step3List']">0</xsl:when>
	</xsl:choose>
</xsl:variable>
<html>
  <head>
    <title>CV - HTML</title>
    <link href="http://europass.cedefop.europa.eu/instruments/css/html.css" type="text/css" rel="stylesheet"/>
  </head>
	<body>
		<table width="700" border="0" cellspacing="0" cellpadding="0" class="CV">
		  <xsl:call-template name="logoheader"/>
		  <xsl:call-template name="personalinformation"/>
		  <xsl:call-template name="application"/>
		  <xsl:choose>
			<xsl:when test="$step3Before=1">
				<xsl:call-template name="workexperience"/>
				<xsl:call-template name="educationalexperience"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="educationalexperience"/>				
				<xsl:call-template name="workexperience"/>
			</xsl:otherwise>
		  </xsl:choose>
		  <xsl:call-template name="personalskillscompetences" />
		  <xsl:call-template name="annexes"/>
		</table>
		<br/>
		<xsl:call-template name="grid"/>
	</body>
</html>
</xsl:template>
<xsl:template name="logoheader">
	<tr>
		<td><img src="http://europass.cedefop.europa.eu/instruments/images/logospace.gif" height="1" width="190"/></td>
		<td><img src="http://europass.cedefop.europa.eu/instruments/images/logospace.gif" height="1" width="7"/></td>
		<td><img src="http://europass.cedefop.europa.eu/instruments/images/logospace.gif" height="1" width="8"/></td>
		<td colspan="11"><img src="http://europass.cedefop.europa.eu/instruments/images/logospace.gif" height="1" width="495"/></td>
	</tr>
	<tr>
		<td class="Logo" rowspan="2">&#160;</td>
		<td style="height:42px;">&#160;</td>
		<td colspan="12" rowspan="2">&#160;</td>
	</tr>
	<tr>
		<td class="Corner">&#160;</td>
	</tr>
	<xsl:call-template name="headingRow">
		<xsl:with-param name="heading">&#160;</xsl:with-param>
		<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
	</xsl:call-template>
	<tr>
		<td class="Title"><xsl:text>Europass</xsl:text><br/><xsl:text>Özgeçmiş</xsl:text></td>
		<xsl:call-template name="verticalline"/>
		<td class="Normal" colSpan="11">&#160;</td>
	</tr>
	<xsl:call-template name="headingRow">
		<xsl:with-param name="heading">&#160;</xsl:with-param>
		<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
	</xsl:call-template>
</xsl:template>
<xsl:template name="personalinformation">
	<xsl:variable name="firstNameBefore">
		<xsl:choose>
		  <xsl:when test="//field[@name='step1.firstName' and @before='step1.lastName']">1</xsl:when>
		  <xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:call-template name="headingRow">
		<xsl:with-param name="heading"><xsl:text>Kişisel bilgiler</xsl:text></xsl:with-param>
		<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="labelHeadingRow">
		<xsl:with-param name="label">
			<xsl:choose>
				<xsl:when test="$firstNameBefore=0">
				  <xsl:text>Soyad Ad</xsl:text>
				</xsl:when>
				<xsl:otherwise>
				  <xsl:text>Ad Soyad</xsl:text>
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
	<xsl:if test="//field[@name='step1.addressInfo' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Adres</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">
				<xsl:for-each select="europass:learnerinfo/identification/contactinfo/address/addressLine">
				<xsl:value-of select="current()" /><br/>
			  </xsl:for-each>
			  <xsl:if test="string-length(europass:learnerinfo/identification/contactinfo/address/postalCode) != 0">
			  <xsl:value-of select="europass:learnerinfo/identification/contactinfo/address/postalCode" />, </xsl:if>
			  <xsl:value-of select="europass:learnerinfo/identification/contactinfo/address/municipality" />
			  <xsl:if test="string-length(europass:learnerinfo/identification/contactinfo/address/country/label) != 0"> (<xsl:value-of select="europass:learnerinfo/identification/contactinfo/address/country/label" />)</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:choose>
		<xsl:when test="//field[@name='step1.telephone' and @keep='true'] and //field[@name='step1.mobile' and @keep='true']">
			<xsl:call-template name="labelRowTwoCells">
				<xsl:with-param name="label1"><xsl:text>Telefon</xsl:text></xsl:with-param>
				<xsl:with-param name="label1content"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/telephone" /></xsl:with-param>
				<xsl:with-param name="label2"><xsl:text>İş/Ev/Cep</xsl:text></xsl:with-param>
				<xsl:with-param name="label2content"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/mobile" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="//field[@name='step1.telephone' and @keep='true'] and //field[@name='step1.mobile' and @keep='false'] ">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Telefon</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/telephone" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="//field[@name='step1.telephone' and @keep='false'] and //field[@name='step1.mobile' and @keep='true'] ">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>İş/Ev/Cep</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/mobile" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
	<xsl:if test="//field[@name='step1.fax' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Faks</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/fax" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.email' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>e-posta</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/email" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.nationality' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Uyruk</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">
				<xsl:for-each select="europass:learnerinfo/identification/demographics/nationality/label">
					<xsl:if test="position() != 1">,&#160;</xsl:if>
					<xsl:value-of select="current()"/>
				</xsl:for-each>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.birthDate' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Doğum tarihi</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">
				<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.gender' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Cinsiyet</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">
				<xsl:if test="europass:learnerinfo/identification/demographics/gender='M'"><xsl:text>Erkek</xsl:text></xsl:if>
			  <xsl:if test="europass:learnerinfo/identification/demographics/gender='F'"><xsl:text>Bayan</xsl:text></xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>
<xsl:template name="application">
	<xsl:if test="//field[@name='step1.application.label' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Talep edilen iş / mesleki alan</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent"><xsl:value-of select="europass:learnerinfo/application/label" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>	
</xsl:template>
<xsl:template name="workexperience">
	<xsl:if test="//field[@name='step3List' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>İş deneyimi</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
		</xsl:call-template>
		<xsl:for-each select="europass:learnerinfo/workexperiencelist/workexperience">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Tarihler</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:call-template name="perioddates"/></xsl:with-param>
			</xsl:call-template>
			<xsl:variable name="indexedStep3"><xsl:value-of select="concat('step3List[', position()-1, ']')" /></xsl:variable>
			<xsl:if test="//field[@name=concat($indexedStep3,'.position.label') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Meslek veya konum</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="position/label" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep3,'.activities') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Ana faaliyetler ve sorumluluklar</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="activities" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep3,'.company.name') and @keep='true']">
				<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>İşverenin adı ve adresi</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent">
					<xsl:value-of select="employer/name" />
					<xsl:if test="//field[@name=concat($indexedStep3,'.company.addressInfo') and @keep='true']">
						&#160;
						<xsl:call-template name="address">
							<xsl:with-param name="element" select="employer/address"/>
						</xsl:call-template>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep3,'.company.sector.label') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>İşletmenin veya sektörün türü</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="employer/sector/label" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="emptyLabelRow"/>
		</xsl:for-each>
	</xsl:if>
</xsl:template>
<xsl:template name="educationalexperience">
	<xsl:if test="//field[@name='step4List' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Eğitim ve öğretim</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
		</xsl:call-template>		
		<xsl:for-each select="europass:learnerinfo/educationlist/education">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Tarihler</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:call-template name="perioddates"/></xsl:with-param>
			</xsl:call-template>
			<xsl:variable name="indexedStep4"><xsl:value-of select="concat('step4List[', position()-1, ']')" /></xsl:variable>
			<xsl:if test="//field[@name=concat($indexedStep4,'.title') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Kazanılan yeterliliğin adı</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="title" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep4,'.skills') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Eğitim ve öğretim kapsamına giren temel konular / mesleki beceriler</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="skills" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep4,'.educationalOrg.name') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Eğitim ve öğretim veren kurumun adı ve türü</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent">
						<xsl:value-of select="organisation/name" />
						<xsl:if test="string-length(organisation/type) != 0"><xsl:text> (</xsl:text><xsl:value-of select="organisation/type" /><xsl:text>) </xsl:text></xsl:if>
						<xsl:if test="//field[@name=concat($indexedStep4,'.educationalOrg.addressInfo') and @keep='true']">
							&#160;
							<xsl:call-template name="address">
								<xsl:with-param name="element" select="organisation/address"/>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep4,'.level.label') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Ulusal veya uluslararası sınıflandırma düzeyi</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="level/label" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="emptyLabelRow"/>
		</xsl:for-each>
	</xsl:if>
</xsl:template>
<xsl:template name="personalskillscompetences">
	<xsl:call-template name="headingRow">
		<xsl:with-param name="heading"><xsl:text>Kişisel beceri ve yeterlilikler</xsl:text></xsl:with-param>
		<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="motherlanguages" />
	<xsl:call-template name="foreignlanguages" />
	<xsl:call-template name="emptyLabelRow"/>
	<xsl:call-template name="skills" />
</xsl:template>
<xsl:template name="motherlanguages">
	<xsl:if test="//field[@name='step5.motherLanguages' and @keep='true']">
		<xsl:call-template name="labelHeadingRow">
			<xsl:with-param name="label"><xsl:text>Ana dil(ler)</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>
<xsl:template name="foreignlanguages">
	<xsl:if test="//field[@name='step5.foreignLanguageList' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Diğer dil(ler)</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">&#160;</xsl:with-param>
		</xsl:call-template>
		<tr>
			<td class="Label"><xsl:text>Kişisel değerlendirme</xsl:text></td>
			<xsl:call-template name="verticalline"/>
			<td class="Heading2Center" colSpan="4"><xsl:text>Anlama</xsl:text></td>
			<td class="Heading2Center" colSpan="4"><xsl:text>Konuşma</xsl:text></td>
			<td class="Heading2Center" colSpan="2"><xsl:text>Yazma</xsl:text></td>
			<td width="1%">&#160;</td>
		</tr>
		<tr>
			<td class="Label"><xsl:text>Avrupa düzeyi</xsl:text></td>
			<xsl:call-template name="verticalline"/>
			<td class="NormalSmall" colSpan="2"><xsl:text>Dinleme</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Okuma</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Karşılıklı konuşma</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Sözlü anlatım</xsl:text></td>
			<td class="NormalSmall" colSpan="2">&#160;</td>
			<td width="1%">&#160;</td>
		</tr>
		<xsl:for-each select="europass:learnerinfo/languagelist/language[@xsi:type='europass:foreign']">
			<xsl:variable name="indexedLang"><xsl:value-of select="concat('step5.foreignLanguageList[', position()-1, ']')" /></xsl:variable>
			<xsl:if test="//field[@name=$indexedLang and @keep='true']">
				<tr>
					<td class="Heading1Box"><xsl:value-of select="label" /></td>
					<td class="VerticalLineBox">&#160;</td>
					<td>&#160;</td>
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
					<td width="1%">&#160;</td>
				</tr>
			</xsl:if>
		</xsl:for-each>
	</xsl:if>
</xsl:template>
<xsl:template name="selfassessmentlevel">
	<xsl:param name="element"/>
	<td class="NormalSmall" width="5%"><xsl:value-of select="$element" /></td>
	<td class="NormalSmall">
		<xsl:if test="$element='a1'">Temel Kullanıcı</xsl:if>
		<xsl:if test="$element='b1'">Bağımsız Kullanıcı</xsl:if>
		<xsl:if test="$element='c1'">Yeterli Kullanıcı</xsl:if>
		<xsl:if test="$element='a2'">Temel Kullanıcı</xsl:if>
		<xsl:if test="$element='b2'">Bağımsız Kullanıcı</xsl:if>
		<xsl:if test="$element='c2'">Yeterli Kullanıcı</xsl:if>
	</td>
</xsl:template>
<xsl:template name="skills">
	<xsl:if test="//field[@name='step6.socialSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Sosyal beceri ve yeterlilikler</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='social']" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.organisationalSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Organizasyonel beceri ve yeterlilikler</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='organisational']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.technicalSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Teknik beceri ve yeterlilikler</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='technical']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.computerSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Bilgisayar beceri ve yeterlilikleri</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='computer']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.artisticSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Sanatsal beceri ve yeterlilikler</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='artistic']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.otherSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Diğer beceri ve yeterlilikler</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='other']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.drivingLicences' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Sürücü belgesi</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">
				<xsl:for-each select="europass:learnerinfo/skilllist/structured-skill[@xsi:type='europass:driving']/drivinglicence">
					<xsl:if test="position() != 1">,&#160;</xsl:if>
					<xsl:value-of select="current()" />
				</xsl:for-each>
			</xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	 
</xsl:template>
<xsl:template name="annexes">
	<xsl:if test="//field[@name='step7.additionalInfo' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>İlave bilgi</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent"><xsl:value-of select="europass:learnerinfo/misclist/misc[@type='additional']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step7.annexes' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Ek</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent"><xsl:value-of select="europass:learnerinfo/misclist/misc[@type='annexes']" /></xsl:with-param>
		</xsl:call-template>	
	</xsl:if>
</xsl:template>
<xsl:template name="address">
	<xsl:param name="element"/>
	<xsl:for-each select="$element/addressLine">
		<xsl:value-of select="current()" /><br/>
	</xsl:for-each>
	<xsl:if test="string-length($element/postalCode) != 0"><xsl:value-of select="$element/postalCode" />, </xsl:if>
	<xsl:value-of select="$element/municipality" />
	<xsl:if test=" string-length($element/country/label) != 0"> (<xsl:value-of select="$element/country/label" />)</xsl:if>
</xsl:template>
<xsl:template name="perioddates">
	<xsl:value-of select="translate(period/from/day,'-','')" />
	<xsl:if test="string-length(period/from/day) != 0">/</xsl:if>
	<xsl:value-of select="translate(period/from/month,'-','')" />
	<xsl:if test="string-length(period/from/month) != 0">/</xsl:if>
	<xsl:value-of select="translate(period/from/year,'-','')" />
	<xsl:if test="string-length(period/to/day) != 0 or string-length(period/to/month) != 0 or string-length(period/to/year) != 0">-</xsl:if>
	<xsl:value-of select="translate(period/to/day,'-','')" />
	<xsl:if test="string-length(period/to/day) != 0">/</xsl:if>
	<xsl:value-of select="translate(period/to/month,'-','')" />
	<xsl:if test="string-length(period/to/month) != 0">/</xsl:if>
	<xsl:value-of select="translate(period/to/year,'-','')" />
</xsl:template>
<xsl:template name="labelRow">
	<xsl:param name="label"/>
	<xsl:param name="labelcontent"/>
	<tr>
		<td class="Label"><xsl:value-of select="$label"/></td>
		<xsl:call-template name="verticalline"/>
		<td class="Normal" colSpan="11"><xsl:value-of select="$labelcontent"/></td>
	</tr>
</xsl:template>
<xsl:template name="labelHeadingRow">
	<xsl:param name="label"/>
	<xsl:param name="labelcontent"/>
	<tr>
		<td class="Label"><xsl:value-of select="$label"/></td>
		<xsl:call-template name="verticalline"/>
		<td class="Heading2" colSpan="11"><xsl:value-of select="$labelcontent"/></td>
	</tr>
</xsl:template>
<xsl:template name="labelRowTwoCells">
	<xsl:param name="label1"/>
	<xsl:param name="label1content"/>
	<xsl:param name="label2"/>
	<xsl:param name="label2content"/>
	<tr>
		<td class="Label"><xsl:value-of select="$label1"/></td>
		<xsl:call-template name="verticalline"/>
		<td class="Normal" colSpan="5"><xsl:value-of select="$label1content"/></td>
		<td class="Label" width="15%" colSpan="2"><xsl:value-of select="$label2"/></td>
		<td class="Normal" colSpan="4"><xsl:value-of select="$label2content"/></td>
	</tr>
</xsl:template>
<xsl:template name="emptyLabelRow">
	<tr>
		<td class="Label">&#160;</td>
		<xsl:call-template name="verticalline"/>
		<td class="Normal" colSpan="11">&#160;</td>
	</tr>
</xsl:template>
<xsl:template name="headingRow">
	<xsl:param name="heading"/>
	<xsl:param name="headingcontent"/>
	<tr>
		<td class="Heading1"><xsl:value-of select="$heading"/></td>
		<xsl:call-template name="verticalline"/>
		<td class="Normal" colspan="11"><xsl:value-of select="$headingcontent"/></td>
	</tr>
</xsl:template>
<xsl:template name="verticalline">
	<td class="VerticalLine">&#160;</td>
	<td>&#160;</td>
</xsl:template>
<xsl:template name="grid">
	<xsl:if test="//field[@name='grid' and @keep='true']">
		<table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<td colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title"><xsl:text>AVRUPA DÜZEYLERİ – KİŞİSEL DEĞERLENDİRME TABLOSU</xsl:text></th>
			</tr>
		<tr class="level">
				<th>A1</th>
				<td>Benimle, ailemle ve yakın çevremle ilgili tanıdık sözcükleri ve çok temel kalıpları, yavaş ve net konuşulduğunda anlayabilirim.</td>
				<td>Katalog, duyuru ya da afiş gibi yazılı metinlerdeki bildik adları, sözcükleri ve çok basit tümceleri anlayabilirim.</td>
				<td>Karşımdaki kişinin söylediklerini daha yavaş bir konuşma hızında yinelemesi ve söylemek istediklerimi oluşturmada bana yardımcı olması koşuluyla, basit yoldan iletişim kurabilirim.  O anki gereksinime ya da çok bildik konulara ilişkin alanlarda basit sorular sorabilir ve cevap verebilirim.</td>
				<td>Yaşadığım yeri ve tanıdığım insanları betimlemek için basit kalıpları ve tümceleri kullanabilirim.</td>
				<td>Kısa ve basit tümcelerle kartpostal yazabilirim. Örneğin; Tatil kartpostalıyla selam göndermek gibi. Kişisel bilgi içeren formları doldurabilirim Örneğin: Otel kayıt formuna isim, uyruk ve adres yazmak gibi.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Beni doğrudan ilgilendiren konularla ilişkili kalıpları ve çok sık kullanılan sözcükleri anlayabilirim. (Örneğin; En temel kişisel ve ailevi bilgiler, alışveriş, yerel çevre, meslek). Kısa, net, basit ileti ve duyurulardaki temel düşünceyi kavrayabilirim.</td>
				<td>Kısa ve basit metinleri okuyabilirim. İlanlar, kullanım kılavuzları, mönüler ve zaman çizelgeleri gibi basit günlük metinlerdeki genel bilgileri kavrayabilir ve kısa kişisel mektupları anlayabilirim.</td>
				<td>Bildik konular ve faaliyetler hakkında doğrudan bilgi alışverişini gerektiren basit ve alışılmış işlerde iletişim kurabilirim. Genellikle konuşmayı sürdürebilecek kadar anlamasam da kısa sohbetlere katılabilirim.</td>
				<td>Basit bir dille ailemi ve diğer insanları, yaşam koşullarımı, eğitim geçmişimi ve son işimi betimlemek için bir dizi kalıp ve tümceyi kullanabilirim.</td>
				<td>Kısa, basit notlar ve iletiler yazabilirim. Teşekkür mektubu gibi çok kısa kişisel mektupları yazabilirim.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>İş, okul, boş zaman vb. ortamlarda sürekli karşılaşılan bildik konulardaki net, standart konuşmanın ana hatlarını anlayabilirim. Güncel olaylar ya da kişisel ilgi alanıma giren konularla ilgili radyo ve televizyon programlarının çoğunun ana hatlarını yavaş ve net olduğunda anlayabilirim.</td>
				<td>Meslekle ilgili ya da günlük dilde en sık kullanılan sözcükleri içeren metinleri anlayabilirim. Kişisel mektuplarda belirtilen olay, duygu ve dilekleri anlayabilirim.</td>
				<td>Dilin konuşulduğu ülkede seyahat ederken ortaya çıkabilecek bir çok durumla başa çıkabilirim. Bildik, ilgi  alanıma giren ya da günlük yaşamla ilgili (Örneğin; aile, hobi, iş, yolculuk ve güncel olaylar gibi) konularda hazırlık yapmadan konuşmalara katılabilirim.</td>
				<td>Deneyimlerimi, hayallerimi, umutlarımı, isteklerimi ve olayları betimlemek için çeşitli kalıpları yalın bir yoldan birbirinebağlayabilirim. Düşünce ve planlara ilişkin açıklamaları ve nedenleri kısaca sıralayabilirim. Bir öyküyü anlatabilirim, bir kitap ya da filmin konusunu aktarabilirim ve izlenimlerimi belirtebilirim.</td>
				<td>Bildik ya da ilgi alanıma giren konularla bağlantılı bir metin yazabilirim. Deneyim ve izlenimlerimi betimleyen kişisel mektuplar yazabilirim.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Güncel bir konu olması koşuluyla uzun konuşma ve sunumları anlayabilir, karmaşık tümcelerle yapılan tartışmaları takip edebilirim. Televizyon haberlerini ve güncel olaylara ilişkin programların çoğunu anlayabilirim. Standart dilin kullanıldığı filmlerin çoğunu anlayabilirim.</td>
				<td>Yazarların belirli tutum ya da görüşü benimsedikleri, güncel sorunlarla ilgili makaleleri ve raporları okuyabilirim. Çağdaş edebi düzyazıyı anlayabilirim. .</td>
				<td>Öğrendiğim dili anadili olarak konuşan kişilerle anlaşmayı mümkün kılacak bir akıcılık ve doğallıkla iletişim kurabilirim. Bildik konularlardaki tartışmalarda, kendi görüşlerimi açıklayıp destekleyerek etkin bir rol oynayabilirim.</td>
				<td>İlgi alanıma giren çeşitli konularda açık ve ayrıntılı bilgi verebilirim. Çeşitli seçeneklerin olumlu ve olumsuz yanlarını ortaya koyarak bir konu  hakkında görüş bildirebilirim.</td>
				<td>İlgi alanıma giren çok çeşitli konularda anlaşılır, ayrıntılı metinler yazabilirim. Belirli bir bakış açısına destek vererek  ya da karşı çıkarak bilgi sunan ve nedenler ileri süren bir kopozisyon  ya da rapor yazabilirim. Olayların ve deneyimlerin benim için taşıdıkları önemi ön plana çıkaran mektuplar yazabilirim.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Açıkça yapılandırılmamış ve ilişkiler açıkça belirtilmemiş sadece ima edilmiş olsa bile uzun konuşmaları anlayabilirim. Televizyon programlarını ve filmleri fazla zorluk çekmeden anlayabilirim.</td>
				<td>Üslup farklılıklarını da ayırt ederek uzun ve karmaşık, somut ya da edebi metinleri okuyabilir, ilgi alanımla alakalı olmasalar bile herhangi bir uzmanlık alanına giren makale ve uzun teknik bilgileri anlayabilirim.</td>
				<td>Kullanacağım sözcükleri çok fazla aramaksızın, kendimi akıcı ve doğal bir biçimde ifade edebilirim. Dili, toplumsal ve mesleki amaçlar için esnek ve etkili bir şekilde kullanabilirim. Düşünce ve fikirlerimi açık bir ifadeyle dile getirebilir ve karşımdakilerin konuşmalarıyla ilişkilendirebilirim</td>
				<td>Karmaşık konuları, alt temalarla bütünleştirerek, açık ve ayrıntılı bir biçimde betimleyebilir, belirli bakış açıları geliştirip uygun bir sonuçla konuşmamı tamamlayabilirim.</td>
				<td>Görüşlerimi ayrıntılı bir biçimde, açık ve iyi yapılandırılmış metinlerle ifade edebilirim. Bir mektup, kompozisyon ya da rapor yazabilirim.  Önemli olduğunu düşündüğüm konuları ön plana çıkararak karmaşık konularda yazabilirim. Hedef belirlediğim okuyucu kitlesine uygun bir üslup seçebilirim.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>İster canlı ister yayın ortamında olsun, hiçbir konuşma türünü anlamakta zorluk çekmem. Sadece normal anadili konuşma hızında ise, aksana alışabilmem için biraz zamana ihtiyacım olabilir.</td>
				<td>Kullanım kılavuzları, uzmanlık alanına yönelik makaleler ve yazınsal yapıtlar gibi soyut, yapısal ve dilbilgisel açıdan karmaşık hemen hemen tüm metin türlerini kolaylıkla okuyabilir ve anlayabilirim.</td>
				<td>Hiç zorlanmadan her türlü konuşma ya da tartışmaya katılabilir; deyimler ve konuşma diline ait ifadeleri anlayabilirim. Kendimi akıcı bir şekilde ifade edebilir, anlamdaki ince ayrıntıları kesin ve doğru bir biçimde vurgulayabilirim. Bir sorunla karşılaşırsam, geriye dönüp, karşımdaki insanların fark etmelerine fırsat vermeyecek bir ustalıkla ifadelerimi yeniden yapılandırabilirim.</td>
				<td>Her konuda bağlama uygun bir üslupla ve dinleyenin önemli noktaları ayırt edip anımsamasına yardımcı olacak şekilde konuşmamı etkili ve mantıksal bir şekilde yapılandırabilir, açık, akıcı bir betimleme ya da karşıt görüş sunabilirim.</td>
				<td>Uygun bir üslup açık, akıcı metinler yazabilirim. Okuyucunun önemli noktaları ayırt edip anımsamasına yardımcı olacak etkili, mantıksal bir yapılandırmayla bir durum ortaya koyan karmaşık mektuplar, raporlar ya da makaleler yazabilirim. Meslekî ya da edebî yapıt özetleri ve eleştirileri yazabilirim.</td>
			</tr>
		</table>
	</xsl:if>
</xsl:template>
</xsl:stylesheet>
