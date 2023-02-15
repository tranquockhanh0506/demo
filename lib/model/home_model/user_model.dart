import 'package:image_picker/image_picker.dart';

class UserModel {
  final int index;
  final String? name;
  final String? description;
  final XFile? file;

  UserModel(this.index,this.name, this.description, this.file);
}