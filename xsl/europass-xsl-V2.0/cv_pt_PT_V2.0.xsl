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
  # Name      : cv_pt_PT_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass CV in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/cv_pt_PT_V2.0.xsl
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
		<td class="Title"><xsl:text>Europass</xsl:text><br/><xsl:text>Curriculum Vitae</xsl:text></td>
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
		<xsl:with-param name="heading"><xsl:text>Informação pessoal</xsl:text></xsl:with-param>
		<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="labelHeadingRow">
		<xsl:with-param name="label">
			<xsl:choose>
				<xsl:when test="$firstNameBefore=0">
				  <xsl:text>Apelido(s) Nome(s) próprio(s)</xsl:text>
				</xsl:when>
				<xsl:otherwise>
				  <xsl:text>Nome(s) próprio(s) Apelido(s)</xsl:text>
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
			<xsl:with-param name="label"><xsl:text>Morada(s)</xsl:text></xsl:with-param>
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
				<xsl:with-param name="label1"><xsl:text>Telefone(s)</xsl:text></xsl:with-param>
				<xsl:with-param name="label1content"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/telephone" /></xsl:with-param>
				<xsl:with-param name="label2"><xsl:text>Telemóvel</xsl:text></xsl:with-param>
				<xsl:with-param name="label2content"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/mobile" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="//field[@name='step1.telephone' and @keep='true'] and //field[@name='step1.mobile' and @keep='false'] ">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Telefone(s)</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/telephone" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="//field[@name='step1.telephone' and @keep='false'] and //field[@name='step1.mobile' and @keep='true'] ">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Telemóvel</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/mobile" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
	<xsl:if test="//field[@name='step1.fax' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Fax(es)</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/fax" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.email' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Endereço(s) de correio electrónico</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/email" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.nationality' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Nacionalidade</xsl:text></xsl:with-param>
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
			<xsl:with-param name="label"><xsl:text>Data de nascimento</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">
				<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.gender' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Sexo</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">
				<xsl:if test="europass:learnerinfo/identification/demographics/gender='M'"><xsl:text>Masculino</xsl:text></xsl:if>
			  <xsl:if test="europass:learnerinfo/identification/demographics/gender='F'"><xsl:text>Feminino</xsl:text></xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>
<xsl:template name="application">
	<xsl:if test="//field[@name='step1.application.label' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Emprego pretendido / Área funcional</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent"><xsl:value-of select="europass:learnerinfo/application/label" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>	
</xsl:template>
<xsl:template name="workexperience">
	<xsl:if test="//field[@name='step3List' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Experiência profissional</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
		</xsl:call-template>
		<xsl:for-each select="europass:learnerinfo/workexperiencelist/workexperience">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Datas</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:call-template name="perioddates"/></xsl:with-param>
			</xsl:call-template>
			<xsl:variable name="indexedStep3"><xsl:value-of select="concat('step3List[', position()-1, ']')" /></xsl:variable>
			<xsl:if test="//field[@name=concat($indexedStep3,'.position.label') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Função ou cargo ocupado</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="position/label" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep3,'.activities') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Principais actividades e responsabilidades</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="activities" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep3,'.company.name') and @keep='true']">
				<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Nome e morada do empregador</xsl:text></xsl:with-param>
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
					<xsl:with-param name="label"><xsl:text>Tipo de empresa ou sector</xsl:text></xsl:with-param>
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
			<xsl:with-param name="heading"><xsl:text>Educação e formação</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
		</xsl:call-template>		
		<xsl:for-each select="europass:learnerinfo/educationlist/education">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Datas</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:call-template name="perioddates"/></xsl:with-param>
			</xsl:call-template>
			<xsl:variable name="indexedStep4"><xsl:value-of select="concat('step4List[', position()-1, ']')" /></xsl:variable>
			<xsl:if test="//field[@name=concat($indexedStep4,'.title') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Designação da qualificação atribuída</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="title" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep4,'.skills') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Principais disciplinas/competências profissionais</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="skills" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep4,'.educationalOrg.name') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Nome e tipo da organização de ensino ou formação</xsl:text></xsl:with-param>
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
					<xsl:with-param name="label"><xsl:text>Nível segundo a classificação nacional ou internacional</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="level/label" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="emptyLabelRow"/>
		</xsl:for-each>
	</xsl:if>
</xsl:template>
<xsl:template name="personalskillscompetences">
	<xsl:call-template name="headingRow">
		<xsl:with-param name="heading"><xsl:text>Aptidões e competências pessoais</xsl:text></xsl:with-param>
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
			<xsl:with-param name="label"><xsl:text>Primeira língua</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>
<xsl:template name="foreignlanguages">
	<xsl:if test="//field[@name='step5.foreignLanguageList' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Outra(s) língua(s)</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">&#160;</xsl:with-param>
		</xsl:call-template>
		<tr>
			<td class="Label"><xsl:text>Auto-avaliação</xsl:text></td>
			<xsl:call-template name="verticalline"/>
			<td class="Heading2Center" colSpan="4"><xsl:text>Compreensão</xsl:text></td>
			<td class="Heading2Center" colSpan="4"><xsl:text>Conversação</xsl:text></td>
			<td class="Heading2Center" colSpan="2"><xsl:text>Escrita</xsl:text></td>
			<td width="1%">&#160;</td>
		</tr>
		<tr>
			<td class="Label"><xsl:text>Nível europeu</xsl:text></td>
			<xsl:call-template name="verticalline"/>
			<td class="NormalSmall" colSpan="2"><xsl:text>Compreensão oral</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Leitura</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Interacção oral</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Produção oral</xsl:text></td>
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
		<xsl:if test="$element='a1'">Utilizador básico</xsl:if>
		<xsl:if test="$element='b1'">Utilizador independente</xsl:if>
		<xsl:if test="$element='c1'">Utilizador avançado</xsl:if>
		<xsl:if test="$element='a2'">Utilizador básico</xsl:if>
		<xsl:if test="$element='b2'">Utilizador independente</xsl:if>
		<xsl:if test="$element='c2'">Utilizador avançado</xsl:if>
	</td>
</xsl:template>
<xsl:template name="skills">
	<xsl:if test="//field[@name='step6.socialSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Aptidões e competências sociais</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='social']" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.organisationalSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Aptidões e competências de organização</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='organisational']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.technicalSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Aptidões e competências técnicas</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='technical']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.computerSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Aptidões e competências informáticas</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='computer']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.artisticSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Aptidões e competências artísticas</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='artistic']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.otherSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Outras aptidões e competências</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='other']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.drivingLicences' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Carta de condução</xsl:text></xsl:with-param>
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
			<xsl:with-param name="heading"><xsl:text>Informação adicional</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent"><xsl:value-of select="europass:learnerinfo/misclist/misc[@type='additional']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step7.annexes' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Anexos</xsl:text></xsl:with-param>
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
				<th colspan="6" class="title"><xsl:text>Níveis europeus – Grelha de auto-avaliação</xsl:text></th>
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
	</xsl:if>
</xsl:template>
</xsl:stylesheet>
