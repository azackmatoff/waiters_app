import 'package:flutter/material.dart';

import 'package:waiters_app/app/presentation/menu/view/menu_view.dart';
import 'package:waiters_app/app/presentation/tables/view/widgets/table_card.dart';

class TablesView extends StatelessWidget {
  const TablesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Table'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 1.2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: List.generate(12, (index) {
              final tableNumber = index + 1;

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MenuView(tableNumber: tableNumber)),
                  );
                },
                child: TableCard(
                  tableNumber: tableNumber,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
