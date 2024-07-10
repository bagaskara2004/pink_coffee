import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pink_coffee/detail.dart';
import 'package:pink_coffee/model/product.dart';
import 'database/table_product.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({super.key});

  @override
  State<ListProduct> createState() => _ProductState();
}

class _ProductState extends State<ListProduct> {
  List<Product> listProduct = [];
  List<Product> listBread = [];
  Tproduct db = Tproduct();

  @override
  void initState() {
    // addProduct();
    _getAllProduct();
    super.initState();
  }
  Future<void> addProduct() async {
    await db.saveProduct(Product(
        name: 'CaffLove',
        price: "25000",
        description: 'coffee pink with love',
        photo: 'Coffee2.jpeg',
        kategori: 'coffee',
        rekomended: 'rekomended'
    ));
    await db.saveProduct(Product(
      name: 'Latte',
      price: "20000",
      description: 'coffee pink with cookie',
      photo: 'Coffee.png',
      kategori: 'coffee',
      rekomended: 'rekomended'
    ));
    await db.saveProduct(Product(
      name: 'Donat',
      price: "15000",
      description: 'donat ping colorful',
      photo: 'Donat.png',
      kategori: 'bread',
      rekomended: 'rekomended'
    ));
    await db.saveProduct(Product(
        name: 'Coffmood',
        price: "17000",
        description: 'coffee for your mood',
        photo: 'Coffmood.jpg',
        kategori: 'coffee',
        rekomended: 'notrekomended'
    ));
    await db.saveProduct(Product(
      name: 'Bolu',
      price: "10000",
      description: 'bread for breakfast',
      photo: 'Bolu.jpeg',
      kategori: 'bread',
      rekomended: 'notrekomended'
    ));
    await db.saveProduct(Product(
      name: 'StroCoff',
      price: "25000",
      description: 'coffee with strawberry',
      photo: 'StroCoff.jpeg',
      kategori: 'coffee',
      rekomended: 'rekomended'
    ));
    await db.saveProduct(Product(
        name: 'Breadmod',
        price: "25000",
        description: 'bread for your day',
        photo: 'Breadmood.jpeg',
        kategori: 'bread',
        rekomended: 'rekomended'
    ));
    await db.saveProduct(Product(
        name: 'Bapao',
        price: "8000",
        description: 'bapao pink with strawberry',
        photo: 'bapao.jpeg',
        kategori: 'bread',
        rekomended: 'notrekomended'
    ));
  }

  Future<void> _getAllProduct() async {
    var list = await db.getAllProduct();
    setState(() {
      listProduct.clear();
      for (var product in list!) {
        listProduct.add(Product.fromMap(product));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Image.asset(
                'images/Banner2.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 64, 125, 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Product',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: const Text(
                        'Coffee',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 64, 125, 1),
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )),
            SizedBox(
              height: 220,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listProduct.length,
                  itemBuilder: (BuildContext context, int index) {
                    Product product = listProduct[index];
                    if (product.kategori != 'bread') {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Detail(product: product,)));
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              margin: const EdgeInsets.only(right: 15),
                              child: ClipRRect(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                                  child: Image.file(
                                    File('${product.photo}'),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                              width: 150,
                              child: Column(
                                children: [
                                  Text(
                                    '${product.name}',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Rp.${product.price}',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Color.fromRGBO(255, 64, 125, 1),
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }else{
                      return const SizedBox.shrink();
                    }
                  }),
            ),
            Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 64, 125, 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Product',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: const Text(
                        'Bread',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 64, 125, 1),
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )),
            SizedBox(
              height: 220,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listProduct.length,
                  itemBuilder: (BuildContext context, int index) {
                    Product product = listProduct[index];
                    if(product.kategori != 'coffee') {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Detail(product: product,)));
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              margin: const EdgeInsets.only(right: 15),
                              child: ClipRRect(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                                  child: Image.file(
                                    File('${product.photo}'),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                              width: 150,
                              child: Column(
                                children: [
                                  Text(
                                    '${product.name}',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Rp.${product.price}',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Color.fromRGBO(255, 64, 125, 1),
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }else{
                      return const SizedBox.shrink();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
