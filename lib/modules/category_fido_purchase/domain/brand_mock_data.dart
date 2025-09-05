import 'package:fido_box_demo01/modules/category_fido_purchase/domain/model_variant.dart';
import 'package:fido_box_demo01/modules/category_fido_purchase/domain/product_model.dart';
import 'package:flutter/material.dart';

import 'brand_model.dart';

final BrandModel brandApple = BrandModel(
  name: 'Apple',
  icon: Icons.apple,
  products: [
    ProductModelp(
      name: 'iPhone 11',
      variants: [
        ModelVariant(name: 'iPhone 11',price: 15000000),
        ModelVariant(name: 'iPhone 11 Pro', price: 15000000),
        ModelVariant(name: 'iPhone 11 Pro Max', price: 15000000),
      ],
    ),
    ProductModelp(
      name: 'iPhone 12',
      variants: [
        ModelVariant(name: 'iPhone 12', price: 15000000),
        ModelVariant(name: 'iPhone 12 Pro', price: 15000000),
        ModelVariant(name: 'iPhone 12 Pro Max', price: 15000000),
      ],
    ),
  ],
);
