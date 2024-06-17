import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:waiters_app/app/data/models/menu_item.dart';
import 'package:waiters_app/app/data/models/order_model.dart';
import 'package:waiters_app/app/presentation/menu/view/wigdets/order_summary/cubit/oder_summary_cubit_state.dart';
import 'package:waiters_app/app/presentation/menu/view/wigdets/order_summary/cubit/order_summary_cubit.dart';

class OrderSummaryBottomSheet extends StatefulWidget {
  final OrderModel order;

  const OrderSummaryBottomSheet({
    super.key,
    required this.order,
  });

  @override
  State<OrderSummaryBottomSheet> createState() => _OrderSummaryBottomSheetState();
}

class _OrderSummaryBottomSheetState extends State<OrderSummaryBottomSheet> {
  late final OrderSummaryCubit _cubit;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _cubit = OrderSummaryCubit(widget.order);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderSummaryCubit, OrderSummaryCubitState>(
      bloc: _cubit,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            controller: _scrollController,
            children: [
              if (state is OrderSummaryList) ..._buildForSummaryList(state),
              if (state is OrderSummarySuccess) Text('Order has been placed for total of: ${state.order.totalPrice}'),
              if (state is OrderSummaryError) Text('Error: ${state.error}'),
              ElevatedButton(
                onPressed: () {
                  if (state is OrderSummaryList) {
                    _cubit.placeOrder();
                  } else if (state is OrderSummarySuccess) {
                    Navigator.pop(context);
                  } else {
                    return;
                  }
                },
                child: state is OrderSummaryLoading
                    ? const CircularProgressIndicator()
                    : state is OrderSummarySuccess
                        ? const Text('Close')
                        : const Text('Place Order'),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildForSummaryList(OrderSummaryList state) {
    return [
      Text(
        'Order Summary (Table ${state.order.tableNumber})',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const Divider(),

      // Drinks
      if (state.order.drinks != null && state.order.drinks!.isNotEmpty)
        _buildCategoryList('Drinks', state.order.drinks!),

      // First Meals (Starters)
      if (state.order.firstMeals != null && state.order.firstMeals!.isNotEmpty)
        _buildCategoryList('Starters', state.order.firstMeals!),

      // Main Meals
      if (state.order.mainMeals != null && state.order.mainMeals!.isNotEmpty)
        _buildCategoryList('Main Courses', state.order.mainMeals!),

      const Divider(),

      Text(
        'Total: ${state.order.totalPrice} €',
        style: const TextStyle(fontSize: 18),
      ),
    ];
  }

  Widget _buildCategoryList(String categoryName, List<MenuItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(categoryName, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text('${item.quantity} x ${item.price.toStringAsFixed(2)} €'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _cubit.removeItem(item);
                },
              ),
            );
          },
        ),
        const SizedBox(height: 16), // Add spacing between categories
      ],
    );
  }
}
