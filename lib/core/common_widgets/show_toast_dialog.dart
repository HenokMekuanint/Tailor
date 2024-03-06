import 'package:flutter_easyloading/flutter_easyloading.dart';

class ShowToastDialog {
  static showToast(String? message,
      {EasyLoadingToastPosition position = EasyLoadingToastPosition.top}) {
    EasyLoading.showToast(
      message!,
      toastPosition: position,
      dismissOnTap: true,
      duration: const Duration(seconds: 3),
      maskType: EasyLoadingMaskType.black,
    );
  }

  static showLoader(String message) {
    EasyLoading.show(status: message);
  }

  static closeLoader() {
    EasyLoading.dismiss();
  }
}
