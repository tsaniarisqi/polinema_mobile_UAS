import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shopping_list/database/product.dart';
import 'package:shopping_list/pages/product/edit_product_page.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Product.readProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 5.0),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              var noteInfo = snapshot.data.docs[index].data();
              String docID = snapshot.data.docs[index].id;
              String categoryName = noteInfo['categoryName'];
              String productName = noteInfo['productName'];
              int qty = noteInfo['qty'];
              String notes = noteInfo['notes'];

              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: Card(
                  color: Colors.grey[50],
                  elevation: 5.0,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    leading: CircleAvatar(
                      child: Icon(Icons.shopping_basket),
                    ),
                    title: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 10, top: 5),
                          child: Text(
                            categoryName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.teal[600]),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            productName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            "Qty: $qty",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "Notes: $notes",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    icon: (Icons.edit),
                    color: Colors.indigo[100],
                    caption: 'Edit',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditProductPage(
                          currentProductName: productName,
                          currentQty: qty.toString(),
                          currentNotes: notes,
                          documentId: docID,
                        ),
                      ),
                    ),
                  ),
                  IconSlideAction(
                    icon: (Icons.delete),
                    color: Colors.pink[100],
                    caption: 'Delete',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Delete"),
                          content:
                              Text("Are you sure to delete this product? "),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel")),
                            FlatButton(
                                onPressed: () async {
                                  await Product.deleteProduct(docId: docID);
                                  Navigator.pop(context);
                                },
                                child: Text("Yes"))
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.black,
            ),
          ),
        );
      },
    );
  }
}
