// mock_categories_full_multilang.dart
import '../../../../core/assets/assets.gen.dart';
import 'category_model.dart';

/// Helper tạo map đa ngôn ngữ nhanh
Map<String, String> ml(String vi, String en, String zh) => {
  'vi': vi,
  'en': en,
  'zh': zh,
};

final List<CategoryModel> mockCategories = [
  // =========================
  // 1) 2Hand
  // =========================
  CategoryModel(
    id: 1,
    name: ml('2Hand', '2Hand', '2Hand'),
    imgUrlA: 'https://example.com/fido_box_image.jpg',
    subCategories: [
      SubCategoryModel(
        id: 10100,
        name: ml('2Hand Nhỏ', 'Small 2Hand', '小号2Hand'),
        imgUrl: Assets.images.icGucci.path,
        products: [
          ProductModel(
            id: 1001,
            name: ml('2Hand Nhỏ - Màu Xanh', 'Small 2Hand - Blue', '小号2Hand - 蓝色'),
            imgUrlp: 'https://images.seeklogo.com/logo-png/61/1/ken-garff-automotive-logo-png_seeklogo-615691.png?v=1961559924317661416',
            price: 499000,
          ),
          ProductModel(
            id: 1002,
            name: ml('2Hand Nhỏ - Màu Đỏ', 'Small 2Hand - Red', '小号2Hand - 红色'),
            imgUrlp: 'https://bizweb.dktcdn.net/thumb/medium/100/329/122/products/chuot-gaming-razer-basilisk-v3-x-hyperspeed-rz01-04870100-r3m1-5.jpg?v=1749435107157',
            price: 499000,
          ),
        ],
      ),
      SubCategoryModel(
        id: 10200,
        name: ml('2Hand Lớn', 'Large 2Hand', '大号2Hand'),
        imgUrl: Assets.images.icLv.path,
        products: [
          ProductModel(
            id: 1003,
            name: ml('2Hand Lớn - Màu Đen', 'Large 2Hand - Black', '大号2Hand - 黑色'),
            imgUrlp: 'https://bizweb.dktcdn.net/thumb/grande/100/329/122/products/man-hinh-msi-pro-mp251-e2-24-5-inch-ips-fhd-120hz-pro-mp251-e2-02.jpg?v=1722498209450',
            price: 799000,
          ),
          ProductModel(
            id: 1004,
            name: ml('2Hand Lớn - Màu Trắng', 'Large 2Hand - White', '大号2Hand - 白色'),
            imgUrlp: 'https://bizweb.dktcdn.net/thumb/grande/100/329/122/products/aeimageframe-31662255.png?v=1749435112483',
            price: 799000,
          ),
        ],
      ),
      SubCategoryModel(
        id: 10300,
        name: ml('2Hand Lớn', 'Large 2Hand', '大号2Hand'),
        imgUrl: Assets.images.icPuma.path,
        products: [
          ProductModel(
            id: 1005,
            name: ml('2Hand Lớn - Màu Đen', 'Large 2Hand - Black', '大号2Hand - 黑色'),
            imgUrlp: 'https://bizweb.dktcdn.net/thumb/medium/100/329/122/products/o-cung-di-dong-ssd-128gb-transcend-esd310-1050mb-s-ts128gesd310c-01.jpg?v=1746496922800',
            price: 799000,
          ),
          ProductModel(
            id: 1006,
            name: ml('2Hand Lớn - Màu Trắng', 'Large 2Hand - White', '大号2Hand - 白色'),
            imgUrlp: 'https://bizweb.dktcdn.net/thumb/medium/100/329/122/products/external-ssd-transcend-esd310-01-fef0a78e-1407-4c06-9bbd-fc108f3783f6.jpg?v=1746496847140',
            price: 799000,
          ),
        ],
      ),
      SubCategoryModel(
        id: 10400,
        name: ml('2Hand Lớn', 'Large 2Hand', '大号2Hand'),
        imgUrl: Assets.images.icAddidas.path,
        products: [
          ProductModel(
            id: 1007,
            name: ml('2Hand Lớn - Màu Đen', 'Large 2Hand - Black', '大号2Hand - 黑色'),
            imgUrlp: 'https://bizweb.dktcdn.net/thumb/large/100/329/122/products/ban-phim-co-khong-day-keychron-k8-max-rgb-keychron-sw-02.jpg?v=1742490116147',
            price: 799000,
          ),
          ProductModel(
            id: 1008,
            name: ml('2Hand Lớn - Màu Trắng', 'Large 2Hand - White', '大号2Hand - 白色'),
            imgUrlp: 'https://bizweb.dktcdn.net/thumb/large/100/329/122/products/ban-phim-co-khong-day-lemokey-p1-pro-space-silver-rgb-hotswap-cnc-aluminum-keychron-sw-08.jpg?v=1746205242853',
            price: 799000,
          ),
        ],
      ),
      SubCategoryModel(
        id: 10500,
        name: ml('2Hand Lớn', 'Large 2Hand', '大号2Hand'),
        imgUrl: Assets.images.icNintendo.path,
        products: [
          ProductModel(
            id: 1009,
            name: ml('2Hand Lớn - Màu Đen', 'Large 2Hand - Black', '大号2Hand - 黑色'),
            imgUrlp: 'https://bizweb.dktcdn.net/thumb/medium/100/329/122/products/ram-laptop-lexar-ddr4-32gb-bus-3200-sodimm-cl22-ld4as032g-b3200gsst-a9f5c4c2-077d-4aa5-8e51-59f9fd1a1d0e.png?v=1683475281143',
            price: 799000,
          ),
          ProductModel(
            id: 1010,
            name: ml('2Hand Lớn - Màu Trắng', 'Large 2Hand - White', '大号2Hand - 白色'),
            imgUrlp: 'https://bizweb.dktcdn.net/thumb/medium/100/329/122/products/ram-laptop-lexar-ddr4-32gb-bus-3200-sodimm-cl22-ld4as032g-b3200gsst-a9f5c4c2-077d-4aa5-8e51-59f9fd1a1d0e.png?v=1683475281143',
            price: 799000,
          ),
        ],
      ),
      SubCategoryModel(
        id: 10600,
        name: ml('2Hand Lớn', 'Large 2Hand', '大号2Hand'),
        imgUrl: Assets.images.icSamsung.path,
        products: [
          ProductModel(
            id: 1011,
            name: ml('2Hand Lớn - Màu Đen', 'Large 2Hand - Black', '大号2Hand - 黑色'),
            imgUrlp: 'https://bizweb.dktcdn.net/thumb/grande/100/329/122/products/laptop-asus-expertbook-p1-p1403cva-i308256-50w-01.jpg?v=1749402310283',
            price: 799000,
          ),
          ProductModel(
            id: 1012,
            name: ml('2Hand Lớn - Màu Trắng', 'Large 2Hand - White', '大号2Hand - 白色'),
            imgUrlp: 'https://bizweb.dktcdn.net/thumb/medium/100/329/122/products/vivobook-go-14-e1404f-e1404g-product-photo-1s-cool-silver-06-webcam-off.jpg?v=1735232423487',
            price: 799000,
          ),
        ],
      ),
      SubCategoryModel(
        id: 10700,
        name: ml('2Hand Lớn', 'Large 2Hand', '大号2Hand'),
        imgUrl: Assets.images.icSony.path,
        products: [
          ProductModel(
            id: 1013,
            name: ml('2Hand Lớn - Màu Đen', 'Large 2Hand - Black', '大号2Hand - 黑色'),
            imgUrlp: 'https://bizweb.dktcdn.net/thumb/grande/100/329/122/products/ssd-hp-s650-2-5-inch-sata-iii-120gb-345m7aa-e3689149-6444-4a80-9d1f-f6da3864e6a0.jpg?v=1724295521477',
            price: 799000,
          ),
          ProductModel(
            id: 1014,
            name: ml('2Hand Lớn - Màu Trắng', 'Large 2Hand - White', '大号2Hand - 白色'),
            imgUrlp: 'https://bizweb.dktcdn.net/thumb/grande/100/329/122/products/pc-msi-i5-3060r.jpg?v=1749402628190',
            price: 799000,
          ),
        ],
      ),
      SubCategoryModel(
        id: 10800,
        name: ml('2Hand Lớn', 'Large 2Hand', '大号2Hand'),
        imgUrl: Assets.images.icCanon.path,
        products: [
          ProductModel(
            id: 1015,
            name: ml('2Hand Lớn - Màu Đen', 'Large 2Hand - Black', '大号2Hand - 黑色'),
            imgUrlp: 'https://bizweb.dktcdn.net/thumb/grande/100/329/122/products/u7-5070.jpg?v=1744175796533',
            price: 799000,
          ),
          ProductModel(
            id: 1016,
            name: ml('2Hand Lớn - Màu Trắng', 'Large 2Hand - White', '大号2Hand - 白色'),
            imgUrlp: 'https://bizweb.dktcdn.net/thumb/grande/100/329/122/products/laptop-gaming-asus-tuf-gaming-fa507-fa507nvr-lp091w-08.jpg?v=1749402197827',
            price: 799000,
          ),
        ],
      ),
    ],
  ),

  // =========================
  // 2) Điện thoại
  // =========================
  CategoryModel(
    id: 2,
    name: ml('Điện thoại', 'Mobile phones', '手机'),
    imgUrlA: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
    subCategories: [
      SubCategoryModel(
        id: 101,
        name: ml('Xiaomi', 'Xiaomi', 'Xiaomi'),
        imgUrl: Assets.images.icGucci.path,
        products: [
          ProductModel(
            id: 1,
            name: ml('Xiaomi 14T Pro 12GB 512GB',
                'Xiaomi 14T Pro 12GB 512GB',
                'Xiaomi 14T Pro 12GB 512GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi_14t_pro_1_.png',
            price: 14870000,
          ),
          ProductModel(
            id: 2,
            name: ml('Xiaomi Redmi Note 14 6GB 128GB',
                'Xiaomi Redmi Note 14 6GB 128GB',
                'Xiaomi Redmi Note 14 6GB 128GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/d/i/dien-thoai-xiaomi-redmi-note-14.png',
            price: 4450000,
          ),
          ProductModel(
            id: 3,
            name: ml('Xiaomi Redmi Note 14 5G 8GB 256GB',
                'Xiaomi Redmi Note 14 5G 8GB 256GB',
                'Xiaomi Redmi Note 14 5G 8GB 256GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/d/i/dien-thoai-xiaomi-redmi-note-14-5g.1.png',
            price: 7090000,
          ),
          ProductModel(
            id: 4,
            name: ml('Xiaomi POCO X7 Pro 5G 12GB 256GB',
                'Xiaomi POCO X7 Pro 5G 12GB 256GB',
                'Xiaomi POCO X7 Pro 5G 12GB 256GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/d/i/dien-thoai-poco-x7-pro-5g_2_.png',
            price: 9390000,
          ),
          ProductModel(
            id: 5,
            name: ml('Xiaomi POCO C71 4GB 128GB',
                'Xiaomi POCO C71 4GB 128GB',
                'Xiaomi POCO C71 4GB 128GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/d/i/dien-thoai-xiaomi-poco-c71_9_.png',
            price: 2850000,
          ),
          ProductModel(
            id: 6,
            name: ml('Xiaomi Redmi Note 13 Pro 5G 8GB 256GB',
                'Xiaomi Redmi Note 13 Pro 5G 8GB 256GB',
                'Xiaomi Redmi Note 13 Pro 5G 8GB 256GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/p/h/photo_2024-12-20_17-05-54_1.jpg',
            price: 7090000,
          ),
          ProductModel(
            id: 7,
            name: ml('Xiaomi 14T 12GB 512GB',
                'Xiaomi 14T 12GB 512GB',
                'Xiaomi 14T 12GB 512GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi_14t_2_.png',
            price: 13240000,
          ),
          ProductModel(
            id: 8,
            name: ml('Xiaomi 15 5G 12GB 256GB',
                'Xiaomi 15 5G 12GB 256GB',
                'Xiaomi 15 5G 12GB 256GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/d/i/dien-thoai-xiaomi-15_11_.png',
            price: 21340000,
          ),
          ProductModel(
            id: 9,
            name: ml('Xiaomi 14 Ultra 5G 16GB 512GB',
                'Xiaomi 14 Ultra 5G 16GB 512GB',
                'Xiaomi 14 Ultra 5G 16GB 512GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-14-ultra.jpg',
            price: 24090000,
          ),
          ProductModel(
            id: 10,
            name: ml('Xiaomi Redmi Note 12 4GB 128GB',
                'Xiaomi Redmi Note 12 4GB 128GB',
                'Xiaomi Redmi Note 12 4GB 128GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-redmi-note-12_1.png',
            price: 3790000,
          ),
          ProductModel(
            id: 11,
            name: ml('Đồng hồ thông minh Xiaomi Redmi Watch 4',
                'Đồng hồ thông minh Xiaomi Redmi Watch 4',
                'Đồng hồ thông minh Xiaomi Redmi Watch 4'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_25__1_9.png',
            price: 1640000,
          ),
        ],
      ),
      SubCategoryModel(
        id: 102,
        name: ml('Iphone', 'Iphone', 'Iphone'),
        imgUrl: Assets.images.icAddidas.path,
        products: [
          ProductModel(
            id: 12,
            name: ml('iPhone 16 Pro Max 256GB | Chính hãng VN/A',
                'iPhone 16 Pro Max 256GB | VN/A',
                'iPhone 16 Pro Max 256GB | 越南行货'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-16-pro-max.png',
            price: 29990000,
          ),
          ProductModel(
            id: 13,
            name: ml('iPhone 16',
                'iPhone 16',
                'iPhone 16'),
            imgUrlp: 'https://store.storeimages.cdn-apple.com/1/as-images.apple.com/is/iphone16-digitalmat-gallery-3-202409?wid=728&hei=666&fmt=p-jpg&qlt=95&.v=Y2tBd1RqSzMrd3hScm1lN290ZENDQnlVUVRHTkd5alQ5aFd0OWdSZUk0SXlLZ0xXbFByV2Vvak9rWndaamlPU3cvMldkdDlIc0lud2tjcDJ3djFCUkV2dGpWUjV5VzZtaGp2QjBiUXR3RUFJWFM4ekI5ZC9uRFBQN3lzOXp4dnA',
            price: 22580000,
          ),
          ProductModel(
            id: 14,
            name: ml('iPhone 15',
                'iPhone 15',
                'iPhone 15'),
            imgUrlp: 'https://store.storeimages.cdn-apple.com/1/as-images.apple.com/is/iphone15-digitalmat-gallery-4-202309?wid=728&hei=666&fmt=png-alpha&.v=NkhGM3Yvbkc1OWtnb1BCdWdROVRSK21WVFhyY3phSHE0c0dmYXl5WVVReHUrR0lqbjI0aE84b21HR0crWjlkeTJSWWg0TDRLSXM4czBZQjZvUHdsVExoZnZwNkp3Tk1LK3ExM0JYS1BwVVlzQ0pUbWFCbmdEa2UrQXJObzNKK3k',
            price: 19635000,
          ),
          ProductModel(
            id: 15,
            name: ml('iPhone 14 Pro Max 128GB | Chính hãng VN/A',
                'iPhone 14 Pro Max 128GB | Chính hãng VN/A',
                'iPhone 14 Pro Max 128GB | Chính hãng VN/A'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/_/x_m_24.png',
            price: 25590000,
          ),
          ProductModel(
            id: 16,
            name: ml('iPhone 12 Pro Max 128GB I Chính hãng VN/A',
                'iPhone 12 Pro Max 128GB I Chính hãng VN/A',
                'iPhone 12 Pro Max 128GB I Chính hãng VN/A'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/_/1_251_1.jpg',
            price: 23490000,
          ),
        ],
      ),
      SubCategoryModel(
        id: 103,
        name: ml('Huawei', 'Huawei', 'Huawei'),
        imgUrl: Assets.images.icPuma.path,
        products: [
          ProductModel(
            id: 17,
            name: ml('iPhone 14 Pro Max 128GB | Chính hãng VN/A',
                'iPhone 14 Pro Max 128GB | Chính hãng VN/A',
                'iPhone 14 Pro Max 128GB | Chính hãng VN/A'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/_/x_m_24.png',
            price: 25590000,
          ),
          ProductModel(
            id: 18,
            name: ml('Xiaomi Redmi 13C 6GB 128GB',
                'Xiaomi Redmi 13C 6GB 128GB',
                'Xiaomi Redmi 13C 6GB 128GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-redmi-13c_21__1.png',
            price: 2990000,
          ),
          ProductModel(
            id: 19,
            name: ml('Xiaomi 13T 12GB 256GB',
                'Xiaomi 13T 12GB 256GB',
                'Xiaomi 13T 12GB 256GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-13t_1__1_2.png',
            price: 10590000,
          ),
          ProductModel(
            id: 20,
            name: ml('Xiaomi Redmi Note 12 4GB 128GB',
                'Xiaomi Redmi Note 12 4GB 128GB',
                'Xiaomi Redmi Note 12 4GB 128GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-redmi-note-12_1.png',
            price: 3790000,
          ),
          ProductModel(
            id: 21,
            name: ml('Xiaomi POCO X6 Pro 5G 8GB 256GB ',
                'Xiaomi POCO X6 Pro 5G 8GB 256GB ',
                'Xiaomi POCO X6 Pro 5G 8GB 256GB '),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/_/t_i_xu_ng_22__6.png',
            price: 7540000,
          ),
        ],
      ),
      SubCategoryModel(
        id: 104,
        name: ml('Thương hiệu khác', 'Other Brands', '其他品牌'),
        imgUrl: Assets.images.icNintendo.path,
        products: [
          ProductModel(
            id: 22,
            name: ml('Xiaomi 13T 12GB 256GB',
                'Xiaomi 13T 12GB 256GB',
                'Xiaomi 13T 12GB 256GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-13t_1__1_2.png',
            price: 10590000,
          ),
          ProductModel(
            id: 23,
            name: ml('iPhone 12 Pro Max 128GB I Chính hãng VN/A',
                'iPhone 12 Pro Max 128GB I Chính hãng VN/AN',
                'iPhone 12 Pro Max 128GB I Chính hãng VN/A'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/_/1_251_1.jpg',
            price: 23490000,
          ),
          ProductModel(
            id: 24,
            name: ml('Samsung Galaxy S24 FE 5G 8GB 128GB',
                'Samsung Galaxy S24 FE 5G 8GB 128GB',
                'Samsung Galaxy S24 FE 5G 8GB 128GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/d/i/dien-thoai-samsung-galaxy-s24-fe_3__4.png',
            price: 11990000,
          ),
          ProductModel(
            id: 25,
            name: ml('Samsung Galaxy Z Flip7 12GB 256GB',
                'Samsung Galaxy Z Flip7 12GB 256GB',
                'Samsung Galaxy Z Flip7 12GB 256GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/a/samsung-galaxy-z-flip-7-xanh.jpg',
            price: 26990000,
          ),
          ProductModel(
            id: 26,
            name: ml('Samsung Galaxy S24 Plus 12GB 256GB',
                'Samsung Galaxy S24 Plus 12GB 256GB',
                'Samsung Galaxy S24 Plus 12GB 256GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/a/samsung-galaxy-s24-plus.png',
            price: 16490000,
          ),
        ],
      ),
    ],
  ),

  // =========================
  // 3) Máy tính
  // =========================
  CategoryModel(
    id: 3,
    name: ml('Máy tính', 'Computers', '电脑'),
    imgUrlA: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/l/a/laptop-gaming-acer-nitro-v-anv15-51-72vs_4_.jpg',
    subCategories: [
      SubCategoryModel(
        id: 201,
        name: ml('Laptop', 'Laptops', '笔记本电脑'),
        imgUrl: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/e/text_ng_n_15__7_118.png',
        products: [
          ProductModel(
            id: 23,
            name: ml('Xiaomi 14T Pro 12GB 512GB',
                'Xiaomi 14T Pro 12GB 512GB',
                'Xiaomi 14T Pro 12GB 512GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi_14t_pro_1_.png',
            price: 14870000,
          ),
          ProductModel(
            id: 24,
            name: ml('Xiaomi Redmi Note 14 6GB 128GB',
                'Xiaomi Redmi Note 14 6GB 128GB',
                'Xiaomi Redmi Note 14 6GB 128GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/d/i/dien-thoai-xiaomi-redmi-note-14.png',
            price: 4450000,
          ),
          ProductModel(
            id: 25,
            name: ml('Xiaomi POCO X7 Pro 5G 12GB 256GB',
                'Xiaomi POCO X7 Pro 5G 12GB 256GB',
                'Xiaomi POCO X7 Pro 5G 12GB 256GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/d/i/dien-thoai-poco-x7-pro-5g_2_.png',
            price: 9390000,
          ),
          ProductModel(
            id: 26,
            name: ml('Xiaomi POCO C71 4GB 128GB',
                'Xiaomi POCO C71 4GB 128GB',
                'Xiaomi POCO C71 4GB 128GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/d/i/dien-thoai-xiaomi-poco-c71_9_.png',
            price: 2850000,
          ),
          ProductModel(
            id: 27,
            name: ml('iPhone 16 Pro Max 256GB | Chính hãng VN/A',
                'iPhone 16 Pro Max 256GB | Chính hãng VN/A',
                'iPhone 16 Pro Max 256GB | Chính hãng VN/A'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-16-pro-max.png',
            price: 29990000,
          ),
        ],
      ),
      SubCategoryModel(
        id: 202,
        name: ml('Máy tính để bàn', 'Desktops', '台式机'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [
          ProductModel(
            id: 28,
            name: ml('Samsung Galaxy S24 FE 5G 8GB 128GB',
                'Samsung Galaxy S24 FE 5G 8GB 128GB',
                'Samsung Galaxy S24 FE 5G 8GB 128GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/d/i/dien-thoai-samsung-galaxy-s24-fe_3__4.png',
            price: 11990000,
          ),
          ProductModel(
            id: 29,
            name: ml('Samsung Galaxy S24 Plus 12GB 256GB',
                'Samsung Galaxy S24 Plus 12GB 256GB',
                'Samsung Galaxy S24 Plus 12GB 256GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/a/samsung-galaxy-s24-plus.png',
            price: 16490000,
          ),
          ProductModel(
            id: 30,
            name: ml('Xiaomi 13T 12GB 256GB',
                'Xiaomi 13T 12GB 256GB',
                'Xiaomi 13T 12GB 256GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-13t_1__1_2.png',
            price: 10590000,
          ),
          ProductModel(
            id: 31,
            name: ml('Xiaomi Redmi Note 12 Pro 5G',
                'Xiaomi Redmi Note 12 Pro 5G',
                'Xiaomi Redmi Note 12 Pro 5G'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-redmi-note-12-pro-5g.png',
            price: 6590000,
          ),
          ProductModel(
            id: 32,
            name: ml('Xiaomi Redmi 14C 4GB 128GB',
                'Xiaomi Redmi 14C 4GB 128GB',
                'Xiaomi Redmi 14C 4GB 128GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi_redmi_14c_5_.png',
            price: 2930000,
          ),
        ],
      ),
      SubCategoryModel(
        id: 203,
        name: ml('Màn hình', 'Monitors', '显示器'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [
          ProductModel(
            id: 33,
            name: ml('Xiaomi Redmi Note 13 Pro 4G 8GB 128GB',
                'Xiaomi Redmi Note 13 Pro 4G 8GB 128GB',
                'Xiaomi Redmi Note 13 Pro 4G 8GB 128GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-redmi-note-13-pro-4g_13__1.png',
            price: 5790000,
          ),
          ProductModel(
            id: 34,
            name: ml('Xiaomi POCO X6 Pro 5G 8GB 256GB ',
                'Xiaomi POCO X6 Pro 5G 8GB 256GB ',
                'Xiaomi POCO X6 Pro 5G 8GB 256GB '),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/t/_/t_i_xu_ng_22__6.png',
            price: 7540000,
          ),
          ProductModel(
            id: 35,
            name: ml('iPhone 14 Pro Max 128GB | Chính hãng VN/Ah',
                'iPhone 14 Pro Max 128GB | Chính hãng VN/A',
                'iPhone 14 Pro Max 128GB | Chính hãng VN/A'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/_/x_m_24.png',
            price: 25590000,
          ),
          ProductModel(
            id: 36,
            name: ml('iPhone 12 Pro Max 128GB I Chính hãng VN/A',
                'iPhone 12 Pro Max 128GB I Chính hãng VN/A',
                'iPhone 12 Pro Max 128GB I Chính hãng VN/A'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/_/1_251_1.jpg',
            price: 23490000,
          ),
          ProductModel(
            id: 37,
            name: ml('Xiaomi Redmi Note 12 4GB 128GB',
                'Xiaomi Redmi Note 12 4GB 128GB',
                'Xiaomi Redmi Note 12 4GB 128GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-redmi-note-12_1.png',
            price: 3790000,
          ),
        ],
      ),
      SubCategoryModel(
        id: 204,
        name: ml('Phụ kiện', 'Accessories', '配件'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [
          ProductModel(
            id: 38,
            name: ml('Xiaomi Redmi Note 12 4GB 128GB',
                'Xiaomi Redmi Note 12 4GB 128GB',
                'Xiaomi Redmi Note 12 4GB 128GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-redmi-note-12_1.png',
            price: 3790000,
          ),
          ProductModel(
            id: 39,
            name: ml('Xiaomi Redmi Note 12 Pro 5G',
                'Xiaomi Redmi Note 12 Pro 5G',
                'Xiaomi Redmi Note 12 Pro 5G'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-redmi-note-12-pro-5g.png',
            price: 6590000,
          ),
          ProductModel(
            id: 40,
            name: ml('Xiaomi Redmi Note 13 Pro 4G 8GB 128GB',
                'Xiaomi Redmi Note 13 Pro 4G 8GB 128GB',
                'Xiaomi Redmi Note 13 Pro 4G 8GB 128GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-redmi-note-13-pro-4g_13__1.png',
            price: 5790000,
          ),
          ProductModel(
            id: 41,
            name: ml('Xiaomi 15 Ultra 5G 16GB 512GB',
                'Xiaomi 15 Ultra 5G 16GB 512GB',
                'Xiaomi 15 Ultra 5G 16GB 512GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/d/i/dien-thoai-xiaomi-15-ultra.png',
            price: 32360000,
          ),
          ProductModel(
            id: 42,
            name: ml('Xiaomi Redmi Note 13 Pro Plus 5G 8GB 256GB',
                'Xiaomi Redmi Note 13 Pro Plus 5G 8GB 256GB',
                'Xiaomi Redmi Note 13 Pro Plus 5G 8GB 256GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-redmi-note-13-pro-plus_9_.png',
            price: 7890000,
          ),
        ],
      ),
    ],
  ),

  // =========================
  // 4) Thiết bị điện tử
  // =========================
  CategoryModel(
    id: 4,
    name: ml('Thiết bị điện tử', 'Digital Products', '数码产品'),
    imgUrlA: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/m/smart_band_1__1.png',
    subCategories: [
      SubCategoryModel(
        id: 301,
        name: ml('Đồng hồ thông minh', 'Smart Watches', '智能手表'),
        imgUrl: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/f/r/frame_1_2__4_3.png',
        products: [
          ProductModel(
            id: 43,
            name: ml('Xiaomi Redmi Note 12 4GB 128GB',
                'Xiaomi Redmi Note 12 4GB 128GB',
                'Xiaomi Redmi Note 12 4GB 128GB'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-redmi-note-12_1.png',
            price: 3790000,
          ),
          ProductModel(
            id: 44,
            name: ml('iPhone 14 Pro 128GB | Chính hãng VN/A',
                'iPhone 14 Pro 128GB | VN/A',
                'iPhone 14 Pro 128GB | 越南行货'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/v/_/v_ng_12.png',
            price: 24990000,
          ),
          ProductModel(
            id: 45,
            name: ml('iPhone 13 128GB | Chính hãng VN/A',
                'iPhone 13 128GB | VN/A',
                'iPhone 13 128GB | 越南行货'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/3/13_4_7_2_7.jpg',
            price: 17990000,
          ),
          ProductModel(
            id: 46,
            name: ml('iPhone 12 mini 256GB | Chính hãng VN/A',
                'iPhone 12 mini 256GB | VN/A',
                'iPhone 12 mini 256GB | 越南行货'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-12_3__5.jpg',
            price: 13990000,
          ),
          ProductModel(
            id: 47,
            name: ml('iPhone SE 2022 128GB | Chính hãng VN/A',
                'iPhone SE 2022 128GB | VN/A',
                'iPhone SE 2022 128GB | 越南行货'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/3/_/3_306_2.png',
            price: 9990000,
          ),
        ],
      ),
      SubCategoryModel(
        id: 302,
        name: ml('Máy tính bảng', 'Tablets', '平板电脑'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [],
      ),
      SubCategoryModel(
        id: 303,
        name: ml('Tai nghe', 'Headphones', '耳机'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [],
      ),
      SubCategoryModel(
        id: 304,
        name: ml('Loa', 'Speakers', '扬声器'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [],
      ),
    ],
  ),

  // =========================
  // 5) Túi xách (Luxury Bags)
  // =========================
  CategoryModel(
    id: 5,
    name: ml('Túi xách', 'Luxury Bags', '奢侈包袋'),
    imgUrlA: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/m/smart_band_1__1.png',
    subCategories: [
      SubCategoryModel(
        id: 401,
        name: ml('Túi xách', 'Handbags', '手提包'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [
          ProductModel(
            id: 48,
            name: ml('iPhone 15 Pro Max 256GB | Chính hãng VN/A','iPhone 15 Pro Max 256GB | VN/A','iPhone 15 Pro Max 256GB | 越南行货'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_3.png',
            price: 29990000,
          ),
          ProductModel(
            id: 49,
            name: ml('iPhone 14 Pro 128GB | Chính hãng VN/A','iPhone 14 Pro 128GB | VN/A','iPhone 14 Pro 128GB | 越南行货'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/v/_/v_ng_12.png',
            price: 24990000,
          ),
          ProductModel(
            id: 50,
            name: ml('iPhone 13 128GB | Chính hãng VN/A','iPhone 13 128GB | VN/A','iPhone 13 128GB | 越南行货'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/3/13_4_7_2_7.jpg',
            price: 17990000,
          ),
          ProductModel(
            id: 51,
            name: ml('iPhone 12 mini 128GB | Chính hãng VN/A','iPhone 12 mini 128GB | VN/A','iPhone 12 mini 128GB | 越南行货'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-12_1__4.jpg',
            price: 13990000,
          ),
          ProductModel(
            id: 52,
            name: ml('iPhone SE 2022 256GB | Chính hãng VN/A','iPhone SE 2022 256GB | VN/A','iPhone SE 2022 256GB | 越南行货'),
            imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/2/_/2_337.png',
            price: 9990000,
          ),
        ],
      ),
      SubCategoryModel(
        id: 402,
        name: ml('Túi đeo vai', 'Shoulder Bags', '单肩包'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [
          ProductModel(id: 53, name: ml('iPhone 15 Pro Max 256GB | Chính hãng VN/A','iPhone 15 Pro Max 256GB | VN/A','iPhone 15 Pro Max 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_3.png', price: 29990000),
          ProductModel(id: 54, name: ml('iPhone 14 Pro 128GB | Chính hãng VN/A','iPhone 14 Pro 128GB | VN/A','iPhone 14 Pro 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/_/x_m_16.png', price: 24990000),
          ProductModel(id: 55, name: ml('iPhone 13 128GB | Chính hãng VN/A','iPhone 13 128GB | VN/A','iPhone 13 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/6/_/6_129_1.jpg', price: 17990000),
          ProductModel(id: 56, name: ml('iPhone 12 mini 64GB | Chính hãng VN/A','iPhone 12 mini 64GB | VN/A','iPhone 12 mini 64GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/6/_/6_129_1.jpg', price: 13990000),
          ProductModel(id: 57, name: ml('iPhone SE 2022 256GB | Chính hãng VN/A','iPhone SE 2022 256GB | VN/A','iPhone SE 2022 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/2/_/2_337.png', price: 9990000),
        ],
      ),
      SubCategoryModel(
        id: 403,
        name: ml('Ba lô', 'Backpacks', '背包'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [
          ProductModel(id: 58, name: ml('iPhone 15 Pro Max 256GB | Chính hãng VN/A','iPhone 15 Pro Max 256GB | VN/A','iPhone 15 Pro Max 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_3.png', price: 29990000),
          ProductModel(id: 59, name: ml('iPhone 14 Pro 128GB | Chính hãng VN/A','iPhone 14 Pro 128GB | VN/A','iPhone 14 Pro 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/v/_/v_ng_12.png', price: 24990000),
          ProductModel(id: 60, name: ml('iPhone 13 128GB | Chính hãng VN/A','iPhone 13 128GB | VN/A','iPhone 13 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/3/13_4_7_2_7.jpg', price: 17990000),
          ProductModel(id: 61, name: ml('iPhone 12 mini 64GB | Chính hãng VN/A','iPhone 12 mini 64GB | VN/A','iPhone 12 mini 64GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/_/1_252_1.jpg', price: 13990000),
          ProductModel(id: 62, name: ml('iPhone SE 2022 256GB | Chính hãng VN/A','iPhone SE 2022 256GB | VN/A','iPhone SE 2022 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/2/_/2_337.png', price: 9990000),
        ],
      ),
      SubCategoryModel(
        id: 404,
        name: ml('Ví', 'Wallets', '钱包'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [
          ProductModel(id: 63, name: ml('iPhone 15 Pro Max 256GB | Chính hãng VN/A','iPhone 15 Pro Max 256GB | VN/A','iPhone 15 Pro Max 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_3.png', price: 29990000),
          ProductModel(id: 64, name: ml('iPhone 14 Pro 128GB | Chính hãng VN/A','iPhone 14 Pro 128GB | VN/A','iPhone 14 Pro 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/_/x_m_16.png', price: 24990000),
          ProductModel(id: 65, name: ml('iPhone 13 128GB | Chính hãng VN/A','iPhone 13 128GB | VN/A','iPhone 13 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/2/12_3_8_2_8.jpg', price: 17990000),
          ProductModel(id: 66, name: ml('iPhone 12 mini 256GB | Chính hãng VN/A','iPhone 12 mini 256GB | VN/A','iPhone 12 mini 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-12_1__5.jpg', price: 13990000),
          ProductModel(id: 67, name: ml('iPhone SE 2022 128GB | Chính hãng VN/A','iPhone SE 2022 128GB | VN/A','iPhone SE 2022 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/_/1_359_2.png', price: 9990000),
        ],
      ),
    ],
  ),

  // =========================
  // 6) Quần áo (Clothing)
  // =========================
  CategoryModel(
    id: 6,
    name: ml('Quần áo', 'Clothing', '衣服'),
    imgUrlA: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/m/smart_band_1__1.png',
    subCategories: [
      SubCategoryModel(
        id: 501,
        name: ml('Nam', 'Men', '男士'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [
          ProductModel(id: 68, name: ml('iPhone 15 Pro Max 256GB | Chính hãng VN/A','iPhone 15 Pro Max 256GB | VN/A','iPhone 15 Pro Max 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_3.png', price: 29990000),
          ProductModel(id: 69, name: ml('iPhone 14 Pro 128GB | Chính hãng VN/A','iPhone 14 Pro 128GB | VN/A','iPhone 14 Pro 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/b/_/b_c_1_1.png', price: 24990000),
          ProductModel(id: 70, name: ml('iPhone 13 128GB | Chính hãng VN/A','iPhone 13 128GB | VN/A','iPhone 13 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/1/11_3_12_2_1_5.jpg', price: 17990000),
          ProductModel(id: 71, name: ml('iPhone 12 mini 64GB | Chính hãng VN/A','iPhone 12 mini 64GB | VN/A','iPhone 12 mini 64GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/5/_/5_157_1.jpg', price: 13990000),
          ProductModel(id: 72, name: ml('iPhone SE 2022 256GB | Chính hãng VN/A','iPhone SE 2022 256GB | VN/A','iPhone SE 2022 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/2/_/2_337.png', price: 9990000),
        ],
      ),
      SubCategoryModel(
        id: 502,
        name: ml('Nữ', 'Women', '女士'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [
          ProductModel(id: 73, name: ml('iPhone 15 Pro Max 256GB | Chính hãng VN/A','iPhone 15 Pro Max 256GB | VN/A','iPhone 15 Pro Max 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_3.png', price: 29990000),
          ProductModel(id: 74, name: ml('iPhone 14 Pro 128GB | Chính hãng VN/A','iPhone 14 Pro 128GB | VN/A','iPhone 14 Pro 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/v/_/v_ng_12.png', price: 24990000),
          ProductModel(id: 75, name: ml('iPhone 13 128GB | Chính hãng VN/A','iPhone 13 128GB | VN/A','iPhone 13 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/1/11_3_12_2_1_5.jpg', price: 17990000),
          ProductModel(id: 76, name: ml('iPhone 12 mini 128GB | Chính hãng VN/A','iPhone 12 mini 128GB | VN/A','iPhone 12 mini 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone_12_mini_purple.png', price: 13990000),
          ProductModel(id: 77, name: ml('iPhone SE 2022 | Chính hãng VN/A','iPhone SE 2022 | VN/A','iPhone SE 2022 | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/2/_/2_337_1.png', price: 9990000),
        ],
      ),
      SubCategoryModel(
        id: 503,
        name: ml('Trẻ em', 'Kids', '儿童'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [
          ProductModel(id: 78, name: ml('iPhone 15 Pro Max 256GB | Chính hãng VN/A','iPhone 15 Pro Max 256GB | VN/A','iPhone 15 Pro Max 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_3.png', price: 29990000),
          ProductModel(id: 79, name: ml('iPhone 14 Pro 128GB | Chính hãng VN/A','iPhone 14 Pro 128GB | VN/A','iPhone 14 Pro 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/v/_/v_ng_12.png', price: 24990000),
          ProductModel(id: 80, name: ml('iPhone 13 128GB | Chính hãng VN/A','iPhone 13 128GB | VN/A','iPhone 13 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/1/11_3_12_2_1_5.jpg', price: 17990000),
          ProductModel(id: 81, name: ml('iPhone 12 mini 64GB | Chính hãng VN/A','iPhone 12 mini 64GB | VN/A','iPhone 12 mini 64GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/5/_/5_157_1.jpg', price: 13990000),
          ProductModel(id: 82, name: ml('iPhone SE 2022 256GB | Chính hãng VN/A','iPhone SE 2022 256GB | VN/A','iPhone SE 2022 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/_/1_359.png', price: 9990000),
        ],
      ),
      SubCategoryModel(
        id: 504,
        name: ml('Phù hợp cả nam và nữ', 'Unisex', '男女通用'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [
          ProductModel(id: 83, name: ml('iPhone 15 Pro Max 256GB | Chính hãng VN/A','iPhone 15 Pro Max 256GB | VN/A','iPhone 15 Pro Max 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_4__1.jpg', price: 29990000),
          ProductModel(id: 84, name: ml('iPhone 14 Pro 128GB | Chính hãng VN/A','iPhone 14 Pro 128GB | VN/A','iPhone 14 Pro 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-14-pro_2__4.png', price: 24990000),
          ProductModel(id: 85, name: ml('iPhone 13 128GB | Chính hãng VN/A','iPhone 13 128GB | VN/A','iPhone 13 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-13_2_.png', price: 17990000),
          ProductModel(id: 86, name: ml('iPhone 12 mini 128GB | Chính hãng VN/A','iPhone 12 mini 128GB | VN/A','iPhone 12 mini 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-12_1__4.jpg', price: 13990000),
          ProductModel(id: 87, name: ml('iPhone SE 2022 128GB | Chính hãng VN/A','iPhone SE 2022 128GB | VN/A','iPhone SE 2022 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/3/_/3_306_2.png', price: 9990000),
        ],
      ),
    ],
  ),

  // =========================
  // 7) Trang sức (Jewelry Accessories)
  // =========================
  CategoryModel(
    id: 7,
    name: ml('Trang sức', 'Jewelry Accessories', '珠宝配件'),
    imgUrlA: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
    subCategories: [
      SubCategoryModel(
        id: 601,
        name: ml('Dây chuyền', 'Necklaces', '项链'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [
          ProductModel(id: 88, name: ml('iPhone 15 Pro Max 256GB | Chính hãng VN/A','iPhone 15 Pro Max 256GB | VN/A','iPhone 15 Pro Max 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_3.png', price: 29990000),
          ProductModel(id: 89, name: ml('iPhone 14 Pro 128GB | Chính hãng VN/A','iPhone 14 Pro 128GB | VN/A','iPhone 14 Pro 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/_/x_m_16.png', price: 24990000),
          ProductModel(id: 90, name: ml('iPhone 13 128GB | Chính hãng VN/A','iPhone 13 128GB | VN/A','iPhone 13 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/3/13_4_7_2_7.jpg', price: 17990000),
          ProductModel(id: 91, name: ml('iPhone 12 mini 128GB | Chính hãng VN/A','iPhone 12 mini 128GB | VN/A','iPhone 12 mini 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-12_4__4.jpg', price: 13990000),
          ProductModel(id: 92, name: ml('iPhone SE 2022 | Chính hãng VN/A','iPhone SE 2022 | VN/A','iPhone SE 2022 | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/3/_/3_306_1.png', price: 9990000),
        ],
      ),
      SubCategoryModel(
        id: 602,
        name: ml('Vòng tay', 'Bracelets', '手链'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [
          ProductModel(id: 93, name: ml('iPhone 15 Pro Max 256GB | Chính hãng VN/A','iPhone 15 Pro Max 256GB | VN/A','iPhone 15 Pro Max 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_3.png', price: 29990000),
          ProductModel(id: 94, name: ml('iPhone 14 Pro 128GB | Chính hãng VN/A','iPhone 14 Pro 128GB | VN/A','iPhone 14 Pro 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/v/_/v_ng_12.png', price: 24990000),
          ProductModel(id: 95, name: ml('iPhone 13 128GB | Chính hãng VN/A','iPhone 13 128GB | VN/A','iPhone 13 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/1/11_3_12_2_1_5.jpg', price: 17990000),
          ProductModel(id: 96, name: ml('iPhone 12 mini 256GB | Chính hãng VN/A','iPhone 12 mini 256GB | VN/A','iPhone 12 mini 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-12_3__5.jpg', price: 13990000),
          ProductModel(id: 97, name: ml('iPhone SE 2022 128GB | Chính hãng VN/A','iPhone SE 2022 128GB | VN/A','iPhone SE 2022 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/2/_/2_337_2.png', price: 9990000),
        ],
      ),
      SubCategoryModel(
        id: 603,
        name: ml('Bông tai', 'Earrings', '耳环'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [
          ProductModel(id: 98, name: ml('iPhone 15 Pro Max 256GB | Chính hãng VN/A','iPhone 15 Pro Max 256GB | VN/A','iPhone 15 Pro Max 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_3.png', price: 29990000),
          ProductModel(id: 99, name: ml('iPhone 14 Pro Max 128GB | Chính hãng VN/A','iPhone 14 Pro Max 128GB | VN/A','iPhone 14 Pro Max 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/b/_/b_c_1_9.png', price: 24990000),
          ProductModel(id: 100, name: ml('iPhone 13 128GB | Chính hãng VN/A','iPhone 13 128GB | VN/A','iPhone 13 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/1/11_3_12_2_1_5.jpg', price: 17990000),
          ProductModel(id: 101, name: ml('iPhone 12 mini 64GB | Chính hãng VN/A','iPhone 12 mini 64GB | VN/A','iPhone 12 mini 64GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/_/1_252_1.jpg', price: 13990000),
          ProductModel(id: 102, name: ml('iPhone SE 2022 128GB | Chính hãng VN/A','iPhone SE 2022 128GB | VN/A','iPhone SE 2022 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/3/_/3_306_2.png', price: 9990000),
        ],
      ),
      SubCategoryModel(
        id: 604,
        name: ml('Nhẫn', 'Rings', '戒指'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [
          ProductModel(id: 103, name: ml('iPhone 15 Pro Max 256GB | Chính hãng VN/A','iPhone 15 Pro Max 256GB | VN/A','iPhone 15 Pro Max 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_3.png', price: 29990000),
          ProductModel(id: 104, name: ml('iPhone 14 Pro 128GB | Chính hãng VN/A','iPhone 14 Pro 128GB | VN/A','iPhone 14 Pro 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/v/_/v_ng_12.png', price: 24990000),
          ProductModel(id: 105, name: ml('iPhone 13 128GB | Chính hãng VN/A','iPhone 13 128GB | VN/A','iPhone 13 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/1/11_3_12_2_1_5.jpg', price: 17990000),
          ProductModel(id: 106, name: ml('iPhone 12 mini 64GB | Chính hãng VN/A','iPhone 12 mini 64GB | VN/A','iPhone 12 mini 64GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/5/_/5_157_1.jpg', price: 13990000),
          ProductModel(id: 107, name: ml('iPhone SE 2022 256GB | Chính hãng VN/A','iPhone SE 2022 256GB | VN/A','iPhone SE 2022 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/_/1_359.png', price: 9990000),
        ],
      ),
    ],
  ),

  // =========================
  // 8) Đồng hồ (Watches)
  // =========================
  CategoryModel(
    id: 8,
    name: ml('Đồng hồ', 'Watches', '手表'),
    imgUrlA: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/m/smart_band_1__1.png',
    subCategories: [
      SubCategoryModel(
        id: 701,
        name: ml('Đồng hồ nam', "Men's Watches", '男士手表'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [],
      ),
      SubCategoryModel(
        id: 702,
        name: ml('Đồng hồ nữ', "Women's Watches", '女士手表'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [
          ProductModel(id: 108, name: ml('iPhone 15 Pro Max 256GB | Chính hãng VN/A','iPhone 15 Pro Max 256GB | VN/A','iPhone 15 Pro Max 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_3.png', price: 29990000),
          ProductModel(id: 109, name: ml('iPhone 14 Pro 128GB | Chính hãng VN','iPhone 14 Pro 128GB | VN','iPhone 14 Pro 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/_/x_m_16.png', price: 24990000),
          ProductModel(id: 110, name: ml('iPhone 13 128GB | Chính hãng VN/A','iPhone 13 128GB | VN/A','iPhone 13 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/1/11_3_12_2_1_5.jpg', price: 17990000),
          ProductModel(id: 111, name: ml('iPhone 12 mini 256GB | Chính hãng VN/A','iPhone 12 mini 256GB | VN/A','iPhone 12 mini 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-12_7__6.jpg', price: 13990000),
          ProductModel(id: 112, name: ml('iPhone SE 2022 256GB | Chính hãng VN/A','iPhone SE 2022 256GB | VN/A','iPhone SE 2022 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/3/_/3_306.png', price: 9990000),
        ],
      ),
      SubCategoryModel(
        id: 703,
        name: ml('Đồng hồ thông minh', 'Smartwatches', '智能手表'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [
          ProductModel(id: 113, name: ml('iPhone 15 Pro Max 256GB | Chính hãng VN/A','iPhone 15 Pro Max 256GB | VN/A','iPhone 15 Pro Max 256GB | 越南行货'), imgUrlp: '', price: 29990000),
          ProductModel(id: 114, name: ml('iPhone 14 Pro 128GB | Chính hãng VN/A','iPhone 14 Pro 128GB | VN/A','iPhone 14 Pro 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/b/_/b_c_1_1.png', price: 24990000),
          ProductModel(id: 115, name: ml('iPhone 13 128GB | Chính hãng VN/A','iPhone 13 128GB | VN/A','iPhone 13 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/3/13_4_7_2_7.jpg', price: 17990000),
          ProductModel(id: 116, name: ml('iPhone 12 mini 256GB | Chính hãng VN/A','iPhone 12 mini 256GB | VN/A','iPhone 12 mini 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-12-mini_1_2.png', price: 13990000),
          ProductModel(id: 117, name: ml('iPhone SE 2022 256GB | Chính hãng VN/A','iPhone SE 2022 256GB | VN/A','iPhone SE 2022 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/2/_/2_337.png', price: 9990000),
        ],
      ),
    ],
  ),

  // =========================
  // 9) Xe máy (Motorcycles)
  // =========================
  CategoryModel(
    id: 9,
    name: ml('Xe máy', 'Motorcycles', '摩托车'),
    imgUrlA: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/m/smart_band_1__1.png',
    subCategories: [
      SubCategoryModel(
        id: 801,
        name: ml('Xe tay ga', 'Scooters', '滑板车'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [
          ProductModel(id: 118, name: ml('iPhone 15 Pro Max 256GB | Chính hãng VN/A','iPhone 15 Pro Max 256GB | VN/A','iPhone 15 Pro Max 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_3.png', price: 29990000),
          ProductModel(id: 119, name: ml('iPhone 14 Pro 128GB | Chính hãng VN/A','iPhone 14 Pro 128GB | VN/A','iPhone 14 Pro 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/v/_/v_ng_12.png', price: 24990000),
          ProductModel(id: 120, name: ml('iPhone 13 128GB | Chính hãng VN/A','iPhone 13 128GB | VN/A','iPhone 13 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/3/13_4_7_2_7.jpg', price: 17990000),
          ProductModel(id: 121, name: ml('iPhone 12 mini 64GB | Chính hãng VN/A','iPhone 12 mini 64GB | VN/A','iPhone 12 mini 64GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/_/1_252_1.jpg', price: 13990000),
          ProductModel(id: 122, name: ml('iPhone SE 2022 256GB | Chính hãng VN/A','iPhone SE 2022 256GB | VN/A','iPhone SE 2022 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/3/_/3_306.png', price: 9990000),
        ],
      ),
      SubCategoryModel(
        id: 802,
        name: ml('Xe máy số', 'Manual Motorbikes', '手动摩托车'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [
          ProductModel(id: 123, name: ml('iPhone 15 Pro Max 256GB | Chính hãng VN/A','iPhone 15 Pro Max 256GB | VN/A','iPhone 15 Pro Max 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_3.png', price: 29990000),
          ProductModel(id: 124, name: ml('iPhone 14 Pro 128GB | Chính hãng VN/A','iPhone 14 Pro 128GB | VN/A','iPhone 14 Pro 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/v/_/v_ng_12.png', price: 24990000),
          ProductModel(id: 125, name: ml('iPhone 13 128GB | Chính hãng VN/A','iPhone 13 128GB | VN/A','iPhone 13 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/1/11_3_12_2_1_5.jpg', price: 17990000),
          ProductModel(id: 126, name: ml('iPhone 12 mini 128GB | Chính hãng VN/A','iPhone 12 mini 128GB | VN/A','iPhone 12 mini 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-12_2__4.jpg', price: 13990000),
          ProductModel(id: 127, name: ml('iPhone SE 2022 | Chính hãng VN/A','iPhone SE 2022 | VN/A','iPhone SE 2022 | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/3/_/3_306_1.png', price: 9990000),
        ],
      ),
      SubCategoryModel(
        id: 803,
        name: ml('Xe máy điện', 'Electric Motorbikes', '电动摩托车'),
        imgUrl: 'https://sackim.com/wp-content/uploads/2019/02/logo-apple-hien-tai.jpg',
        products: [
          ProductModel(id: 128, name: ml('iPhone 15 Pro Max 256GB | Chính hãng VN/A','iPhone 15 Pro Max 256GB | VN/A','iPhone 15 Pro Max 256GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-pro-max_3.png', price: 29990000),
          ProductModel(id: 129, name: ml('iPhone 14 Pro 128GB | Chính hãng VN/A','iPhone 14 Pro 128GB | VN/A','iPhone 14 Pro 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-14-pro_2__4.png', price: 24990000),
          ProductModel(id: 130, name: ml('iPhone 13 128GB | Chính hãng VN/A','iPhone 13 128GB | VN/A','iPhone 13 128GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/1/3/13_4_7_2_7.jpg', price: 17990000),
          ProductModel(id: 131, name: ml('iPhone 12 mini 64GB | Chính hãng VN/A','iPhone 12 mini 64GB | VN/A','iPhone 12 mini 64GB | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/6/_/6_129_1.jpg', price: 13990000),
          ProductModel(id: 132, name: ml('iPhone SE 2022 | Chính hãng VN/A','iPhone SE 2022 | VN/A','iPhone SE 2022 | 越南行货'), imgUrlp: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/3/_/3_306_1.png', price: 9990000),
        ],
      ),
    ],
  ),
];
