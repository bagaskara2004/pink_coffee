import 'package:flutter/material.dart';
import 'package:pink_coffee/database/table_product.dart';

import 'detail.dart';
import 'model/product.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();
  Tproduct db = Tproduct();
  List<Product> listProduct = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void clearAll(){
    setState(() {
      listProduct.clear();
      _controller.clear();
    });
  }

  void _handleSubmit(String value) async {
    var listName = await db.searchProductByName(value);

    setState(() {
      listProduct.clear();

      if (listName != null && listName.isNotEmpty && value != '') {
        for (var productMap in listName) {
          listProduct.add(Product.fromMap(productMap));
        }
      } else {
        String title = 'Not Found';
        String msg = '$value tidak ditemukan';
        if(value == ''){
          title = 'Empty Search';
          msg = 'tidak boleh kosong';
        }
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Text(msg),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    clearAll();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
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
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextField(
                controller: _controller,
                onSubmitted: _handleSubmit,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.pink, width: 2),
                        borderRadius: BorderRadius.circular(30)),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      onPressed: () {
                        clearAll();
                      },
                      icon: const Icon(Icons.cancel),
                    ),
                    hintText: 'Search Product',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.pink, width: 2),
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
            ),
            SizedBox(
              height: 600,
              child: ListView.builder(
                  itemCount: listProduct.length,
                  itemBuilder: (BuildContext context, int index) {
                    Product product = listProduct[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Detail(
                                      product: product,
                                    )));
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 300,
                            width: double.infinity,
                            child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Image.asset(
                                  'images/${product.photo}',
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${product.name}',
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Rp.${product.price}',
                                  style: const TextStyle(
                                      fontSize: 25,
                                      color: Color.fromRGBO(255, 64, 125, 1),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
