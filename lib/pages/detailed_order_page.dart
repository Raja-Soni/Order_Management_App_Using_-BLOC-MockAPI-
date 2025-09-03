import 'package:erp_using_api/bloc/api_data/api_bloc_events_state.dart';
import 'package:erp_using_api/bloc/dark_theme_mode/dark_theme_bloc_events_state.dart';
import 'package:erp_using_api/bloc/new_order/new_order_bloc_events_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../AppColors/app_colors.dart';
import '../custom_widgets/import_all_custom_widgets.dart';
import '../utils/enums.dart';

class DetailedOrderPage extends StatefulWidget {
  const DetailedOrderPage();
  @override
  State<DetailedOrderPage> createState() => DetailedOrderPageState();
}

class DetailedOrderPageState extends State<DetailedOrderPage> {
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColor.transparentColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_rounded, color: AppColor.lightThemeColor),
        ),
        title: CustomText(
          text: "Order Details",
          textSize: 30,
          textBoldness: FontWeight.bold,
          textColor: AppColor.appbarTitleTextColor,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<DarkThemeBloc, DarkThemeState>(
        builder: (context, darkThemeState) {
          return BlocBuilder<APIDataBaseBloc, APIDataBaseStates>(
            buildWhen: (prev, curr) => prev.dataList != curr.dataList,
            builder: (context, apiState) {
              if (apiState.apiStatus == Status.success)
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomContainer(
                          borderRadius: 10,
                          backgroundColor: darkThemeState.darkTheme
                              ? AppColor.scaffoldDarkBackgroundColor
                              : AppColor.scaffoldLightBackgroundColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text:
                                    "Customer/Company: ${apiState.dataList[apiState.selectedOrderIndex].customer}",
                                textSize: 24,
                                textBoldness: FontWeight.bold,
                              ),
                              Divider(
                                color: darkThemeState.darkTheme
                                    ? AppColor.dividerDarkColor
                                    : AppColor.dividerLightColor,
                              ),
                              Row(
                                children: [
                                  CustomText(
                                    text: "Total: ",
                                    textSize: 20,
                                    textBoldness: FontWeight.bold,
                                  ),
                                  CustomText(
                                    text:
                                        " ₹${apiState.dataList[apiState.selectedOrderIndex].amount}/-",
                                    textSize: 20,
                                    textBoldness: FontWeight.bold,
                                    textColor: darkThemeState.darkTheme
                                        ? AppColor.amountTextDarkThemeColor
                                        : AppColor.amountTextLightThemeColor,
                                  ),
                                ],
                              ),
                              Divider(
                                color: darkThemeState.darkTheme
                                    ? AppColor.dividerDarkColor
                                    : AppColor.dividerLightColor,
                              ),
                              Row(
                                children: [
                                  CustomText(
                                    text:
                                        "Date: ${apiState.dataList[apiState.selectedOrderIndex].dateAndTime.toString().split(" ").first}",
                                    textSize: 20,
                                  ),
                                  SizedBox(width: 50),
                                  CustomText(
                                    text:
                                        "Time: ${apiState.dataList[apiState.selectedOrderIndex].dateAndTime.toString().split(" ").last.split(".").first}",
                                    textSize: 20,
                                  ),
                                ],
                              ),
                              Divider(
                                color: darkThemeState.darkTheme
                                    ? AppColor.dividerDarkColor
                                    : AppColor.dividerLightColor,
                              ),
                            ],
                          ),
                        ),
                        BlocBuilder<NewOrderBloc, NewOrderState>(
                          builder: (context, orderState) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: " Order Status:  ",
                                  textSize: 30,
                                ),
                                Row(
                                  children: [
                                    CustomContainer(
                                      height: 30,
                                      width: 120,
                                      backgroundColor: getStatusColor(
                                        apiState
                                            .dataList[apiState
                                                .selectedOrderIndex]
                                            .status
                                            .toString(),
                                      ),
                                      borderRadius: 20,
                                      child: Center(
                                        child: CustomText(
                                          text: apiState
                                              .dataList[apiState
                                                  .selectedOrderIndex]
                                              .status
                                              .toString(),
                                          textSize: 18,
                                          textColor: AppColor.whiteColor,
                                          textBoldness: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return BlocBuilder<
                                              APIDataBaseBloc,
                                              APIDataBaseStates
                                            >(
                                              buildWhen: (prev, curr) =>
                                                  prev.apiStatus !=
                                                  curr.apiStatus,
                                              builder: (context, apiState) {
                                                return AlertDialog(
                                                  backgroundColor:
                                                      darkThemeState.darkTheme
                                                      ? AppColor.darkThemeColor
                                                      : AppColor
                                                            .lightThemeColor,
                                                  title: Center(
                                                    child: CustomText(
                                                      text:
                                                          apiState.apiStatus ==
                                                              Status.loading
                                                          ? "Changing Order Status"
                                                          : "Order Status",
                                                      textSize: 20,
                                                      textBoldness:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  content:
                                                      apiState.apiStatus ==
                                                          Status.loading
                                                      ? SizedBox(
                                                          height: 50,
                                                          child: Center(
                                                            child: CircularProgressIndicator(
                                                              color:
                                                                  darkThemeState
                                                                      .darkTheme
                                                                  ? AppColor
                                                                        .circularProgressDarkColor
                                                                  : AppColor
                                                                        .circularProgressLightColor,
                                                            ),
                                                          ),
                                                        )
                                                      : Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Radio(
                                                                  activeColor:
                                                                      AppColor
                                                                          .confirmColor,
                                                                  value:
                                                                      "Pending",
                                                                  groupValue: apiState
                                                                      .dataList[apiState
                                                                          .selectedOrderIndex]
                                                                      .status,
                                                                  onChanged: (value) {
                                                                    context
                                                                        .read<
                                                                          APIDataBaseBloc
                                                                        >()
                                                                        .add(
                                                                          UpdateSelectedOrderStatus(
                                                                            id: apiState.dataList[apiState.selectedOrderIndex].id!,
                                                                            updateStatus:
                                                                                value!,
                                                                          ),
                                                                        );
                                                                  },
                                                                ),
                                                                CustomText(
                                                                  text:
                                                                      "Order Pending",
                                                                  textSize: 20,
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(width: 30),
                                                            Row(
                                                              children: [
                                                                Radio(
                                                                  activeColor:
                                                                      AppColor
                                                                          .confirmColor,
                                                                  value:
                                                                      "Delivered",
                                                                  groupValue: apiState
                                                                      .dataList[apiState
                                                                          .selectedOrderIndex]
                                                                      .status,
                                                                  onChanged: (value) {
                                                                    context
                                                                        .read<
                                                                          APIDataBaseBloc
                                                                        >()
                                                                        .add(
                                                                          UpdateSelectedOrderStatus(
                                                                            id: apiState.dataList[apiState.selectedOrderIndex].id!,
                                                                            updateStatus:
                                                                                value!,
                                                                          ),
                                                                        );
                                                                  },
                                                                ),
                                                                CustomText(
                                                                  text:
                                                                      "Order Delivered",
                                                                  textSize: 20,
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(width: 30),
                                                            Row(
                                                              children: [
                                                                Radio(
                                                                  activeColor:
                                                                      AppColor
                                                                          .confirmColor,
                                                                  value:
                                                                      "Cancelled",
                                                                  groupValue: apiState
                                                                      .dataList[apiState
                                                                          .selectedOrderIndex]
                                                                      .status,
                                                                  onChanged: (value) {
                                                                    context
                                                                        .read<
                                                                          APIDataBaseBloc
                                                                        >()
                                                                        .add(
                                                                          UpdateSelectedOrderStatus(
                                                                            id: apiState.dataList[apiState.selectedOrderIndex].id!,
                                                                            updateStatus:
                                                                                value!,
                                                                          ),
                                                                        );
                                                                  },
                                                                ),
                                                                CustomText(
                                                                  text:
                                                                      "Order Cancelled",
                                                                  textSize: 20,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                  actions:
                                                      apiState.apiStatus ==
                                                          Status.loading
                                                      ? []
                                                      : [
                                                          ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  darkThemeState
                                                                      .darkTheme
                                                                  ? AppColor
                                                                        .alertBtnDarkColor
                                                                  : AppColor
                                                                        .alertBtnLightColor,
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                context,
                                                              );
                                                            },
                                                            child: CustomText(
                                                              text: "OK",
                                                              textColor:
                                                                  darkThemeState
                                                                      .darkTheme
                                                                  ? AppColor
                                                                        .textDarkThemeColor
                                                                  : AppColor
                                                                        .textLightThemeColor,
                                                            ),
                                                          ),
                                                        ],
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        size: 30,
                                        color: darkThemeState.darkTheme
                                            ? AppColor.editIconDarkThemeColor
                                            : AppColor.editIconLightThemeColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                        Column(
                          spacing: 10,
                          children: [
                            CustomContainer(
                              backgroundColor: darkThemeState.darkTheme
                                  ? AppColor.darkBlueGreyColor
                                  : AppColor.blueGreyColor,
                              borderRadius: 10,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 15.0,
                                  top: 5,
                                  bottom: 5,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: orientation == Orientation.portrait
                                          ? 0
                                          : 40,
                                    ),
                                    CustomText(
                                      text: "#",
                                      textColor: AppColor.whiteColor,
                                    ),
                                    SizedBox(
                                      width: orientation == Orientation.portrait
                                          ? 30
                                          : 28,
                                    ),
                                    CustomText(
                                      text: "Items",
                                      textColor: AppColor.whiteColor,
                                    ),
                                    SizedBox(
                                      width: orientation == Orientation.portrait
                                          ? 55
                                          : 302,
                                    ),
                                    CustomText(
                                      text: "Price",
                                      textColor: AppColor.whiteColor,
                                    ),
                                    SizedBox(
                                      width: orientation == Orientation.portrait
                                          ? 17
                                          : 73,
                                    ),
                                    CustomText(
                                      text: "Quantity",
                                      textColor: AppColor.whiteColor,
                                    ),
                                    SizedBox(
                                      width: orientation == Orientation.portrait
                                          ? 30
                                          : 210,
                                    ),
                                    CustomText(
                                      text: "Total",
                                      textColor: AppColor.whiteColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            CustomContainer(
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width,
                              backgroundColor: darkThemeState.darkTheme
                                  ? AppColor.containerDarkThemeColor
                                  : AppColor.containerLightThemeColor,
                              borderRadius: 10,
                              child: Expanded(
                                child: ListView.builder(
                                  itemCount: apiState
                                      .dataList[apiState.selectedOrderIndex]
                                      .newOrderDetails!
                                      .length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      color: darkThemeState.darkTheme
                                          ? AppColor.darkThemeColor
                                          : AppColor.lightThemeColor,
                                      child: ListTile(
                                        leading: CustomText(
                                          text: "${index + 1}",
                                        ),
                                        title: Row(
                                          spacing: 10,
                                          children: [
                                            Expanded(
                                              child: CustomText(
                                                text:
                                                    "${apiState.dataList[apiState.selectedOrderIndex].newOrderDetails![index].itemName}",
                                                maxLinesAllowed: 1,
                                                textOverflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Expanded(
                                              child: CustomText(
                                                alignment: TextAlign.right,
                                                text:
                                                    "${apiState.dataList[apiState.selectedOrderIndex].newOrderDetails![index].price}/-",
                                                textOverflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Expanded(
                                              child: CustomText(
                                                alignment: TextAlign.center,
                                                text:
                                                    "${apiState.dataList[apiState.selectedOrderIndex].newOrderDetails![index].quantity}",
                                                textOverflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Expanded(
                                              child: CustomText(
                                                alignment: TextAlign.end,
                                                text:
                                                    "₹${apiState.dataList[apiState.selectedOrderIndex].newOrderDetails![index].totalItemsPrice}/-",
                                                maxLinesAllowed: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              backgroundColor: darkThemeState.darkTheme
                                  ? AppColor.buttonDarkThemeColor
                                  : AppColor.buttonLightThemeColor,
                              height: 50,
                              width: 120,
                              buttonText: "Go Back",
                              callback: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              else
                return Center(
                  child: CircularProgressIndicator(
                    color: darkThemeState.darkTheme
                        ? AppColor.circularProgressDarkColor
                        : AppColor.circularProgressLightColor,
                  ),
                );
            },
          );
        },
      ),
    );
  }
}
