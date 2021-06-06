import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/add_category_form.dart';

class AddCategoryPage extends StatelessWidget {
  final FocusNode _categoryNameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _categoryNameFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Category"),
          backgroundColor: Colors.teal[400],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child:
                AddCategoryForm(categoryNameFocusNode: _categoryNameFocusNode),
          ),
        ),
      ),
    );
  }
}
