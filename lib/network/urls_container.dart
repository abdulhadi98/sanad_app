class UrlsContainer {
  static final String baseUrl = "https://sanad.aratech.co";
  static final String baseApiUrl = "$baseUrl/api";

  // Authentication's endpoints
  static String emailLogin = "$baseApiUrl/login";
  static String addDeviceToken = "$baseApiUrl/add-device-token";
  static String getUser = "$baseApiUrl/get-user";
  static String forgotPassword = "$baseApiUrl/forgot-password";
  static String resetPassword = "$baseApiUrl/reset-password";
  static String logout = "$baseApiUrl/logout";

  static String getClientsInfo = "$baseApiUrl/get-clients-info";
  static String getSalesEmployees = "$baseApiUrl/get-sales-employees";

  static String addNewOrder = "$baseApiUrl/add-new-order";
  static String getORders = "$baseApiUrl/get-orders";
  static String getOrderById = "$baseApiUrl/get-order";

  static String addDelegation = "$baseApiUrl/add-delegation-sales";
  static String addDelegationManger = "$baseApiUrl/add-delegation-manager";
  static String rejectDelegation = "$baseApiUrl/reject-delegation";
  static String getDelegationsOrders = "$baseApiUrl/get-delegation-orders";
  static String getDelegationById = "$baseApiUrl/get-delegation-by-id";

  //Movment Manger
  static String printOrder = "$baseApiUrl/print-order";
  static String getDrivers = "$baseApiUrl/get-drivers";
  static String assignDriver = "$baseApiUrl/assigne-driver";
}
