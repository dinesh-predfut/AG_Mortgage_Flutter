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
