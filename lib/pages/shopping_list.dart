import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/auth/auth_services.dart';
import 'package:shopping_list/auth/sign_in.dart';
import 'package:shopping_list/pages/category.dart';
import 'package:shopping_list/pages/login.dart';

class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final FirebaseAuth auth = FirebaseAuth.instance;

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
        onPressed: () {},
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
                MaterialPageRoute(builder: (context) => ShoppingList()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.list_outlined),
            title: Text("All Category"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Category()),
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
                return login();
              }), ModalRoute.withName('/'));
            },
          ),
        ],
      ),
    );
  }
}
