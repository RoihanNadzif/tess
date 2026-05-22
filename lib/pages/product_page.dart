import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tess/model/Product.dart';
import 'dart:convert';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<List<Product>> fetchProduct() async {
    final url = Uri.parse('https://api.dianeka.web.id/api/products');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);
        List<dynamic> data = body['data'] ?? [];
        return data.map((product) => Product.fromJson(product)).toList();
      } else {
        throw Exception('Gagal mengambil data produk ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Halaman Produk")),
      body: FutureBuilder<List<Product>>(
        future: fetchProduct(),
        builder: (context, snapshot) {
          final produks = snapshot.data!;
          return ListView.builder(
            itemCount: produks.length,
            itemBuilder: (context, index) {
              final item = produks[index];
              return ListTile(
                leading: Image.network(
                  item.imageUrl,
                  width: 80,
                  fit: BoxFit.cover,
                ),
                title: Text(item.Name),
              );
            },
          );
        },
      ),
    );
  }
}
