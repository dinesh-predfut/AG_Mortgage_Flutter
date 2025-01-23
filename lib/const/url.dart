class Urls {
  static const String baseUrl = "http://3.253.82.115";

  static const String signIn = "$baseUrl/api/auth/signin";
  static const String sendOTP =
      "$baseUrl/api/auth/resend-email-verification-otp";
  static const String getallCards = "$baseUrl/api/cards";
  static const String getallCardsByid = "$baseUrl/api/cards/getCardsById?id=";
  static const String allCity = "$baseUrl/api/location/getAllAreas";
  static const String allArea = "$baseUrl/api/location/area?cityId=";
  static const String mortagaform = "$baseUrl/api/mortgage";
  static const String withdraw = "$baseUrl/api/withdraw";
  static const String getAllTransactions = "$baseUrl/api/getAllTransactions";
  static const String marketPlace = "$baseUrl/api/apartmentAndMarketplace";
  static const String houseView =
      "$baseUrl/api/apartmentAndMarketplace/getApartmentAndMarketplaceById";
}
