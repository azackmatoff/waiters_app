import 'package:waiters_app/app/data/models/menu_item.dart';

class MenuViewCubitState {
  final List<MenuItem> drinks;
  final List<MenuItem> starters;
  final List<MenuItem> mainCourses;
  final int totalSelectedItems;

  MenuViewCubitState({
    required this.drinks,
    required this.starters,
    required this.mainCourses,
    this.totalSelectedItems = 0,
  });

  MenuViewCubitState copyWith({
    List<MenuItem>? drinks,
    List<MenuItem>? starters,
    List<MenuItem>? mainCourses,
    int? totalSelectedItems,
  }) {
    return MenuViewCubitState(
      drinks: drinks ?? this.drinks,
      starters: starters ?? this.starters,
      mainCourses: mainCourses ?? this.mainCourses,
      totalSelectedItems: totalSelectedItems ?? this.totalSelectedItems,
    );
  }
}
