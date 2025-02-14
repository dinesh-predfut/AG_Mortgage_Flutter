class PostsModel {
  
  int? id;
  String? name;
  

  PostsModel({ this.id, this.name});

  PostsModel.fromJson(Map<String, dynamic> json) {
    
    id = json['id'];
    name = json['name'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    
    data['id'] = this.id;
    data['name'] = this.name;
    
    return data;
  }
}
class SeletArea {
  
  int? id;
  String? name;
  

  SeletArea({ this.id, this.name});

  SeletArea.fromJson(Map<String, dynamic> json) {
    
    id = json['id'];
    name = json['name'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    
    data['id'] = id;
    data['name'] = name;
    
    return data;
  }
}
class LoanType {
  final int id;
  final String typeName;
  final int screeningPeriod;

  LoanType({required this.id, required this.typeName, required this.screeningPeriod});

  factory LoanType.fromJson(Map<String, dynamic> json) {
    return LoanType(
      id: json['id'],
      typeName: json['typeName'],
      screeningPeriod: json['screeningPeriod'],
    );
  }
}
class LoanModel {
  final int id;
  final String typeName;
  final int screeningPeriod;
  final int minPaymentPeriod;
  final int maxPaymentPeriod;
  final double depositScreeningInterest;
  final double financeInterest;
  final double mortgageInterest;
  final double profit;
  final double minimumDeposit;
  final String effectiveFrom;

  LoanModel({
    required this.id,
    required this.typeName,
    required this.screeningPeriod,
    required this.minPaymentPeriod,
    required this.maxPaymentPeriod,
    required this.depositScreeningInterest,
    required this.financeInterest,
    required this.mortgageInterest,
    required this.profit,
    required this.minimumDeposit,
    required this.effectiveFrom,
  });

  factory LoanModel.fromJson(Map<String, dynamic> json) {
    return LoanModel(
      id: json['id'],
      typeName: json['typeName'],
      screeningPeriod: json['screeningPeriod'],
      minPaymentPeriod: json['minPaymentPeriod'],
      maxPaymentPeriod: json['maxPaymentPeriod'],
      depositScreeningInterest: json['depositScreeningInterest'].toDouble(),
      financeInterest: json['financeInterest'].toDouble(),
      mortgageInterest: json['mortgageInterest'].toDouble(),
      profit: json['profit'].toDouble(),
      minimumDeposit: json['minimumDeposit'].toDouble(),
      effectiveFrom: json['effectiveFrom'],
    );
  }
}
