import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ws/src/data/products_model.dart';
import 'package:ws/src/presentation/home/search_page.dart';
import 'package:ws/src/presentation/home/widgets/product_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.token});
  final String token;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<Product> products = [];

  final dio = Dio();

  fetchProducts() async {
    final response = await dio.get('https://dummyjson.com/products');
    final producsModel = ProductsModel.fromJson(response.data);
    log(response.data.toString());
    log(producsModel.productList!.first.title!);
    setState(() {
      products = producsModel.productList!;
      isLoading = false;
    });
  }

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SearchPage(token: widget.token),
            ),
          ),
          icon: const Icon(Icons.search),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Categories',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
        title: const Text(
          'Korea - GoYang',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: 200,
                    child: Image.asset(
                      'assets/images/Imagen 18.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Text(
                    'Lastest Items',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      itemBuilder: (context, index) => ProductTile(
                        product: products[index],
                      ),
                    ),
                  ),
                  const Text(
                    'Yout Publications',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: 400,
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 1 / 0.8,
                      scrollDirection: Axis.vertical,
                      children:
                          products.map((e) => ProductTile(product: e)).toList(),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
