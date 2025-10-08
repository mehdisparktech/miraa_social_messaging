import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miraa_social_messaging/services/storage/storage_services.dart';
import 'package:miraa_social_messaging/utils/enum/enum.dart';
import 'package:miraa_social_messaging/utils/helpers/other_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/api/api_end_point.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../data/model/message_model.dart';

class ProfileController extends GetxController {
  /// Language List here
  List languages = ["English", "French", "Arabic"];

  /// form key here
  final formKey = GlobalKey<FormState>();

  /// select Language here
  String selectedLanguage = "English";

  /// select image here
  String? image;

  /// edit button loading here
  bool isLoading = false;

  Status status = Status.completed;

  // Message data for YourFeedsSection
  RxList<MessageItemModel> messages = <MessageItemModel>[].obs;
  RxBool isLoadingMessages = false.obs;
  RxString messagesError = ''.obs;

  /// Privacy Policy Controller instance create here
  static ProfileController get instance => Get.put(ProfileController());

  /// all controller here
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  /// select image function here
  getProfileImage() async {
    image = await OtherHelper.openGalleryForProfile();
    update();
  }

  /// select language  function here
  selectLanguage(int index) {
    selectedLanguage = languages[index];
    update();
    Get.back();
  }

  /// Get profile function here
  Future<void> getProfileRepo() async {
    status = Status.loading;
    update();

    var response = await ApiService.get(ApiEndPoint.getuserProfile);

    if (response.statusCode == 200) {
      var data = response.data["data"];
      firstNameController.text = data["firstName"]?.toString() ?? "";
      lastNameController.text = data["lastName"]?.toString() ?? "";
      usernameController.text = data["userName"]?.toString() ?? "";
      emailController.text = data["email"]?.toString() ?? "";
      status = Status.completed;
      update();
    } else {
      Utils.errorSnackBar(response.statusCode, response.message);
      status = Status.error;
      update();
    }
  }

  /// update profile function here
  Future<void> editProfileRepo() async {
    if (!formKey.currentState!.validate()) return;

    if (!LocalStorage.isLogIn) return;
    isLoading = true;
    update();

    Map<String, String> body = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "username": usernameController.text,
      "email": emailController.text,
    };

    var response = await ApiService.multipart(
      ApiEndPoint.user,
      body: body,
      imagePath: image,
      imageName: "image",
    );

    if (response.statusCode == 200) {
      var data = response.data;

      LocalStorage.userId = data['data']?["_id"] ?? "";
      LocalStorage.myImage = data['data']?["image"] ?? "";
      LocalStorage.myName = data['data']?["fullName"] ?? "";
      LocalStorage.myEmail = data['data']?["email"] ?? "";

      LocalStorage.setString("userId", LocalStorage.userId);
      LocalStorage.setString("myImage", LocalStorage.myImage);
      LocalStorage.setString("myName", LocalStorage.myName);
      LocalStorage.setString("myEmail", LocalStorage.myEmail);

      Utils.successSnackBar("Successfully Profile Updated", response.message);
      Get.toNamed(AppRoutes.profile);
    } else {
      Utils.errorSnackBar(response.statusCode, response.message);
    }

    isLoading = false;
    update();
  }

  @override
  void onInit() {
    getProfileRepo();
    fetchMessages();
    super.onInit();
  }

  /// Fetch messages function here
  Future<void> fetchMessages() async {
    try {
      isLoadingMessages.value = true;
      messagesError.value = '';

      final response = await ApiService.get(ApiEndPoint.messageList);

      if (response.statusCode == 200) {
        final messageResponse = MessageResponseModel.fromJson(
          Map<String, dynamic>.from(response.data),
        );
        messages.value = messageResponse.data.data;
      } else {
        messagesError.value = 'Failed to load messages';
        Fluttertoast.showToast(
          msg: "Failed to load messages",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.red,
          textColor: AppColors.white,
          fontSize: 14.sp,
        );
      }
    } catch (e) {
      messagesError.value = 'Error loading messages: ${e.toString()}';
      Fluttertoast.showToast(
        msg: "Error loading messages",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.red,
        textColor: AppColors.white,
        fontSize: 14.sp,
      );
    } finally {
      isLoadingMessages.value = false;
    }
  }
}
