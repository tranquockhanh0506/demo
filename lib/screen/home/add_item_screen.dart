import 'dart:io';
import 'package:demo/model/home_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddItemScreen extends StatefulWidget {
  final UserModel? userModel;

  const AddItemScreen({Key? key, this.userModel}) : super(key: key);

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  // name controller
  final TextEditingController _nameController = TextEditingController();

  // description controller
  final TextEditingController _descriptionController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  void initState() {
    _getInitData();
    super.initState();
  }

  // get init data
  _getInitData() {
    if (widget.userModel != null) {
      if (widget.userModel!.name != null) {
        _nameController.text = widget.userModel!.name!;
      }
      if (widget.userModel!.description != null) {
        _descriptionController.text = widget.userModel!.description!;
      }
      if (widget.userModel!.file != null) {
        _image = widget.userModel!.file;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Add item"), backgroundColor: Colors.redAccent),
        body: Container(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'input name',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      hintText: 'input description',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 40.0,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple,
                        ),
                        onPressed: () async {
                          _image = await _picker.pickImage(
                              source: ImageSource.camera);
                          setState(() {
                            //update UI
                          });
                        },
                        child: const Text("Pick Image")),
                  ),
                ),
                _image == null
                    ? Container()
                    : Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.file(File(_image!.path))),
                    ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 40.0,
                  child: ElevatedButton(
                      onPressed: () => _getData(), child: const Text('Add')),
                )
              ],
            )));
  }

  // handle get data
  _getData() {
    if (_nameController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      Navigator.pop(
          context,
          UserModel(
              0, _nameController.text, _descriptionController.text, _image));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Please enter Name and Description",
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
      ));
    }
  }
}
