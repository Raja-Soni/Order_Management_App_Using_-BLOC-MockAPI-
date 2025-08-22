import 'package:erp_using_api/bloc/alert_pop_up/alert_popup_bloc.dart';
import 'package:erp_using_api/bloc/alert_pop_up/alert_popup_state.dart';
import 'package:erp_using_api/bloc/api_data/api_db_bloc.dart';
import 'package:erp_using_api/bloc/api_data/api_db_events.dart';
import 'package:erp_using_api/bloc/api_data/api_db_states.dart';
import 'package:erp_using_api/bloc/dark_theme_mode/dark_theme_bloc.dart';
import 'package:erp_using_api/bloc/dark_theme_mode/dark_theme_event.dart';
import 'package:erp_using_api/bloc/dark_theme_mode/dark_theme_state.dart';
import 'package:erp_using_api/bloc/new_order/new_order_bloc.dart';
import 'package:erp_using_api/pages/homepage.dart';
import 'package:erp_using_api/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'AppColors/app_colors.dart';
import 'bloc/alert_pop_up/alert_popup_events.dart';
import 'custom_widgets/custom_alert_box.dart';

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
            home: MyHomePage(),
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
            if (!pendingPopUpShown) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                int pendingOrders = alertPopUpState.pendingOrders;
                int totalPendingAmount =
                    alertPopUpState.totalPendingOrderAmount;
                showDialog(
                  context: context,
                  builder: (context) => BlocBuilder<DarkThemeBloc, DarkThemeState>(
                    builder: (context, darkThemeState) => CustomAlertBox(
                      backgroundColor: darkThemeState.darkTheme
                          ? AppColor.darkThemeColor
                          : AppColor.lightThemeColor,
                      buttonTextColor: darkThemeState.darkTheme
                          ? AppColor.lightThemeColor
                          : AppColor.darkThemeColor,
                      confirmationButtonColor: darkThemeState.darkTheme
                          ? AppColor.buttonDarkThemeColor
                          : AppColor.lightThemeColor,
                      title: "Pending Orders",
                      message:
                          "You have $pendingOrders pending orders today worth ₹$totalPendingAmount",
                    ),
                  ),
                ).then((_) {
                  context.read<AlertPopUpBloc>().add(
                    PendingPopupShown(isShown: true),
                  );
                });
              });
            }
            bool limitCrossPopUpShow = alertPopUpState.limitPopUpShow;
            if (limitCrossPopUpShow == false &&
                alertPopUpState.apiStatus == Status.success) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return BlocBuilder<DarkThemeBloc, DarkThemeState>(
                      builder: (context, darkThemeState) => CustomAlertBox(
                        backgroundColor: darkThemeState.darkTheme
                            ? AppColor.darkThemeColor
                            : AppColor.lightThemeColor,
                        buttonTextColor: darkThemeState.darkTheme
                            ? AppColor.lightThemeColor
                            : AppColor.darkThemeColor,
                        confirmationButtonColor: darkThemeState.darkTheme
                            ? AppColor.buttonDarkThemeColor
                            : AppColor.lightThemeColor,
                        title: "High Amount Orders",
                        message:
                            "${alertPopUpState.limitCrossedOrders} order's crossed ₹10,000/-",
                      ),
                    );
                  },
                ).then((_) {
                  context.read<AlertPopUpBloc>().add(
                    LimitCrossedPopupShown(show: true),
                  );
                });
              });
            }
          },
        ),
      ],
      child: HomePage(),
    );
  }
}
