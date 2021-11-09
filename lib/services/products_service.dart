import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsServices extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-c7352-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  late Product selectedProduct;

  bool isLoading = true;

  ProductsServices() {
    this.loadProducts();
  }

  Future loadProducts() async {
    this.isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);

    // print(productsMap);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      this.products.add(tempProduct);
    });

    this.isLoading = false;
    notifyListeners();

    return this.products;

    // print(this.products[0].name);
  }
}