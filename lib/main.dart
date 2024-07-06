import 'package:flutter/material.dart';
import 'package:pink_coffee/home.dart';
import 'package:pink_coffee/login.dart';
import 'package:pink_coffee/search.dart';
import 'package:pink_coffee/list_product.dart';

void main() {
  runApp(const Apps());
}

class Apps extends StatelessWidget {
  const Apps({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PinkCoffee(),
    );
  }
}

class PinkCoffee extends StatefulWidget {
  const PinkCoffee({super.key});

  @override
  State<PinkCoffee> createState() => _PinkCoffeeState();
}

class _PinkCoffeeState extends State<PinkCoffee> {
  int _pageIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Home(),
    Search(),
    ListProduct(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bali,jimbaran',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(153, 153, 153, 1)),
            ),
            Text(
              'Pink Coffee',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(255, 64, 125, 1)),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
            },
            icon: const Icon(Icons.login),
            iconSize: 30,
            style: const ButtonStyle(
                iconColor:
                    MaterialStatePropertyAll(Color.fromRGBO(255, 64, 125, 1))),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Center(
        child: _pages.elementAt(_pageIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.backup_table),
            label: 'Product',
          ),
        ],
        currentIndex: _pageIndex,
        selectedItemColor: const Color.fromRGBO(255, 64, 125, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}
