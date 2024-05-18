import 'package:flutter/material.dart';
import 'package:ws/src/data/products_model.dart';

class ProductDeailsPage extends StatefulWidget {
  const ProductDeailsPage({super.key, required this.product});
  final Product product;

  @override
  State<ProductDeailsPage> createState() => _ProductDeailsPageState();
}

class _ProductDeailsPageState extends State<ProductDeailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.product.title!,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: 200,
            child: Image.network(widget.product.thumbnail!),
          ),
          Text(widget.product.title!),
          Text("Brand ${widget.product.brand}", style: const TextStyle(color: Colors.red),),
          Text(widget.product.description!)
        ],
      ),
    );
  }
}