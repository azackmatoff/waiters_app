import 'package:waiters_app/app/data/models/menu_item.dart';

class DummyContent {
  // Sample Menu Data (Replace with your actual data)
  static final List<MenuItem> drinks = [
    MenuItem(name: 'Coca-Cola', price: 2.5, category: MenuCategory.drinks),
    MenuItem(name: 'Sprite', price: 2.5, category: MenuCategory.drinks),
    MenuItem(name: 'Fanta', price: 2.5, category: MenuCategory.drinks),
  ];

  static final List<MenuItem> starters = [
    MenuItem(name: 'Caesar Salad', price: 8.99, category: MenuCategory.starter),
    MenuItem(name: 'Bruschetta', price: 5.99, category: MenuCategory.starter),
    MenuItem(name: 'Onion Rings', price: 4.50, category: MenuCategory.starter),
  ];

  static final List<MenuItem> mainCourses = [
    MenuItem(name: 'Steak', price: 22.50, category: MenuCategory.mainCourse),
    MenuItem(name: 'Salmon', price: 18.99, category: MenuCategory.mainCourse),
    MenuItem(name: 'Pasta Primavera', price: 14.99, category: MenuCategory.mainCourse),
  ];
}
