import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:waiters_app/app/common/constants/dummy_content/dummy_content.dart';
import 'package:waiters_app/app/data/models/menu_item.dart';
import 'package:waiters_app/app/data/models/order_model.dart';
import 'package:waiters_app/app/presentation/menu/cubit/menu_view_cubit_state.dart';

class MenuViewCubit extends Cubit<MenuViewCubitState> {
  MenuViewCubit() : super(MenuViewCubitState(drinks: [], starters: [], mainCourses: [])) {
    _loadMenu(DummyContent.drinks, DummyContent.starters, DummyContent.mainCourses);
  }

  void _loadMenu(List<MenuItem> drinks, List<MenuItem> starters, List<MenuItem> mainCourses) {
    emit(state.copyWith(drinks: drinks, starters: starters, mainCourses: mainCourses));
  }

  void increaseQuantity(MenuItem item, MenuCategory category) {
    switch (category) {
      case MenuCategory.drinks:
        _updateQuantity(item, state.drinks);
        break;
      case MenuCategory.starter:
        _updateQuantity(item, state.starters);
        break;
      case MenuCategory.mainCourse:
        _updateQuantity(item, state.mainCourses);
        break;
    }
  }

  void decreaseQuantity(MenuItem item, MenuCategory category) {
    switch (category) {
      case MenuCategory.drinks:
        _updateQuantity(item, state.drinks, decrease: true);
        break;
      case MenuCategory.starter:
        _updateQuantity(item, state.starters, decrease: true);
        break;
      case MenuCategory.mainCourse:
        _updateQuantity(item, state.mainCourses, decrease: true);
        break;
    }
  }

  void _updateQuantity(MenuItem item, List<MenuItem> itemList, {bool decrease = false}) {
    final updatedItems = itemList.map((i) {
      if (i == item) {
        final newQuantity = (decrease ? i.quantity - 1 : i.quantity + 1);
        return i.copyWith(quantity: newQuantity);
      }
      return i;
    }).toList();

    // Calculate new totalSelectedItems
    int newTotalSelectedItems = state.totalSelectedItems; // Start with the current total
    if (decrease) {
      newTotalSelectedItems--; // Decrease if quantity was reduced
    } else {
      newTotalSelectedItems++; // Increase if quantity was increased
    }

    emit(state.copyWith(
      drinks: itemList == state.drinks ? updatedItems : state.drinks,
      starters: itemList == state.starters ? updatedItems : state.starters,
      mainCourses: itemList == state.mainCourses ? updatedItems : state.mainCourses,
      totalSelectedItems: newTotalSelectedItems, // Update totalSelectedItems
    ));
  }

  OrderModel createOrderModel(int tableNumber, int waiterId) {
    final selectedDrinks = state.drinks.where((item) => item.quantity > 0).toList();
    final selectedStarters = state.starters.where((item) => item.quantity > 0).toList();
    final selectedMainCourses = state.mainCourses.where((item) => item.quantity > 0).toList();

    final totalItems = selectedDrinks.length + selectedStarters.length + selectedMainCourses.length;
    if (totalItems == 0) {
      // Handle the case where no items are selected (e.g., show an error message)
      return OrderModel(id: '', tableNumber: 0, waiterId: 0, totalPrice: 0); // Return a dummy object
    }

    final totalPrice = _calculateTotalPrice(selectedDrinks, selectedStarters, selectedMainCourses);

    return OrderModel(
      id: const Uuid().v4(), // Replace with your logic to generate an order ID
      tableNumber: tableNumber,
      drinks: selectedDrinks,
      firstMeals: selectedStarters,
      mainMeals: selectedMainCourses,
      waiterId: waiterId,
      totalPrice: totalPrice,
    );
  }

  int _calculateTotalPrice(List<MenuItem> drinks, List<MenuItem> starters, List<MenuItem> mainCourses) {
    int total = 0;
    for (final item in drinks + starters + mainCourses) {
      total += (item.price * item.quantity).toInt();
    }
    return total;
  }
}
