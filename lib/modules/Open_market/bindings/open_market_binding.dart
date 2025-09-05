import 'package:get/get.dart';
import '../controllers/open_market_controller.dart';

class OpenMarketBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OpenMarketController());
    // Get.put(ArtistListController());
  }
}
