import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wits_app/main.dart';

class AuthMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    int? roleId = sharedPreferences!.getInt('role');
    if (roleId == 6)
      return RouteSettings(name: '/movment-manger-root-screen');
    else if (roleId == 5)
      return RouteSettings(name: '/sales-manger-root-screen');
    else if (roleId == 4)
      return RouteSettings(name: '/sales-employee-root-screen');
    else if (roleId == 3)
      return RouteSettings(name: '/salesman-root-screen');
    else if (roleId == 7)
      return RouteSettings(name: '/warehouse-manger-root-screen');
    else if (roleId == 8)
      return RouteSettings(name: '/prepartion-worker-root-screen');
    else if (roleId == 17)
      return RouteSettings(name: '/return-manger-root-screen');
    else if (roleId == 2)
      return RouteSettings(name: '/driver-root-screen');
    else if (roleId == 10)
      return RouteSettings(name: '/quality-supervisor-root-screen');
    else if (roleId == 9)
      return RouteSettings(name: '/incpection-officer-root-screen');
    else if (roleId == 11) return RouteSettings(name: '/general-manager-root-screen');
  }
}
