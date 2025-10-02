import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:miraa_social_messaging/utils/helpers/other_helper.dart';

import '../../../../../config/route/app_routes.dart';
import '../../../../../services/api/api_service.dart';
import '../../../../../services/storage/storage_keys.dart';
import '../../../../../config/api/api_end_point.dart';
import '../../../../../services/storage/storage_services.dart';
import '../../../../../utils/app_utils.dart';

class SignUpController extends GetxController {
  /// Sign Up Form Key

  bool isPopUpOpen = false;
  bool isLoading = false;
  bool isLoadingVerify = false;
  bool isAgree = false;
  Timer? _timer;
  int start = 0;

  String time = "";

  List selectedOption = [
    "Lifelong Learner / Student",
    "Working Professional",
    "Parent / Caregiver",
    "Partnered / Navigating Relationships",
    "Independent / Navigating Life",
    "In Transition / Redefining Myself",
  ];

  String selectRole = "Lifelong Learner / Student";
  String countryCode = "+880";
  String? image;

  String signUpToken = '';

  static SignUpController get instance => Get.put(SignUpController());

  TextEditingController nameController = TextEditingController(
    text: kDebugMode ? "Namimul Hassan" : "",
  );
  TextEditingController lastNameController = TextEditingController(
    text: kDebugMode ? "Hassan" : "",
  );
  TextEditingController usernameController = TextEditingController(
    text: kDebugMode ? "namimul" : "",
  );
  TextEditingController emailController = TextEditingController(
    text: kDebugMode ? "developernaimul00@gmail.com" : '',
  );
  TextEditingController passwordController = TextEditingController(
    text: kDebugMode ? 'hello123' : '',
  );
  TextEditingController confirmPasswordController = TextEditingController(
    text: kDebugMode ? 'hello123' : '',
  );
  TextEditingController numberController = TextEditingController(
    text: kDebugMode ? '1865965581' : '',
  );
  TextEditingController otpController = TextEditingController(
    text: kDebugMode ? '123456' : '',
  );

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  onCountryChange(Country value) {
    countryCode = value.dialCode.toString();
  }

  setSelectedRole(value) {
    selectRole = value;
    update();
  }

  openGallery() async {
    image = await OtherHelper.openGallery();
    update();
  }

  signUpUser(GlobalKey<FormState> signUpFormKey) async {
    if (!signUpFormKey.currentState!.validate()) return;

    isLoading = true;
    update();

    // Updated body with all required fields as per user specification
    Map<String, String> body = {
      "email": emailController.text.trim(),
      "userName": usernameController.text.trim(),
      "password": passwordController.text,
      "category":
          selectRole, // Using selectRole as category (exact match with backend)
      "firstName": nameController.text.trim(),
      "lastName": lastNameController.text.trim(),
      "role": "user", // Backend only accepts "user" as role
      // Additional fields that might be needed by the existing API
      "phoneNumber": numberController.text.trim(),
      "countryCode": countryCode,
    };

    try {
      var response = await ApiService.post(ApiEndPoint.signUp, body: body);

      if (response.statusCode == 200) {
        //var data = response.data;
        //signUpToken = data['data']['signUpToken'];

        // Success message
        Utils.successSnackBar("Success", "Account created successfully!");
        Get.toNamed(AppRoutes.verifyUser);
      } else {
        Utils.errorSnackBar(response.statusCode.toString(), response.message);
      }
    } catch (e) {
      // Handle network or other errors
      Utils.errorSnackBar("Error", "Something went wrong. Please try again.");
      if (kDebugMode) {
        print("SignUp Error: $e");
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  void startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    start = 180; // Reset the start value
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (start > 0) {
        start--;
        final minutes = (start ~/ 60).toString().padLeft(2, '0');
        final seconds = (start % 60).toString().padLeft(2, '0');

        time = "$minutes:$seconds";

        update();
      } else {
        _timer?.cancel();
      }
    });
  }

  Future<void> verifyOtpRepo() async {
    isLoadingVerify = true;
    update();

    // Using the email and oneTimeCode as specified in the request
    Map<String, String> body = {
      "email": emailController.text.trim(),
      "oneTimeCode": otpController.text,
    };

    var response = await ApiService.post(ApiEndPoint.verifyEmail, body: body);

    if (response.statusCode == 200) {
      var data = response.data;

      LocalStorage.token = data['data']["accessToken"];
      // LocalStorage.userId = data['data']["attributes"]["_id"];
      // LocalStorage.myImage = data['data']["attributes"]["image"];
      // LocalStorage.myName = data['data']["attributes"]["fullName"];
      // LocalStorage.myEmail = data['data']["attributes"]["email"];
      LocalStorage.isLogIn = true;

      //LocalStorage.setBool(LocalStorageKeys.isLogIn, LocalStorage.isLogIn);
      LocalStorage.setString(LocalStorageKeys.token, LocalStorage.token);
      // LocalStorage.setString(LocalStorageKeys.userId, LocalStorage.userId);
      // LocalStorage.setString(LocalStorageKeys.myImage, LocalStorage.myImage);
      // LocalStorage.setString(LocalStorageKeys.myName, LocalStorage.myName);
      // LocalStorage.setString(LocalStorageKeys.myEmail, LocalStorage.myEmail);

      Utils.successSnackBar("Success", "Account verified successfully!");
      Get.offAllNamed(AppRoutes.signIn);
    } else {
      Utils.errorSnackBar(response.statusCode.toString(), response.message);
    }

    isLoadingVerify = false;
    update();
  }
}
