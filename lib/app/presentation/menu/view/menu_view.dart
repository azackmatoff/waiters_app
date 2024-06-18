import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:waiters_app/app/data/models/menu_item.dart';
import 'package:waiters_app/app/data/models/order_model.dart';
import 'package:waiters_app/app/presentation/menu/cubit/menu_view_cubit.dart';
import 'package:waiters_app/app/presentation/menu/cubit/menu_view_cubit_state.dart';
import 'package:waiters_app/app/presentation/menu/view/wigdets/menu_item_card.dart';
import 'package:waiters_app/app/presentation/menu/view/wigdets/order_summary/widget/order_summary_bottom_sheet.dart';

class MenuView extends StatefulWidget {
  final int tableNumber;

  const MenuView({super.key, required this.tableNumber});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> with SingleTickerProviderStateMixin {
  final _cubit = MenuViewCubit();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: BlocBuilder<MenuViewCubit, MenuViewCubitState>(
        bloc: _cubit,
        builder: (context, state) {
          return Column(
            children: [
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Drinks'),
                  Tab(text: 'Starter'),
                  Tab(text: 'Main Course'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildMenuList(state.drinks),
                    _buildMenuList(state.starters),
                    _buildMenuList(state.mainCourses),
                  ],
                ),
              ),

              // Bottom Container (visible if items are selected)
              if (state.totalSelectedItems > 0) // Conditionally show the container
                _bottomContainer(state, context),
            ],
          );
        },
      ),
    );
  }

  Widget _bottomContainer(MenuViewCubitState state, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Background color
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${state.totalSelectedItems} items selected',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: () {
              _showOrderSummary(
                  context,
                  _cubit.createOrderModel(
                    widget.tableNumber,

                    /// dummy waiter id
                    widget.tableNumber + 1,
                  ));
            },
            child: const Text('View Order'),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuList(List<MenuItem> items) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return MenuItemCard(
            title: item.name,
            price: item.price,
            quantity: item.quantity,
            onIncrease: () => _cubit.increaseQuantity(item, item.category),
            onDecrease: () {
              if (items[index].quantity > 0) {
                _cubit.decreaseQuantity(item, item.category);
              }
            },
          );
        },
      ),
    );
  }

  void _showOrderSummary(BuildContext context, OrderModel order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: OrderSummaryBottomSheet(order: order),
        );
      },
    );
  }
}
