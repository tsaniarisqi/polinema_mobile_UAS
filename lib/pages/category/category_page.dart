import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/auth/auth_services.dart';
import 'package:shopping_list/pages/category/add_category_page.dart';
import 'package:shopping_list/pages/login.dart';
import 'package:shopping_list/pages/product/product_page.dart';
import 'package:shopping_list/widgets/category_list.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Category"),
        backgroundColor: Colors.teal[400],
      ),
      drawer: _drawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal[400],
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddCategoryPage(),
            ),
          );
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: CategoryList(),
        ),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal[300],
            ),
            accountName:Text(
              "Selamat Datang",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 3),
            ),
            accountEmail: Text(
              auth.currentUser.email,
              style: TextStyle(fontSize: 15),
            ),
            currentAccountPicture: CircleAvatar(
              child: Icon(
                Icons.account_circle,
                size: 70,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart_outlined),
            title: Text("Shopping List"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.list_outlined),
            title: Text("All Category"),
            selected: true,
            selectedTileColor: Colors.teal[50],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoryPage()),
              );
            },
          ),
          Divider(thickness: 3),
          ListTile(
            leading: Icon(Icons.login_outlined),
            title: Text("Log Out"),
            onTap: () async {
              AuthService.signOutGoogle();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                return Login();
              }), ModalRoute.withName('/'));
            },
          ),
        ],
      ),
    );
  }
}
