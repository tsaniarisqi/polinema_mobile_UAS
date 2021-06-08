import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection =
    _firestore.collection('shoppingList');

class Product {
  static String userUid;

  static Future<void> addProduct({
    String categoryName,
    String productName,
    int qty,
    String notes,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('product').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "categoryName": categoryName,
      "productName": productName,
      "qty": qty,
      "notes": notes,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Note item added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateProduct({
    String categoryName,
    String productName,
    int qty,
    String notes,
    String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('product').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "categoryName": categoryName,
      "productName": productName,
      "qty": qty,
      "notes": notes,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readProducts() {
    CollectionReference notesItemCollection =
        _mainCollection.doc(userUid).collection('product');

    return notesItemCollection.snapshots();
  }

  static Future<void> deleteProduct({
    String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('product').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}
