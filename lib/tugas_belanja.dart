import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingListModel extends ChangeNotifier {
  final List<String> _items = [];

  List<String> get items => List.unmodifiable(_items);

  void addItem(String item) {
    if (item.trim().isEmpty) return;
    _items.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}

class TugasBelanjaPage extends StatelessWidget {
  const TugasBelanjaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ShoppingListModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Belanja'),
          backgroundColor: Colors.teal,
        ),
        body: const ShoppingListScreen(),
      ),
    );
  }
}

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addItem(BuildContext context) {
    Provider.of<ShoppingListModel>(
      context,
      listen: false,
    ).addItem(_controller.text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(labelText: 'Tambah Item'),
                  onSubmitted: (_) => _addItem(context),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => _addItem(context),
                child: const Text('Tambah'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              ),
            ],
          ),
        ),
        Expanded(
          child: Consumer<ShoppingListModel>(
            builder:
                (context, model, _) => ListView.builder(
                  itemCount: model.items.length,
                  itemBuilder:
                      (context, index) => ShoppingListItem(
                        item: model.items[index],
                        onDelete: () => model.removeItem(index),
                      ),
                ),
          ),
        ),
      ],
    );
  }
}

class ShoppingListItem extends StatelessWidget {
  final String item;
  final VoidCallback onDelete;

  const ShoppingListItem({
    required this.item,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: onDelete,
      ),
    );
  }
}
