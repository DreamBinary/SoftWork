import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../theme/app_colors.dart';
import '../theme/app_string.dart';

class PasswordTextField extends StatelessWidget {
  final TextEditingController ctrl;
  final String hint;
  final IconData? prefixIcon;
  final Function() onClear;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;
  final Rx<bool> clearVisible = false.obs;
  final Rx<bool> passwordVisible = false.obs;
  final FocusNode focusNode = FocusNode();
  late final Rx<bool> focus = false.obs;

  PasswordTextField(
    this.ctrl, {
    super.key,
    required this.hint,
    required this.prefixIcon,
    required this.onClear,
    this.onSubmitted,
    this.textInputAction,
  }) {
    focusNode.addListener(() {
      focus.value = focusNode.hasFocus;
      clearVisible.value = ctrl.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => TextField(
        controller: ctrl,
        focusNode: focusNode,
        decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(prefixIcon),
            suffix: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                    visible: focus.value && clearVisible.value,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      onTap: () => {onClear(), clearVisible.value = false},
                      child: const Icon(Icons.clear, size: 15),
                    )),
                Visibility(
                    visible: focus.value && clearVisible.value,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      onTap: () =>
                          {passwordVisible.value = !passwordVisible.value},
                      child:
                          const Icon(Icons.remove_red_eye_outlined, size: 15),
                    )),
              ],
            )),
        obscureText: !focus.value || !passwordVisible.value,
        textInputAction: textInputAction,
        maxLength: 10,
        keyboardType: TextInputType.visiblePassword,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]|[0-9]"))
        ],
        onChanged: (str) => {clearVisible.value = str.isNotEmpty},
        onSubmitted: onSubmitted));
  }
}

class UsernameTextField extends StatelessWidget {
  final TextEditingController ctrl;
  final Function() onClear;
  final Rx<bool> clearVisible = false.obs;
  final FocusNode focusNode = FocusNode();
  late final Rx<bool> focus = false.obs;

  UsernameTextField(
    this.ctrl, {
    super.key,
    required this.onClear,
  }) {
    focusNode.addListener(() {
      focus.value = focusNode.hasFocus;
      clearVisible.value = ctrl.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => TextField(
          controller: ctrl,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: AppString.usernameInput,
            prefixIcon: const Icon(Icons.person),
            suffix: Visibility(
              visible: focus.value && clearVisible.value,
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                onTap: onClear,
                child: const Icon(Icons.clear, size: 15),
              ),
            ),
          ),
          textInputAction: TextInputAction.next,
          maxLength: 11,
          keyboardType: TextInputType.number,
          onChanged: (str) => {clearVisible.value = str.isNotEmpty},
          // onSubmitted: (_) => KeyboardUtils.hideKeyboard(context)
        ));
  }
}

class VerifyTextField extends StatelessWidget {
  final TextEditingController ctrl;
  final Function() onSend;
  final ValueChanged<String>? onSubmitted;

  const VerifyTextField(
    this.ctrl, {
    super.key,
    required this.onSend,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: ctrl,
        decoration: InputDecoration(
            hintText: AppString.verifyInput,
            hintStyle: const TextStyle(
              height: 1.5,
            ),
            prefixIcon: const Icon(Icons.verified),
            suffix: Ink(
              decoration: const BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                onTap: onSend,
                child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(AppString.verifyGet)),
              ),
            )),
        textInputAction: TextInputAction.next,
        maxLength: 6,
        keyboardType: TextInputType.number,
        onSubmitted: onSubmitted);
  }
}

class PasswordTextFieldIOS extends StatelessWidget {
  final TextEditingController ctrl;
  final String hint;
  final IconData? prefixIcon;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;
  final Rx<bool> passwordVisible = false.obs;
  final FocusNode focusNode = FocusNode();
  late final Rx<bool> focus = false.obs;

  PasswordTextFieldIOS(
    this.ctrl, {
    super.key,
    required this.hint,
    required this.prefixIcon,
    this.onSubmitted,
    this.textInputAction,
  }) {
    focusNode.addListener(() {
      focus.value = focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => CupertinoTextField(
        controller: ctrl,
        focusNode: focusNode,
        placeholder: hint,
        prefix: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(prefixIcon),
        ),
        suffix: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            onTap: () => {passwordVisible.value = !passwordVisible.value},
            child: const Icon(Icons.remove_red_eye_rounded,
                color: Colors.grey, size: 15),
          ),
        ),
        suffixMode: OverlayVisibilityMode.editing,
        obscureText: !focus.value || !passwordVisible.value,
        textInputAction: textInputAction,
        maxLength: 10,
        keyboardType: TextInputType.visiblePassword,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]|[0-9]"))
        ],
        onSubmitted: onSubmitted));
  }
}

class UsernameTextFieldIOS extends StatelessWidget {
  final TextEditingController ctrl;

  const UsernameTextFieldIOS(
    this.ctrl, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: ctrl,
      placeholder: AppString.usernameInput,
      prefix: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.person),
      ),
      clearButtonMode: OverlayVisibilityMode.editing,
      textInputAction: TextInputAction.next,
      maxLength: 11,
      keyboardType: TextInputType.number,
      // onSubmitted: (_) => KeyboardUtils.hideKeyboard(context)
    );
  }
}

class VerifyTextFieldIOS extends StatelessWidget {
  final TextEditingController ctrl;
  final Function() onSend;
  final ValueChanged<String>? onSubmitted;

  const VerifyTextFieldIOS(
    this.ctrl, {
    super.key,
    required this.onSend,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
        controller: ctrl,
        placeholder: AppString.verifyInput,
        prefix: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.verified),
        ),
        suffix: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            onTap: onSend,
            child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(AppString.verifyGet)),
          ),
        ),
        textInputAction: TextInputAction.next,
        maxLength: 4,
        keyboardType: TextInputType.number,
        onSubmitted: onSubmitted);
  }
}
