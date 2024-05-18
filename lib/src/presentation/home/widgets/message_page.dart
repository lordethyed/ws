import 'package:flutter/material.dart';
import 'package:ws/src/data/products_model.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text('Seller is ${product.brand}'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              'Now this function is not available',
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 32),
            ),
            Image.asset('assets/images/Imagen 4.png')
          ],
        ),
      ),
    );
  }
}
