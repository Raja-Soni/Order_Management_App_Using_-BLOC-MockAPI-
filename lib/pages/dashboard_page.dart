import 'package:erp_using_api/custom_widgets/import_all_custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../AppColors/app_colors.dart';
import '../bloc/api_data/api_bloc_events_state.dart';
import '../bloc/dark_theme_mode/dark_theme_bloc_events_state.dart';
import '../routes/all_routes.dart';
import '../utils/enums.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<DarkThemeBloc, DarkThemeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              surfaceTintColor: AppColor.transparentColor,
              leading: Icon(Icons.list, size: 40, color: Colors.white),
              title: CustomText(
                text: "Order List",
                textSize: 33,
                textBoldness: FontWeight.bold,
                textColor: AppColor.appbarTitleTextColor,
              ),
              actions: [
                Switch(
                  padding: EdgeInsets.only(right: 30),
                  trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
                  activeTrackColor: AppColor.switchActiveTrackColor,
                  inactiveTrackColor: AppColor.switchInactiveTrackColor,
                  activeThumbImage: AssetImage("assets/images/dark_mode.jpg"),
                  inactiveThumbImage: AssetImage(
                    "assets/images/light_mode.png",
                  ),
                  value: state.darkTheme,
                  onChanged: (value) {
                    context.read<DarkThemeBloc>().add(
                      DarkModeToggleAndPreference(darkModeToggle: value),
                    );
                  },
                ),
              ],
            ),
            body: BlocBuilder<DarkThemeBloc, DarkThemeState>(
              builder: (context, darkModeState) {
                return BlocBuilder<APIDataBaseBloc, APIDataBaseStates>(
                  builder: (context, apiDbState) {
                    final dataList = apiDbState.dataList;
                    if (apiDbState.apiStatus == Status.loading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: darkModeState.darkTheme
                              ? AppColor.circularProgressDarkColor
                              : AppColor.circularProgressLightColor,
                        ),
                      );
                    } else if (apiDbState.apiStatus == Status.failure) {
                      return Center(
                        child: CustomText(text: apiDbState.message.toString()),
                      );
                    } else {
                      return CustomContainer(
                        child: Column(
                          children: [
                            CustomContainer(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 15.0,
                                  right: 10.0,
                                  top: 10.0,
                                  bottom: 7.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: "Order Details",
                                      textSize: 30,
                                      textColor: darkModeState.darkTheme
                                          ? AppColor.textDarkThemeColor
                                          : AppColor.textLightThemeColor,
                                    ),
                                    Card(
                                      elevation: 6,
                                      color: darkModeState.darkTheme
                                          ? AppColor.darkThemeColor
                                          : AppColor.lightThemeColor,
                                      child: DropdownButton(
                                        style: TextStyle(
                                          color: darkModeState.darkTheme
                                              ? AppColor.textDarkThemeColor
                                              : AppColor.textLightThemeColor,
                                        ),
                                        dropdownColor: darkModeState.darkTheme
                                            ? AppColor.darkThemeColor
                                            : AppColor.lightThemeColor,
                                        icon: Icon(
                                          Icons.tune,
                                          color: darkModeState.darkTheme
                                              ? AppColor.iconDarkThemeColor
                                              : AppColor.iconLightThemeColor,
                                        ),
                                        iconSize: 25,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        value: apiDbState.filter,
                                        underline: SizedBox.shrink(),
                                        items: [
                                          DropdownMenuItem(
                                            value: Filters.all,
                                            child: CustomText(
                                              text: "All Orders",
                                            ),
                                          ),
                                          DropdownMenuItem(
                                            value: Filters.today,
                                            child: CustomText(
                                              text: "Today Orders",
                                            ),
                                          ),
                                          DropdownMenuItem(
                                            value: Filters.pending,
                                            child: CustomText(
                                              text: "Pending Orders",
                                            ),
                                          ),
                                          DropdownMenuItem(
                                            value: Filters.delivered,
                                            child: CustomText(
                                              text: "Delivered Orders",
                                            ),
                                          ),
                                          DropdownMenuItem(
                                            value: Filters.cancelled,
                                            child: CustomText(
                                              text: "Cancelled Orders",
                                            ),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          if (value != null) {
                                            context.read<APIDataBaseBloc>().add(
                                              ApplyFilter(filter: value),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            dataList.isEmpty
                                ? Expanded(
                                    child: Center(
                                      child: CustomText(
                                        textSize: 40,
                                        text:
                                            "${apiDbState.filter.name.toString().substring(0, 1).toUpperCase() + apiDbState.filter.name.toString().substring(1).toLowerCase()} orders: ${dataList.length}",
                                        textBoldness: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: NotificationListener(
                                      onNotification:
                                          (
                                            ScrollNotification notificationInfo,
                                          ) {
                                            if (notificationInfo
                                                        .metrics
                                                        .pixels ==
                                                    notificationInfo
                                                        .metrics
                                                        .maxScrollExtent &&
                                                apiDbState.filter ==
                                                    Filters.all) {
                                              context
                                                  .read<APIDataBaseBloc>()
                                                  .add(
                                                    FetchMoreData(
                                                      page: apiDbState.page + 1,
                                                    ),
                                                  );
                                            }
                                            return false;
                                          },
                                      child: ListView.separated(
                                        itemCount:
                                            dataList.length +
                                            (apiDbState.hasMoreData ? 1 : 0),
                                        padding: EdgeInsets.only(
                                          top: 3,
                                          left: 10,
                                          right: 10,
                                          bottom: 80,
                                        ),
                                        separatorBuilder: (context, index) =>
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10.0,
                                                  ),
                                              child: Divider(
                                                color: darkModeState.darkTheme
                                                    ? AppColor.dividerDarkColor
                                                    : AppColor
                                                          .dividerLightColor,
                                              ),
                                            ),
                                        itemBuilder: (context, index) {
                                          if (index == dataList.length &&
                                              apiDbState.hasMoreData) {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: darkModeState.darkTheme
                                                    ? AppColor
                                                          .circularProgressDarkColor
                                                    : AppColor
                                                          .circularProgressLightColor,
                                              ),
                                            );
                                          } else {
                                            return Card(
                                              elevation: 6,
                                              color: darkModeState.darkTheme
                                                  ? AppColor.darkThemeColor
                                                  : AppColor.lightThemeColor,
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                splashColor:
                                                    AppColor.confirmColor,
                                                onTap: () {
                                                  context
                                                      .read<APIDataBaseBloc>()
                                                      .add(
                                                        DetailedOrderPage(
                                                          selectedOrderIndex:
                                                              index,
                                                        ),
                                                      );
                                                  Navigator.pushNamed(
                                                    context,
                                                    RouteNames
                                                        .detailedOrderPage,
                                                  );
                                                },
                                                child: ListTile(
                                                  minLeadingWidth: 0.0,
                                                  textColor:
                                                      darkModeState.darkTheme
                                                      ? AppColor
                                                            .textDarkThemeColor
                                                      : AppColor
                                                            .textLightThemeColor,
                                                  isThreeLine: true,
                                                  leading: Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 3.0,
                                                    ),
                                                    child: CustomText(
                                                      textSize: 20,
                                                      text:
                                                          "${(index + 1).toString()})",
                                                    ),
                                                  ),

                                                  title: CustomText(
                                                    textSize: 20,
                                                    text:
                                                        dataList[index].customer
                                                            .toString()
                                                            .substring(0, 1)
                                                            .toUpperCase() +
                                                        dataList[index].customer
                                                            .toString()
                                                            .substring(1),
                                                  ),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomText(
                                                        textSize: 16,
                                                        text:
                                                            '${dataList[index].dateAndTime.toString().split(' ').first}',
                                                      ),
                                                      CustomText(
                                                        textSize: 16,
                                                        text:
                                                            '₹ ${dataList[index].amount}/-',
                                                        textColor:
                                                            darkModeState
                                                                .darkTheme
                                                            ? AppColor
                                                                  .amountTextDarkThemeColor
                                                            : AppColor
                                                                  .amountTextLightThemeColor,
                                                      ),
                                                    ],
                                                  ),
                                                  trailing: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    spacing: 5,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      CustomContainer(
                                                        height: 25,
                                                        width: 90,
                                                        backgroundColor:
                                                            getStatusColor(
                                                              dataList[index]
                                                                  .status
                                                                  .toString(),
                                                            ),
                                                        borderRadius: 20,
                                                        child: Center(
                                                          child: CustomText(
                                                            text:
                                                                dataList[index]
                                                                    .status
                                                                    .toString(),
                                                            textSize: 15,
                                                            textColor:
                                                                Colors.white,
                                                            textBoldness:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      IconButton(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        alignment:
                                                            AlignmentGeometry.xy(
                                                              3.3,
                                                              3.3,
                                                            ),
                                                        highlightColor:
                                                            Colors.red.shade200,
                                                        onPressed: () {
                                                          context
                                                              .read<
                                                                APIDataBaseBloc
                                                              >()
                                                              .add(
                                                                DeleteItem(
                                                                  id: dataList[index]
                                                                      .id,
                                                                  filter:
                                                                      apiDbState
                                                                          .filter,
                                                                ),
                                                              );
                                                        },
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color:
                                                              Colors.redAccent,
                                                          size: 34,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      );
                    }
                  },
                );
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton:
                BlocBuilder<APIDataBaseBloc, APIDataBaseStates>(
                  builder: (context, apiDbState) {
                    return BlocBuilder<DarkThemeBloc, DarkThemeState>(
                      builder: (context, darkModeState) {
                        if (apiDbState.apiStatus == Status.loading ||
                            apiDbState.apiStatus == Status.failure) {
                          return SizedBox.shrink();
                        } else {
                          return CustomButton(
                            height: 50,
                            backgroundColor: darkModeState.darkTheme
                                ? AppColor.buttonDarkThemeColor
                                : AppColor.buttonLightThemeColor,
                            width: MediaQuery.of(context).size.width / 2,
                            buttonText: "Add New Order",
                            callback: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.newSalesOrderPage,
                              );
                            },
                          );
                        }
                      },
                    );
                  },
                ),
          );
        },
      ),
    );
  }
}
