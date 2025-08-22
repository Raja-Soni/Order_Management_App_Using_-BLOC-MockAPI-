import 'package:equatable/equatable.dart';

abstract class AlertPopUpEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetPendingAndLimitCrossedOrders extends AlertPopUpEvents {}

class PendingPopupShown extends AlertPopUpEvents {
  final bool? isShown;
  PendingPopupShown({this.isShown});
}

class LimitCrossedPopupShown extends AlertPopUpEvents {
  final bool? show;
  LimitCrossedPopupShown({required this.show});
}
