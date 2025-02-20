class CustomerModel {
  final int? id;
  final int? customerId;
  final String? customerName;
  final int? apartmentOrMarketplace;
  final int? typeOfApartment;
  final int? city;
  final int? area;
  final double? estimatedPropertyValue;
  final double? initialDeposit;
  final int? loanRepaymentPeriod;
  final double? monthlyRepaymentAmount;
  final String? startDate;
  final String? anniversary;
  final String? status;
  final double? monthlyRentalAmount;
  final int? rentalRepaymentPeriod;
  final double? monthlyLoanAmount;
  final double? estimatedLoanAmount;

  CustomerModel({
    this.id,
    this.customerId,
    this.customerName,
    this.apartmentOrMarketplace,
    this.typeOfApartment,
    this.city,
    this.area,
    this.estimatedPropertyValue,
    this.initialDeposit,
    this.loanRepaymentPeriod,
    this.monthlyRepaymentAmount,
    this.startDate,
    this.anniversary,
    this.status,
    this.monthlyRentalAmount,
    this.rentalRepaymentPeriod,
    this.monthlyLoanAmount,
    this.estimatedLoanAmount,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      customerId: json['customerId'],
      customerName: json['customerName'],
      apartmentOrMarketplace: json['apartmentOrMarketplace'],
      typeOfApartment: json['typeOfApartment'],
      city: json['city'],
      area: json['area'],
      estimatedPropertyValue: json['estimatedPropertyValue']?.toDouble(),
      initialDeposit: json['initialDeposit']?.toDouble(),
      loanRepaymentPeriod: json['loanRepaymentPeriod'],
      monthlyRepaymentAmount: json['monthlyRepaymentAmount']?.toDouble(),
      startDate: json['startDate'],
      anniversary: json['anniversary'],
      status: json['status'],
      monthlyRentalAmount: json['monthlyRentalAmount']?.toDouble(),
      rentalRepaymentPeriod: json['rentalRepaymentPeriod'],
      monthlyLoanAmount: json['monthlyLoanAmount']?.toDouble(),
      estimatedLoanAmount: json['estimatedLoanAmount']?.toDouble(),
    );
  }
  
}
class ConstructionProject {
  final int id;
  final int customerId;
  final String customerName;
  final int typeOfConstruction;
  final int city;
  final int area;
  final int stageOfDevelopment;
  final int screeningPeriod;
  final int repaymentPeriod;
  final double totalMonthlySaving;
  final double totalExpectedSaving;
  final double estimatedAmountSpent;
  final double estimatedCompletionAmount;
  final double monthlyRepaymentAmount;
  final double valuationAmount;
  final String startDate;
  final String anniversary;
  final bool hasLandTitleCertificate;
  final bool hasRegisteredDeed;
  final bool hasValuationReport;
  final bool hasApprovedDrawings;
  final bool hasElectricalAndMechanicalDrawings;
  final bool hasBillOfQuantities;
  final String status;
  final String? architectName;
  final String? architectRegistrationNumber;
  final String? engineerName;
  final String? engineerRegistrationNumber;
  final String? quantitySurveyorName;
  final String? quantitySurveyorRegistrationNumber;

  ConstructionProject({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.typeOfConstruction,
    required this.city,
    required this.area,
    required this.stageOfDevelopment,
    required this.screeningPeriod,
    required this.repaymentPeriod,
    required this.totalMonthlySaving,
    required this.totalExpectedSaving,
    required this.estimatedAmountSpent,
    required this.estimatedCompletionAmount,
    required this.monthlyRepaymentAmount,
    required this.valuationAmount,
    required this.startDate,
    required this.anniversary,
    required this.hasLandTitleCertificate,
    required this.hasRegisteredDeed,
    required this.hasValuationReport,
    required this.hasApprovedDrawings,
    required this.hasElectricalAndMechanicalDrawings,
    required this.hasBillOfQuantities,
    required this.status,
    this.architectName,
    this.architectRegistrationNumber,
    this.engineerName,
    this.engineerRegistrationNumber,
    this.quantitySurveyorName,
    this.quantitySurveyorRegistrationNumber,
  });

  factory ConstructionProject.fromJson(Map<String, dynamic> json) {
    return ConstructionProject(
      id: json['id'] ?? 0,
      customerId: json['customerId'] ?? 0,
      customerName: json['customerName'] ?? '',
      typeOfConstruction: json['typeOfConstruction'] ?? 0,
      city: json['city'] ?? 0,
      area: json['area'] ?? 0,
      stageOfDevelopment: json['stageOfDevelopment'] ?? 0,
      screeningPeriod: json['screeningPeriod'] ?? 0,
      repaymentPeriod: json['repaymentPeriod'] ?? 0,
      totalMonthlySaving: (json['totalMonthlySaving'] ?? 0.0).toDouble(),
      totalExpectedSaving: (json['totalExpectedSaving'] ?? 0.0).toDouble(),
      estimatedAmountSpent: (json['estimatedAmountSpent'] ?? 0.0).toDouble(),
      estimatedCompletionAmount: (json['estimatedCompletionAmount'] ?? 0.0).toDouble(),
      monthlyRepaymentAmount: (json['monthlyRepaymentAmount'] ?? 0.0).toDouble(),
      valuationAmount: (json['valuationAmount'] ?? 0.0).toDouble(),
      startDate: json['startDate'] ?? '',
      anniversary: json['anniversary'] ?? '',
      hasLandTitleCertificate: json['hasLandTitleCertificate'] ?? false,
      hasRegisteredDeed: json['hasRegisteredDeed'] ?? false,
      hasValuationReport: json['hasValuationReport'] ?? false,
      hasApprovedDrawings: json['hasApprovedDrawings'] ?? false,
      hasElectricalAndMechanicalDrawings: json['hasElectricalAndMechanicalDrawings'] ?? false,
      hasBillOfQuantities: json['hasBillOfQuantities'] ?? false,
      status: json['status'] ?? 'Unknown',
      architectName: json['architectName'],
      architectRegistrationNumber: json['architectRegistrationNumber'],
      engineerName: json['engineerName'],
      engineerRegistrationNumber: json['engineerRegistrationNumber'],
      quantitySurveyorName: json['quantitySurveyorName'],
      quantitySurveyorRegistrationNumber: json['quantitySurveyorRegistrationNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'customerName': customerName,
      'typeOfConstruction': typeOfConstruction,
      'city': city,
      'area': area,
      'stageOfDevelopment': stageOfDevelopment,
      'screeningPeriod': screeningPeriod,
      'repaymentPeriod': repaymentPeriod,
      'totalMonthlySaving': totalMonthlySaving,
      'totalExpectedSaving': totalExpectedSaving,
      'estimatedAmountSpent': estimatedAmountSpent,
      'estimatedCompletionAmount': estimatedCompletionAmount,
      'monthlyRepaymentAmount': monthlyRepaymentAmount,
      'valuationAmount': valuationAmount,
      'startDate': startDate,
      'anniversary': anniversary,
      'hasLandTitleCertificate': hasLandTitleCertificate,
      'hasRegisteredDeed': hasRegisteredDeed,
      'hasValuationReport': hasValuationReport,
      'hasApprovedDrawings': hasApprovedDrawings,
      'hasElectricalAndMechanicalDrawings': hasElectricalAndMechanicalDrawings,
      'hasBillOfQuantities': hasBillOfQuantities,
      'status': status,
      'architectName': architectName,
      'architectRegistrationNumber': architectRegistrationNumber,
      'engineerName': engineerName,
      'engineerRegistrationNumber': engineerRegistrationNumber,
      'quantitySurveyorName': quantitySurveyorName,
      'quantitySurveyorRegistrationNumber': quantitySurveyorRegistrationNumber,
    };
  }
}
