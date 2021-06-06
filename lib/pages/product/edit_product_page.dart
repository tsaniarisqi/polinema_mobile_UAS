import 'package:flutter/material.dart';
import 'package:shopping_list/database/product.dart';
import 'package:shopping_list/widgets/edit_product_from.dart';

class EditProductPage extends StatefulWidget {
  final String currentProductName;
  final String currentQty;
  final String currentNotes;
  final String documentId;

  EditProductPage({
    this.currentProductName,
    this.currentQty,
    this.currentNotes,
    this.documentId,
  });

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final FocusNode _productNameFocusNode = FocusNode();
  final FocusNode _qtyFocusNode = FocusNode();
  final FocusNode _notesFocusNode = FocusNode();
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _productNameFocusNode.unfocus();
        _qtyFocusNode.unfocus();
        _notesFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Product"),
          backgroundColor: Colors.teal[400],
          actions: [
            _isDeleting
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                      right: 16.0,
                    ),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.redAccent,
                      ),
                      strokeWidth: 3,
                    ),
                  )
                : IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                      size: 32,
                    ),
                    onPressed: () async {
                      setState(() {
                        _isDeleting = true;
                      });

                      await Product.deleteProduct(
                        docId: widget.documentId,
                      );

                      setState(() {
                        _isDeleting = false;
                      });

                      Navigator.of(context).pop();
                    },
                  ),
          ],
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
              productNameFocusNode: _productNameFocusNode,
              qtyFocusNode: _qtyFocusNode,
              notesFocusNode: _notesFocusNode,
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
