import 'package:fido_box_demo01/modules/Open_market/domain/model/highlighted_model.dart';
import 'package:get/get.dart';
import '../domain/model/artist_model.dart';
import '../domain/model/merch_product_model.dart';
import '../domain/model/mock_artistmodel.dart';
import '../domain/model/mock_highlighted.dart';

class OpenMarketController extends GetxController {
  final currentTab = 0.obs;
  final allArtists = mockArtists.obs;
// Truy cập mockHighlighted trực tiếp
  final highlightedItems = mockHighlighted;
  final Rxn<ArtistModel> selectedArtist = Rxn<ArtistModel>();
  final selectedArtistId = ''.obs; // <- dùng cho UI filter dropdown

  List<ArtistModel> get followedArtists =>
      allArtists.where((artist) => artist.isFollowing).toList();

  List<MerchProduct> get allProducts =>
      allArtists.expand((artist) => artist.merchProducts).toList();
  List<HighlightedModel> get allHighlightedItems => mockHighlighted;


  List<MerchProduct> get filteredProducts {
    final artist = selectedArtist.value;
    return artist == null ? allProducts : artist.merchProducts;
  }

  void selectArtist(ArtistModel artist) {
    selectedArtist.value = artist;
    selectedArtistId.value = artist.id;
  }

  void selectArtistById(String id) {
    if (id.isEmpty) {
      clearSelectedArtist();
      return;
    }

    final artist = allArtists.firstWhereOrNull((a) => a.id == id);
    if (artist != null) {
      selectArtist(artist);
    }
  }

  void clearSelectedArtist() {
    selectedArtist.value = null;
    selectedArtistId.value = '';
  }

  void toggleFollow(int index) {
    allArtists[index].isFollowing = !allArtists[index].isFollowing;
    update(); // rebuild GetBuilder if needed
  }

  void changeTab(int index) {
    currentTab.value = index;
  }
//
//   void toggleFollow(int index) {
// //     final artist = artists[index];
// //     artist.isFollowing = !artist.isFollowing;
// //     artists[index] = artist; // Trigger cập nhật UI
// //   }
}
