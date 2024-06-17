import 'package:waiters_app/app/data/models/order_model.dart';

abstract class OrderSummaryCubitState {}

class OrderSummaryLoading extends OrderSummaryCubitState {}

class OrderSummaryList extends OrderSummaryCubitState {
  final OrderModel order;

  OrderSummaryList({required this.order});

  OrderSummaryList copyWith({OrderModel? order}) {
    return OrderSummaryList(order: order ?? this.order);
  }
}

class OrderSummarySuccess extends OrderSummaryCubitState {
  final OrderModel order;

  OrderSummarySuccess({required this.order});
}

class OrderSummaryError extends OrderSummaryCubitState {
  final String error;

  OrderSummaryError({required this.error});
}
