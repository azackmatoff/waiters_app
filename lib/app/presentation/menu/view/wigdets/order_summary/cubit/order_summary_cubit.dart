import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiters_app/app/data/models/menu_item.dart';
import 'package:waiters_app/app/data/models/order_model.dart';
import 'package:waiters_app/app/domain/repositories/order_repository.dart';
import 'package:waiters_app/app/presentation/menu/view/wigdets/order_summary/cubit/oder_summary_cubit_state.dart';
import 'package:waiters_app/app/sl/service_locator.dart';

class OrderSummaryCubit extends Cubit<OrderSummaryCubitState> {
  final OrderRepository _orderRepository = sl.get<OrderRepository>();

  OrderSummaryCubit(OrderModel initialOrder) : super(OrderSummaryList(order: initialOrder));

  void removeItem(MenuItem item) {
    final currentOrder = (state as OrderSummaryList).order; // Cast to OrderSummaryList
    final updatedDrinks = currentOrder.drinks?.where((i) => i != item).toList() ?? [];
    final updatedFirstMeals = currentOrder.firstMeals?.where((i) => i != item).toList() ?? [];
    final updatedMainMeals = currentOrder.mainMeals?.where((i) => i != item).toList() ?? [];

    final updatedOrder = currentOrder.copyWith(
      drinks: updatedDrinks.isEmpty ? null : updatedDrinks,
      firstMeals: updatedFirstMeals.isEmpty ? null : updatedFirstMeals,
      mainMeals: updatedMainMeals.isEmpty ? null : updatedMainMeals,
      totalPrice: _calculateTotalPrice(updatedDrinks, updatedFirstMeals, updatedMainMeals),
    );

    emit(OrderSummaryList(order: updatedOrder)); // Emit the updated state
  }

  void placeOrder() async {
    try {
      final order = (state as OrderSummaryList).order;
      emit(OrderSummaryLoading()); // Show loading state
      await _orderRepository.addOrder(order); // Cast to OrderSummaryList
      emit(OrderSummarySuccess(order: order)); // Show success state
    } catch (e) {
      // Handle the error, e.g., by showing a snackbar or dialog
      log('Error placing order: $e');
      emit(OrderSummaryError(error: e.toString())); // Show error state
    }
  }

  int _calculateTotalPrice(List<MenuItem> drinks, List<MenuItem> starters, List<MenuItem> mainCourses) {
    int total = 0;
    for (var item in drinks + starters + mainCourses) {
      total += (item.price * item.quantity).toInt();
    }
    return total;
  }

  void updateOrderItems(List<MenuItem> updatedItems) {
    final updatedDrinks = updatedItems.where((item) => item.category == MenuCategory.drinks).toList();
    final updatedStarters = updatedItems.where((item) => item.category == MenuCategory.starter).toList();
    final updatedMainCourses = updatedItems.where((item) => item.category == MenuCategory.mainCourse).toList();

    final totalPrice = _calculateTotalPrice(updatedDrinks, updatedStarters, updatedMainCourses);

    emit(
      OrderSummaryList(
        // Use OrderSummaryList state
        order: OrderModel(
          id: (state as OrderSummaryList).order.id, // Cast to OrderSummaryList
          tableNumber: (state as OrderSummaryList).order.tableNumber,
          drinks: updatedDrinks,
          firstMeals: updatedStarters,
          mainMeals: updatedMainCourses,
          waiterId: (state as OrderSummaryList).order.waiterId,
          totalPrice: totalPrice,
        ),
      ),
    );
  }
}
