import 'package:flutter/material.dart';

import '../../models/wishlist_model.dart';

class WishlistPage extends StatelessWidget {
  final List<WishlistedItem> wishlistItems;

  WishlistPage({required this.wishlistItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: ListView.builder(
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(wishlistItems[index].image),
            title: Text(wishlistItems[index].title),
            subtitle: Text('${wishlistItems[index].location}\n\$${wishlistItems[index].price}'),
          );
        },
      ),
    );
  }
}
