import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/add_product_form.dart';

class AddProductPage extends StatelessWidget {
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
          title: Text("Add Product"),
          backgroundColor: Colors.teal[400],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: AddProductForm(
              categoryNameFocusNode: _categoryNameFocusNode,
              productNameFocusNode: _productNameFocusNode,
              qtyFocusNode: _qtyFocusNode,
              notesFocusNode: _notesFocusNode,
            ),
          ),
        ),
      ),
    );
  }
}
