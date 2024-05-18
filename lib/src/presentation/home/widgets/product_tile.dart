import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ws/src/data/products_model.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(25.0)
      ),
      width: 150,
      height: 150,
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 100,
                child: Image.network(
                  product.images!.first,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                children: [
                  SizedBox(
                width: 150,
                child: Text(
                  product.title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: 150,
                height: 45,
                child: Text(
                  product.description!,
                  style: const TextStyle(fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                "${product.price!.toString()}\$",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
