import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ws/src/data/products_model.dart';
import 'package:ws/src/presentation/home/widgets/product_tile.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final dio = Dio();

  List<String> categories = [];

  String? selectedCategory = '';

  List<Product> products = [];

  bool isLoading = true;

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

  getItems(String value) async {
    try {
      isLoading = true;
      final response =
          await dio.get('https://dummyjson.com/products/category/$value');
      final productsModel = ProductsModel.fromJson(response.data);
      setState(() {
        products = productsModel.productList!;
        isLoading = false;
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          'Categories',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                DropdownMenu<String>(
                  initialSelection: selectedCategory,
                  onSelected: (String? value) {
                    getItems(value ?? 'smartphones');
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                  dropdownMenuEntries:
                      categories.map<DropdownMenuEntry<String>>(
                    (String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    },
                  ).toList(),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1 / 0.8,
                    scrollDirection: Axis.vertical,
                    children:
                        products.map((e) => ProductTile(product: e)).toList(),
                  ),
                ),
              ],
            ),
    );
  }
}
