class SellerReview {
  final String id;
  final String userName;
  final String location;
  final String comment;
  final List<String> tags;
  final List<String> productImages;
  final String productName;
  final bool isVerified;
  final String avatar;
  final String category;
  final String soldAmount;

  SellerReview({
    required this.id,
    required this.userName,
    required this.location,
    required this.comment,
    required this.tags,
    required this.productImages,
    required this.productName,
    required this.isVerified,
    required this.avatar,
    required this.category,
    required this.soldAmount,
  });
}
