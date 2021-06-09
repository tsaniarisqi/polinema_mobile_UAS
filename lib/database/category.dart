import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection =
    _firestore.collection('shoppingList');

class Categories {
  static String userUid;

  static Future<void> addCategory({
    String categoryName,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('category').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "categoryName": categoryName,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateCategory({
    String categoryName,
    String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('category').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "categoryName": categoryName,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readCategories() {
    CollectionReference notesItemCollection =
        _mainCollection.doc(userUid).collection('category');

    return notesItemCollection.orderBy("categoryName").snapshots();
  }

  static Future<void> deleteCategory({
    String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('category').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}
