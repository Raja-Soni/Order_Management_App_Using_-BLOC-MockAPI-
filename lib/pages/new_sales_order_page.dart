import 'package:erp_using_api/bloc/alert_pop_up/alert_popup_bloc_events_state.dart';
import 'package:erp_using_api/bloc/dark_theme_mode/dark_theme_bloc_events_state.dart';
import 'package:erp_using_api/bloc/new_order/new_order_bloc_events_state.dart';
import 'package:erp_using_api/custom_widgets/import_all_custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../AppColors/app_colors.dart';

class NewSalesOrderPage extends StatefulWidget {
  const NewSalesOrderPage({super.key});

  @override
  State<NewSalesOrderPage> createState() => NewSalesOrderPageState();
}

class NewSalesOrderPageState extends State<NewSalesOrderPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    context.read<NewOrderBloc>().add(InitialState());
  }

  @override
  Widget build(BuildContext context) {
    final message = ScaffoldMessenger.of(context);
    final orientation = MediaQuery.of(context).orientation;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: AppColor.transparentColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: AppColor.lightThemeColor,
            ),
          ),
          title: CustomText(
            text: "Add New Order",
            textSize: 30,
            textBoldness: FontWeight.bold,
            textColor: AppColor.appbarTitleTextColor,
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<DarkThemeBloc, DarkThemeState>(
          builder: (context, darkModeState) {
            return BlocBuilder<NewOrderBloc, NewOrderState>(
              builder: (context, newOrderState) {
                final navigator = Navigator.of(context);
                return CustomContainer(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 15,
                        children: [
                          CustomFormTextField(
                            inputType: TextInputType.name,
                            hintText: "Enter Customer/Company Name",
                            icon: Icon(Icons.person_outlined),
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Name";
                              }
                              return null;
                            },
                            changedValue: (value) {
                              context.read<NewOrderBloc>().add(
                                CustomerNameGivenEvent(name: value!),
                              );
                              return null;
                            },
                          ),
                          if (newOrderState.itemDetails.isEmpty)
                            SizedBox.shrink()
                          else
                            Column(
                              children: [
                                CustomContainer(
                                  backgroundColor: darkModeState.darkTheme
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
                                        SizedBox(width: 8),
                                        CustomText(
                                          text: "#",
                                          textColor: AppColor.whiteColor,
                                        ),
                                        SizedBox(
                                          width:
                                              orientation ==
                                                  Orientation.portrait
                                              ? 25
                                              : 28,
                                        ),
                                        CustomText(
                                          text: "Items",
                                          textColor: AppColor.whiteColor,
                                        ),
                                        SizedBox(
                                          width:
                                              orientation ==
                                                  Orientation.portrait
                                              ? 33
                                              : 270,
                                        ),
                                        CustomText(
                                          text: "Price",
                                          textColor: AppColor.whiteColor,
                                        ),
                                        SizedBox(
                                          width:
                                              orientation ==
                                                  Orientation.portrait
                                              ? 28
                                              : 58,
                                        ),
                                        CustomText(
                                          text:
                                              orientation ==
                                                  Orientation.portrait
                                              ? "Qty"
                                              : "Quantity",
                                          textColor: AppColor.whiteColor,
                                        ),
                                        SizedBox(
                                          width:
                                              orientation ==
                                                  Orientation.portrait
                                              ? 38
                                              : 190,
                                        ),
                                        CustomText(
                                          text: "Total",
                                          textColor: AppColor.whiteColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                CustomContainer(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  borderRadius: 10,
                                  backgroundColor: darkModeState.darkTheme
                                      ? AppColor.containerDarkThemeColor
                                      : AppColor.containerLightThemeColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: ListView.builder(
                                      itemCount:
                                          newOrderState.itemDetails.length,
                                      itemBuilder: (context, index) {
                                        return Card(
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
                                                        "${newOrderState.itemDetails[index].itemName}",
                                                    maxLinesAllowed: 1,
                                                    textOverflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomText(
                                                    maxLinesAllowed: 1,
                                                    textOverflow:
                                                        TextOverflow.ellipsis,
                                                    alignment: TextAlign.right,
                                                    text:
                                                        "₹${newOrderState.itemDetails[index].price}",
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomText(
                                                    alignment: TextAlign.center,
                                                    text:
                                                        "${newOrderState.itemDetails[index].quantity}",
                                                    maxLinesAllowed: 1,
                                                    textOverflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomText(
                                                    alignment: TextAlign.right,
                                                    text:
                                                        "₹${newOrderState.itemDetails[index].totalItemsPrice}",
                                                    maxLinesAllowed: 1,
                                                    textOverflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                GestureDetector(
                                                  child: Icon(
                                                    Icons.cancel_outlined,
                                                    color: AppColor.cancelColor,
                                                  ),
                                                  onTap: () {
                                                    context
                                                        .read<NewOrderBloc>()
                                                        .add(
                                                          RemoveItemFromList(
                                                            itemIndex: index,
                                                          ),
                                                        );
                                                    context
                                                        .read<NewOrderBloc>()
                                                        .add(
                                                          TotalPriceChangedEvent(),
                                                        );
                                                  },
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
                          GestureDetector(
                            onTap: () {
                              {
                                GlobalKey<FormState> itemFormKey = GlobalKey();
                                showDialog(
                                  context: context,
                                  builder: (dialogContext) {
                                    return AlertDialog(
                                      backgroundColor: darkModeState.darkTheme
                                          ? AppColor
                                                .dialogBackgroundDarkThemeColor
                                          : AppColor
                                                .dialogBackgroundLightThemeColor,
                                      title: Center(
                                        child: CustomText(
                                          text: "Enter Item Details",
                                          textSize: 30,
                                          textBoldness: FontWeight.bold,
                                        ),
                                      ),
                                      content: SingleChildScrollView(
                                        child: Form(
                                          key: itemFormKey,
                                          child: Column(
                                            spacing: 10,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CustomFormTextField(
                                                inputType: TextInputType.name,
                                                hintText: "Enter Item Name",
                                                icon: Icon(
                                                  Icons.person_outlined,
                                                ),
                                                validate: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Please Enter Item Name";
                                                  }
                                                  return null;
                                                },
                                                savedValue: (value) {
                                                  context
                                                      .read<NewOrderBloc>()
                                                      .add(
                                                        NewItemDetails(
                                                          itemName: value!,
                                                        ),
                                                      );
                                                  return null;
                                                },
                                              ),
                                              CustomFormTextField(
                                                inputType: TextInputType.number,
                                                hintText: "Enter Quantity",
                                                icon: Icon(
                                                  Icons.numbers_rounded,
                                                ),
                                                validate: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Please Enter Quantity";
                                                  }
                                                  if (!RegExp(
                                                    r'^[0-9]+$',
                                                  ).hasMatch(value)) {
                                                    return "Only numbers allowed";
                                                  }
                                                  int quantity = int.parse(
                                                    value.toString(),
                                                  );
                                                  if (quantity < 0) {
                                                    return "Quantity must be more than 0";
                                                  }

                                                  return null;
                                                },
                                                savedValue: (value) {
                                                  int quantity = int.parse(
                                                    value.toString(),
                                                  );
                                                  context
                                                      .read<NewOrderBloc>()
                                                      .add(
                                                        NewItemDetails(
                                                          quantity: quantity,
                                                        ),
                                                      );
                                                  return null;
                                                },
                                              ),
                                              CustomFormTextField(
                                                inputType: TextInputType.number,
                                                hintText: "Enter Price",
                                                icon: Icon(
                                                  Icons.currency_rupee_rounded,
                                                ),
                                                validate: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Please Enter Price";
                                                  }
                                                  if (!RegExp(
                                                    r'^[0-9]+$',
                                                  ).hasMatch(value)) {
                                                    return "Only numbers allowed";
                                                  }
                                                  int price = int.parse(
                                                    value.toString(),
                                                  );
                                                  if (price < 0) {
                                                    return "Price must be more than 0";
                                                  }

                                                  return null;
                                                },
                                                savedValue: (value) {
                                                  int price = int.parse(
                                                    value.toString(),
                                                  );
                                                  context
                                                      .read<NewOrderBloc>()
                                                      .add(
                                                        NewItemDetails(
                                                          price: price,
                                                        ),
                                                      );
                                                  return null;
                                                },
                                              ),
                                              CustomButton(
                                                backgroundColor:
                                                    darkModeState.darkTheme
                                                    ? AppColor.darkThemeColor
                                                    : AppColor.confirmColor,
                                                width: MediaQuery.of(
                                                  dialogContext,
                                                ).size.width,
                                                buttonText: "Add Item",
                                                callback: () {
                                                  bool isValidState =
                                                      itemFormKey.currentState!
                                                          .validate();

                                                  if (isValidState) {
                                                    itemFormKey.currentState!
                                                        .save();
                                                    context
                                                        .read<NewOrderBloc>()
                                                        .add(
                                                          OrderItemDetailedList(),
                                                        );
                                                    context
                                                        .read<NewOrderBloc>()
                                                        .add(
                                                          TotalPriceChangedEvent(),
                                                        );

                                                    Navigator.of(
                                                      dialogContext,
                                                    ).pop();
                                                  }
                                                },
                                              ),
                                              CustomButton(
                                                backgroundColor:
                                                    darkModeState.darkTheme
                                                    ? AppColor.darkThemeColor
                                                    : AppColor.cancelColor,
                                                width: MediaQuery.of(
                                                  dialogContext,
                                                ).size.width,
                                                buttonText: "Cancel",
                                                callback: () {
                                                  Navigator.of(
                                                    dialogContext,
                                                  ).pop();
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            child: CustomContainer(
                              backgroundColor: darkModeState.darkTheme
                                  ? AppColor.darkBlueGreyColor
                                  : AppColor.blueGreyColor,
                              borderRadius: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: " Add Item",
                                      textBoldness: FontWeight.bold,
                                      textSize: 25,
                                      textColor: AppColor.whiteColor,
                                    ),
                                    Icon(
                                      Icons.add,
                                      size: 35,
                                      color: AppColor.whiteColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: CustomText(
                                    text: "Status:",
                                    textSize: 22,
                                    textBoldness: FontWeight.w500,
                                  ),
                                ),
                                Radio(
                                  activeColor: AppColor.confirmColor,
                                  value: "Pending",
                                  groupValue: newOrderState.isDelivered,
                                  onChanged: (value) {
                                    context.read<NewOrderBloc>().add(
                                      OrderDeliveryStatusChangedEvent(
                                        isDelivered: "Pending",
                                      ),
                                    );
                                  },
                                ),
                                CustomText(text: "Pending", textSize: 20),
                                SizedBox(width: 30),
                                Radio(
                                  activeColor: AppColor.confirmColor,
                                  value: "Delivered",
                                  groupValue: newOrderState.isDelivered,
                                  onChanged: (value) {
                                    context.read<NewOrderBloc>().add(
                                      OrderDeliveryStatusChangedEvent(
                                        isDelivered: "Delivered",
                                      ),
                                    );
                                  },
                                ),
                                CustomText(text: "Delivered", textSize: 20),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: CustomText(
                                    text: "Total Amount: ",
                                    textSize: 22,
                                    textBoldness: FontWeight.w500,
                                  ),
                                ),
                                Expanded(
                                  child: CustomText(
                                    text: "₹ ${newOrderState.totalPrice}/-",
                                    textSize: 22,
                                    textBoldness: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomButton(
                            backgroundColor: darkModeState.darkTheme
                                ? AppColor.darkThemeColor
                                : AppColor.confirmColor,
                            width: MediaQuery.of(context).size.width,
                            buttonText: "Add Order",
                            callback: () {
                              bool isValidState = formKey.currentState!
                                  .validate();
                              if (newOrderState.itemDetails.isEmpty) {
                                message.showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        Icon(
                                          Icons.cancel,
                                          color: AppColor.cancelColor,
                                        ),
                                        CustomText(
                                          text: " Add at least 1 item",
                                          textBoldness: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else if (newOrderState.totalPrice <= 0) {
                                message.showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        Icon(
                                          Icons.info,
                                          color: AppColor.cancelColor,
                                        ),
                                        CustomText(
                                          text:
                                              " Total Amount must be more than zero",
                                          textBoldness: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              }
                              if (isValidState &&
                                  newOrderState.itemDetails.isNotEmpty &&
                                  newOrderState.totalPrice > 0) {
                                message
                                    .showSnackBar(
                                      SnackBar(
                                        content: Row(
                                          spacing: 10,
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color: AppColor.confirmColor,
                                            ),
                                            CustomText(
                                              text: "Order Added",
                                              textBoldness: FontWeight.bold,
                                            ),
                                          ],
                                        ),
                                        duration: Duration(milliseconds: 600),
                                      ),
                                    )
                                    .closed
                                    .then((_) {
                                      if (!context.mounted) return;
                                      context.read<NewOrderBloc>().add(
                                        AddNewOrderEvent(),
                                      );
                                      if (newOrderState.totalPrice > 10000) {
                                        context.read<AlertPopUpBloc>().add(
                                          LimitCrossedPopupShown(show: false),
                                        );
                                        context.read<AlertPopUpBloc>().add(
                                          InitHighOrderAlert(
                                            name: newOrderState.customerName,
                                            amount: newOrderState.totalPrice,
                                          ),
                                        );
                                      }
                                      navigator.pop();
                                    });
                              }
                            },
                          ),
                          CustomButton(
                            backgroundColor: darkModeState.darkTheme
                                ? AppColor.darkThemeColor
                                : AppColor.cancelColor,
                            width: MediaQuery.of(context).size.width,
                            buttonText: "Cancel",
                            callback: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
