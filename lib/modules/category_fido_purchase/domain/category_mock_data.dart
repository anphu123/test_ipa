import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../domain/brand_model.dart';
import 'brand_mock_data.dart';

final List<CategoryModel> mockCategoryList = [
  // Nhóm: Thiết bị điện tử
  CategoryModel(
    id: 0,
    name: LocaleKeys.phone_category.trans(),
    bannerImage: Assets.images.bgCateFidoPurchase.path,
    featuredProductName: 'Xiaomi 15 Ultra',
    featuredProductImage: Assets.images.pXiaomi15.path,
    featuredProductPrice: '₫30.000.000',
    brands: [
      brandApple,
      BrandModel(name: 'Samsung', icon: Icons.android),
    ],
    popularModels: ['iPhone 15 Pro', 'Samsung Galaxy S24'],
  ),
  CategoryModel(
    id: 1,
    name: LocaleKeys.tablet_category.trans(),
    bannerImage: Assets.images.bgCateFidoPurchase.path,
    featuredProductName: 'Xiaomi 15 Ultra',
    featuredProductImage: Assets.images.pXiaomi15.path,
    featuredProductPrice: '₫28.000.000',
    brands: [
      brandApple,
      BrandModel(name: 'Samsung', icon: Icons.tablet_android),
    ],
    popularModels: ['iPad Mini 6', 'Galaxy Tab S9'],
  ),
  CategoryModel(
    id: 2,
    name: LocaleKeys.laptop_category.trans(),
    bannerImage: Assets.images.bgCateFidoPurchase.path,
    featuredProductName: 'Xiaomi 15 Ultra',
    featuredProductImage: Assets.images.pXiaomi15.path,
    featuredProductPrice: '₫65.000.000',
    brands: [
      BrandModel(name: 'Apple', icon: Icons.laptop_mac),
      BrandModel(name: 'Asus', icon: Icons.computer),
    ],
    popularModels: ['MacBook Air M2', 'Asus ZenBook'],
  ),
  CategoryModel(
    id: 3,
    name: LocaleKeys.clock.trans(),
    bannerImage: Assets.images.bgCateFidoPurchase.path,
    featuredProductName: 'Xiaomi 15 Ultra',
    featuredProductImage: Assets.images.pXiaomi15.path,
    featuredProductPrice: '₫21.000.000',
    brands: [
      BrandModel(name: 'Apple', icon: Icons.watch),
      BrandModel(name: 'Garmin', icon: Icons.timer),
    ],
    popularModels: ['Apple Watch Ultra 2', 'Garmin Venu 2'],
  ),
  CategoryModel(
    id: 4,
    name: LocaleKeys.game_machine.trans(),
    bannerImage: Assets.images.bgCateFidoPurchase.path,
    featuredProductName: 'Xiaomi 15 Ultra',
    featuredProductImage: Assets.images.pXiaomi15.path,
    featuredProductPrice: '₫9.000.000',
    brands: [
      BrandModel(name: 'Nintendo', icon: Icons.videogame_asset),
    ],
    popularModels: ['Switch OLED', 'Switch Lite'],
  ),
  CategoryModel(
    id: 5,
    name: LocaleKeys.pc.trans(),
    bannerImage: Assets.images.bgCateFidoPurchase.path,
    featuredProductName: 'Xiaomi 15 Ultra',
    featuredProductImage: Assets.images.pXiaomi15.path,
    featuredProductPrice: '₫39.000.000',
    brands: [
      BrandModel(name: 'Apple', icon: Icons.desktop_mac),
      BrandModel(name: 'Dell', icon: Icons.desktop_windows),
    ],
    popularModels: ['iMac M3', 'Dell Optiplex'],
  ),
  CategoryModel(
    id: 6,
    name: LocaleKeys.camera.trans(),
    bannerImage: Assets.images.bgCateFidoPurchase.path,
    featuredProductName: 'Xiaomi 15 Ultra',
    featuredProductImage: Assets.images.pXiaomi15.path,
    featuredProductPrice: '₫45.000.000',
    brands: [
      BrandModel(name: 'Canon', icon: Icons.camera_alt),
      BrandModel(name: 'Sony', icon: Icons.camera),
    ],
    popularModels: ['EOS R6', 'Sony Alpha A7'],
  ),
  CategoryModel(
    id: 7,
    name: LocaleKeys.flycam.trans(),
    bannerImage: Assets.images.bgCateFidoPurchase.path,
    featuredProductName: 'Xiaomi 15 Ultra',
    featuredProductImage: Assets.images.pXiaomi15.path,
    featuredProductPrice: '₫23.000.000',
    brands: [
      BrandModel(name: 'DJI', icon: Icons.airplanemode_active),
    ],
    popularModels: ['Mini 3 Pro', 'Mini 4 Pro'],
  ),

  // Nhóm: Đời sống
  CategoryModel(
    id: 8,
    name: LocaleKeys.household.trans(),
    bannerImage: Assets.images.bgCateFidoPurchase.path,
    featuredProductName: 'Xiaomi 15 Ultra',
    featuredProductImage: Assets.images.pXiaomi15.path,
    featuredProductPrice: '₫12.000.000',
    brands: [
      BrandModel(name: 'Dyson', icon: Icons.cleaning_services),
      BrandModel(name: 'Panasonic', icon: Icons.kitchen),
    ],
    popularModels: ['Dyson V12', 'Panasonic Cooker'],
  ),
  CategoryModel(
    id: 9,
    name: LocaleKeys.sport.trans(),
    bannerImage: Assets.images.bgCateFidoPurchase.path,
    featuredProductName: 'Xiaomi 15 Ultra',
    featuredProductImage: Assets.images.pXiaomi15.path,
    featuredProductPrice: '₫15.000.000',
    brands: [
      BrandModel(name: 'Kingsport', icon: Icons.directions_run),
    ],
    popularModels: ['Kingsport Treadmill K-800', 'Gym Set 3in1'],
  ),
  CategoryModel(
    id: 10,
    name: LocaleKeys.musical_instrument.trans(),
    bannerImage: Assets.images.bgCateFidoPurchase.path,
    featuredProductName: 'Xiaomi 15 Ultra',
    featuredProductImage: Assets.images.pXiaomi15.path,
    featuredProductPrice: '₫3.000.000',
    brands: [
      BrandModel(name: 'Yamaha', icon: Icons.music_note),
    ],
    popularModels: ['F310', 'Fender Strat'],
  ),
  CategoryModel(
    id: 11,
    name: LocaleKeys.pets.trans(),
    bannerImage: Assets.images.bgCateFidoPurchase.path,
    featuredProductName: 'Xiaomi 15 Ultra',
    featuredProductImage: Assets.images.pXiaomi15.path,
    featuredProductPrice: '₫850.000',
    brands: [
      BrandModel(name: 'Petzone', icon: Icons.pets),
    ],
    popularModels: ['Nhà chó mèo', 'Chuồng gỗ'],
  ),

  // Nhóm: Sản phẩm cao cấp
  CategoryModel(
    id: 12,
    name: LocaleKeys.hand_bag.trans(),
    bannerImage: Assets.images.bgCateFidoPurchase.path,
    featuredProductName: 'Xiaomi 15 Ultra',
    featuredProductImage: Assets.images.pXiaomi15.path,
    featuredProductPrice: '₫58.000.000',
    brands: [
      BrandModel(name: 'LV', icon: Icons.shopping_bag),
      BrandModel(name: 'Gucci', icon: Icons.store),
    ],
    popularModels: ['LV Neverfull', 'Gucci Dionysus'],
  ),
  CategoryModel(
    id: 13,
    name: LocaleKeys.jewelry.trans(),
    bannerImage: Assets.images.bgCateFidoPurchase.path,
    featuredProductName: 'Xiaomi 15 Ultra',
    featuredProductImage: Assets.images.pXiaomi15.path,
    featuredProductPrice: '₫42.000.000',
    brands: [
      BrandModel(name: 'Cartier', icon: Icons.favorite),
    ],
    popularModels: ['Cartier Love', 'Tiffany T'],
  ),
  CategoryModel(
    id: 14,
    name: LocaleKeys.shoes_sandals.trans(),
    bannerImage: Assets.images.bgCateFidoPurchase.path,
    featuredProductName: 'Xiaomi 15 Ultra',
    featuredProductImage: Assets.images.pXiaomi15.path,
    featuredProductPrice: '₫6.000.000',
    brands: [
      BrandModel(name: 'Nike', icon: Icons.directions_walk),
      BrandModel(name: 'Adidas', icon: Icons.sports_baseball),
    ],
    popularModels: ['Jordan 1', 'Adidas Ultraboost'],
  ),
  CategoryModel(
    id: 15,
    name: LocaleKeys.clock.trans(),
    bannerImage: Assets.images.bgCateFidoPurchase.path,
    featuredProductName: 'Xiaomi 15 Ultra',
    featuredProductImage: Assets.images.pXiaomi15.path,
    featuredProductPrice: '₫250.000.000',
    brands: [
      BrandModel(name: 'Rolex', icon: Icons.watch),
    ],
    popularModels: ['Submariner', 'Omega Seamaster'],
  ),
];
