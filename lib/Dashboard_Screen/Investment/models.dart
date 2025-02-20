class LoanTypeInvestment {
  final int id;
  final String typeName;
  final int tenure;
  final double interestRate;


  LoanTypeInvestment({
    required this.id,
    required this.typeName,
    required this.tenure,
    required this.interestRate,
    
  });

  factory LoanTypeInvestment.fromJson(Map<String, dynamic> json) {
    return LoanTypeInvestment(
      id: json['id'] ?? 0,
      typeName: json['typeName'] ?? '',
      tenure: json['tenure'] ?? 0,
      interestRate: (json['interestRate'] ?? 0.0).toDouble(),
    
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'typeName': typeName,
      'tenure': tenure,
      'interestRate': interestRate,
      
    };
  }
}
