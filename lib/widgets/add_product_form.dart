import 'package:flutter/material.dart';
import 'package:shopping_list/database/product.dart';

class AddProductForm extends StatefulWidget {
  final FocusNode productNameFocusNode;
  final FocusNode qtyFocusNode;
  final FocusNode notesFocusNode;

  const AddProductForm({
    this.productNameFocusNode,
    this.qtyFocusNode,
    this.notesFocusNode,
  });

  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _addProductFormKey = GlobalKey<FormState>();

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _addProductFormKey,
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
            child: ButtonTheme(
              minWidth: 185,
              height: 50,
              child: RaisedButton(
                color: Colors.teal[300],
                child: Text(
                  'Save',
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, letterSpacing: 3),
                ),
                onPressed: () async {
                  await Product.addProduct(
                      productName: _productNameController.text,
                      qty: int.tryParse(_qtyController.text),
                      notes: _notesController.text);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
