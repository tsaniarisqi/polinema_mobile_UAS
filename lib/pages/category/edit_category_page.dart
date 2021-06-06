import 'package:flutter/material.dart';
import 'package:shopping_list/database/category.dart';
import 'package:shopping_list/widgets/edit_category_form.dart';

class EditCategoryPage extends StatefulWidget {
  final String currentCategoryName;
  final String documentId;

  EditCategoryPage({
    this.currentCategoryName,
    this.documentId,
  });

  @override
  _EditCategoryPageState createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  final FocusNode _categoryNameFocusNode = FocusNode();
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _categoryNameFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Category"),
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

                      await Categories.deleteCategory(
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
            child: EditCategoryForm(
              documentId: widget.documentId,
              categoryNameFocusNode: _categoryNameFocusNode,
              currentCategoryName: widget.currentCategoryName,
            ),
          ),
        ),
      ),
    );
  }
}
