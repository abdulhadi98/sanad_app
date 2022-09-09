class UrlsContainer {
  static final String baseUrl = "https://sanad.aratech.co";
  static final String baseApiUrl = "$baseUrl/api";

  static String addImage = "$baseApiUrl/add-image";
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
  static String addOrderIdToDelegation = "$baseApiUrl/add-order-id-to-delegation";
  
  static String getORders = "$baseApiUrl/get-orders";
  static String getOrderById = "$baseApiUrl/get-order";

  static String addDelegation = "$baseApiUrl/add-delegation-sales";
  static String addDelegationManger = "$baseApiUrl/add-delegation-manager";
  static String assignDelegationToEmployee = "$baseApiUrl/assign-delegation-to-employee";
  
  static String rejectDelegation = "$baseApiUrl/reject-delegation";
  static String getDelegationsOrders = "$baseApiUrl/get-delegation-orders";
  static String getAssignedDelegations = "$baseApiUrl/get-assigned-delegations";
  
  static String getDelegationById = "$baseApiUrl/get-delegation-by-id";

  //Movment Manger
  static String printOrder = "$baseApiUrl/print-order";
  static String getDrivers = "$baseApiUrl/get-drivers";
  static String assignDriver = "$baseApiUrl/assign-driver";

  //Warehouse Manger
  static String receiveReturns = "$baseApiUrl/returns-delevired";
  static String getPerperators = "$baseApiUrl/get-preparators";
  static String assignPerperator = "$baseApiUrl/assign-preparator";

  //Prepartion Worker
  static String preprationDone = "$baseApiUrl/prepration-done";

  //Incpection Officer
  static String enterBoxesNumber = "$baseApiUrl/prepration-verified";

  //Driver
  static String billIsStamped = "$baseApiUrl/bill-is-stamped";
  static String billNotStamped = "$baseApiUrl/bill-not-stamped";
  static String changeDriver = "$baseApiUrl/change-driver";
  
  

  

}
