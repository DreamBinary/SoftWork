import 'package:flutter/material.dart';

import '../../component/mytopbar.dart';
import '../../theme/app_string.dart';
import '../../theme/app_text_theme.dart';

class UseClausePage extends StatefulWidget {
  const UseClausePage({super.key});

  @override
  State<StatefulWidget> createState() => _UseClausePageState();
}

class _UseClausePageState extends State<UseClausePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTopBar(
        middle: Text(
          AppString.useClause,
          style: AppTS.topBarTitle.copyWith(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text.rich(
            TextSpan(
                text:
                "欢迎您使用种花家，以下是使用条款内容，请仔细阅读。\n",
                style: AppTS.textTitle,
                children: [
                  TextSpan(text: "一、", children: [
                    TextSpan(
                        text:
                        "保护用户个人信息是一项基本原则，我们将会采取合理的措施保护用户的个人信息。除法律法规规定的情形外，未经用户许可我们不会向第三方公开、透漏个人信息。APP对相关信息采用专业加密存储与传输方式，保障用户个人信息安全，如果您选择同意使用APP软件，即表示您认可并接受APP服务条款及其可能随时更新的内容。\n",
                        style: AppTS.textBody)
                  ]),
                  TextSpan(text: "二、", children: [
                    TextSpan(
                        text:
                        "我们将会使用您的以下功能：喇叭、WIFI网络、蜂窝通信网络、手机基站数据、SD卡、短信控制。如果您禁止APP使用以上相关服务和功能，您将自行承担不能获得或享用APP相应服务的后果。\n",
                        style: AppTS.textBody)
                  ]),
                  TextSpan(text: "三、", children: [
                    TextSpan(
                        text:
                        "为了提供更好的客户服务，基于技术必要性收集一些有关设备级别事件（例如崩溃）的信息，但这些信息并不能够让我们识别您的身份。\n",
                        style: AppTS.textBody)
                  ]),
                  TextSpan(text: "四、", children: [
                    TextSpan(
                        text:
                        "由于您的自身行为或不可抗力等情形，导致上述可能涉及您隐私或您认为是私人信息的内容发生被泄露、批漏，或被第三方获取、使用、转让等情形的，均由您自行承担不利后果，我们对此不承担任何责任。\n",
                        style: AppTS.textBody)
                  ]),
                  TextSpan(text: "五、", children: [
                    TextSpan(text: "我们拥有对上述条款的最终解释权。\n",
                        style: AppTS.textBody)
                  ]),
                ]),
          ),
        ),
      ),
    );
  }
}
