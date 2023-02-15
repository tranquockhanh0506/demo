import 'package:demo/model/home_model/user_model.dart';
import 'package:demo/screen/home/add_item_screen.dart';
import 'package:demo/screen/home/components/user_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<UserModel> _listItem = [];

  @override
  void initState() {
    _listItem.add(UserModel(0,'Tran Quoc Khanh', 'Mobile Dev', null));
    _listItem.add(UserModel(1,'Tran The Khang', 'BE Dev', null));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Demo'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _addItem(),),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: ListView.builder(
            itemCount: _listItem.length,
            itemBuilder: (context, index) {
              final item = _listItem[index];
              return GestureDetector(
                  onTap: ()=> _handleEditItem(item),
                  child: UserItem(userName: item.name ?? '', description: item.description ?? '', image: item.file,));
            }),
      ),
    );
  }

  // handle edit item
  _handleEditItem(UserModel userItem) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddItemScreen(userModel: userItem,)),
    ).then((value) {
      setState(() {
        _listItem[userItem.index] = value as UserModel;
      });
    });
  }

  // handle add item
 _addItem() {
   Navigator.push(
     context,
     MaterialPageRoute(builder: (context) => const AddItemScreen()),
   ).then((value) {
     final result = value as UserModel;
    setState(() {
      final data = UserModel(_listItem.length, result.name, result.description, result.file);
      _listItem.add(data);
    });
   });
 }
}
