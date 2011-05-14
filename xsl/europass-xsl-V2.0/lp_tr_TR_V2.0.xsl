<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_tr_TR_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_tr_TR_V2.0.xsl
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
					<span class="LabelBold">Europass Dil Pasaportu</span>
					<br/>
					<span class="Label">Avrupa Konseyi tarafından geliştirilen Avrupa Dil Portfolyosunun Parçası</span>
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
							  <xsl:text>Soyad </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Soyad</xsl:text>
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
						<xsl:with-param name="label"><xsl:text>Doğum tarihi</xsl:text></xsl:with-param>
						<xsl:with-param name="labelcontent"><xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				</xsl:if>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Ana dil(ler)</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Diğer dil(ler)</xsl:text></xsl:with-param>
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
					<td class="GridHeadingBold" colspan="10">Dil becerilerinin kişisel değerlendirmesi</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Anlama</td>
					<td class="GridHeadingBold" colspan="4">Konuşma</td>
					<td class="GridHeadingBold" colspan="2">Yazma</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Dinleme</td>
					<td class="GridHeading" colspan="2">Okuma</td>
					<td class="GridHeading" colspan="2">Karşılıklı konuşma</td>
					<td class="GridHeading" colspan="2">Sözlü anlatım</td>
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
		<xsl:if test="$element='a1'">Temel Kullanıcı</xsl:if>
		<xsl:if test="$element='b1'">Bağımsız Kullanıcı</xsl:if>
		<xsl:if test="$element='c1'">Yeterli Kullanıcı</xsl:if>
		<xsl:if test="$element='a2'">Temel Kullanıcı</xsl:if>
		<xsl:if test="$element='b2'">Bağımsız Kullanıcı</xsl:if>
		<xsl:if test="$element='c2'">Yeterli Kullanıcı</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Diploma(lar) veya sertifika(lar)</td>
			</tr>
			<tr>
				<td class="GridHeading">Diploma veya sertifika başlığı</td>
				<td class="GridHeading">Veren kurum</td>
				<td class="GridHeading">Tarih</td>
				<td class="GridHeading">Avrupa düzeyi</td>
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
				<td class="GridHeadingBold" colspan="3">Dil deneyim(ler)i</td>
			</tr>
			<tr>
				<td class="GridHeading">Açıklama</td>
				<td class="GridHeading">Başlangıç</td>
				<td class="GridHeading">Bitiş</td>
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
		(*) Işaretli kısımlar opsiyoneldir.
		(**) Işaretliler için Kişisel Değerlendirme Tablosuna bakınız.
		(***) Işaretliler için ise diplomanın ya da sertifikanın orjinalinde belirtilmişse Avrupa Ortak Ölçüt Çerçevesi (Common European Framework of Reference-CEF) düzeyini kullanın.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Açıklayıcı not</b><br/>
		Avrupa Konseyi‘nin geliştiridiği Avrupa Dil Portfolyosu’nun bir parçası olan Europass Dil Pasaportu, ulaşıla dil yeterlilik düzeyinin kaydedilmesi amacıyla Avrupa Ortak Dil Ölçütleri Çerçevesi’nin 6 aşamalı Avrupa Düzeyini kullanır.<br/>
		Europass Dil Pasaportu hakkında daha fazla bilgi için: http://europass.cedefop.europa.eu Avrupa Dil Portfolyosu hakkında daha fazla bilgi için: www.coe.int/portfolio<br/>
		Europass Dil Pasaportu şablonu yukarıda belirtilen websitelerinden ücretsiz olarak indirilebilir.<br/>
		© Avrupa Konseyi ve Avrupa Toplulukları, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">AVRUPA DÜZEYLERİ – KİŞİSEL DEĞERLENDİRME TABLOSU</th>
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
  </xsl:template>
</xsl:stylesheet>
