import 'package:flutter/material.dart';
import 'package:shopping_list/database/product.dart';

class EditProductForm extends StatefulWidget {
  final FocusNode productNameFocusNode;
  final FocusNode qtyFocusNode;
  final FocusNode notesFocusNode;
  final String currentProductName;
  final int currentQty;
  final String currentNotes;
  final String documentId;

  const EditProductForm({
    this.productNameFocusNode,
    this.qtyFocusNode,
    this.notesFocusNode,
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

  TextEditingController _productNameController;
  TextEditingController _qtyController;
  TextEditingController _notesController;

  @override
  void initState() {
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
                      await Product.updateProduct(
                          docId: widget.documentId,
                          productName: _productNameController.text,
                          qty: int.tryParse(_qtyController.text),
                          notes: _notesController.text);
                      Navigator.of(context).pop();
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
