import 'package:flutter/material.dart';
import 'package:shopping_list/auth/auth_services.dart';
import 'package:shopping_list/auth/sign_in.dart';
import 'package:shopping_list/pages/category/add_category_page.dart';
import 'package:shopping_list/pages/login.dart';
import 'package:shopping_list/pages/product/product_page.dart';
import 'package:shopping_list/widgets/category_list.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

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
