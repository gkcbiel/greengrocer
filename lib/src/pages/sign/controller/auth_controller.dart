import 'package:app_greengrocer/src/pages/cart/components/user_model.dart';
import 'package:app_greengrocer/src/pages/sign/repository/auth_repository.dart';
import 'package:app_greengrocer/src/pages/sign/result/sign_result.dart';
import 'package:app_greengrocer/src/pages_routes/app_pages.dart';
import 'package:app_greengrocer/src/services/utils_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();
  final utilsServices = UtilsServices();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  UserModel user = UserModel();

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    //await Future.delayed(const Duration(seconds: 2));

    SignResult result =
        await authRepository.signIn(email: email, password: password);

    isLoading.value = false;

    result.when(success: (user) {
      this.user = user;

      //Get.offAllNamed(PagesRoutes.baseRoute);

       Get.offAndToNamed(PagesRoutes.baseRoute);

    }, error: (message) {
      utilsServices.showToast(message: message, isError: true);
    });
  }
}
