import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ws/src/data/products_model.dart';
import 'package:ws/src/presentation/home/widgets/message_page.dart';

class ProductDeailsPage extends StatelessWidget {
  const ProductDeailsPage({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          product.title!,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: 200,
            child: Image.network(
              product.thumbnail!,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title!,
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Text(
                      "Brand: ",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      product.brand!.toUpperCase(),
                      style: const TextStyle(color: Colors.red),
                    )
                  ],
                ),
                Text(product.description!.toUpperCase()),
                Center(
                  child: Image.asset('assets/images/Imagen 4.png'),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: 50,
            padding: const EdgeInsets.only(left: 8.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.heart_broken_outlined,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "\$${product.price}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const Spacer(),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.grey.shade800),
                  ),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => MessagePage(product: product))),
                  child: const Text('Message', style: TextStyle(color: Colors.white),),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
