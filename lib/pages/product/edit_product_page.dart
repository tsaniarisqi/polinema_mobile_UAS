import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/edit_product_from.dart';

class EditProductPage extends StatefulWidget {
  final String currentCategoryName;
  final String currentProductName;
  final String currentQty;
  final String currentNotes;
  final String documentId;

  EditProductPage({
    this.currentCategoryName,
    this.currentProductName,
    this.currentQty,
    this.currentNotes,
    this.documentId,
  });

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final FocusNode _categoryNameFocusNode = FocusNode();
  final FocusNode _productNameFocusNode = FocusNode();
  final FocusNode _qtyFocusNode = FocusNode();
  final FocusNode _notesFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _categoryNameFocusNode.unfocus();
        _productNameFocusNode.unfocus();
        _qtyFocusNode.unfocus();
        _notesFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Product"),
          backgroundColor: Colors.teal[400],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: EditProductForm(
              documentId: widget.documentId,
              categoryNameFocusNode: _categoryNameFocusNode,
              productNameFocusNode: _productNameFocusNode,
              qtyFocusNode: _qtyFocusNode,
              notesFocusNode: _notesFocusNode,
              currentCategoryName: widget.currentCategoryName,
              currentProductName: widget.currentProductName,
              currentQty: int.tryParse(widget.currentQty),
              currentNotes: widget.currentNotes,
            ),
          ),
        ),
      ),
    );
  }
}
