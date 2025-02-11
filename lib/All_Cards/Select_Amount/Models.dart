class CardModel {
  final int id;
  final String cardName;
  final String cardNumber;
  final String expDate;
  final String cardStatus;
  final String cvv;

  CardModel({
    required this.id,
    required this.cardName,
    required this.cardNumber,
    required this.expDate,
    required this.cardStatus,
    required this.cvv,
  });

  // Factory method to parse JSON data into CardModel object
  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'],
      cardName: json['cardName'],
      cardNumber: json['cardNumber'],
      expDate: json['expDate'],
      cardStatus: json['cardStatus'],
      cvv: json['cvv'],
    );
  }

  // Convert the CardModel object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardName': cardName,
      'cardNumber': cardNumber,
      'expDate': expDate,
      'cardStatus': cardStatus,
      'cvv': cvv,
    };
  }
}
