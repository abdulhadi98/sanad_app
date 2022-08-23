import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_timeline/flutter_timeline.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wits_app/bindings/bindings.dart';
import 'package:wits_app/middleware/auth_middleware.dart';
import 'package:wits_app/view/auth/login_screen.dart';
import 'package:wits_app/view/common_widgets/steper_widget.dart';
import 'package:wits_app/view/common_widgets/timeline.dart';
import 'package:wits_app/view/movment_manger/movment_manger_root_screen.dart';
import 'package:wits_app/view/movment_manger/order_details_movment_manger_screen.dart';
import 'package:wits_app/view/movment_manger/print_order_movment_manger.dart';
import 'package:wits_app/view/root/choose_role_screen.dart';
import 'package:wits_app/view/root_screen.dart';
import 'package:wits_app/view/sales/sales_manger/add_new_order/add_new_order_screen.dart';
import 'package:wits_app/view/sales/sales_manger/add_new_order/submit_order_screen.dart';
import 'package:wits_app/view/sales/sales_manger/assign_salses_employee/order_details_screen.dart';
import 'package:wits_app/view/sales/sales_manger/assign_salses_employee/send_order_to_sales_employee.dart';
import 'package:wits_app/view/sales/sales_manger/delegations/add_order_from_delegation_screen.dart';
import 'package:wits_app/view/sales/sales_manger/delegations/reject_delegation_screen.dart';
import 'package:wits_app/view/sales/sales_manger/delegations/submit_order_delegation_screen.dart';
import 'package:wits_app/view/sales/sales_manger/orders/orders_root_screen.dart';
import 'package:wits_app/view/sales/sales_manger/sales_manger_root_screen.dart';
import 'package:get/get.dart';

import 'helper/app_colors.dart';
import 'view/sales/sales representative/salesman_root_screen.dart';
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
    ));
    return GetMaterialApp(
      // home: IconStepperDemo(),
      //   themeMode: ThemeData.dark().cop,
      //   initialBinding: GolbalBindings(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      // initialBinding: ,
      theme: ThemeData(
        fontFamily: 'Bahij',
        canvasColor: Colors.white,
        primaryColor: AppColors.mainColor1,
      ),
      // home: ,
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
        GetPage(name: '/send_order_to_sales_employee', page: () => SendOrderToSalesEmployee()),
        GetPage(name: '/delegations-list-screen', page: () => DelegationsListSceen()),
        GetPage(name: '/orders-root-screen', page: () => OrdersRootScreen()),
        GetPage(name: '/order-from-salesperson-screen', page: () => SalesmanOrderScreen()),
        GetPage(name: '/sales-employee-root-screen', page: () => SalesEmployeeRootScreen()),
        GetPage(name: '/salesman-root-screen', page: () => SalesmanRootScreen()),
        GetPage(name: '/reject-delegation-screen', page: () => RejectDelegationScreen()),
        GetPage(name: '/choose-role-screen', page: () => ChooseRoleScreen()),
        GetPage(name: '/add-order-from-delegation-screen', page: () => AddOrderFromDelegationScreen()),
        GetPage(name: '/submit-order-delegation-screen', page: () => SubmitOrderDelegationScreen()),
        GetPage(name: '/movment-manger-root-screen', page: () => MovmentMangerRootScreen(), binding: GolbalBindings()),
        GetPage(name: '/print-order-movament-manger-screen', page: () => PrintOrderMovmentMangerScreen(), binding: GolbalBindings()),
        GetPage(name: '/Order-details-movament-manger-screen', page: () => OrderDetailsMovmentMangerScreen(), binding: GolbalBindings()),
      ],
    );
  }
}

class StatusSteper extends StatefulWidget {
  StatusSteper({Key? key}) : super(key: key);

  @override
  State<StatusSteper> createState() => _StatusSteperState();
}

class _StatusSteperState extends State<StatusSteper> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
