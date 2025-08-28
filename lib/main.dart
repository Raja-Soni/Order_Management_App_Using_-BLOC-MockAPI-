import 'package:erp_using_api/bloc/alert_pop_up/alert_popup_bloc_events_state.dart';
import 'package:erp_using_api/bloc/api_data/api_bloc_events_state.dart';
import 'package:erp_using_api/bloc/dark_theme_mode/dark_theme_bloc_events_state.dart';
import 'package:erp_using_api/bloc/new_order/new_order_bloc_events_state.dart';
import 'package:erp_using_api/custom_widgets/import_all_custom_widgets.dart';
import 'package:erp_using_api/pages/all_pages.dart';
import 'package:erp_using_api/routes/all_routes.dart';
import 'package:erp_using_api/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'AppColors/app_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => APIDataBaseBloc()),
        BlocProvider(create: (_) => DarkThemeBloc()),
        BlocProvider(
          create: (context) => NewOrderBloc(context.read<APIDataBaseBloc>()),
        ),
        BlocProvider(
          create: (context) =>
              (AlertPopUpBloc(context.read<APIDataBaseBloc>())),
        ),
      ],
      child: BlocBuilder<DarkThemeBloc, DarkThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'ERP Mini Application',
            debugShowCheckedModeBanner: false,
            themeMode: state.darkTheme ? ThemeMode.dark : ThemeMode.light,
            darkTheme: ThemeData.dark().copyWith(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Colors.black,
              appBarTheme: AppBarTheme(
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                backgroundColor: AppColor.appbarDarkThemeColor,
              ),
            ),
            theme: ThemeData().copyWith(
              brightness: Brightness.light,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                backgroundColor: AppColor.appbarLightThemeColor,
              ),
            ),
            initialRoute: RouteNames.homePage,
            onGenerateRoute: Routes.generateRoute,
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<AlertPopUpBloc>().add(GetHighOrderAlert());
    context.read<APIDataBaseBloc>().add(FetchOnlineData());
    context.read<DarkThemeBloc>().add(GetDarkModePreference());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<APIDataBaseBloc, APIDataBaseStates>(
          listener: (context, apiState) {
            if (apiState.apiStatus == Status.success) {
              context.read<AlertPopUpBloc>().add(
                GetPendingAndLimitCrossedOrders(),
              );
            }
          },
        ),
        BlocListener<AlertPopUpBloc, AlertPopUpStates>(
          listenWhen: (old, latest) =>
              old.limitCrossedOrders != latest.limitCrossedOrders,
          listener: (context, alertPopUpState) {
            bool pendingPopUpShown = alertPopUpState.pendingPopUpShow;
            Future<void> showPopUP(String title, String message) async {
              await showDialog(
                context: context,
                builder: (context) =>
                    BlocBuilder<DarkThemeBloc, DarkThemeState>(
                      builder: (context, darkThemeState) => CustomAlertBox(
                        backgroundColor: darkThemeState.darkTheme
                            ? AppColor.darkThemeColor
                            : AppColor.lightThemeColor,
                        buttonTextColor: darkThemeState.darkTheme
                            ? AppColor.alertBtnTextDarkColor
                            : AppColor.alertBtnTextLightColor,
                        confirmationButtonColor: darkThemeState.darkTheme
                            ? AppColor.alertBtnDarkColor
                            : AppColor.alertBtnLightColor,
                        title: title,
                        message: message,
                      ),
                    ),
              );
            }

            if (alertPopUpState.lastHighOrderCustomerName.isNotEmpty &&
                alertPopUpState.lastHighOrderCustomerAmount > 0 &&
                alertPopUpState.highOrderAlertPopupShow == false) {
              showPopUP(
                "High Order Alert",
                "Last Highest amount Order was ₹ ${alertPopUpState.lastHighOrderCustomerAmount}/- from (${alertPopUpState.lastHighOrderCustomerName})",
              ).then((_) {
                if (!context.mounted) return;
                context.read<AlertPopUpBloc>().add(ClearHighOrderAlert());
                if (!pendingPopUpShown) {
                  int pendingOrders = alertPopUpState.pendingOrders;
                  int totalPendingAmount =
                      alertPopUpState.totalPendingOrderAmount;
                  showPopUP(
                    "Pending Orders",
                    "Among the first 10 orders, You have $pendingOrders pending orders today worth ₹ $totalPendingAmount/-",
                  ).then((_) {
                    if (!context.mounted) return;
                    context.read<AlertPopUpBloc>().add(
                      PendingPopupShown(isShown: true),
                    );
                  });
                }
              });
            } else {
              if (!pendingPopUpShown) {
                int pendingOrders = alertPopUpState.pendingOrders;
                int totalPendingAmount =
                    alertPopUpState.totalPendingOrderAmount;
                showPopUP(
                  "Pending Orders",
                  "Among the first 10 orders, You have $pendingOrders pending orders today worth ₹ $totalPendingAmount/-",
                ).then((_) {
                  if (!context.mounted) return;
                  context.read<AlertPopUpBloc>().add(
                    PendingPopupShown(isShown: true),
                  );
                });
              }
            }
            bool limitCrossPopUpShow = alertPopUpState.limitPopUpShow;
            if (limitCrossPopUpShow == false &&
                alertPopUpState.apiStatus == Status.success) {
              showPopUP(
                "High Amount Orders",
                "Among the first 10 orders, ${alertPopUpState.limitCrossedOrders} have crossed ₹ 10,000/-",
              ).then((_) {
                if (!context.mounted) return;
                context.read<AlertPopUpBloc>().add(
                  LimitCrossedPopupShown(show: true),
                );
              });
            }
          },
        ),
      ],
      child: DashboardPage(),
    );
  }
}
