import 'package:erp_using_api/bloc/alert_pop_up/alert_popup_bloc_events_state.dart';
import 'package:erp_using_api/bloc/dark_theme_mode/dark_theme_bloc_events_state.dart';
import 'package:erp_using_api/bloc/new_order/new_order_bloc_events_state.dart';
import 'package:erp_using_api/custom_widgets/import_all_custom_widgets.dart';
import 'package:erp_using_api/model/sales_order.dart';
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
  String selectedItem = "Select Item";
  List<String> items = [
    "Select Item",
    "Bulb Box",
    "Fan Box",
    "Switch Box",
    "Wire Box",
    "Socket Box",
    "Fuse Box",
  ];

  @override
  void initState() {
    super.initState();
    context.read<NewOrderBloc>().add(InitialState());
  }

  @override
  Widget build(BuildContext context) {
    final message = ScaffoldMessenger.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
            textColor: AppColor.lightThemeColor,
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<DarkThemeBloc, DarkThemeState>(
          builder: (context, darkModeState) {
            return BlocBuilder<NewOrderBloc, NewOrderState>(
              builder: (context, newOrderState) {
                final navigator = Navigator.of(context);
                return Container(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          CustomFormTextField(
                            inputType: TextInputType.name,
                            hintText: "Enter Name",
                            icon: Icon(Icons.person_outlined),
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Name";
                              }
                              return null;
                            },
                            changedValue: (value) {
                              context.read<NewOrderBloc>().add(
                                NameGivenEvent(name: value!),
                              );
                              return null;
                            },
                          ),
                          DropdownButton(
                            iconSize: 40,
                            dropdownColor: darkModeState.darkTheme
                                ? AppColor.darkThemeColor
                                : AppColor.lightThemeColor,
                            value: selectedItem,
                            onChanged: (value) {
                              selectedItem = value!;
                              setState(() {});
                            },
                            isExpanded: true,
                            items: items
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: CustomText(text: e),
                                  ),
                                )
                                .toList(),
                          ),
                          CustomFormTextField(
                            inputType: TextInputType.number,
                            hintText: "Enter Quantity",
                            icon: Icon(Icons.numbers_rounded),
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Quantity";
                              }
                              if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                return "Only numbers allowed";
                              }
                              int quantity = int.parse(value.toString());
                              if (quantity < 0) {
                                return "Quantity must be more than 0";
                              }
                              return null;
                            },
                            changedValue: (value) {
                              int quantity = value!.isEmpty
                                  ? 0
                                  : int.parse(value);
                              context.read<NewOrderBloc>().add(
                                QuantityChangedEvent(quantity: quantity),
                              );
                              context.read<NewOrderBloc>().add(
                                TotalPriceChangedEvent(),
                              );
                              return null;
                            },
                          ),
                          CustomFormTextField(
                            inputType: TextInputType.number,
                            hintText: "Enter Price",
                            icon: Icon(Icons.currency_rupee_rounded),
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Price";
                              }
                              if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                return "Only numbers allowed";
                              }
                              int price = int.parse(value.toString());
                              if (price < 0) {
                                return "Price must be more than 0";
                              }

                              return null;
                            },
                            changedValue: (value) {
                              int price = value!.isEmpty ? 0 : int.parse(value);
                              context.read<NewOrderBloc>().add(
                                PriceChangedEvent(price: price),
                              );
                              context.read<NewOrderBloc>().add(
                                TotalPriceChangedEvent(),
                              );
                              return null;
                            },
                          ),
                          CustomText(
                            text: "Total: ₹ ${newOrderState.totalPrice}",
                            textSize: 25,
                            textBoldness: FontWeight.w500,
                          ),
                          CustomButton(
                            width: MediaQuery.of(context).size.width,
                            buttonText: "Add Order",
                            callback: () {
                              bool isValidState = formKey.currentState!
                                  .validate();
                              if (isValidState) {
                                message
                                    .showSnackBar(
                                      SnackBar(
                                        content: Row(
                                          spacing: 10,
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
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
                                      ItemModel newOrderItem = ItemModel(
                                        customer: newOrderState.name,
                                        amount: newOrderState.totalPrice,
                                        status:
                                            (newOrderState.totalPrice % 2) == 0
                                            ? "Pending"
                                            : "Delivered",
                                        date: DateTime.now()
                                            .toString()
                                            .split(" ")
                                            .first,
                                      );
                                      if (!context.mounted) return;
                                      context.read<NewOrderBloc>().add(
                                        AddNewOrderEvent(
                                          itemModel: newOrderItem,
                                        ),
                                      );
                                      if (newOrderState.totalPrice > 10000) {
                                        context.read<AlertPopUpBloc>().add(
                                          LimitCrossedPopupShown(show: false),
                                        );
                                        context.read<AlertPopUpBloc>().add(
                                          InitHighOrderAlert(
                                            name: newOrderState.name,
                                            amount: newOrderState.totalPrice,
                                          ),
                                        );
                                      }
                                      navigator.pop();
                                    });
                              } else {
                                message.showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      spacing: 10,
                                      children: [
                                        Icon(Icons.cancel, color: Colors.red),
                                        CustomText(
                                          text: "Failed to add order",
                                          textBoldness: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                    duration: Duration(milliseconds: 600),
                                  ),
                                );
                              }
                            },
                          ),
                          CustomButton(
                            backgroundColor: Colors.red,
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
