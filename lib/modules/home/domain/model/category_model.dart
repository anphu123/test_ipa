import 'package:meta/meta.dart';

typedef L = Map<String, String>; // Localized text alias

class CategoryModel {
  final int id;
  final L name;            // đa ngôn ngữ
  String? icon;
  String? imgUrlA;
  final List<SubCategoryModel> subCategories;

  CategoryModel({
    required this.id,
    required this.name,
    this.imgUrlA,
    this.icon,
    this.subCategories = const [],
  });
}

class SubCategoryModel {
  final int id;
  final L name;            // đa ngôn ngữ
  final String imgUrl;
  final List<ProductModel> products;

  SubCategoryModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.products,
  });
}

/// -------------------------- PRODUCT & DETAIL --------------------------

class ProductModel {
  final int id;
  final L name;            // đa ngôn ngữ
  final String imgUrlp;    // ảnh cover
  final double price;

  /// Danh sách ảnh (ngoại hình, preview)
  final List<String> gallery;

  /// Thông tin người bán / bài đăng
  final SellerInfo? seller;

  /// Báo cáo kiểm định (màn “Báo cáo kiểm tra”)
  final InspectionReport? inspection;

  /// Danh sách phụ kiện
  final AccessoryInfo? accessories;

  /// Review + Tổng kết AI
  final ReviewAggregate? reviews;

  ProductModel({
    required this.id,
    required this.name,
    required this.imgUrlp,
    required this.price,
    this.gallery = const [],
    this.seller,
    this.inspection,
    this.accessories,
    this.reviews,
  });

  @override
  String toString() => 'ProductModel(id: $id, name: \\${name['vi'] ?? name.values.first}, price: $price)';
}

/// -------------------------- SELLER --------------------------

class SellerInfo {
  final String sellerId;     // ID người bán
  final L? displayName;      // tên hiển thị đã mask (đa ngôn ngữ nếu cần)
  final String? avatarUrl;   // avatar người bán
  final DateTime? postedAt;  // ngày đăng bán

  const SellerInfo({
    required this.sellerId,
    this.displayName,
    this.avatarUrl,
    this.postedAt,
  });
}

/// -------------------------- INSPECTION REPORT --------------------------

class InspectionReport {
  final String? inspectionId;   // Số nhận dạng kiểm định
  final bool isDirectCheck;     // Cờ “Kiểm tra trực tiếp”
  final DateTime? inspectedAt;  // Thời gian kiểm định
  final L? stationName;         // Trạm/đối tác kiểm định (đa ngôn ngữ)
  final L? providerName;        // Đơn vị uỷ quyền (đa ngôn ngữ)

  /// Tóm tắt ngoại hình/chức năng phần đầu
  final AppearanceSummary? appearance;

  /// Thông số kỹ thuật dạng grid 3 cột
  final SpecsSection? specs;

  /// Tình trạng pin
  final BatteryInfo? battery;

  /// Ảnh ngoại hình & ghi chú
  final ExteriorInfo? exterior;

  /// Nhóm kiểm tra khác + chi tiết (dropdown)
  final List<CheckGroup> otherChecks;

  /// Giải thích kiểm tra máy (các card text)
  final List<ExplanationItem> explanations;

  /// Box “thông tin kiểm định” (các dòng mô tả)
  final List<InfoLine> infoLines;

  const InspectionReport({
    this.inspectionId,
    this.isDirectCheck = false,
    this.inspectedAt,
    this.stationName,
    this.providerName,
    this.appearance,
    this.specs,
    this.battery,
    this.exterior,
    this.otherChecks = const [],
    this.explanations = const [],
    this.infoLines = const [],
  });
}

class AppearanceSummary {
  final int? appearanceScore;  // ví dụ: 95
  final L? functionGrade;      // ví dụ: {vi:'B', en:'B', zh:'B'}
  final L? description;        // mô tả ngắn đa ngôn ngữ

  const AppearanceSummary({this.appearanceScore, this.functionGrade, this.description});
}

class SpecsSection {
  final L? sim;               // "Hỗ trợ 2 SIM"
  final L? networkCompat;     // "Tương thích mọi nhà mạng"
  final L? networkType;       // "Hỗ trợ 5G"
  final L? chipset;           // "Snapdragon 8 Gen 2"
  final L? batteryPercent;    // "80%–85%"
  final bool? batteryReplaced;// true/false
  final L? ram;               // "16GB LPDDR5X"
  final L? rom;               // "256GB UFS 4.0"
  final L? fastCharge;        // "90W USB-C"

  /// Mở rộng cặp label/value đa ngôn ngữ
  final List<SpecItem> extra;

  const SpecsSection({
    this.sim,
    this.networkCompat,
    this.networkType,
    this.chipset,
    this.batteryPercent,
    this.batteryReplaced,
    this.ram,
    this.rom,
    this.fastCharge,
    this.extra = const [],
  });
}

class SpecItem {
  final L label;  // nhãn
  final L value;  // giá trị
  const SpecItem({required this.label, required this.value});
}

class BatteryInfo {
  final double? healthRatio;  // 0..1
  final L? healthText;        // "80% - 85%"
  final bool? replaced;       // đã thay pin?
  final L? note;              // ghi chú

  const BatteryInfo({this.healthRatio, this.healthText, this.replaced, this.note});
}

class ExteriorInfo {
  final int? findingCount;    // số dấu vết sử dụng
  final List<String> photos;  // URLs ảnh
  final L? note;              // mô tả

  const ExteriorInfo({this.findingCount, this.photos = const [], this.note});
}

class CheckGroup {
  final L label;                // nhãn nhóm
  final List<CheckItem> details;// chi tiết các mục
  const CheckGroup({required this.label, this.details = const []});
}

class CheckItem {
  final L name;   // tên mục kiểm tra
  final bool ok;  // đạt hay không
  const CheckItem({required this.name, required this.ok});
}

class ExplanationItem {
  final L title;        // tiêu đề
  final L description;  // nội dung
  const ExplanationItem({required this.title, required this.description});
}

class InfoLine {
  final L text;     // dòng mô tả
  final bool muted; // hiển thị mờ hay không
  const InfoLine(this.text, {this.muted = false});
}

/// -------------------------- ACCESSORIES --------------------------

class AccessoryInfo {
  final L? commonNote;       // ghi chú chung
  final List<L> extraItems;  // danh sách item bổ sung
  const AccessoryInfo({this.commonNote, this.extraItems = const []});
}

/// -------------------------- REVIEWS & AI SUMMARY --------------------------

class ReviewAggregate {
  final int totalReviews;  // tổng số đánh giá
  final int imageCount;
  final int videoCount;
  final int positiveCount;

  final AiSummary? aiSummary;     // Tổng kết AI
  final List<UserReview> samples; // vài review mẫu

  const ReviewAggregate({
    this.totalReviews = 0,
    this.imageCount = 0,
    this.videoCount = 0,
    this.positiveCount = 0,
    this.aiSummary,
    this.samples = const [],
  });
}

class AiSummary {
  final L title;            // ví dụ: {'vi':'Tổng kết AI :', 'en':'AI Summary :', 'zh':'AI 总结 :'}
  final L disclaimer;       // cảnh báo
  final List<L> lines;      // các dòng bullet

  const AiSummary({
    this.title = const {'vi':'Tổng kết AI :','en':'AI Summary :','zh':'AI 总结 :'},
    this.disclaimer = const {'vi':'','en':'','zh':''},
    this.lines = const [],
  });
}

class UserReview {
  final String avatarUrl;   // avatar URL
  final L title;            // tiêu đề ngắn
  final L content;          // nội dung

  const UserReview({
    required this.avatarUrl,
    required this.title,
    required this.content,
  });
}