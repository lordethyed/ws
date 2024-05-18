import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ws/src/data/products_model.dart';
import 'package:ws/src/presentation/home/widgets/product_details_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.token});
  final String token;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final dio = Dio();

  String user = '';

  bool isEmptyList = true;

  List<Product> products = [];

  getUser() async {
    try {
      final headers = {'Authorization': 'Bearer ${widget.token}'};
      final response = await dio.get('https://dummyjson.com/auth/me',
          options: Options(headers: headers));

      log(response.data.toString());
      setState(() {
        user =
            '${response.data['firstName']} ${response.data['maidenName']} ${response.data['lastName']}';
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  search(String value) async {
    final response =
        await dio.get('https://dummyjson.com/products/search?q=$value');
    final productsModel = ProductsModel.fromJson(response.data);
    setState(() {
      isEmptyList = value.isEmpty;
      products = productsModel.productList!;
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text('Search Item'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Hello ",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "$user",
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Text('Please type for search by item name.'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: search,
              decoration: const InputDecoration(
                labelText: 'Search',
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
              ),
            ),
          ),
          if (!isEmptyList)
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDeailsPage(product: products[index]),
                    ),
                  ),
                  child: ListTile(
                    leading: Image.network(products[index].images!.first),
                    title: Text(products[index].title!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products[index].description!,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '\$${products[index].price}',
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
