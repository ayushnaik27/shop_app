import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class EditProductsScreen extends StatefulWidget {
  static const routeName = '/edit-products';

  const EditProductsScreen({super.key});

  @override
  State<EditProductsScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductsScreen> {
  final _priceFocus = FocusNode();
  final _descriptionfocus = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _existingValue = Item(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
    quantity: 0,
  );
  var isLoading = false;
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

  Future<void> _saveform() async {
    setState(() {
      isLoading = true;
    });
    _form.currentState?.validate();
    _form.currentState?.save();
    if (_existingValue.id != null) {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_existingValue.id, _existingValue);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_existingValue);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('An error occured'),
                content: const Text('Something went wrong'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Okay'),
                  ),
                ],
              );
            });
      } //finally {
      //   setState(() {
      //     isLoading = false;
      //   });
      //   Navigator.pop(context);
      // }
    }
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context);
  }

  bool _isInit = true;
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments as String?;
      if (productId != null) {
        _existingValue = Provider.of<Products>(context).findById(productId);
        _initValues = {
          'title': _existingValue.title,
          'description': _existingValue.description,
          'price': _existingValue.price.toString(),
          // 'imageUrl': _existingValue.imageUrl,
        };
        _imageUrlController.text = _existingValue.imageUrl;
      }
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Products'),
        actions: [
          TextButton(
              onPressed: () {
                _saveform();
              },
              child: const Text('Save'))
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _form,
                child: ListView(children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Title'),
                    initialValue: _initValues['title'],
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocus);
                    },
                    onSaved: (newValue) {
                      _existingValue = Item(
                        id: _existingValue.id,
                        title: newValue as String,
                        price: _existingValue.price,
                        description: _existingValue.description,
                        imageUrl: _existingValue.imageUrl,
                        quantity: _existingValue.quantity,
                        isFavourite: _existingValue.isFavourite,
                      );
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Price'),
                    initialValue: _initValues['price'],
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocus,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_descriptionfocus);
                    },
                    onSaved: (newValue) {
                      _existingValue = Item(
                        id: _existingValue.id,
                        title: _existingValue.title,
                        price: double.parse(newValue as String),
                        description: _existingValue.description,
                        imageUrl: _existingValue.imageUrl,
                        quantity: _existingValue.quantity,
                        isFavourite: _existingValue.isFavourite,
                      );
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid price';
                      }
                      if (double.parse(value) <= 0) {
                        return 'Please enter a valid price';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Description'),
                    initialValue: _initValues['description'],
                    // textInputAction: TextInputAction.next,
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    focusNode: _descriptionfocus,
                    onSaved: (newValue) {
                      _existingValue = Item(
                        id: _existingValue.id,
                        title: _existingValue.title,
                        price: _existingValue.price,
                        description: newValue as String,
                        imageUrl: _existingValue.imageUrl,
                        quantity: _existingValue.quantity,
                        isFavourite: _existingValue.isFavourite,
                      );
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a description';
                      }
                      if (value.length < 10) {
                        return 'Enter atleast 10 characters';
                      }
                      return null;
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(top: 8, right: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: _imageUrlController.text.isEmpty
                            ? const Text(
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
                          decoration: const InputDecoration(hintText: 'Image URL'),
                          // initialValue: _initValues['imageUrl'],
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageUrlController,
                          onFieldSubmitted: (value) {
                            setState(() {});
                          },
                          onSaved: (newValue) {
                            _existingValue = Item(
                              id: _existingValue.id,
                              title: _existingValue.title,
                              price: _existingValue.price,
                              description: _existingValue.description,
                              imageUrl: newValue as String,
                              quantity: _existingValue.quantity,
                              isFavourite: _existingValue.isFavourite,
                            );
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a description';
                            }
                            return null;
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
