import 'package:erp_using_api/bloc/api_data/api_bloc_events_state.dart';
import 'package:erp_using_api/bloc/dark_theme_mode/dark_theme_bloc_events_state.dart';
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
      body: BlocBuilder<APIDataBaseBloc, APIDataBaseStates>(
        builder: (context, apiState) {
          if (apiState.apiStatus == Status.success)
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text:
                          "Customer/Company: ${apiState.dataList[apiState.selectedOrderIndex].customer}",
                      textSize: 25,
                    ),
                    CustomText(
                      text:
                          "Total Order Amount: ₹${apiState.dataList[apiState.selectedOrderIndex].amount}/-",
                      textSize: 22,
                    ),
                    Row(
                      children: [
                        CustomText(text: "Order Status: ", textSize: 22),
                        CustomContainer(
                          height: 25,
                          width: 90,
                          backgroundColor:
                              apiState
                                      .dataList[apiState.selectedOrderIndex]
                                      .status ==
                                  "Delivered"
                              ? Colors.green
                              : Colors.orange,
                          borderRadius: 20,
                          child: Center(
                            child: CustomText(
                              text: apiState
                                  .dataList[apiState.selectedOrderIndex]
                                  .status
                                  .toString(),
                              textSize: 15,
                              textColor: Colors.white,
                              textBoldness: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomText(
                      text:
                          "Order Date: ${apiState.dataList[apiState.selectedOrderIndex].dateAndTime.toString().split(" ").first}",
                      textSize: 20,
                    ),
                    CustomText(
                      text:
                          "Order Time: ${apiState.dataList[apiState.selectedOrderIndex].dateAndTime.toString().split(" ").last.split(".").first}",
                      textSize: 20,
                    ),
                    CustomContainer(
                      backgroundColor: AppColor.confirmColor,
                      borderRadius: 10,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.0, top: 5, bottom: 5),
                        child: Row(
                          children: [
                            CustomText(text: "#"),
                            SizedBox(width: 30),
                            CustomText(text: "Items"),
                            SizedBox(width: 58),
                            CustomText(text: "Price"),
                            SizedBox(width: 18),
                            CustomText(text: "Quantity"),
                            SizedBox(width: 40),
                            CustomText(text: "Total"),
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<DarkThemeBloc, DarkThemeState>(
                      builder: (context, darkThemeState) {
                        return CustomContainer(
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.height,
                          backgroundColor: darkThemeState.darkTheme
                              ? AppColor.darkThemeColor
                              : AppColor.lightGreyColor,
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
                                    leading: CustomText(text: "${index + 1}"),
                                    title: Row(
                                      spacing: 10,
                                      children: [
                                        Expanded(
                                          child: CustomText(
                                            text:
                                                "${apiState.dataList[apiState.selectedOrderIndex].newOrderDetails![index].itemName}",
                                            maxLinesAllowed: 1,
                                            textOverflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Expanded(
                                          child: CustomText(
                                            alignment: TextAlign.right,
                                            text:
                                                "${apiState.dataList[apiState.selectedOrderIndex].newOrderDetails![index].price}/-",
                                            textOverflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Expanded(
                                          child: CustomText(
                                            alignment: TextAlign.center,
                                            text:
                                                "${apiState.dataList[apiState.selectedOrderIndex].newOrderDetails![index].quantity}",
                                            textOverflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Expanded(
                                          child: CustomText(
                                            alignment: TextAlign.end,
                                            text:
                                                "₹${apiState.dataList[apiState.selectedOrderIndex].newOrderDetails![index].totalItemsPrice}",
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
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          height: 60,
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
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
