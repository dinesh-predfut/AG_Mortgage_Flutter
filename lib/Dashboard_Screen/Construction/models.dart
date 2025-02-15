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
  final int profilingPeriod;
  final int minPaymentPeriod;
  final int maxPaymentPeriod;
  final String constructionType;
  final String constructionLocation;
  final double depositInterest;
  final double mortgageInterest;

  LoanModel({
    required this.id,
    required this.typeName,
    required this.profilingPeriod,
    required this.minPaymentPeriod,
    required this.maxPaymentPeriod,
    required this.constructionType,
    required this.constructionLocation,
    required this.depositInterest,
    required this.mortgageInterest,
  });

  factory LoanModel.fromJson(Map<String, dynamic> json) {
    return LoanModel(
      id: json['id'] ?? 0, // Ensure ID is never null
      typeName: json['typeName'] ?? "Unknown Loan",
      profilingPeriod: json['profilingPeriod'] ?? 0,
      minPaymentPeriod: json['minPaymentPeriod'] ?? 0,
      maxPaymentPeriod: json['maxPaymentPeriod'] ?? 0,
      constructionType: json['constructionType'] ?? "Unknown Type",
      constructionLocation: json['constructionLocation'] ?? "Unknown Location",
      depositInterest: (json['depositInterest'] ?? 0.0).toDouble(),
      mortgageInterest: (json['mortgageInterest'] ?? 0.0).toDouble(),
    );
  }
}
