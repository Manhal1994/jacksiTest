part of 'add_product_bloc.dart';

abstract class AddProductState {}

class AddProductInitial extends AddProductState {}
class AddProductLoading extends AddProductState {}
class AddProductSuccess extends AddProductState {
  final bool success;
  AddProductSuccess(this.success);
}
class AddProductFail extends AddProductState {
  final String message;
  AddProductFail(this.message);
}



