import 'package:flutter/material.dart';
import 'package:shopping_list/database/category.dart';

class AddCategoryForm extends StatefulWidget {
  final FocusNode categoryNameFocusNode;

  const AddCategoryForm({
    this.categoryNameFocusNode,
  });

  @override
  _AddCategoryFormState createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends State<AddCategoryForm> {
  final _addCategoryFormKey = GlobalKey<FormState>();

  final TextEditingController _categoryNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _addCategoryFormKey,
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
            child: TextFormField(
              controller: _categoryNameController,
              focusNode: widget.categoryNameFocusNode,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Category Name',
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
                  await Categories.addCategory(
                      categoryName: _categoryNameController.text);
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
