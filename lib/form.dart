import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pink_coffee/database/table_product.dart';
import 'package:pink_coffee/model/product.dart';

const List<String> kategoriProduct = <String>['coffee', 'bread'];
const List<String> rekomendedProduct = <String>['rekomended', 'notrekomended'];

class FormProduct extends StatefulWidget {
  final Product? product;
  const FormProduct({super.key, this.product});

  @override
  State<FormProduct> createState() => _FormProductState();
}

class _FormProductState extends State<FormProduct> {
  Tproduct db = Tproduct();

  File? image;
  String kategoriValue = kategoriProduct.first;
  String rekomendedValue = rekomendedProduct.first;
  TextEditingController? name;
  TextEditingController? price;
  TextEditingController? description;
  TextEditingController? photo;

  @override
  void initState() {
    name = TextEditingController(
        text: widget.product == null ? '' : widget.product!.name);
    price = TextEditingController(
        text: widget.product == null ? '' : widget.product!.price);
    description = TextEditingController(
        text: widget.product == null ? '' : widget.product!.description);
    photo = TextEditingController(
        text: widget.product == null ? '' : widget.product!.photo);

    if (widget.product?.photo != null && widget.product!.photo!.isNotEmpty) {
      image = File(widget.product!.photo!);
    } else {
      image = null;
    }
    super.initState();
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;

      final imageFile = File(pickedImage.path);
      setState(() {
        image = imageFile;
      });

      await moveImage(imageFile);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }

  Future<void> moveImage(File imageFile) async {
    try {
      List<Directory>? appDirs = await getExternalStorageDirectories();

      Directory appDir = appDirs![0];

      String appPath = '${appDir.path}/MyApp';
      Directory appDirFolder = Directory(appPath);
      if (!(await appDirFolder.exists())) {
        await appDirFolder.create(recursive: true);
      }

      String newPath = '$appPath/${DateTime.now().millisecondsSinceEpoch}.jpg';
      await imageFile.copy(newPath);
    } catch (e) {
      if (kDebugMode) {
        print('Error moving file: $e');
      }
    }
  }

  Future<void> upsertProduct(context) async {
    if(name?.text == '' || price?.text == '' || description?.text == '' || image == null) {
      _showAlertDialog(context, 'Erorr Form', 'tidak boleh kosong');
    }else if (widget.product != null) {
      await db.updateProduct(Product.fromMap({
        'id' : widget.product!.id,
        'name' : name!.text,
        'price' : price!.text,
        'description' : description!.text,
        'photo' : image!.path,
        'kategori' : kategoriValue,
        'rekomended' : rekomendedValue
      }));
      Navigator.pop(context, 'update');
    } else {
      await db.saveProduct(Product(
        name: name!.text,
        price: price!.text,
        description: description!.text,
        photo: image!.path,
        kategori: kategoriValue,
        rekomended: rekomendedValue,
      ));
      Navigator.pop(context, 'save');
    }
  }

  void _showAlertDialog(BuildContext context, title, msg) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(msg),
            actions: <Widget>[
              TextButton(
                child: const Text('ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title: const Text(
          'Form',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(255, 64, 125, 1),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextField(
            controller: name,
            decoration: const InputDecoration(
              labelText: 'Nama',
            ),
          ),
          TextField(
            controller: price,
            decoration: const InputDecoration(
              labelText: 'Harga',
            ),
          ),
          TextField(
            controller: description,
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
          ),
          DropdownButton<String>(
            value: kategoriValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            padding: const EdgeInsets.only(top: 20),
            style: const TextStyle(color: Colors.black,fontSize: 18),
            underline: Container(
              height: 2,
              color: Colors.grey,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                kategoriValue = value!;
              });
            },
            items:
                kategoriProduct.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          DropdownButton<String>(
            value: rekomendedValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            padding: const EdgeInsets.only(top: 20),
            style: const TextStyle(color: Colors.black,fontSize: 18),
            underline: Container(
              height: 2,
              color: Colors.grey,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                rekomendedValue = value!;
              });
            },
            items:
                rekomendedProduct.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 20,
          ),
          if (image != null) ...[
            Image.file(image!,height: 50,),
            const SizedBox(height: 20),
          ],
          const SizedBox(
            height: 10,
          ),
          MaterialButton(
            color: const Color.fromRGBO(255, 64, 125, 1),
            child: const Text(
              "Pick Image from Gallery",
              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              pickImage(ImageSource.gallery);
            },
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              upsertProduct(context);
            },
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(255, 64, 125, 1)),
              padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
            ),
            child: (widget.product == null)
                ? const Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  )
                : const Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        ],
      ),
    );
  }
}
