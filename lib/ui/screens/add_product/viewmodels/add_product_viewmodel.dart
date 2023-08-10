import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jacksi_test/data/database/database.dart';
import 'package:jacksi_test/data/entities/product_dto.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddProductViewModel {
  final ValueNotifier<List<String>> _productImages =
      ValueNotifier<List<String>>([]);

  ValueNotifier<List<String>> get productImages => _productImages;

  final ValueNotifier<Category?> _productCategory =
      ValueNotifier<Category?>(null);

  ValueNotifier<Category?> get productCategory => _productCategory;

  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();

  pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        _productImages.value.add(image.path);
        _productImages.notifyListeners();
      }
    } catch (e) {
      debugPrint("error" + e.toString());
    }
  }

  deleteProductImage(int index) {
    _productImages.value.removeAt(index);
    _productImages.notifyListeners();
  }

  selectCategory(Category? category) {
    _productCategory.value = category;
    _productCategory.notifyListeners();
  }

  ProductDTO? getProductDTO() {
    if (validateInput()) {
      return ProductDTO(
          price: double.parse(priceController.text),
          categoryId: productCategory.value!.id,
          productName: productNameController.text.trim(),
          storeName: storeNameController.text.trim(),
          images: productImages.value);
    } else {
      return null;
    }
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  bool validateName(String name) {
    return name.isNotEmpty;
  }

  bool validatePrice() {
    return (priceController.text.isNotEmpty||isNumeric(priceController.text)||(double.tryParse(priceController.text.trim())??0)>0);
  }

  bool validateImages() {
    return productImages.value.isNotEmpty;
  }

  bool validateCategory() {
    return productCategory.value != null;
  }

  bool validateInput() {
    // validate product images
    if (!validateImages()) {
      showToast("اضف صورة واحدة على الأقل");
      return false;
    }
    // validate product name
    if (!validateName(productNameController.text.trim())) {
      showToast("اسم المنتج فارغ");
      return false;
    }
    // validate product price
    if (!validatePrice()) {
      showToast("ادخل سعر منتج صالح");
      return false;
    }
    // validate store name
    if (!validateName(storeNameController.text.trim())) {
      showToast("اسم المتجر فارغ");
      return false;
    }
    // validate product  category
    if (!validateCategory()) {
      showToast("اختر تصنيف");
      return false;
    }
    return true;
  }

  showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
