import 'package:equatable/equatable.dart';

class Category extends Equatable{
  int id;
  String name;
  Category(this.id,this.name);

  @override
  List<Object?> get props => [id,name];
}