// import 'package:get/get.dart';
// import '../domain/model/artist_model.dart';
// import '../domain/model/mock_artistmodel.dart'; // mockArtists
//
// class ArtistListController extends GetxController {
//   final RxList<ArtistModel> artists = <ArtistModel>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     artists.assignAll(mockArtists); // Gán dữ liệu ban đầu
//   }
//
//   void toggleFollow(int index) {
//     final artist = artists[index];
//     artist.isFollowing = !artist.isFollowing;
//     artists[index] = artist; // Trigger cập nhật UI
//   }
// }
