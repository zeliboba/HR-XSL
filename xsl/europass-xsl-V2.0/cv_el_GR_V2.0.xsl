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
  # Name      : cv_el_GR_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass CV in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/cv_el_GR_V2.0.xsl
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
		<td class="Title"><xsl:text>Βιογραφικό σημείωμα</xsl:text><br/><xsl:text>Europass</xsl:text></td>
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
		<xsl:with-param name="heading"><xsl:text>Προσωπικές πληροφορίες</xsl:text></xsl:with-param>
		<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="labelHeadingRow">
		<xsl:with-param name="label">
			<xsl:choose>
				<xsl:when test="$firstNameBefore=0">
				  <xsl:text>Επώνυμο (-α) Όνομα (-τα)</xsl:text>
				</xsl:when>
				<xsl:otherwise>
				  <xsl:text>Όνομα (-τα) Επώνυμο (-α)</xsl:text>
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
			<xsl:with-param name="label"><xsl:text>Διεύθυνση (-εις)</xsl:text></xsl:with-param>
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
				<xsl:with-param name="label1"><xsl:text>Τηλέφωνο (-α)</xsl:text></xsl:with-param>
				<xsl:with-param name="label1content"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/telephone" /></xsl:with-param>
				<xsl:with-param name="label2"><xsl:text>Κινητό</xsl:text></xsl:with-param>
				<xsl:with-param name="label2content"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/mobile" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="//field[@name='step1.telephone' and @keep='true'] and //field[@name='step1.mobile' and @keep='false'] ">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Τηλέφωνο (-α)</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/telephone" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="//field[@name='step1.telephone' and @keep='false'] and //field[@name='step1.mobile' and @keep='true'] ">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Κινητό</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/mobile" /></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise></xsl:otherwise>
	</xsl:choose>
	<xsl:if test="//field[@name='step1.fax' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Φαξ</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/fax" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.email' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Διεύθυνση (-εις) ηλεκτρονικού ταχυδρομείου</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/identification/contactinfo/email" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.nationality' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Υπηκοότητα</xsl:text></xsl:with-param>
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
			<xsl:with-param name="label"><xsl:text>Ημερομηνία γέννησης</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">
				<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:if test="//field[@name='step1.gender' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Φύλο</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">
				<xsl:if test="europass:learnerinfo/identification/demographics/gender='M'"><xsl:text>Άρρεν</xsl:text></xsl:if>
			  <xsl:if test="europass:learnerinfo/identification/demographics/gender='F'"><xsl:text>Θήλυ</xsl:text></xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>
<xsl:template name="application">
	<xsl:if test="//field[@name='step1.application.label' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Επιθυμητή θέση εργασίας / τομέας απασχόλησης</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent"><xsl:value-of select="europass:learnerinfo/application/label" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>	
</xsl:template>
<xsl:template name="workexperience">
	<xsl:if test="//field[@name='step3List' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Επαγγελματική πείρα</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
		</xsl:call-template>
		<xsl:for-each select="europass:learnerinfo/workexperiencelist/workexperience">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Χρονολογίες</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:call-template name="perioddates"/></xsl:with-param>
			</xsl:call-template>
			<xsl:variable name="indexedStep3"><xsl:value-of select="concat('step3List[', position()-1, ']')" /></xsl:variable>
			<xsl:if test="//field[@name=concat($indexedStep3,'.position.label') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Απασχόληση ή θέση που κατείχατε</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="position/label" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep3,'.activities') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Κύριες δραστηριότητες και αρμοδιότητες</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="activities" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep3,'.company.name') and @keep='true']">
				<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Όνομα και διεύθυνση εργοδότη</xsl:text></xsl:with-param>
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
					<xsl:with-param name="label"><xsl:text>Τύπος ή τομέας δραστηριότητας</xsl:text></xsl:with-param>
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
			<xsl:with-param name="heading"><xsl:text>Εκπαίδευση και κατάρτιση</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent">&#160;</xsl:with-param>
		</xsl:call-template>		
		<xsl:for-each select="europass:learnerinfo/educationlist/education">
			<xsl:call-template name="labelRow">
				<xsl:with-param name="label"><xsl:text>Χρονολογίες</xsl:text></xsl:with-param>
				<xsl:with-param name="labelcontent"><xsl:call-template name="perioddates"/></xsl:with-param>
			</xsl:call-template>
			<xsl:variable name="indexedStep4"><xsl:value-of select="concat('step4List[', position()-1, ']')" /></xsl:variable>
			<xsl:if test="//field[@name=concat($indexedStep4,'.title') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Τίτλος του πιστοποιητικού ή διπλώματος</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="title" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep4,'.skills') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Κύρια θέματα / επαγγελματικές δεξιότητες</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="skills" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="//field[@name=concat($indexedStep4,'.educationalOrg.name') and @keep='true']">
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Επωνυμία και είδος του οργανισμού που παρείχε την εκπαίδευση ή κατάρτιση</xsl:text></xsl:with-param>
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
					<xsl:with-param name="label"><xsl:text>Επίπεδο κατάρτισης με βάση την εθνική ή διεθνή ταξινόμηση</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="level/label" /></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="emptyLabelRow"/>
		</xsl:for-each>
	</xsl:if>
</xsl:template>
<xsl:template name="personalskillscompetences">
	<xsl:call-template name="headingRow">
		<xsl:with-param name="heading"><xsl:text>Ατομικές δεξιότητες και ικανότητες</xsl:text></xsl:with-param>
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
			<xsl:with-param name="label"><xsl:text>Μητρική (-ες) γλώσσα (-ες)</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>
<xsl:template name="foreignlanguages">
	<xsl:if test="//field[@name='step5.foreignLanguageList' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Άλλη (-ες) γλώσσα (-ες)</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent">&#160;</xsl:with-param>
		</xsl:call-template>
		<tr>
			<td class="Label"><xsl:text>Αυτοαξιολόγηση</xsl:text></td>
			<xsl:call-template name="verticalline"/>
			<td class="Heading2Center" colSpan="4"><xsl:text>Κατανόηση</xsl:text></td>
			<td class="Heading2Center" colSpan="4"><xsl:text>Ομιλία</xsl:text></td>
			<td class="Heading2Center" colSpan="2"><xsl:text>Γραφή</xsl:text></td>
			<td width="1%">&#160;</td>
		</tr>
		<tr>
			<td class="Label"><xsl:text>Ευρωπαϊκό επίπεδο</xsl:text></td>
			<xsl:call-template name="verticalline"/>
			<td class="NormalSmall" colSpan="2"><xsl:text>Προφορική</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Γραπτή (ανάγνωση)</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Επικοινωνία</xsl:text></td>
			<td class="NormalSmall" colSpan="2"><xsl:text>Προφορική έκφραση</xsl:text></td>
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
		<xsl:if test="$element='a1'">Βασικός χρήστης</xsl:if>
		<xsl:if test="$element='b1'">Ανεξάρτητος χρήστης</xsl:if>
		<xsl:if test="$element='c1'">Έμπειρος χρήστης</xsl:if>
		<xsl:if test="$element='a2'">Βασικός χρήστης</xsl:if>
		<xsl:if test="$element='b2'">Ανεξάρτητος χρήστης</xsl:if>
		<xsl:if test="$element='c2'">Έμπειρος χρήστης</xsl:if>
	</td>
</xsl:template>
<xsl:template name="skills">
	<xsl:if test="//field[@name='step6.socialSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Κοινωνικές δεξιότητες και ικανότητες</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='social']" /></xsl:with-param>
		</xsl:call-template>
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.organisationalSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Οργανωτικές δεξιότητες και ικανότητες</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='organisational']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.technicalSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Τεχνικές δεξιότητες και ικανότητες</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='technical']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.computerSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Δεξιότητες πληροφορικής</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='computer']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.artisticSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Καλλιτεχνικές δεξιότητες και ικανότητες</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='artistic']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.otherSkills' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Άλλες δεξιότητες και ικανότητες</xsl:text></xsl:with-param>
			<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/skilllist/skill[@type='other']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step6.drivingLicences' and @keep='true']">
		<xsl:call-template name="labelRow">
			<xsl:with-param name="label"><xsl:text>Άδεια οδήγησης</xsl:text></xsl:with-param>
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
			<xsl:with-param name="heading"><xsl:text>Πρόσθετες πληροφορίες</xsl:text></xsl:with-param>
			<xsl:with-param name="headingcontent"><xsl:value-of select="europass:learnerinfo/misclist/misc[@type='additional']" /></xsl:with-param>
		</xsl:call-template>		
	</xsl:if>	  
	<xsl:if test="//field[@name='step7.annexes' and @keep='true']">
		<xsl:call-template name="headingRow">
			<xsl:with-param name="heading"><xsl:text>Παραρτήματα</xsl:text></xsl:with-param>
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
				<th colspan="6" class="title"><xsl:text>Ευρωπαϊκά επίπεδα - Πίνακας αυτοαξιολόγησης</xsl:text></th>
			</tr>
		<tr class="level">
				<th>A1</th>
				<td>Μπορώ να κατανοώ βασικές λέξεις και πολύ συνηθισμένες εκφράσεις σχετικά με το άτομό μου, την οικογένειά μου και το άμεσο περιβάλλον μου, με την προϋπόθεση ότι ο συνομιλητής μου μιλάει αργά και καθαρά.</td>
				<td>Μπορώ να κατανοώ λέξεις και φράσεις πολύ απλές όπως για παράδειγμα αυτές που περιέχονται σε αγγελίες, σε αφίσες και σε διαφημιστικά φυλλάδια.</td>
				<td>Μπορώ να επικοινωνώ με απλό τρόπο, με την προϋπόθεση ότι ο συνομιλητής μου θα επαναλαμβάνει ή θα επαναδιατυπώνει τις φράσεις του πιο αργά και θα με βοηθάει να εκφράσω αυτό που θέλω να πω. Μπορώ να θέτω απλές ερωτήσεις πάνω σε θέματα οικεία ή άμεσης προτεραιότητας και να δίνω ανάλογες απαντήσεις.</td>
				<td>Μπορώ να χρησιμοποιώ απλές εκφράσεις για να περιγράψω την κατοικία μου και τους ανθρώπους που γνωρίζω.</td>
				<td>Μπορώ να γράφω σε μια καρτ ποστάλ ένα σύντομο μήνυμα με απλά λόγια (π.χ. τους χαιρετισμούς σε κάποιον κατά τη διάρκεια των διακοπών μου). Μπορώ να συμπληρώνω τα προσωπικά μου στοιχεία (όνομα, εθνικότητα, διεύθυνση) σ’ ένα ερωτηματολόγιο, όπως για παράδειγμα σε ένα έντυπο ξενοδοχείου.</td>
			</tr>
			<tr class="level">
				<th>A2</th>
				<td>Μπορώ να κατανοώ εκφράσεις εκτός κειμένου και λέξεις που χρησιμοποιούνται πολύ συχνά και αφορούν το άτομό μου, την οικογένειά μου αγορές, εργασία ή το άμεσο περιβάλλον μου. Μπορώ επίσης να κατανοώ το νόημα ενός απλού, σαφούς και σύντομου μηνύματος.</td>
				<td>Μπορώ να διαβάζω ένα πολύ απλό και σύντομο κείμενο, να βρίσκω μια συγκεκριμένη πληροφορία σε συνοπτικά κείμενα όπως μικρές αγγελίες, διαφημιστικά φυλλάδια, καταλόγους εστιατορίων, έντυπα με ωράρια αφίξεων και αναχωρήσεων μέσων μαζικής μεταφοράς. Μπορώ επίσης να κατανοώ μια σύντομη και απλή προσωπική επιστολή.</td>
				<td>Μπορώ να επικοινωνώ σε καθημερινές περιστάσεις όπου χρειάζεται να ανταλλάσσω απλές πληροφορίες για δραστηριότητες και θέματα οικεία. Μπορώ να έχω πολύ σύντομες συνομιλίες, ακόμη και αν σε γενικές γραμμές δεν καταλαβαίνω αρκετά για να παρακολουθήσω μια συζήτηση.</td>
				<td>Μπορώ να χρησιμοποιώ απλές προτάσεις για να περιγράψω την οικογένειά μου, τους άλλους ανθρώπους, την κατάρτισή μου, την τωρινή ή πρόσφατη επαγγελματική μου ενασχόληση.</td>
				<td>Μπορώ να γράφω σημειώσεις και μηνύματα με απλό και σύντομο τρόπο. Μπορώ να γράφω μια πολύ απλή προσωπική επιστολή όπως για παράδειγμα για να εκφράσω τις ευχαριστίες μου σε κάποιον.</td>
			</tr>
			<tr class="level">
				<th>B1</th>
				<td>Μπορώ να κατανοώ τα κύρια σημεία μιας συζήτησης, με την προϋπόθεση ότι η γλώσσα που χρησιμοποιείται είναι απλή και σαφής και τα θέματα της συζήτησης οικεία, όπως για παράδειγμα εργασία, σχολείο, καθημερινές δραστηριότητες κ.λπ. Μπορώ να κατανοώ το κεντρικό θέμα ραδιοφωνικών και τηλεοπτικών εκπομπών, εάν αυτό παρουσιάζει ενδιαφέρον για μένα και οι συνομιλητές μιλούν αργά και καθαρά.</td>
				<td>Μπορώ να κατανοώ κείμενα που είναι γραμμένα στην καθομιλουμένη ή σε γλώσσα σχετική με τη δουλειά μου. Μπορώ να κατανοώ την περιγραφή ενός γεγονότος, ή την έκφραση συναισθημάτων και ευχών σε μια προσωπική επιστολή.</td>
				<td>Μπορώ να αντεπεξέρχομαι λεκτικά στις περισσότερες καταστάσεις που είναι δυνατόν να συναντήσει κανείς όταν ταξιδεύει στο εξωτερικό. Μπορώ να συμμετέχω χωρίς προετοιμασία σε μια συζήτηση πάνω σε θέματα οικεία ή με προσωπικό ενδιαφέρον ή με αναφορές στην καθημερινή ζωή (όπως για παράδειγμα οικογένεια, προσωπικές ασχολίες, εργασία, ταξίδια, επικαιρότητα).</td>
				<td>Μπορώ να χειρίζομαι με απλό τρόπο εκφράσεις προκειμένου να περιγράψω εμπειρίες, γεγονότα, όνειρα, τις ελπίδες, τους στόχους μου. Μπορώ να εκφράζω με συντομία τις απόψεις και τα σχέδιά μου. Μπορώ να διηγούμαι την πλοκή μιας κινηματογραφικής ταινίας και να περιγράφω τις αντιδράσεις μου.</td>
				<td>Μπορώ να γράφω ένα απλό και δομημένο κείμενο πάνω σε θέματα οικεία ή με προσωπικό ενδιαφέρον. Μπορώ να γράφω προσωπικές επιστολές για να διηγηθώ εμπειρίες και εντυπώσεις.</td>
			</tr>
			<tr class="level">
				<th>B2</th>
				<td>Μπορώ να κατανοώ διαλέξεις με σύνθετη επιχειρηματολογία, εάν το θέμα είναι αρκετά οικείο. Μπορώ να κατανοώ το μεγαλύτερο μέρος των τηλεοπτικών δελτίων ειδήσεων και των ντοκιμαντέρ. Μπορώ να κατανοώ τις περισσότερες κινηματογραφικές ταινίες αν η γλώσσα είναι η καθομιλουμένη.</td>
				<td>Μπορώ να διαβάζω άρθρα και συνεντεύξεις που εκφράζουν προσωπικές θέσεις και απόψεις .Μπορώ να κατανοώ ένα σύγχρονο λογοτεχνικό κείμενο σε πρόζα.</td>
				<td>Μπορώ να επικοινωνώ με αυθορμητισμό και άνεση, ώστε η συζήτηση να εκτυλίσσεται με ομαλό τρόπο. Μπορώ να συμμετέχω ενεργά σε μια συζήτηση υπό κανονικές συνθήκες, να εκθέτω και να υπερασπίζομαι τις απόψεις μου.</td>
				<td>Μπορώ να εκφράζομαι με σαφή και λεπτομερή τρόπο πάνω σε θέματα που άπτονται των ενδιαφερόντων μου. Μπορώ να αναπτύσσω την άποψή μου σε ένα θέμα της επικαιρότητας και να εξηγώ τα προτερήματα και τα μειονεκτήματα των διαφορετικών προσεγγίσεων στο θέμα.</td>
				<td>Μπορώ να γράφω κείμενο σαφές και λεπτομερές πάνω σε μια μεγάλη ποικιλία θεμάτων σχετικών με τα ενδιαφέροντά μου. Μπορώ να γράφω μια μελέτη ή μια αναφορά μεταφέροντας μια πληροφορία ή εκθέτοντας ένα επιχείρημα το οποίο υποστηρίζει ή αντικρούει τη συγκεκριμένη άποψη. Μπορώ να γράφω προσωπικές ή επίσημες επιστολές που αποδίδουν με λεπτές αποχρώσεις προσωπικά γεγονότα και εμπειρίες.</td>
			</tr>
			<tr class="level">
				<th>C1</th>
				<td>Μπορώ να κατανοώ μια μακροσκελή συζήτηση, ακόμη και αν δεν είναι καλά δομημένη και οι ιδέες δεν είναι σαφείς. Μπορώ να κατανοώ τηλεοπτικές εκπομπές και κινηματογραφικές ταινίες χωρίς ιδιαίτερη προσπάθεια.</td>
				<td>Μπορώ να κατανοώ λογοτεχνικά ή μη κείμενα μακροσκελή και πολύπλοκα και να αντιλαμβάνομαι τις διαφορές του ύφους. Μπορώ να κατανοώ εξειδικευμένα άρθρα και μακροσκελείς τεχνικές οδηγίες, ακόμη και αν δεν είναι σχετικές με την ειδικότητά μου.</td>
				<td>Μπορώ να εκφράζομαι αυθόρμητα και με συνεχή λόγο χωρίς να ψάχνω να βρω τις κατάλληλες λέξεις. Μπορώ να χρησιμοποιώ τη γλώσσα αβίαστα και αποτελεσματικά σε κοινωνικές και επαγγελματικές σχέσεις. 
Μπορώ να εκφράζω τις ιδέες και τις απόψεις μου με ακρίβεια και να συνδέω τις παρεμβάσεις μου με αυτές των συνομιλητών μου.</td>
				<td>Μπορώ να παρουσιάζω με σαφείς και περιεκτικές περιγραφές ένα πολύπλοκο θέμα, συνδέοντας τις επιμέρους έννοιες, αναπτύσσοντας τα κύρια σημεία και ολοκληρώνοντας τις παρεμβάσεις μου με προσωπικό τρόπο.</td>
				<td>Μπορώ να εκφράζομαι αναπτύσσοντας τις απόψεις μου μέσα από ένα κείμενο σαφές και καλά δομημένο. Μπορώ να γράφω μια επιστολή, μια μελέτη, μια αναφορά αναπτύσσοντας ένα πολύπλοκο θέμα και τονίζοντας τα σπουδαιότερα σημεία του. Μπορώ να υιοθετήσω ένα ύφος προσαρμοσμένο στις ανάγκες εκφώνησης του λόγου μου.</td>
			</tr>
			<tr class="level">
				<th>C2</th>
				<td>Δεν έχω καμία δυσκολία να κατανοώ τον προφορικό λόγο είτε σε συνθήκες άμεσης επικοινωνίας είτε όταν αυτός εκφέρεται από τα μέσα μαζικής ενημέρωσης ακόμη και εάν οι άλλοι μιλούν γρήγορα, αρκεί να υπάρχει ο χρόνος για να εξοικειωθώ με μια συγκεκριμένη ιδιόλεκτο.</td>
				<td>Μπορώ να διαβάζω χωρίς προσπάθεια και να εμβαθύνω σε κάθε είδος κειμένου, όπως για παράδειγμα ένα εγχειρίδιο, ένα εξειδικευμένο άρθρο ή ένα λογοτεχνικό έργο.</td>
				<td>Μπορώ να συμμετέχω χωρίς προσπάθεια σε κάθε συζήτηση και να έχω άνεση με τις ιδιωματικές και τις καθημερινές εκφράσεις. Μπορώ να εκφράζω με ευχέρεια και με ακρίβεια τις λεπτές αποχρώσεις των εννοιών. 
Μπορώ να αντεπεξέρχομαι σε μια εννοιολογική δυσκολία με τρόπο που να μη γίνει κατανοητό από το συνομιλητή μου.</td>
				<td>Μπορώ να κάνω μια περιγραφή ή να αναπτύσσω μια επιχειρηματολογία με σαφή και ρέοντα λόγο και με ύφος προσαρμοσμένο στις περιστάσεις δομώντας μια παρουσίαση με λογικό τρόπο και βοηθώντας τους ακροατές μου να υπογραμμίζουν και να ανακαλούν στη μνήμη τους τα κύρια σημεία.</td>
				<td>Μπορώ να γράφω ένα σαφές κείμενο με ροή και ύφος προσαρμοσμένο στις περιστάσεις. Μπορώ να συντάσσω επιστολές, αναφορές ή πολύπλοκα άρθρα με δομή σαφή που να επιτρέπουν στον αναγνώστη να αντιλαμβάνεται και να απομνημονεύει τα κύρια σημεία. Μπορώ να παρουσιάζω περιληπτικά και με κριτικό τρόπο μια εργασία επαγγελματική ή ένα λογοτεχνικό έργο.</td>
			</tr>
		</table>
	</xsl:if>
</xsl:template>
</xsl:stylesheet>
