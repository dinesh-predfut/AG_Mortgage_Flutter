class Urls {
  static const String baseUrl = "http://3.253.82.115";
  static const String signIn = "$baseUrl/api/auth/customer-signup";
  static const String signup = "$baseUrl/api/auth/signin";
  static const String sendOTP =
      "$baseUrl/api/auth/resend-email-verification-otp";
  static const String getallCards = "$baseUrl/api/cards";
  static const String getallCardsByid = "$baseUrl/api/cards/getCardsById?id=";
  static const String allCity = "$baseUrl/api/location/getAllAreas";
  static const String allArea = "$baseUrl/api/location/area?cityId=";
  static const String mortagaform = "$baseUrl/api/mortgage";
  static const String depositAmont = "$baseUrl/api/deposit";
  static const String rentToOwn = "$baseUrl/api/rentToOwn";
  static const String withdraw = "$baseUrl/api/withdraw";
  static const String getAllTransactions = "$baseUrl/api/getAllTransactions";
  static const String marketPlace = "$baseUrl/api/apartmentAndMarketplace";
  static const String upDateTermsheet =
      "$baseUrl/api/mortgage/getAllMortgageDetailsByCustomer?id=9";
  static const String amountPay = "$baseUrl/api/cards/getCardsById";
  static const String employeRegister =
      "$baseUrl/api/customer/employmentDetails";
  static const String getEmployeeDetailsID = "$baseUrl/api/customer";
  static const String houseView =
      "$baseUrl/api/apartmentAndMarketplace/getApartmentAndMarketplaceById";
  static const String kinDetails = "$baseUrl/api/kin";
  static const String profile = "$baseUrl/api/customer/profileImage";
  static const String logInDetails = "$baseUrl/api/customer/loginDetails";
  static const String stateList = "$baseUrl/api/location/state";
  static const String cityList = "$baseUrl/api/location/city";
  static const String areaList = "$baseUrl/api/location/area";
  static const String homeAddress = "$baseUrl/api/customer/addressDetails";
  static const String helpDisk = "$baseUrl/api/settings/helpDesk";
  static const String plan = "$baseUrl/api/settings/helpDesk";
  static const String getMortgageDetails =
      "$baseUrl/api/mortgage/getAllMortgageDetailsByCustomer";
  static const String getRentToOwnDetails =
      "$baseUrl/api/rentToOwn/getAllRentToOwnDetailsByCustomer";

  static const String getsettingsData = "$baseUrl/api/settings/rentToOwn";
  static const String constructionFinance =
      "$baseUrl/api/settings/constructionFinance";
       static const String construction =
      "$baseUrl/api/constructionFinance";
}
