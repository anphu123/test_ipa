import 'package:fido_box_demo01/core/assets/assets.gen.dart';
import 'seller_review_model.dart';

final List<SellerReview> sellerReviewsMock = [
  // Original mock
  SellerReview(
    id: "cmt001",
    userName: "Fi***ox",
    location: "TP. Hồ Chí Minh",
    comment:
    "Giao dịch nhanh chóng, khuyến khích mọi người nên sử dụng ứng dụng.",
    tags: [
      "Thu mua giá tốt",
      "Kiểm định chuẩn",
      "Chuyên nghiệp",
      "Kiểm định nhanh",
    ],
    productImages: [
      Assets.images.pXiaomi15.path,
      Assets.images.pXiaomi15.path,
      Assets.images.pXiaomi15.path,
      Assets.images.pXiaomi15.path,
      Assets.images.pXiaomi15.path,
      Assets.images.pXiaomi15.path,
    ],
    productName: "Xiaomi 15 Ultra",
    isVerified: true,
    avatar: Assets.images.logoHome.path,
    category: "Tất cả",
    soldAmount: "đ30.000.000",
  ),
  SellerReview(
    id: "cmt002",
    userName: "An***Minh",
    location: "Đà Nẵng",
    comment: "Điện thoại mới nguyên seal, giá tốt hơn thị trường.",
    tags: ["Đóng gói kỹ", "Giao hàng nhanh"],
    productImages: [
      Assets.images.pXiaomi15.path,
      Assets.images.pXiaomi15.path
    ],
    productName: "iPhone 13 Pro Max",
    isVerified: true,
    avatar: Assets.images.logoHome.path,
    category: "Điện thoại",
    soldAmount: "đ12.000.000",
  ),

  // Expanded mock data
  SellerReview(
    id: "cmt003",
    userName: "Tr***Duc",
    location: "Hà Nội",
    comment:
    "Máy đẹp, giá hợp lý. Giao dịch nhanh gọn, nhân viên tư vấn nhiệt tình.",
    tags: ["Giá tốt", "Tư vấn nhiệt tình", "Giao dịch nhanh"],
    productImages: [Assets.images.pXiaomi15.path],
    productName: "Samsung Galaxy S24",
    isVerified: true,
    avatar: Assets.images.logoHome.path,
    category: "Điện thoại",
    soldAmount: "đ18.500.000",
  ),
  SellerReview(
    id: "cmt004",
    userName: "Mi***Anh",
    location: "Cần Thơ",
    comment:
    "Laptop chạy mượt, kiểm tra kỹ càng. Rất hài lòng với dịch vụ.",
    tags: ["Kiểm tra kỹ", "Chất lượng tốt", "Dịch vụ tốt"],
    productImages: [
      Assets.images.pXiaomi15.path,
      Assets.images.pXiaomi15.path
    ],
    productName: "MacBook Pro M3",
    isVerified: false,
    avatar: Assets.images.logoHome.path,
    category: "Laptop",
    soldAmount: "đ45.000.000",
  ),
  SellerReview(
    id: "cmt005",
    userName: "Qu***Huy",
    location: "Đà Nẵng",
    comment:
    "Đồng hồ đẹp, còn mới. Giá cả phải chăng, giao hàng đúng hẹn.",
    tags: ["Đúng hẹn", "Giá phải chăng", "Còn mới"],
    productImages: [Assets.images.pXiaomi15.path],
    productName: "Apple Watch Series 9",
    isVerified: true,
    avatar: Assets.images.logoHome.path,
    category: "Đồng hồ",
    soldAmount: "đ8.200.000",
  ),
  SellerReview(
    id: "cmt006",
    userName: "Th***Linh",
    location: "TP. Hồ Chí Minh",
    comment:
    "Tablet hoạt động tốt, màn hình sắc nét. Nhân viên hỗ trợ tận tình.",
    tags: ["Màn hình đẹp", "Hỗ trợ tốt", "Hoạt động ổn định"],
    productImages: [
      Assets.images.pXiaomi15.path,
      Assets.images.pXiaomi15.path,
      Assets.images.pXiaomi15.path
    ],
    productName: "iPad Pro 12.9",
    isVerified: true,
    avatar: Assets.images.logoHome.path,
    category: "Tablet",
    soldAmount: "đ25.000.000",
  ),
  SellerReview(
    id: "cmt007",
    userName: "Ph***Nam",
    location: "Hải Phòng",
    comment:
    "Thiết bị âm thanh chất lượng cao, âm thanh trong trẻo. Rất đáng mua.",
    tags: ["Chất lượng cao", "Âm thanh tốt", "Đáng mua"],
    productImages: [Assets.images.pXiaomi15.path],
    productName: "AirPods Pro 2",
    isVerified: false,
    avatar: Assets.images.logoHome.path,
    category: "Thiết bị điện tử",
    soldAmount: "đ5.500.000",
  ),
  SellerReview(
    id: "cmt008",
    userName: "Le***Tuan",
    location: "Nha Trang",
    comment:
    "Phụ kiện đầy đủ, đóng gói cẩn thận. Giao dịch uy tín và chuyên nghiệp.",
    tags: ["Đầy đủ phụ kiện", "Đóng gói tốt", "Uy tín"],
    productImages: [
      Assets.images.pXiaomi15.path,
      Assets.images.pXiaomi15.path
    ],
    productName: "Bàn phím cơ Gaming",
    isVerified: true,
    avatar: Assets.images.logoHome.path,
    category: "Phụ kiện",
    soldAmount: "đ2.800.000",
  ),
];
