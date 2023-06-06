import 'package:flutter/material.dart';

class EditProductsScreen extends StatefulWidget {
  static const routeName = '/edit-products';

  @override
  State<EditProductsScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductsScreen> {
  final _priceFocus = FocusNode();
  final _descriptionfocus = FocusNode();
  final _imageUrlController = TextEditingController();
  // final _imageUrlFocus = FocusNode();

  @override
  void dispose() {
    // _imageUrlFocus.removeListener(() {
    //   _updateImage();
    // });
    // _imageUrlFocus.dispose();
    _priceFocus.dispose();
    _descriptionfocus.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   _imageUrlFocus.addListener(() {
  //     _updateImage();
  //   });
  //   super.initState();
  // }

  // void _updateImage() {
  //   if (!_imageUrlFocus.hasFocus) {
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          child: ListView(children: [
            TextFormField(
              decoration: InputDecoration(hintText: 'Title'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocus);
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Price'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocus,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_descriptionfocus);
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Description'),
              // textInputAction: TextInputAction.next,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              focusNode: _descriptionfocus,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(top: 8, right: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: _imageUrlController.text.isEmpty
                      ? Text(
                          'Enter Url',
                          textAlign: TextAlign.center,
                        )
                      : FittedBox(
                          child: Image.network(
                            _imageUrlController.text,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Image URL'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrlController,
                    onFieldSubmitted: (value) {
                      setState(() {});
                    },
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
