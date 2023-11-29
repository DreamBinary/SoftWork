import 'package:get/get.dart';

import '../../../data/net/api_user.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/toast.dart';
import '../login/login_logic.dart';
import '../login/login_state.dart';
import 'register_state.dart';

class RegisterLogic extends GetxController {
  final RegisterState state = RegisterState();
  final LoginState stateLogin = Get
      .find<LoginLogic>()
      .state;

  register() async {
    String username = stateLogin.usernameCtrl.text.trim();
    String password = stateLogin.passwordCtrl.text.trim();
    String verify = state.verifyCtrl.text.trim();
    String verifyPassword = state.verifyPasswordCtrl.text.trim();

    if (password.isEmpty) {
      ToastUtil.showToast("密码不能为空");
      return;
    }
    if (verifyPassword != password) {
      ToastUtil.showToast("两次密码不一致");
      return;
    }
    bool isSuccess = await ApiUser.signUp(username, password);
    if (isSuccess) {
      ToastUtil.showToast("注册成功");
      Get.offNamed(Routes.login);
    }
  }
}
