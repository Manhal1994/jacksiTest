import 'package:flutter/material.dart';
import 'package:jacksi_test/data/database/database.dart';
import 'package:jacksi_test/data/entities/product_dto.dart';
import 'package:jacksi_test/data/repository.dart';

enum ViewType { horizontal, vertical }

class HomePageViewModel {
  final Repository repository;

  HomePageViewModel(this.repository) {
    repository.allProducts().listen((event) async {
      selectCategory(selectedCategory.value);
    });
  }

  final ValueNotifier<List<ProductDTO>> _products =
      ValueNotifier<List<ProductDTO>>([]);

  ValueNotifier<List<ProductDTO>> get products => _products;

  final ValueNotifier<Category?> _selectedCategory =
      ValueNotifier<Category?>(null);

  ValueNotifier<Category?> get selectedCategory => _selectedCategory;

  final ValueNotifier<ViewType> _selectedViewType =
      ValueNotifier<ViewType>(ViewType.vertical);

  ValueNotifier<ViewType> get selectedViewType => _selectedViewType;

  selectViewType(ViewType viewType) {
    _selectedViewType.value = viewType;
    _selectedViewType.notifyListeners();
  }

  selectCategory(Category? category) async {
    selectedCategory.value = category;
    selectedCategory.notifyListeners();
    if (category != null) {
      _products.value = await repository.getProductsByCategory(category.id);
    } else {
      _products.value = await repository.getProducts();
    }
    _products.notifyListeners();
  }
}
