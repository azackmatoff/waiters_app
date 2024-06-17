import 'package:flutter/material.dart';

class TableCard extends StatelessWidget {
  final int tableNumber;

  const TableCard({
    super.key,
    required this.tableNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: Center(
        child: Text(
          '$tableNumber',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
