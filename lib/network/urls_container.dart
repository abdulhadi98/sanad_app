class UrlsContainer {
  static final String baseUrl = "https://sanad.aratech.co";
  static final String baseApiUrl = "$baseUrl/api/v1";
  static final String imagesUrl = "$baseUrl/storage";

  static String addImage = "$baseApiUrl/add-image";
  // Authentication's endpoints
  static String emailLogin = "$baseApiUrl/login";
  static String getImages = "$baseApiUrl/get-images";

  static String getNotifications = "$baseApiUrl/get-notifications";
  static String getReviews = "$baseApiUrl/get-reviews";
  static String getReviewsById = "$baseApiUrl/get-review-by-id";

  static String addDeviceToken = "$baseApiUrl/add-device-token";
  static String removeDeviceToken = "$baseApiUrl/remove-device-token";

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
  static String getRejectedDelegations = "$baseApiUrl/get-rejected-delegations";

  static String getDelegationById = "$baseApiUrl/get-delegation-by-id";

  //Movment Manger
  static String printOrder = "$baseApiUrl/print-order";
  static String getDrivers = "$baseApiUrl/get-drivers";
  static String assignDriver = "$baseApiUrl/assign-driver";

  //Warehouse Manger
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
  static String addReturns = "$baseApiUrl/add-returns";

  //Quality Supervisor
  static String accecptStampedBill = "$baseApiUrl/accept-stamped-bill";
  static String rejectStampedBill = "$baseApiUrl/reject-stamped-bill";

  //Returns Manager
  static String getReturnById = "$baseApiUrl/get-returns-by-id";
  static String receiveReturns = "$baseApiUrl/returns-delivered";

  //General Manager
  static String addReviewById = "$baseApiUrl/add-review-by-order";
  static String getEmployeesByOrder = "$baseApiUrl/get-employees-by-order";
  static String getRoles = "$baseApiUrl/get-roles";
  static String getEmployeesByRole = "$baseApiUrl/get-employees-by-role";
  static String addReviewByRole = "$baseApiUrl/add-review-by-role";

  //Super Manager
  static String getWarehouses = "$baseApiUrl/get-warehouses";
  static String getOrdersByWareHouse = "$baseApiUrl/get-warehouse-orders";
  static String getEmployeesByRoleSuper = "$baseApiUrl/get-employees-by-role-super";

  static String addNewOrderSuperManager = "$baseApiUrl/add-order-super";
  static String addDelegationSuperManager = "$baseApiUrl/add-delegation-super";
}
