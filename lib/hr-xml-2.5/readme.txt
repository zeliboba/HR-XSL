===========================================
HR-XML CONSORTIUM RELEASE ERRATA 2007-06-20
===========================================

1. SEP/Candidate.xsd 

An error existed in the version originally included in the 2_5 release.  
RelatedPositionPostings is an optional element. By error it was
required in the version released on 2007-04-15. This has been corrected
within the 2_5 release package. RelatedPositionPostings is optional as it 
was in prior releases. An instance valid against the uncorrected version 
will still be valid against the corrected version.

===========================================
HR-XML CONSORTIUM RELEASE NOTES 2007-04-15
===========================================

Contents:

1. COPYRIGHT
2. CONTACT INFORMATION
3. BACKWARD COMPATIBILITY / NAMESPACE
4. NEW/CHANGED IN THIS RELEASE
   a. Assessment
   b. Background Check
   c. EducationHistory
   d. Enrollment
   e. Employee Performance Management Results
   f. SearchTypes, PositionOpening, Candidate, and NewHire
   g. SIDES
   h. TimeCard
5. KNOWN ISSUES / TIPS
6. OPEN APPLICATIONS GROUP CONTENT
7. ACRONYMS AND TERMINOLOGY

===========================================
1.       COPYRIGHT
===========================================

"Copyright 2007 The HR-XML Consortium, Inc."

Terms of license can be found in license.txt.

===========================================
2.       CONTACT INFORMATION
===========================================

Send comments, bug reports, maintenance requests, and questions to:
info@hr-xml.org

===========================================
3.    BACKWARD COMPATIBILITY / NAMESPACE
===========================================

This 2_5 release is backwardly compatible with the 2_4 release (i.e.,
an instance conforming with the 2_4 release will be valid against
the 2_5 release), excepting the following items:
   * Per HR-XML schema design guidelines and schema versioning
     best practices, the version (release date) is reflected in the
     new namespace. The new namespace is:
     http://ns.hr-xml.org/2007-04-15
     While a 2_4 instance will be valid against 2_5, the reverse
     is not true. The versioning of the namespace allows an
     application supporting trading partners using different versions
     of the standards to discern instances of each version.
   * Any elements removed because they previously were classified
     as "deprecated" for at least 3 releases.

===========================================
4.    NEW/CHANGED IN THIS RELEASE
===========================================

New and changed content is described in the sections that follow.

-------------------------------------------
a.             Assessment
-------------------------------------------
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/Assessment/AssessmentResult.xsd
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/Assessment/AssessmentTypes.xsd
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/Assessment/AssessmentOrderRequest.xsd

Summary of changes:
    * Added additional enumerations to the "type" attribute of "Score." This
      expanded list of types are defined in AssessmentResultEnumTypes within
      AssessmentResults.xsd. In the prior release, available values were: percentile;
      raw score; and other. In this release, enumerations are: percentile; raw score;
      stanine; sten; t-score; z-score; intelligence quotient; number attempted; and other.
      The type attribute uses the "string-pattern" extension so that other values may be
      specified if preceded with an "x:".
    * Created AssessmentPersonDescriptors, which is located within AssessmentSubject.
      AssessmentPersonDescriptors follows the data model specified within the HR-XMl
      Cross Process Object, PersonDescriptors, but it is a subset of that bigger model.
      AssessmentPersonDescriptors allows for the transfer of demographic data (legal
      identifiers, race, ethnicity, gender, etc.). This data may be necessary for
      compliance with equal opportunity regulations (such as in the United States)
      or may otherwise be necessary to analyze the validity of test instruments.

-------------------------------------------
b.          Background Check
-------------------------------------------

A new example has been added. This is a non-normative example illustrating a
UserArea extension for the PersonalData node within BackgroundCheck.xsd.
This type of extension could be useful depending on the particular screening
order pattern used by the screening company and its client. Read in-line
comments within the below examples for further information:
  * http://ns.hr-xml.org/2_5/HR-XML-2_5/Screening/US/BackgroundCheck-extension-example.xml
  * http://ns.hr-xml.org/2_5/HR-XML-2_5/Screening/US/Example_PersonalDataExtensions.xsd

-------------------------------------------
c.          EducationHistory
-------------------------------------------
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/CPO/EducationHistory.html
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/CPO/EducationHistory.xsd
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/CPO/EducationHistoryExample_1.xml
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/CPO/EducationHistoryExample_2.xml
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/CPO/EducationHistoryExample_3.xml

Summary of changes:
    * Please read deprecation notes in element descriptions.
    * see MR98:  http://mr.hr-xml.org/main/issue98
    * Added ISCEDInstitutionClassification and LocalInstitutionClassification
      structures to replace deprecated schoolType attribute.
    * ISCEDInstitutionClassification implements the United Nations Educational,
      Scientific And Cultural Organization's (UNESCO) International Standard
      Classification of Education (ISCED). Use of the ISCED classifications
      provides a way for a normalized international representation of an
      institution type.
    * Added DegreeClassification structure to replace deprecated degreeType
      attribute.

-------------------------------------------
d.           Enrollment
-------------------------------------------

==== Enrollment ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/Enrollment/Enrollment.html
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/Enrollment/EnrollmentTypes.xsd
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/Enrollment/US/USTierCoverage.xsd
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/Enrollment/US/USSpendingAccountCoverage.xsd

Summary of Changes:
    * Gave names to certain anonymous types, which allows for better modularization,
      reuse, and handling by class generation tools.
    * Added "HSAVendor" element to "TierCoverage" to better support enrollments in
      Healthcare Spending Account (HSA) programs. See Section 4.14, Healthcare Spending
      Accounts (HSAs) and Section 3.6.4, USTierCoverage Global Type.
    * Added "Health Reimbursement Account" to existing enumerated SpendingAccountCoverage
      types.
    * Added optional PlanStartDate and PlanEndDate elements under SpendingAccountCoverage.
      These elements are intended to be used when finer-grained "plan year" information is
      required.
    * Within ContributionData, made the following changes:
          o Made GoalAmount element optional (not relevant for all spending account
            coverage types)
          o Added option StartDate (LocalDateType). This is the date on which contribution
            changes become effective.
          o Added optional FirstPayrollDate (LocalDateType). This would be an indication of
            the first payroll date on which contributions would start.
    * Added an optional AutoReimbursement element. This has enumerated values of "all";
      "none"; and "byClaim".

==== Enrollment Audit Guidelines ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/Enrollment/EnrollmentAuditGuidelines.html

    This is a non-normative technical note providing broad guidance for benefit plan
    record keepers and insurance carriers in  using HR-XML's Enrollment and Application
    Acknowledgement specifications to conduct eligibility audits. The guidance is most
    relevant to health-plan and similar "tier-coverages" within the U.S. market.

-------------------------------------------
e.    Employee Performance Management Results
-------------------------------------------

    This is a new specification designed to support the integration of results from
    employee performance management systems with other systems, including HRIS,
    learning management, compensation, and other talent management systems. For an
    overview of this multi-part specification, see:
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/PerformanceManagement/EPMResultsOverview.html

==== EPM Results: Full Result Scenarios ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/PerformanceManagement/EPMFullResultScenarios.html
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/ws/PerformanceManagement/EPMFullResult_wsdl.html
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/ws/PerformanceManagement/EPMFullResult.wsdl
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/PerformanceManagement/EPMResult.xsd
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/PerformanceManagement/EPMSummaryResult_example_1.xml

==== EPM Results: HRIS Scenarios  ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/PerformanceManagement/EPMSummaryResultScenarios.html
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/ws/PerformanceManagement/EPMSummaryResult_wsdl.html
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/ws/PerformanceManagement/EPMSummaryResult.wsdl
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/PerformanceManagement/EPMSummaryResult.xsd
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/PerformanceManagement/EPMSummaryResult_example_1.xml

==== EPM Results: Compensation System Scenarios ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/PerformanceManagement/EPMCompensationSystemScenarios.html
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/ws/PerformanceManagement/EPMRemunerationResult_wsdl.html
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/ws/PerformanceManagement/EPMRemunerationResult.wsdl
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/PerformanceManagement/EPMRemunerationResult.xsd
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/PerformanceManagement/EPMRemunerationRecommendation_example3.xml

==== EPM Developmental Plans: LMS Scenarios ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/PerformanceManagement/EPMLMSScenarios.html
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/ws/PerformanceManagement/EPMDevelopmentPlan_wsdl.html
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/ws/PerformanceManagement/EPMDevelopmentPlan.wsdl
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/PerformanceManagement/EPMDevelopmentPlan.xsd
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/PerformanceManagement/EPMDevelopmentPlan_eg1.xml

-------------------------------------------
f. SearchTypes, PositionOpening, Candidate, and NewHire
-------------------------------------------

SearchTypes is a new specification that defines two data types intended as generalized,
reusable components for structuring information about search criteria as well as
search-result metadata, such as search result relevance. Related changes have been
made to PositionOpening, Candidate, and NewHire.

==== SearchTypes ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SEP/SearchTypes.html
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SEP/SearchCriteriaExample.xml
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SEP/SearchCriteriaExample-2.xml
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SEP/SearchResultExample.xml

==== PositionOpening ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SEP/PositionOpening.xsd
    * SearchCriteria has been added as an optional element within the PositionDetail node:
        o [PositionOpening/PositionProfile/PositionDetail/SearchCriteria]

==== Candidate ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SEP/Candidate.xsd
    * Optional SearchCriteria and SearchResult elements have been added to the
      optional and repeatable PositionPosting node:
        o [Candidate/RelatedPositionPostings/PositionPosting/SearchCriteria]
        o [Candidate/RelatedPositionPostings/PositionPosting/SearchResult]

==== NewHire ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/NewHire/NewHire.xsd
    * Optional SearchCriteriaId and SearchResultId elements have been added
      to the ReferenceInfo node:
        o [NewHire/PositionInfo/ReferenceInfo/SearchCriteriaId]
        o [NewHire/PositionInfo/ReferenceInfo/SearchResultId]

==== SharedStaffingModules ====
    * Named the existing anonymous type within PositionPostingsType
      to PositionPostingType (a singular PositionPosting) so that it
      could be extended within Candidate.xsd to allow SearchCriteriaInfo
      and SearchResultInfo. PositionPostingsType also is used within
      the PositionOpening.xsd, which handles SearchCriteriaInfo differently
      (a SearchCriteriaId within PositionDetail).

-------------------------------------------
g.                 SIDES
-------------------------------------------

The release includes a variety changes driven by the requirements of
Dutch, French, and Japanese stakeholders. New and changed localized
content is provided for the French and Japanese markets.
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SIDES/SIDES.html

==== Localized Content for Japanese Market ====

The release includes the new localized content for the Japanese
staffing market:
  * http://ns.hr-xml.org/2_5/HR-XML-2_5/SIDES/JP/SIDESJPLocalizations.html
  * http://ns.hr-xml.org/2_5/HR-XML-2_5/SIDES/JP/JPLocalizations.xsd
  * http://ns.hr-xml.org/2_5/HR-XML-2_5/SIDES/JP/Assignment_ContractRequirements.xml
  * http://ns.hr-xml.org/2_5/HR-XML-2_5/SIDES/JP/StaffingPositionHeader_NoLimitStaffing.xml

==== Assignment ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SIDES/Assignment.xsd
        o Added Reference Id's to match other SIDES schemas MasterOrderId,
          TimeCardId, InvoiceId.
        o Added EffectiveDate to ContractInformation.
        o Changed LocalContractRequirements to localized structure.
        o Added Japanese Localization: JPContractRequirements.

==== BankAccountInfo ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SIDES/BankAccountInfo.xsd
        o Created new schema from the BankAccountInfo within FRLocalization.xsd.
        o Added BankAccountType and BankAccountHolder optional elements.

==== ContactInfo ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SIDES/ContactInfo.xsd
        o Added ContactId to ContactInfoType.

==== HumanResource ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SIDES/HumanResource.xsd
        o Added Reference Id's to match other SIDES schema: MasterOrderId,
          TimeCardId, InvoiceId, and BillToEntityId.
        o Added staffing information to PositionHeader.
        o Added Social Insurance structure.

==== Localizations ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SIDES/Localizations.xsd
        o Removed FRBankAccountInfo. It is no longer a localized structure.
        o Added LocalStaffingPositionInfoType.
        o Added JPContractRequirements.

==== Rates  ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SIDES/Rates.xsd
        o Added TimeWorkedRounding.

==== StaffingAction ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SIDES/StaffingAction.xsd
        o Added Reference Id's to match other SIDES ns. BillToEntityId, MasterOrderId.
        o Added 'Modification', 'Cancelled', 'Request' enumerations to StaffingActionReasonCode.
        o Added 'Reporting' enumeration to StaffingActionReasonSubjects.

==== StaffingContactType ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SIDES/StaffingContactType.xsd
        o Added 'first day contact', 'customer complaints', 'supplier manager',
          'supplier complaints', and 'deputy time approver' enumerations to
          ContactType within StaffingContactType schema.

==== StaffingOrder ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SIDES/StaffingOrder.xsd
        o Added Reference Id's to match other SIDES ns. TimeCardId,
          InvoiceId, PositionId, AssignmentId, HumanResourceId.
        o Added 'extension' and 'replacement' enumerations to OrderStatus.

==== StaffingOrganization ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SIDES/StaffingOrganization.xsd
        o Added Reference Id's to match other SIDES ns. MasterOrderId.
        o Added TaxEvaluation structure to PaymentInfo.
        o Changed BankAccountInfo to not be localized.
        o Added AccountType and AccountHolder to BankAccountInfo.

==== StaffingPosition ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SIDES/StaffingPosition.xsd
        o Added PositionDuration to PositionDateRange.
        o Added ExtensionParameters to PositionDateRange.
        o Added InvoiceInfo.
        o Changed PositionHeader element to use StaffingPositionHeaderType.

==== StaffingPositionHeader ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SIDES/StaffingPositionHeader.xsd
        o Extended CPO PositionHeader with staffing-relevant information
          (StaffingPositionHeader): FormattedPositionDescription, ShiftWork,
          PositionMustEndByInfo, TransitionInfo, OverTimeInfo, HolidayWork, and
          BusyPeriodInfo.
        o Added Japanese extension (LocalStaffingPositionInfo)

==== StaffingShift ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SIDES/StaffingShift.xsd
        o Added 'event' enumeration to shiftPeriod.

==== StaffingWorkSite ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SIDES/StaffingWorkSite.xsd
        o Added StructuredTravelDirections.

==== StaffingWorkSiteEnvironment ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SIDES/StaffingWorkSiteEnvironment.xsd
        o 'SafetyAndHygiene' enumeration to EnvironmentConsiderations.

==== TimeCardAdditionalData ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SIDES/TimeCardAdditionalData.xsd
        o Added Reference Id's to match other SIDES ns. StaffingSupplierOrgUnitId,
          StaffingCustomerOrgUnitId, InvoiceId, BillToEntityId.

==== JPLocalizations ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SIDES/JP/JPLocalizations.xsd
        o Includes localizations for Japanese market

==== FRLocalizations ====
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/SIDES/FR/FRLocalizations.xsd
        o Removed FRBankAccountInfo.

-------------------------------------------
h.              TimeCard
-------------------------------------------

    * http://ns.hr-xml.org/2_5/HR-XML-2_5/TimeCard/TimeCard.html
    * http://ns.hr-xml.org/2_5/HR-XML-2_5/TimeCard/TimeCard.xsd

Summary of Changes:

Addressed the following maintenance requests (see http://mr.hr-xml.org):
    * MR28: Added billable indicator to Allowance, Replaced the Allowance element on
            TimeInterval with the richer Allowance element on ReportedTime level.
    * MR29: Added "Unchanged" to enumeration of ActionCodeType
    * MR63: Added SubmitterInfo element on every location where the ApprovalInfo
            element was already in place.
    * MR80: Removed the restriction on the status attribute of ReportedTime, and
            included within this documentation a list of proposed values with
            definitions.
    * MR90: Removed changed history from Schema and copied in this table

===========================================
5.          KNOWN ISSUES / TIPS
===========================================

a. Some parser implementations require the namespace prefix "xml"
be declared as an attribute in the "xsd:schema" root element:
xmlns:xml="http://www.w3.org/XML/1998/namespace"

b. The Consortium schemas have been developed in a modular and
reusable manner.  If your tool encounters problems with these
modular schema components, please try the the StandAlone version
of the schema(s), which are located in the "StandAlone" folder
in the release distribution package.

For example, Tibco's TurboXML tool indicates a warning when validating
ns.that have duplicative imports.  The warning is shown as:
"Duplicate import of namespace ignored.  http://w3.org/2000/09/xmldsig# resolved to W3C/xmldsig-core-schema.xsd"

A conformant XML processor is supposed to ignore duplicative imports. So
in the case of TurboXML and similar tools the "dupicate import" warning
is not consequential in terms of conformance with applicable W3C
recommendations. This warning should not pose any validation or processing
problems.  If you do experience any issues, use the StandAlone version
of the schema(s), which are located in the "StandAlone" folder in the
package.

c. The StandAlone schemas combine "included" module schemas
into a single schema. Those modules are all within the same
namespace.

NOTE: Standalone schemas include components under the HR-XML namespace.
A single XML schema file can define components only for a single
namespace. This is by design. Implementers using the standalone
schemas need to consider this because non-HR-XML namespace components
required by HR-XML specifications cannot be merged into a single
XML schema file. Some HR-XML schemas use the xsd:import feature
to import components from schemas under a different namespace.
Thus, use of the StandAlone schemas will require access to schemas
for imported namespaces. The "import" schema files necessary to
validate HR-XML schemas are provided within the "StandAlone" folder
within the release distribution package.

===========================================
6.     OPEN APPLICATIONS GROUP INVOICE
===========================================

The HR-XML SIDES initiative (Staffing Industry Data Exchange Standards) uses
the invoice schema developed by the Open Applications Group, Inc.

The Open Applications group OAGIS 8.0 Invoice specification is included
in this download as a convenience.  It is a subset of the overall OAGIS
8.0 content.

For more information on OAGIS 8.0, see http://www.openapplications.org.

NOTE: HR-XML's next (3.0) release will share a common library structure and
architecture with OAGIS and bring dependent HR-XML content up to the OAGIS
current version.

===========================================
7.        ACRONYMS AND TERMINOLOGY
===========================================

 CPO ............. Cross Process Objects. Used to refer to basic reusable schema components
                   that are used and enforced Consortium-wide.
 Recommendation .. A standard that has been approved by the Consortium via vote as described
                   in the Consortium by-laws.
 Edition ..........A re-release of a component, documentation, or schema.  This is not a minor
                   version update and should not include semantic changes. This is to be used
                   for bug fix or technical change releases (i.e. the move to a single
                   Consortium-wide namespace in the 2003).?
 SEP ............. Staffing Exchange Protocol.
 SIDES ........... Staffing Industry Data Exchange Standards.
 Technical Note .. A formal "Note" issued by the Technical Steering Committee  that carries
                   official recognition.  Technical Notes have not been voted on by the Consortium.
 TSC ............. Technical Steering Committee.
 UserArea ........ Standard Consortium extension element.  See CPO/HRXMLExtension.html document.