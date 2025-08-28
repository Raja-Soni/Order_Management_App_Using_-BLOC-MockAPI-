import 'package:erp_using_api/custom_widgets/custom_text.dart';
import 'package:erp_using_api/main.dart';
import 'package:erp_using_api/pages/new_sales_order_page.dart';
import 'package:erp_using_api/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.homePage:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const MyHomePage(),
        );
      case RouteNames.newSalesOrderPage:
        return PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          child: NewSalesOrderPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: CustomText(
                text: "Error",
                textSize: 25,
                textBoldness: FontWeight.bold,
              ),
            ),
            body: Center(
              child: CustomText(
                text: "404-Page Not Found",
                textSize: 30,
                textBoldness: FontWeight.bold,
              ),
            ),
          ),
        );
    }
  }
}
