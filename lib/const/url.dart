class Urls {
  static const String baseUrl = "http://3.253.82.115";
  static const String signIn = "$baseUrl/api/auth/customer-signup";
  static const String signup = "$baseUrl/api/auth/signin";
  static const String sendOTP =
      "$baseUrl/api/auth/resend-email-verification-otp";
        static const String forgetPassword =
      "$baseUrl/api/auth/forgotPassword";
  static const String getallCards = "$baseUrl/api/cards";
  static const String getallCardsByid = "$baseUrl/api/cards/getCardsById?id=";
  static const String allCity = "$baseUrl/api/location/getAllCity";
  static const String allArea = "$baseUrl/api/location/area?cityId=";
  static const String checkToken = "$baseUrl/api/auth/verifyEmail";
  static const String addFavorites =
      "$baseUrl/api/apartmentAndMarketplace/favourite";
  static const String mortagaform = "$baseUrl/api/mortgage";
  static const String investment = "$baseUrl/api/investment";
    static const String investmentByid = "$baseUrl/api/investment/getAllInvestmentDetailsByCustomer?id=";
  static const String depositAmont = "$baseUrl/api/deposit";
  static const String rentToOwn = "$baseUrl/api/rentToOwn";
  static const String withdraw = "$baseUrl/api/withdraw";
  static const String bankTransfer = "$baseUrl/api/bankTransfer";
  static const String getAllTransactions = "$baseUrl/api/getAllTransactions";
  static const String marketPlace = "$baseUrl/api/apartmentAndMarketplace";
  static const String upDateTermsheet =
      "$baseUrl/api/mortgage/getAllMortgageDetailsByCustomer?id=9";
  static const String amountPay = "$baseUrl/api/cards/getCardsById";
  static const String apartment = "$baseUrl/api/settings/getAllApartmentTypes";
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
  static const String getAllConstructionFinanceDetailsByCustomer =
      "$baseUrl/api/constructionFinance/getAllConstructionFinanceDetailsByCustomer";
  static const String getsettingsData = "$baseUrl/api/settings/rentToOwn";
  static const String getsettingsDataInvestment =
      "$baseUrl/api/settings/investment";
  static const String constructionFinance =
      "$baseUrl/api/settings/constructionFinance";
  static const String construction = "$baseUrl/api/constructionFinance";
  static const String documentUpload = "$baseUrl/api/customer/documentUpload";
  static const String getAllDocuments = "$baseUrl/api/settings/document";
  static const String getallNotification = "$baseUrl/api/notification";
  static const String validateToken = "$baseUrl/api/auth/verifyRefreshToken";
  static const String getScore = "$baseUrl/api/getCreditScore?customerId=";
  static const String referalOverAll = "$baseUrl/api/customer/referralCode/stats";
    static const String fetchApartmentsApi= "$baseUrl/api/settings/getAllApartmentTypes";

}
