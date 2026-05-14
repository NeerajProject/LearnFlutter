import 'package:flutter/material.dart';
import 'dart:convert';
import '../config/api_config.dart';
import '../services/api_service.dart';

class Food {
  final int id;
  final String name;
  final double calories;
  final int userId;

  Food({required this.id, required this.name, required this.calories, required this.userId});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      calories: json['calories'].toDouble(),
      userId: json['user_id'],
    );
  }
}

class DietPage extends StatefulWidget {
  const DietPage({super.key});

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  List<Food> _foods = [];
  bool _isLoading = false;
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchFoods();
  }

  Future<void> _fetchFoods() async {
    setState(() => _isLoading = true);
    try {
      final response = await ApiService.get(ApiConfig.foodUrl);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _foods = data.map((json) => Food.fromJson(json)).toList();
        });
      } else {
        _showMessage("Failed to load foods: ${response.statusCode}");
      }
    } catch (e) {
      _showMessage("Error fetching foods: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _addFood() async {
    if (_nameController.text.isEmpty || _caloriesController.text.isEmpty) {
      _showMessage("Please fill all fields");
      return;
    }

    try {
      final response = await ApiService.post(ApiConfig.foodUrl, {
        "name": _nameController.text.trim(),
        "calories": double.parse(_caloriesController.text.trim()),
      });

      if (ApiConfig.successStatusCodes.contains(response.statusCode)) {
        _nameController.clear();
        _caloriesController.clear();
        Navigator.pop(context);
        _fetchFoods();
        _showMessage("Food added successfully!");
      } else {
        _showMessage("Failed to add food: ${response.body}");
      }
    } catch (e) {
      _showMessage("Error adding food: $e");
    }
  }

  Future<void> _deleteFood(int id) async {
    try {
      final response = await ApiService.delete("${ApiConfig.foodUrl}$id");

      if (response.statusCode == 200) {
        _fetchFoods();
        _showMessage("Food deleted");
      } else {
        _showMessage("Failed to delete food: ${response.body}");
      }
    } catch (e) {
      _showMessage("Error deleting food: $e");
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showAddFoodDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Food"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Food Name"),
            ),
            TextField(
              controller: _caloriesController,
              decoration: const InputDecoration(labelText: "Calories"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(onPressed: _addFood, child: const Text("Add")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Master"),
        actions: [
          IconButton(onPressed: _fetchFoods, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _foods.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.restaurant_menu, size: 60, color: Colors.grey),
                      const SizedBox(height: 10),
                      const Text("No food items found", style: TextStyle(color: Colors.grey)),
                      TextButton(onPressed: _showAddFoodDialog, child: const Text("Add your first food")),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _foods.length,
                  itemBuilder: (context, index) {
                    final food = _foods[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.orange.shade100,
                          child: const Icon(Icons.fastfood, color: Colors.orange),
                        ),
                        title: Text(food.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text("${food.calories} kcal"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () => _deleteFood(food.id),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddFoodDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
