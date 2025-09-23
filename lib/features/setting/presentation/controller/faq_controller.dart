import 'package:get/get.dart';
import '../../../../services/api/api_service.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/enum/enum.dart';

class FaqController extends GetxController {
  /// Api status check here
  Status status = Status.completed;
  List data = [];

  ///  HTML model initialize here
  // HtmlModel data = HtmlModel.fromJson({});

  /// Privacy Policy Controller instance create here
  static FaqController get instance => Get.put(FaqController());

  /// Faq Api call here
  getFaqRepo() async {
    // return;
    status = Status.loading;
    update();

    var response = await ApiService.get(ApiEndPoint.faq);

    if (response.statusCode == 200) {
      // data = HtmlModel.fromJson(response.data["data"]);
      data = response.data["data"] as List;
      status = Status.completed;
      update();
    } else {
      Utils.errorSnackBar(response.statusCode, response.message);
      status = Status.error;
      update();
    }
  }

  /// Controller on Init here
  @override
  void onInit() {
    getFaqRepo();
    super.onInit();
  }
}
