import 'package:fido_box_demo01/modules/category_fido_purchase/domain/product_model.dart';
import 'package:flutter/material.dart';

class BrandModel {
  final String name;
  final IconData icon;
  final List<ProductModelp>? products;

  BrandModel({
    required this.name,
    required this.icon,
    this.products,
  });
}

class CategoryModel {
  final int id;
  final String name;
  final String bannerImage;
  final String? featuredProductName;
  final String? featuredProductImage;
  final String? featuredProductPrice;
  final List<BrandModel> brands;
  final List<String> popularModels;

  CategoryModel({
    required this.id,
    required this.name,
    required this.bannerImage,
    this.featuredProductName,
    this.featuredProductImage,
    this.featuredProductPrice,
    required this.brands,
    required this.popularModels,
  });
}