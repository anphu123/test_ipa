import 'package:get/get.dart';

import '../controllers/answer_detail_controller.dart';

class AnswerDetailBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(() => AnswerDetailController());
  }
}
