import 'package:flutter/material.dart';
import 'package:shopping_list/database/category.dart';

class EditCategoryForm extends StatefulWidget {
  final FocusNode categoryNameFocusNode;
  final String currentCategoryName;
  final String documentId;

  const EditCategoryForm({
    this.categoryNameFocusNode,
    this.currentCategoryName,
    this.documentId,
  });

  @override
  _EditCategoryFormState createState() => _EditCategoryFormState();
}

class _EditCategoryFormState extends State<EditCategoryForm> {
  final _editCategoryFormKey = GlobalKey<FormState>();
  TextEditingController _categoryNameController;

  @override
  void initState() {
    _categoryNameController = TextEditingController(
      text: widget.currentCategoryName,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _editCategoryFormKey,
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
                      await Categories.updateCategory(
                          docId: widget.documentId,
                          categoryName: _categoryNameController.text);
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
