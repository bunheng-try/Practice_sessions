import 'package:flutter/material.dart';
import '../../models/grocery.dart';
import '../../data/mock_grocery_repository.dart';
import 'grocery_form.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  late List<Grocery> groceryItems;

  @override
  void initState() {
    super.initState();
    groceryItems = List.from(dummyGroceryItems);
  }

  void onCreate() {
    // Navigate to the form screen using the Navigator push 
    Navigator.of(context).push<Grocery>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    ).then((newItem) {
      // Handle the returned item from the form
      if (newItem != null) {
        setState(() {
          groceryItems.add(newItem);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (groceryItems.isNotEmpty) {
       // TODO-1 - Display groceries with an Item builder and  LIst Tile
      content = ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (context, index) {
          return GroceryTile(grocery: groceryItems[index]);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: onCreate,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}

class GroceryTile extends StatelessWidget {
  const GroceryTile({super.key, required this.grocery});

  final Grocery grocery;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: grocery.category.color,
        ),
      ),
      title: Text(grocery.name),
      subtitle: Text('Quantity: ${grocery.quantity}'),
      trailing: Text(grocery.category.label),
    );
  }
}

