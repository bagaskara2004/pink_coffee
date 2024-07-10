import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pink_coffee/form.dart';

import 'database/table_product.dart';
import 'detail.dart';
import 'model/product.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Tproduct db = Tproduct();
  List<Product> listProduct = [];

  Future<void> _getAllProduct() async {
    var list = await db.getAllProduct();
    setState(() {
      listProduct.clear();
      for (var product in list!) {
        listProduct.add(Product.fromMap(product));
      }
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const FormProduct()));
    if (result == 'save') {
      await _getAllProduct();
    }
  }

  Future<void> _openFormEdit(Product product) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormProduct(product: product)));
    if (result == 'update') {
      await _getAllProduct();
    }
  }

  Future<void> _deleteProduct(Product product, int position) async {
    await db.deleteProduct(product.id!);

    setState(() {
      listProduct.removeAt(position);
    });
  }

  @override
  void initState() {
    _getAllProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 64, 125, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.logout),
          color: Colors.white,
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bali,jimbaran',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              'Pink Coffee',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: listProduct.length,
          itemBuilder: (context, index) {
            Product product = listProduct[index];

            return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Detail(
                                product: product,
                              )));
                },
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  '${product.name}',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.deepOrangeAccent),
                ),
                subtitle: Text('${product.price}'),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            _openFormEdit(product);
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          AlertDialog hapus = AlertDialog(
                            title: const Text('Information'),
                            content: SizedBox(
                              height: 100,
                              child: Column(
                                children: [
                                  Text(
                                      'Apakah anda yakin ingin menghapus data ${product.name}'),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('Ya'),
                                onPressed: () {
                                  //delete
                                  _deleteProduct(product, index);
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: const Text('Tidak'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                          showDialog(
                              context: context, builder: (context) => hapus);
                        },
                      ),
                    ],
                  ),
                ),
                leading: CircleAvatar(
                  backgroundImage: FileImage(File('${product.photo}')),
                ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openFormCreate();
        },
        backgroundColor: const Color.fromRGBO(255, 64, 125, 1),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
