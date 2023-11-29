import 'package:get/get.dart';

import '../../../data/net/api_user.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/app_string.dart';
import '../../../utils/mmkv.dart';
import '../../../utils/toast.dart';
import 'login_state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();

  login(Function shake) async {
    String username = state.usernameCtrl.text.trim();
    String password = state.passwordCtrl.text.trim();

    // if (username == "11111111111" && password == "1111111111") {
    //   ToastUtil.showToast("登录成功");
    //   MMKVUtil.put(AppString.mmUsername, username);
    //   MMKVUtil.put(AppString.mmIsLogin, true);
    //   Get.offAllNamed(Routes.route);
    //   return;
    // }

    if (username.length != 11) {
      ToastUtil.showToast("请输入正确的手机号");
      return;
    }

    if (password.isEmpty) {
      ToastUtil.showToast("密码不能为空");
      return;
    }
    if (state.checkUseAndPrivate.value == false) {
      shake();
      ToastUtil.showToast("请勾选使用条款和隐私政策");
      return;
    }

    bool isSuccess = await ApiUser.login(username, password);
    if (isSuccess) {
      ToastUtil.showToast("登录成功");
      MMKVUtil.put(AppString.mmUsername, username);
      MMKVUtil.put(AppString.mmIsLogin, true);
      Get.offAllNamed(Routes.route);
    } else {
      ToastUtil.showToast("登录失败");
    }
  }
}
