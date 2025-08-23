import 'package:equatable/equatable.dart';

abstract class AlertPopUpEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitHighOrderAlert extends AlertPopUpEvents {
  final String name;
  final int amount;
  InitHighOrderAlert({required this.name, required this.amount});
}

class GetHighOrderAlert extends AlertPopUpEvents {}

class ClearHighOrderAlert extends AlertPopUpEvents {}

class GetPendingAndLimitCrossedOrders extends AlertPopUpEvents {}

class PendingPopupShown extends AlertPopUpEvents {
  final bool? isShown;
  PendingPopupShown({this.isShown});
}

class LimitCrossedPopupShown extends AlertPopUpEvents {
  final bool? show;
  LimitCrossedPopupShown({required this.show});
}
