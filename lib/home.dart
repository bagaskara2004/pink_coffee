import 'dart:io';

import 'package:flutter/material.dart';

import 'database/table_product.dart';
import 'detail.dart';
import 'model/product.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> listProduct = [];
  Tproduct db = Tproduct();

  @override
  void initState() {
    _getAllProduct();
    super.initState();
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
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: Image.asset(
                'images/Banner.png',
                fit: BoxFit.cover,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 160,
                  width: 120,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomLeft: Radius.circular(50)),
                      child: Image.asset(
                        'images/ListCoffee.png',
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  height: 160,
                  width: 120,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomLeft: Radius.circular(50)),
                      child: Image.asset(
                        'images/ListDrink.png',
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  height: 160,
                  width: 120,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomLeft: Radius.circular(50)),
                      child: Image.asset(
                        'images/ListFood.png',
                        fit: BoxFit.cover,
                      )),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 64, 125, 1),
              ),
              child: const Text(
                'Best Sellers',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ),
            SizedBox(
              height: 220,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listProduct.length,
                  itemBuilder: (BuildContext context, int index) {
                    Product product = listProduct[index];
                    if (product.rekomended == 'rekomended') {
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
