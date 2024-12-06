import 'package:flutter/material.dart';
import 'api_shop.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  late Future<List<dynamic>> futureProducts;
  final List<dynamic> cart = [];

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts();
  }

  void addToCart(dynamic product) {
    setState(() {
      cart.add(product);
    });
  }

  void showCart() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        if (cart.isEmpty) {
          return const Center(
            child: Text('Your cart is empty'),
          );
        } else {
          return ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, index) {
              final product = cart[index];
              final imageUrl = product['image'] ?? 'https://via.placeholder.com/150';
              final productName = product['title'] ?? 'No name';
              final productPrice = product['price'] != null ? '\$${product['price']}' : 'No price';

              return ListTile(
                leading: Image.network(imageUrl),
                title: Text(productName),
                subtitle: Text(productPrice),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: showCart,
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found'));
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(10.0), 
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 1 : 4,
                childAspectRatio: isMobile ? 1 / 1.5 : 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                final imageUrl = product['image'] ?? 'https://via.placeholder.com/150';
                final productName = product['title'] ?? 'No name';
                final productPrice = product['price'] != null ? '\$${product['price']}' : 'No price';
                final productDescription = product['description'] ?? 'No description';

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  margin: const EdgeInsets.all(5.0), 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                        ),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: isMobile ? 200 : 150,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text(
                                    productPrice,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 207, 177, 131),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Text(
                                  productDescription,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: ElevatedButton(
                                    onPressed: () => addToCart(product),
                                    child: const Text('Add to Cart'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}