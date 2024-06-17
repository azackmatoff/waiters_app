import 'package:flutter/material.dart';

class MenuItemCard extends StatefulWidget {
  final String title;
  final double price;
  final int quantity;
  final Function() onIncrease;
  final Function() onDecrease;

  const MenuItemCard({
    super.key,
    required this.title,
    required this.price,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  _MenuItemCardState createState() => _MenuItemCardState();
}

class _MenuItemCardState extends State<MenuItemCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Placeholder for Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(Icons.image, size: 40), // Optional: Add an icon
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.price.toStringAsFixed(2)} €', // Format price
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 16),
            // Quantity Controls
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: widget.quantity > 0 ? widget.onDecrease : null, // Disable if quantity is 0
                ),
                Text(
                  '${widget.quantity}',
                  style: TextStyle(
                    fontWeight: widget.quantity > 0 ? FontWeight.w900 : FontWeight.normal,
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: widget.onIncrease,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
