import 'package:flutter/material.dart';
import 'package:shopping_list/auth/auth_services.dart';
import 'package:shopping_list/auth/sign_in.dart';
import 'package:shopping_list/pages/category/category_page.dart';
import 'package:shopping_list/pages/login.dart';
import 'package:shopping_list/pages/product/add_product_page.dart';
import 'package:shopping_list/widgets/product_list.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping List"),
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
              builder: (context) => AddProductPage(),
            ),
          );
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: ProductList(),
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
            accountName: Text(name),
            accountEmail: Text(email),
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
            selected: true,
            selectedTileColor: Colors.teal[50],
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoryPage()),
              );
            },
          ),
          Divider(height: 10),
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
