import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final dio = Dio();

  bool isLoading = true;

  String? selectedCategory = '';
  String? selectedCurrency = '';
  List<String> categories = [];
  List<String> currencies = ['USD', 'EURO', 'KZT', "JPY"];

  getCategories() async {
    final response = await dio.get('https://dummyjson.com/products/categories');
    final List<String> kCategories = [];
    for (var category in response.data) {
      kCategories.add(category.toString());
    }

    setState(() {
      categories = kCategories;
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Add Item',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const Row(),
                const Text(
                  "Create a new product",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 300,
                  height: 500,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Item Information',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.grey,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: const BorderSide(color: Colors.grey)),
                          filled: false,
                          labelText: 'Item Name',
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 300,
                        child: DropdownMenu<String>(
                          initialSelection: selectedCategory,
                          onSelected: (String? value) {
                            setState(() {
                              selectedCategory = value!;
                            });
                          },
                          dropdownMenuEntries: categories
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      DropdownMenu<String>(
                        initialSelection: selectedCurrency,
                        onSelected: (String? value) {
                          setState(() {
                            selectedCategory = value!;
                          });
                        },
                        dropdownMenuEntries: currencies
                            .map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                              value: value, label: value);
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: const BorderSide(color: Colors.grey)),
                          filled: false,
                          labelText: 'Price',
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: const BorderSide(color: Colors.grey)),
                          filled: false,
                          labelText: 'Description',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.grey),
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product saved succsesfully')));
                                Navigator.of(context).pop();
                              },
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.red),
                              ),
                              child: const Text(
                                'Register',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
