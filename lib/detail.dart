import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pink_coffee/model/product.dart';

class Detail extends StatelessWidget {
  final Product? product;
  const Detail({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color.fromRGBO(255, 213, 226, 1.0),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: const Text(
            'Detail',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(255, 64, 125, 1),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: ClipRRect(
                      child: Image.file(
                        File('${product?.photo}'),
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 20,bottom: 15),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 64, 125, 1),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Center(child: Text('${product?.name}',style: const TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w500),)),
                ),
                const Divider(
                  color: Color.fromRGBO(255, 64, 125, 1), // Warna garis
                  thickness: 2, //Jaarak kanan garis dari tepi
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Price :',style: TextStyle(fontSize: 20,color: Color.fromRGBO(255, 64, 125, 1),fontWeight: FontWeight.bold),),
                    Text('${product?.price}',style: const TextStyle(fontSize: 20,color: Color.fromRGBO(255, 64, 125, 1)),),
                  ],
                ),
                const Divider(
                  color: Color.fromRGBO(255, 64, 125, 1), // Warna garis
                  thickness: 2, //Jaarak kanan garis dari tepi
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Kategori :',style: TextStyle(fontSize: 20,color: Color.fromRGBO(255, 64, 125, 1),fontWeight: FontWeight.bold),),
                    Text('${product?.kategori}',style: const TextStyle(fontSize: 20,color: Color.fromRGBO(255, 64, 125, 1)),),
                  ],
                ),
                const Divider(
                  color: Color.fromRGBO(255, 64, 125, 1), // Warna garis
                  thickness: 2, //Jaarak kanan garis dari tepi
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Description :',style: TextStyle(fontSize: 20,color: Color.fromRGBO(255, 64, 125, 1),fontWeight: FontWeight.bold),),
                    Flexible(
                      child: Text(
                        '${product?.description}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(255, 64, 125, 1),
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 3,
                        textAlign: TextAlign.end,
                      ),),
                  ],
                ),
                
              ],
            ),
          ),
        ));
  }
}
