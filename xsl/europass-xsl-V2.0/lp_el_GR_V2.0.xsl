<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
  <!ENTITY copy   "&#169;">
]><xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:europass="http://europass.cedefop.europa.eu/Europass/V2.0">
<xsl:template match="/">
<xsl:comment>
  # © European Communities, 2002-2009 http://europass.cedefop.europa.eu
  # http://europass.cedefop.europa.eu/europass/home/botnav/LegalNotice.csp
  # Name      : lp_el_GR_V2.0.xsl
  # Version   : V2.0
  # Purpose   : Provides a way to show the Europass LP in HTML format.
  # Author(s) : Europass team
  # URL       : http://europass.cedefop.europa.eu/TechnicalResources/XML/xsl/europass-xsl-V2.0/lp_el_GR_V2.0.xsl
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
					<span class="LabelBold">Διαβατήριο γλωσσών Europass</span>
					<br/>
					<span class="Label">Τμήμα του Ευρωπαϊκού Γλωσσικού Διαβατηρίου που εκπόνησε το Συμβούλιο της Ευρώπης</span>
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
							  <xsl:text>Επώνυμο (α) </xsl:text>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:text> Επώνυμο (α)</xsl:text>
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
						<xsl:with-param name="label"><xsl:text>Ημερομηνία γέννησης</xsl:text></xsl:with-param>
						<xsl:with-param name="labelcontent"><xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 9, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 6, 2)" />/<xsl:value-of select="substring(europass:learnerinfo/identification/demographics/birthdate, 1, 4)" />
						</xsl:with-param>
					</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				</xsl:if>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Μητρική (-ές) γλώσσα (-ες)</xsl:text></xsl:with-param>
					<xsl:with-param name="labelcontent"><xsl:value-of select="europass:learnerinfo/languagelist/language[@xsi:type='europass:mother']/label" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="emptyLabelRow"/>
				<xsl:call-template name="labelRow">
					<xsl:with-param name="label"><xsl:text>Άλλη (-ες) γλώσσα (-ες)</xsl:text></xsl:with-param>
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
					<td class="GridHeadingBold" colspan="10">Αυτοαξιολόγηση γλωσσικών δεξιοτήτων</td>
				</tr>
				<tr>
					<td class="GridHeadingBold" colspan="4">Κατανόηση</td>
					<td class="GridHeadingBold" colspan="4">Ομιλία</td>
					<td class="GridHeadingBold" colspan="2">Γραφή</td>
				</tr>
				<tr>
					<td class="GridHeading" colspan="2">Προφορική</td>
					<td class="GridHeading" colspan="2">Γραπτή (ανάγνωση)</td>
					<td class="GridHeading" colspan="2">Επικοινωνία</td>
					<td class="GridHeading" colspan="2">Προφορική έκφραση</td>
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
		<xsl:if test="$element='a1'">Βασικός χρήστης</xsl:if>
		<xsl:if test="$element='b1'">Ανεξάρτητος χρήστης</xsl:if>
		<xsl:if test="$element='c1'">Έμπειρος χρήστης</xsl:if>
		<xsl:if test="$element='a2'">Βασικός χρήστης</xsl:if>
		<xsl:if test="$element='b2'">Ανεξάρτητος χρήστης</xsl:if>
		<xsl:if test="$element='c2'">Έμπειρος χρήστης</xsl:if>
	</td>
</xsl:template>
<xsl:template name="linguisticdiplomatable">
	<xsl:param name="indexedLang"/>
	<table>
		<tbody>
			<xsl:call-template name="firstlineLinguisticdiplomatable"/>
			<tr>
			  <td class="GridHeadingBold" colspan="4">Δίπλωμα (διπλώματα) ή πιστοποιητικό (α)</td>
			</tr>
			<tr>
				<td class="GridHeading">Τίτλος διπλώματος (διπλωμάτων) ή πιστοποιητικού (ών)</td>
				<td class="GridHeading">Φορέας απονομής</td>
				<td class="GridHeading">Ημερομηνία</td>
				<td class="GridHeading">Ευρωπ. επίπεδο</td>
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
				<td class="GridHeadingBold" colspan="3">Γλωσσικές εμπειρίες</td>
			</tr>
			<tr>
				<td class="GridHeading">Περιγραφή</td>
				<td class="GridHeading">Από</td>
				<td class="GridHeading">Έως</td>
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
		(*)Τα πεδία που σημειώνονται με αστερίσκο είναι προαιρετικά.
		(**)Βλέπε πίνακα αυτοαξιολόγησης όπισθεν.
		(***)Επίπεδο κοινού ευρωπαϊκού πλαισίου αναφοράς, εφόσον αναφέρεται στο πρωτότυπο πιστοποιητικό ή δίπλωμα.<br/>
	</div>
	<br/>
	<div class="Footnote">
		<b>Επεξηγηματική σημείωση</b><br/>
		Το διαβατήριο γλωσσών Europass αποτελεί μέρος του ευρωπαϊκού χαρτοφυλακίου γλωσσών που ανέπτυξε το Συμβούλιο της Ευρώπης. Χρησιμοποιεί 6 ευρωπαϊκά επίπεδα του κοινού ευρωπαϊκού πλαισίου αναφοράς για τις γλώσσες για την καταγραφή του επιπέδου γλωσσικής επάρκειας που έχει επιτευχθεί σε τυποποιημένη μορφή.<br/>
		Περισσότερες πληροφορίες για το Διαβατήριο γλωσσών Europass: http://europass.cedefop.europa.eu - Περισσότερες πληροφορίες για το ευρωπαϊκό χαρτοφυλάκιο γλωσσών: www.coe.int/portfolio<br/>
		Μπορείτε να μεταφορτώσετε δωρεάν το πρότυπο του διαβατηρίου γλωσσών Europass από τους ανωτέρω ιστοχώρους.<br/>
		© Συμβούλιο της Ευρώπης και Ευρωπαϊκές Κοινότητες, 2004   20060628<br/>
	</div>
	<br/>
</xsl:template>
  <xsl:template name="grid">
	    <table width="710" border="0" cellspacing="0" cellpadding="0" class="Grid">
			<tr class="spacer">
				<th colspan="6"/>
			</tr>
			<tr>
				<th colspan="6" class="title">Ευρωπαϊκά επίπεδα - Πίνακας αυτοαξιολόγησης</th>
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
  </xsl:template>
</xsl:stylesheet>
