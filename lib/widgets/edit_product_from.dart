import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/database/category.dart';
import 'package:shopping_list/database/product.dart';

class EditProductForm extends StatefulWidget {
  final FocusNode categoryNameFocusNode;
  final FocusNode productNameFocusNode;
  final FocusNode qtyFocusNode;
  final FocusNode notesFocusNode;
  final String currentCategoryName;
  final String currentProductName;
  final int currentQty;
  final String currentNotes;
  final String documentId;

  const EditProductForm({
    this.categoryNameFocusNode,
    this.productNameFocusNode,
    this.qtyFocusNode,
    this.notesFocusNode,
    this.currentCategoryName,
    this.currentProductName,
    this.currentQty,
    this.currentNotes,
    this.documentId,
  });

  @override
  _EditProductFormState createState() => _EditProductFormState();
}

class _EditProductFormState extends State<EditProductForm> {
  final _editProductFormKey = GlobalKey<FormState>();
  var selectedCategory;

  TextEditingController _categoryController = TextEditingController();
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _qtyController = TextEditingController();
  TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    _categoryController =
        TextEditingController(text: widget.currentCategoryName);
    _productNameController = TextEditingController(
      text: widget.currentProductName,
    );
    _qtyController = TextEditingController(
      text: widget.currentQty.toString(),
    );
    _notesController = TextEditingController(
      text: widget.currentNotes,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _editProductFormKey,
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
            child: TextFormField(
              controller: _productNameController,
              focusNode: widget.productNameFocusNode,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please fill this section';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: TextFormField(
              controller: _qtyController,
              focusNode: widget.qtyFocusNode,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Qty',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please fill this section';
                }
                return null;
              },
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: Categories.readCategories(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                const Text("Loading.....");
              else {
                List<DropdownMenuItem> categoryItems = [];
                for (int i = 0; i < snapshot.data.docs.length; i++) {
                  DocumentSnapshot snap = snapshot.data.docs[i];
                  categoryItems.add(
                    DropdownMenuItem(
                      child: Text(
                        snap.get("categoryName"),
                      ),
                      value: "${snap.get("categoryName")}",
                    ),
                  );
                }
                return Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    focusNode: widget.categoryNameFocusNode,
                    items: categoryItems,
                    onChanged: (categoryValue) {
                      setState(() {
                        selectedCategory = categoryValue;
                      });
                    },
                    value: selectedCategory,
                  ),
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
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: TextFormField(
              controller: _notesController,
              focusNode: widget.notesFocusNode,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please fill this section';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Row(
              children: <Widget>[
                // tombol simpan
                ButtonTheme(
                  minWidth: 185,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.teal[300],
                    child: Text(
                      'Update',
                      style: TextStyle(
                          color: Colors.white, fontSize: 18, letterSpacing: 3),
                    ),
                    onPressed: () async {
                      if (selectedCategory != null) {
                        await Product.updateProduct(
                            docId: widget.documentId,
                            categoryName: selectedCategory,
                            productName: _productNameController.text,
                            qty: int.tryParse(_qtyController.text),
                            notes: _notesController.text);
                        Navigator.of(context).pop();
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Message"),
                            content: Text("Please choose a category"),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("OK"),
                              )
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
                Container(
                  width: 5.0,
                ),
                // tombol batal
                ButtonTheme(
                  minWidth: 185,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.teal[300],
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.white, fontSize: 18, letterSpacing: 3),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
