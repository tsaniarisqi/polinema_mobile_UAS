// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:shopping_list/auth/auth_services.dart';
// import 'package:shopping_list/auth/sign_in.dart';
// import 'package:shopping_list/contoh_sederhana/category_card.dart';
// import 'package:shopping_list/pages/login.dart';
// import 'package:shopping_list/contoh_sederhana/product_page.dart';

// class Category extends StatefulWidget {
//   @override
//   _CategoryState createState() => _CategoryState();
// }

// class _CategoryState extends State<Category> {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final TextEditingController categoryNameController = TextEditingController();
//   CollectionReference _category =
//       FirebaseFirestore.instance.collection('category');
  
//   void clearInputText() {
//     categoryNameController.text = "";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("All Category"),
//         backgroundColor: Colors.teal[400],
//       ),
//       body: Column(
//         children: [
//           Align(
//               alignment: Alignment.topCenter,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 decoration: BoxDecoration(color: Colors.white, boxShadow: [
//                   BoxShadow(
//                       color: Colors.black12,
//                       offset: Offset(-5, 0),
//                       blurRadius: 15,
//                       spreadRadius: 3)
//                 ]),
//                 width: double.infinity,
//                 height: 130,
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width - 160,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           TextField(
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 16),
//                             controller: categoryNameController,
//                             decoration: InputDecoration(
//                                 hintText: "Isi Category",
//                                 hintStyle: TextStyle(
//                                     color: Colors.grey,
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 16)),
//                           )
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: 130,
//                       width: 130,
//                       padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
//                       child: RaisedButton(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8)),
//                           color: Colors.blue.shade900,
//                           child: Text(
//                             'Add Data',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           onPressed: () async {
//                             // TODO 1 ADD DATA HERE
//                             await _category.add(
//                                 {"categoryName": categoryNameController.text});
//                             clearInputText();
//                           }),
//                     ),
//                   ],
//                 ),
//               )),
//           Expanded(
//             child: ListView(
//               children: [
//                 // TODO 2 VIEW, update , and delete DATA HERE
//                 /// hanya get sekali saja jika menggunakan FutureBuilder
//                 /*
//                   FutureBuilder<QuerySnapshot>(
//                     future: _pengguna.get(),
//                     builder: (buildContext, snapshot) {
//                       return Column(
//                         children: snapshot.data!.docs
//                             .map((e) =>
//                                 ItemCard(e.data()['name'], e.data()['age']))
//                             .toList(),
//                       );
//                     },
//                   ),
//                   */

//                 // get secara realtime jikga menggunakan stream builder
//                 StreamBuilder<QuerySnapshot>(
//                   // contoh penggunaan srteam
//                   // _pengguna.orderBy('age', descending: true).snapshots()
//                   // _pengguna.where('age', isLessThan: 30).snapshots()
//                   stream: _category
//                       .orderBy('categoryName', descending: true)
//                       .snapshots(),
//                   builder: (buildContext, snapshot) {
//                     return Column(
//                       children: snapshot.data.docs
//                           .map((e) => CategoryCard(
//                                 e.data()['categoryName'],
//                                 onUpdate: () {
//                                   _category.doc(e.id).update({
//                                     "categoryName": categoryNameController.text
//                                   });
//                                 },
//                                 onDelete: () {
//                                   _category.doc(e.id).delete();
//                                 },
//                               ))
//                           .toList(),
//                     );
//                   },
//                 ),
//                 SizedBox(
//                   height: 150,
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//       drawer: _drawer(),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.teal[400],
//         foregroundColor: Colors.white,
//         child: Icon(Icons.add),
//         onPressed: () {},
//       ),
//     );
//   }

//   Widget _drawer() {
//     return Drawer(
//       child: ListView(
//         children: <Widget>[
//           UserAccountsDrawerHeader(
//             decoration: BoxDecoration(
//               color: Colors.teal[300],
//             ),
//             accountName: Text(name),
//             accountEmail: Text(email),
//             currentAccountPicture: CircleAvatar(
//               child: Icon(
//                 Icons.account_circle,
//                 size: 70,
//               ),
//             ),
//           ),
//           ListTile(
//             leading: Icon(Icons.shopping_cart_outlined),
//             title: Text("Shopping List"),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Product()),
//               );
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.list_outlined),
//             title: Text("All Category"),
//             selected: true,
//             selectedTileColor: Colors.teal[50],
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Category()),
//               );
//             },
//           ),
//           Divider(height: 10),
//           ListTile(
//             leading: Icon(Icons.login_outlined),
//             title: Text("Log Out"),
//             onTap: () async {
//               AuthService.signOutGoogle();
//               Navigator.of(context).pushAndRemoveUntil(
//                   MaterialPageRoute(builder: (context) {
//                 return Login();
//               }), ModalRoute.withName('/'));
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
