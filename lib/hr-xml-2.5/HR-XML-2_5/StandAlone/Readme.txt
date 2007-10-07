2007-04-15  Standalone Schemas

The HR-XML Consortium library relies heavily on XML schema "includes" (xsd:include)
to manage component re-use.  This feature enables the modular design of 
schemas and promotes consistency across the HR-XML Consortium Library. 

While the use of xsd:include is useful and necessary during HR-XML's design process, 
implementers may encounter tools that have difficulty resolving included schemas. 
For this reason, HR-XML also makes available "standalone" versions of approved schemas. 
The standalone versions contain all the necessary HR-XML components in a single file.  

The HR-XML release distribution package contains both the modular and standalone 
versions of the same schemas. While the standalone schemas pose fewer tool
compatibility problems, they may not always be the best choice for the task at hand.  
For example, the entire HR-XML Consortium Library can be used in a code 
generation tool to create classes for use in processing XML instances.  An
implementer using the modular schemas to generate code could achieve the desired
result of creating one class for each component. However, an implementer generating 
code using two or more of the standalone schemas would create duplicative classes.

Recommendations:

For simple requirements, the standalone schemas may be the easiest to use. For more
complex requirements, including generating code across more than one HR transaction, 
the modular schemas may be more suitable. For your convenience, both versions are 
contained in the distribution package.


HR-XML Members have access to a normalization tool to create their own StandAlone
schemas. See:
http://testbed.hr-xml.org/tools/norm/


Standalone Schemas included in this release are:

ApplicationAcknowledgement.xsd
AssessmentCancelRequest.xsd
AssessmentCatalog.xsd
AssessmentCatalogQuery.xsd
AssessmentOrderAcknowledgement.xsd
AssessmentOrderRequest.xsd
AssessmentResult.xsd
AssessmentStatusRequest.xsd
Assignment.xsd
BackgroundCheck.xsd
BackgroundCheckStatusRequest.xsd
BackgroundReports.xsd
Candidate.xsd
Credit.xsd
CustomerReportingRequirements.xsd
Enrollment.xsd
EPMDevelopmentPlan.xsd
EPMObjectivesPlan.xsd
EPMObjectivesResult.xsd
EPMRemunerationResult.xsd
EPMResult.xsd
EPMSummaryResult.xsd
ExerciseConfirmation.xsd
ExerciseRequest.xsd
Grant.xsd
HumanResource.xsd
IndicativeBatch.xsd
IndicativeData.xsd
Invoice.xsd
MetricsInterchange.xsd
NewHire.xsd
PayrollBenefitContributions.xsd
PayrollInstructions.xsd
PositionOpening.xsd
Rates.xsd
RemoveExerciseConfirmations.xsd
RemoveExerciseRequests.xsd
RemoveGrants.xsd
RemoveStockDeposits.xsd
RemoveStockPlanParticipants.xsd
RemoveStockPlans.xsd
RemoveStockSaleConfirmations.xsd
ResourceScreening.xsd
Resume.xsd
simpledc20021212.xsd
StaffingAction.xsd
StaffingOrder.xsd
StaffingOrganization.xsd
StaffingPosition.xsd
StaffingShift.xsd
StockDeposit.xsd
StockPlan.xsd
StockPlanParticipant.xsd
StockPurchasePlanCoverage.xsd
StockSaleConfirmation.xsd
TimeCard.xsd
TimeCardConfiguration.xsd
xml.xsd
xmldsig-core-schema.xsd
