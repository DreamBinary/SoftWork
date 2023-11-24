import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginState {
  final usernameCtrl = TextEditingController(text: "");
  final passwordCtrl = TextEditingController(text: "");
  var showClearUsername = false.obs;
  var showClearPassword = false.obs;
  var showPassword = false.obs;
  var checkUseAndPrivate = false.obs;

  LoginState() {
    usernameCtrl.addListener(() {
      showClearUsername.value = usernameCtrl.text.isNotEmpty;
    });
    passwordCtrl.addListener(() {
      showClearPassword.value = passwordCtrl.text.isNotEmpty;
    });
  }
}
