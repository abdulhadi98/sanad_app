import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wits_app/bindings/bindings.dart';
import 'package:wits_app/controller/sales/sales_man/rejected_delegations_controller.dart';
import 'package:wits_app/middleware/auth_middleware.dart';
import 'package:wits_app/view/auth/forgot_password_screen.dart';
import 'package:wits_app/view/auth/login_screen.dart';
import 'package:wits_app/view/driver/add_returns_after_deliver_screen.dart';
import 'package:wits_app/view/driver/add_returns_screen.dart';
import 'package:wits_app/view/driver/deliver_to_client_screen.dart';
import 'package:wits_app/view/driver/driver_root_screen.dart';
import 'package:wits_app/view/driver/load_will_delevired_to_screen.dart';
import 'package:wits_app/view/driver/not_stamped_bill_screen.dart';
import 'package:wits_app/view/driver/orders_driver_screen.dart';
import 'package:wits_app/view/driver/recive_from_another_driver_screen.dart';
import 'package:wits_app/view/general/doing_orders_manager_screen.dart';
import 'package:wits_app/view/general/done_orders_employees_screen.dart';
import 'package:wits_app/view/general/done_orders_manager_side_menu_screen.dart';
import 'package:wits_app/view/general/notes/note_details_screen.dart';
import 'package:wits_app/view/general/notes/notes_list_screen.dart';
import 'package:wits_app/view/general/order_details_for_employee_screen.dart';
import 'package:wits_app/view/general/orders_side_menu_screen.dart';
import 'package:wits_app/view/general/resetpassword_notification_screen.dart';
import 'package:wits_app/view/general/search_screen.dart';
import 'package:wits_app/view/general_manager/choose_review_type_screen.dart';
import 'package:wits_app/view/general_manager/general_manager_root_screen.dart';
import 'package:wits_app/view/general_manager/review_by_department_screen.dart';
import 'package:wits_app/view/general_manager/review_by_order_screen.dart';
import 'package:wits_app/view/incpection_officer/enter_boxes_number_screen.dart';
import 'package:wits_app/view/incpection_officer/incpection_officer_root_screen.dart';
import 'package:wits_app/view/incpection_officer/orders_incpection_officer_screen.dart';
import 'package:wits_app/view/movment_manger/assign_driver_screen.dart';
import 'package:wits_app/view/movment_manger/movment_manger_root_screen.dart';
import 'package:wits_app/view/movment_manger/orders_movement_manger_screen.dart';
import 'package:wits_app/view/movment_manger/order_details_movment_manger_screen.dart';
import 'package:wits_app/view/movment_manger/print_order_movment_manger_screen.dart';
import 'package:wits_app/view/general/notifications/notifications_screen.dart';
import 'package:wits_app/view/preparation_worker/orders_preparation_worker_screen.dart';
import 'package:wits_app/view/preparation_worker/preparation_worker_root_screen.dart';
import 'package:wits_app/view/preparation_worker/prepration_done_screen.dart';
import 'package:wits_app/view/quality_supervisor/check_order_screen.dart';
import 'package:wits_app/view/quality_supervisor/orders_quality_supervisor_screen.dart';
import 'package:wits_app/view/quality_supervisor/quality_supervisor_root_screen.dart';
import 'package:wits_app/view/returns_manger/all_returns_returns_manager_screen.dart';
import 'package:wits_app/view/returns_manger/orders_returns_manager_screen.dart';
import 'package:wits_app/view/returns_manger/recive_returns_screen.dart';
import 'package:wits_app/view/returns_manger/returns_details_screen.dart';
import 'package:wits_app/view/returns_manger/returns_list_screen.dart';
import 'package:wits_app/view/returns_manger/returns_manger_root_screen.dart';
import 'package:wits_app/view/root/choose_role_screen.dart';
import 'package:wits_app/view/root_screen.dart';
import 'package:wits_app/view/sales/sales%20representative/rejected_delegation_details_screen.dart';
import 'package:wits_app/view/sales/sales%20representative/rejected_delegations_screen.dart';
import 'package:wits_app/view/sales/sales%20representative/resend_delegation_screen.dart';
import 'package:wits_app/view/sales/sales%20representative/salesman_root_screen-new.dart';
import 'package:wits_app/view/sales/sales_employee/add_order_from_delegation_sales_employee_screen.dart';
import 'package:wits_app/view/sales/sales_employee/delegations_list_sales_employee_screen.dart';
import 'package:wits_app/view/sales/sales_employee/submit_order_delegation_sales_employee_screen.dart';
import 'package:wits_app/view/sales/sales_manger/add_new_order/add_new_order_screen.dart';
import 'package:wits_app/view/sales/sales_manger/add_new_order/submit_order_screen.dart';
import 'package:wits_app/view/sales/sales_manger/assign_salses_employee/order_details_screen.dart';
import 'package:wits_app/view/sales/sales_manger/assign_salses_employee/send_order_to_sales_employee.dart';
import 'package:wits_app/view/sales/sales_manger/delegations/accept_and_assign_sales_employee_screen.dart';
import 'package:wits_app/view/sales/sales_manger/delegations/add_order_from_delegation_screen.dart';
import 'package:wits_app/view/sales/sales_manger/delegations/reject_delegation_screen.dart';
import 'package:wits_app/view/sales/sales_manger/delegations/submit_order_delegation_screen.dart';
import 'package:wits_app/view/sales/sales_manger/orders/orders_root_screen.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';
import 'package:get/get.dart';
import 'package:wits_app/view/super_manager/add_delegation_to_sales_manager_screen.dart';
import 'package:wits_app/view/super_manager/add_new_order_super_manager_screen.dart';
import 'package:wits_app/view/super_manager/choose_review_type_supermanager_screen.dart';
import 'package:wits_app/view/super_manager/choose_warehouse_screen.dart';
import 'package:wits_app/view/super_manager/orders_super_manger_screen.dart';
import 'package:wits_app/view/super_manager/returns_by_warehouse_screen.dart';
import 'package:wits_app/view/super_manager/review_by_department_supermanager_screen.dart';
import 'package:wits_app/view/super_manager/review_by_order_supermanager_screen.dart';
import 'package:wits_app/view/super_manager/supermanager_root_screen.dart';
import 'package:wits_app/view/warehouse_manger/assign_preparator_screen.dart';
import 'package:wits_app/view/warehouse_manger/orders_warehouse_manger.dart';
import 'package:wits_app/view/warehouse_manger/warehouse_manger_root_screen.dart';

import 'helper/app_colors.dart';
import 'view/driver/deliver_to_driver_screen.dart';
import 'view/sales/sales representative/salesman_root_screen(add-delegation).dart';
import 'view/sales/sales_employee/sales_emplyee_root_screen.dart';
import 'view/sales/sales_manger/delegations/delegations_list_screen.dart';
import 'view/sales/sales_manger/orders/order_from_salesperson_screen.dart';

SharedPreferences? sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return GetMaterialApp(
      // home: IconStepperDemo(),
      //   themeMode: ThemeData.dark().cop,
      //   initialBinding: GolbalBindings(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Bahij',
        canvasColor: Colors.white,
        primaryColor: AppColors.mainColor1,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => LoginScreen(),
          middlewares: [AuthMiddleWare()],
        ),
        GetPage(
          name: '/root',
          page: () => RootScreen(),
          middlewares: [
            AuthMiddleWare(),
          ],
        ),
        GetPage(name: '/sales-manger-root-screen', page: () => SalesMangerRootScreen(), binding: GolbalBindings()),
        GetPage(name: '/add-new-order-screen', page: () => AddNewOrderScreen(), binding: GolbalBindings()),
        GetPage(name: '/submit-order-screen', page: () => SubmitOrderScreen(), binding: GolbalBindings()),
        GetPage(name: '/order-details-screen', page: () => OrderDetailsScreen()),
        GetPage(name: '/accept-and-assign-sales-employee', page: () => AcceptAndAssignSalesEmployee()),

        // General
        GetPage(name: '/search_screen', page: () => SearchScreen()),
        GetPage(name: '/notifications_screen', page: () => NotificationsScreen()),
        GetPage(name: '/reset_password_notification_screen', page: () => ResetPasswordNotificationScreen()),
        GetPage(name: '/notes-list-screen', page: () => NotesScreen()),
        GetPage(name: '/note-detials-screen', page: () => NoteDetailsScreen()),
        GetPage(name: '/orders-sidemenu-screen', page: () => OrdersSideMenuScreen()),
        GetPage(name: '/done-orders-manager-side-menu-screen', page: () => DoneOrdersManagerSideMenuScreen()),
        GetPage(name: '/done-orders-employee-side-menu-screen', page: () => DoneOrdersEmployeesScreen()),
        GetPage(name: '/order-details-employee-side-menu-screen', page: () => OrderDetailsForEmployeesSideMenuScreen()),
        GetPage(name: '/doing-orders-manager-side-menu-screen', page: () => DoingOrdersManagerSideMenuScreen()),
        GetPage(name: '/forgot-password-screen', page: () => ForgotPasswordScreen()),

        //Sales Employee
        GetPage(name: '/sales-employee-root-screen', page: () => SalesEmployeeRootScreen(), binding: GolbalBindings()),
        GetPage(name: '/delegations_list_sales_employee_screen', page: () => DelegationsListSalesEmployeeScreen()),
        GetPage(name: '/rejected_delegations_screen', page: () => RejectedDelegationsScreen()),
        GetPage(name: '/rejected-delegation-details-screen', page: () => RejectedDelegationDetailsScreen()),

        GetPage(name: '/add-order-from-delegation-sales-employee-screen', page: () => AddOrderFromDelegationSalesEmployeeScreen()),
        GetPage(name: '/submit-order-delegation-sales-employee-screen', page: () => SubmitOrderDelegationSalesEmployeeScreen()),

        GetPage(name: '/send_order_to_sales_employee', page: () => SendOrderToSalesEmployee()),
        GetPage(name: '/delegations-list-screen', page: () => DelegationsListSceen()),
        GetPage(name: '/orders-root-screen', page: () => OrdersRootScreen()),
        GetPage(name: '/order-from-salesperson-screen', page: () => SalesmanOrderScreen()),
        GetPage(name: '/salesman-root-screen', page: () => SalesmanRootScreen(), binding: GolbalBindings()),
        GetPage(name: '/salesman-root-screen-new', page: () => SalesMangerRootScreenNew(), binding: GolbalBindings()),
        GetPage(name: '/resend-delegation-screen', page: () => ResendDelegationScreen()),

        GetPage(name: '/reject-delegation-screen', page: () => RejectDelegationScreen()),

        GetPage(name: '/choose-role-screen', page: () => ChooseRoleScreen()),
        GetPage(name: '/add-order-from-delegation-screen', page: () => AddOrderFromDelegationScreen()),
        GetPage(name: '/submit-order-delegation-screen', page: () => SubmitOrderDelegationScreen()),
        GetPage(name: '/movment-manger-root-screen', page: () => MovmentMangerRootScreen(), binding: GolbalBindings()),
        GetPage(name: '/print-order-movament-manger-screen', page: () => PrintOrderMovmentMangerScreen(), binding: GolbalBindings()),
        GetPage(name: '/Order-details-movament-manger-screen', page: () => OrderDetailsMovmentMangerScreen(), binding: GolbalBindings()),
        GetPage(name: '/orders_movment_manger_screen', page: () => MovmentMangerRootScreen(), binding: GolbalBindings()),
        GetPage(name: '/orders-screen-movment-manger', page: () => OrdersScreentMovmentManger()),
        GetPage(name: '/assign-driver-screen', page: () => AssignDriverScreen()),

        //WareHouse Section
        GetPage(name: '/warehouse-manger-root-screen', page: () => WarehouseMangerRootScreen(), binding: GolbalBindings()),
        GetPage(name: '/orders-screen-warehouse-manger', page: () => OrdersWarehouseMangerScreen()),
        GetPage(name: '/assign-perperator-screen', page: () => AssignPreperatorScreen()),

        //Preparation Worker
        GetPage(name: '/orders-preparation-worker-screen', page: () => OrdersPreparationWorkerScreent()),
        GetPage(name: '/preparation-done-screen', page: () => PrepartionDoneSceeen()),
        GetPage(name: '/prepartion-worker-root-screen', page: () => PreparationWorkerRootScreen(), binding: GolbalBindings()),

        //Incpection Officer
        GetPage(name: '/orders-screen-incpection_officer', page: () => OrdersScreentIncpectionOfficer()),
        GetPage(name: '/enter-boxes-number-screen', page: () => EnterBoxesNumberScreen()),
        GetPage(name: '/incpection-officer-root-screen', page: () => IncpectionOfficerRootScreen(), binding: GolbalBindings()),

        //Returns Manger
        GetPage(name: '/orders-screen-returns-manger', page: () => OrdersScreentReturnsManger()),
        GetPage(name: '/recive-returns-screen', page: () => ReciveReturnsScreen()),
        GetPage(name: '/return-manger-root-screen', page: () => ReturnsMangerRootScreen(), binding: GolbalBindings()),
        GetPage(name: '/all-orders-returns-manager-screen', page: () => OrdersForRetrunsManagerScreen()),
        GetPage(name: '/all-returns-returns-manager-screen', page: () => ReturnsReturnsManagerScreen()),
        GetPage(name: '/returns_details_screen', page: () => ReturnsDetailsScreen()),

        //Driver
        GetPage(name: '/driver-root-screen', page: () => DriverRootScreen(), binding: GolbalBindings()),
        GetPage(name: '/orders-driver-screen', page: () => OrdersDriverScreen()),
        GetPage(name: '/load-will-delivered-screen', page: () => LoadWillDeleviredScreen()),
        GetPage(name: '/deliver-to-client-screen', page: () => DeliverToClientScreen()),
        GetPage(name: '/deliver-to-driver-screen', page: () => DeliverToDriverScreen()),
        GetPage(name: '/not-stamped-bill-screen', page: () => NotStampedBillScreen()),
        GetPage(name: '/recive-from-another-driver-screen', page: () => ReciveFromAnotherDriver()),
        GetPage(name: '/add-returns-screen', page: () => AddReturnsScreen()),
        GetPage(name: '/add-returns-after-deliver-screen', page: () => AddReturnsAfterDeliverScreen()),

        //Quality Supervisor
        GetPage(name: '/quality-supervisor-root-screen', page: () => QualitySupervisorRootScreen(), binding: GolbalBindings()),
        GetPage(name: '/orders-quality-supervisor-screen', page: () => OrdersQualitySupervisorScreent()),
        GetPage(name: '/check-order-screen', page: () => CheckOrderScreen()),

        //
        GetPage(name: '/recive-returns-screen', page: () => ReciveReturnsScreen()),

        //General Manager
        GetPage(name: '/general-manager-root-screen', page: () => GeneralManagerRootScreen(), binding: GolbalBindings()),
        GetPage(name: '/choose-review-type-screen', page: () => ChooseReviewTypeScreen()),
        GetPage(name: '/review-by-order-screen', page: () => ReviewByOrderScreen()),
        GetPage(name: '/review-by-department-screen', page: () => ReviewByDepartmentScreen()),

        //Super Manager
        GetPage(name: '/choose-warehouse-screen', page: () => ChooseWarehouseScreen(), binding: GolbalBindings()),
        GetPage(name: '/super-manager-root-screen', page: () => SuperManagerRootScreen(), binding: GolbalBindings()),
        GetPage(name: '/add-new-order-super-manager-screen', page: () => AddNewOrderSuperManagerScreen()),
        GetPage(name: '/add-delegation-super-manager-screen', page: () => AddDelegationSuperManagerScreen()),

        GetPage(name: '/super-manager-orders-screen', page: () => SuperManagerOrdersScreen()),

        GetPage(name: '/choose-review-type-screen', page: () => ChooseReviewTypeScreen()),
        GetPage(name: '/review-by-order-supermanager-screen', page: () => ReviewByOrderSupermanagerScreen()),
        GetPage(name: '/review-by-department-supermanager-screen', page: () => ReviewByDepartmentSuperManagerScreen()),
        GetPage(name: '/choose-review-type-supermanager-screen', page: () => ChooseReviewTypeSupermanagerScreen()),
        GetPage(name: '/returns-by-warehouse-screen', page: () => ReturnsByWareHouseScreen()),
      ],
    );
  }
}

// class StatusSteper extends StatefulWidget {
//   StatusSteper({Key? key}) : super(key: key);

//   @override
//   State<StatusSteper> createState() => _StatusSteperState();
// }

// class _StatusSteperState extends State<StatusSteper> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
