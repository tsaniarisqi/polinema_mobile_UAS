import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shopping_list/database/category.dart';
import 'package:shopping_list/pages/category/edit_category_page.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Categories.readCategories(),
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
                      child: Icon(Icons.category),
                    ),
                    title: Text(
                      categoryName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                        builder: (context) => EditCategoryPage(
                          currentCategoryName: categoryName,
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
                              Text("Are you sure to delete this category? "),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel")),
                            FlatButton(
                                onPressed: () async {
                                  await Categories.deleteCategory(docId: docID);
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
