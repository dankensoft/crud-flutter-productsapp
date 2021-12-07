import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final producsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    if (producsService.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(title: Text('Productos'), actions: [
        IconButton(
            onPressed: () {
              authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
            icon: Icon(Icons.login_outlined))
      ]),
      body: ListView.builder(
          itemCount: producsService.products.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () {
                producsService.selectedProduct =
                    producsService.products[index].copy();
                Navigator.pushNamed(context, 'product');
              },
              child: ProductCard(product: producsService.products[index]))),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          producsService.selectedProduct =
              new Product(available: false, name: '', price: 0);
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }
}
