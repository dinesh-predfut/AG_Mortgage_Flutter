// ignore: file_names
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
}
