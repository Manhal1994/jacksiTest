part of 'add_product_bloc.dart';

@immutable
abstract class AddProductEvent {}

 class InsertProduct extends AddProductEvent {
  final ProductDTO productDTO;
  InsertProduct(this.productDTO);
 }

