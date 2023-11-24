
import 'package:flutter/material.dart';

import '../../component/mytopbar.dart';
import '../../theme/app_string.dart';
import '../../theme/app_text_theme.dart';

class PrivacyClausePage extends StatefulWidget {
  const PrivacyClausePage({super.key});

  @override
  State<StatefulWidget> createState() => _PrivacyClausePageState();
}

class _PrivacyClausePageState extends State<PrivacyClausePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTopBar(
        middle: Text(
          AppString.privacy,
          style: AppTS.topBarTitle.copyWith(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text.rich(
            TextSpan(
                text:
                    "本应用尊重并保护所有使用服务用户的个人隐私权。在未征得您事先许可的情况下，本应用不会将您的隐私信息对外披露或向第三方提供。\n",
                style: AppTS.textTitle,
                children: [
                  TextSpan(text: "一、适用范围\n", children: [
                    TextSpan(
                        text:
                            "在您使用本应用网络服务时，本应用自动接收并记录的您的浏览器和计算机上的信息，包括但不限于您的IP地址、浏览器的类型、使用的语言、访问日期和时间、软硬件特征信息及您需求的网页记录等数据。\n您了解并同意，以下信息不适用本隐私权政策：",
                        style: AppTS.textBody),
                    TextSpan(text: "1、", style: AppTS.textTitle2, children: [
                      TextSpan(
                          text: "本应用收集到的您在本应用发布的有关信息数据，包括但不限于参与活动、成交信息及评价详情；\n",
                          style: AppTS.textBody)
                    ]),
                    TextSpan(text: "2、", style: AppTS.textTitle2, children: [
                      TextSpan(
                          text: "违反法律规定或违反本应用规则行为及本应用已对您采取的措施\n",
                          style: AppTS.textBody)
                    ]),
                  ]),
                  TextSpan(text: "二、信息使用\n", children: [
                    TextSpan(text: "1、", style: AppTS.textTitle2, children: [
                      TextSpan(
                          text:
                              "本应用不会向任何无关第三方提供、出售、出租、分享或交易您的个人信息，除非事先得到您的许可，或该第三方和本应用单独或共同为您提供服务，且在该服务结束后，其将被禁止访问包括其以前能够访问的所有这些资料。\n",
                          style: AppTS.textBody)
                    ]),
                    TextSpan(text: "2、", style: AppTS.textTitle2, children: [
                      TextSpan(
                          text:
                              "本应用亦不允许任何第三方以任何手段收集、编辑、出售或者无偿传播您的个人信息。任何本应用平台用户如从事上述活动，一经发现，本应用有权立即终止与该用户的服务协议。\n",
                          style: AppTS.textBody)
                    ]),
                  ]),
                  TextSpan(text: "三、信息披露\n", children: [
                    TextSpan(
                        text: "在如下情况下，本应用将依据您的个人意愿或法律的规定全部或部分的披露您的个人信息：\n",
                        style: AppTS.textBody),
                    TextSpan(text: "1、", style: AppTS.textTitle2, children: [
                      TextSpan(text: "经您事先同意，向第三方披露；\n", style: AppTS.textBody)
                    ]),
                    TextSpan(text: "2、", style: AppTS.textTitle2, children: [
                      TextSpan(
                          text: "为提供您所要求的产品和服务，而必须和第三方分享您的个人信息；\n",
                          style: AppTS.textBody)
                    ]),
                    TextSpan(text: "3、", style: AppTS.textTitle2, children: [
                      TextSpan(
                          text: "根据法律的有关规定，或者行政或司法机构的要求，向第三方或者行政、司法机构披露；\n",
                          style: AppTS.textBody)
                    ]),
                    TextSpan(text: "4、", style: AppTS.textTitle2, children: [
                      TextSpan(
                          text: "如您出现违反中国有关法律、法规或者本应用服务协议或相关规则的情况，需要向第三方披露；\n",
                          style: AppTS.textBody)
                    ]),
                    TextSpan(text: "5、", style: AppTS.textTitle2, children: [
                      TextSpan(
                          text:
                              "如您是适格的知识产权投诉人并已提起投诉，应被投诉人要求，向被投诉人披露，以便双方处理可能的权利纠纷；\n",
                          style: AppTS.textBody)
                    ]),
                    TextSpan(text: "6、", style: AppTS.textTitle2, children: [
                      TextSpan(
                          text:
                              "在本应用平台上创建的某一交易中，如交易任何一方履行或部分履行了交易义务并提出信息披露请求的，本应用有权决定向该用户提供其交易对方的联络方式等必要信息，以促成交易的完成或纠纷的解决。\n",
                          style: AppTS.textBody)
                    ]),
                    TextSpan(text: "6、", style: AppTS.textTitle2, children: [
                      TextSpan(
                          text: "本应用根据法律、法规或者网站政策认为合适的披露。\n",
                          style: AppTS.textBody)
                    ]),
                  ]),
                  TextSpan(text: "四、信息存储和交换\n", children: [
                    TextSpan(
                        text:
                            "本应用收集的有关您的信息和资料将保存在本应用的服务器上，这些信息和资料可能传送至您所在国家、地区或本应用收集信息和资料所在地的境外并在境外被访问、存储和展示。\n",
                        style: AppTS.textBody)
                  ]),
                  TextSpan(text: "五、Cookie的使用\n", children: [
                    TextSpan(text: "1、", style: AppTS.textTitle2, children: [
                      TextSpan(
                          text:
                              "在您未拒绝接受cookies的情况下，本应用会在您的计算机上设定或取用cookies ，以便您能登录或使用依赖于cookies的本应用平台服务或功能。本应用使用cookies可为您提供更加周到的个性化服务，包括推广服务。\n",
                          style: AppTS.textBody)
                    ]),
                    TextSpan(text: "2、", style: AppTS.textTitle2, children: [
                      TextSpan(
                          text:
                              "您有权选择接受或拒绝接受cookies。您可以通过修改浏览器设置的方式拒绝接受cookies。但如果您选择拒绝接受cookies，则您可能无法登录或使用依赖于cookies的本应用网络服务或功能。\n",
                          style: AppTS.textBody)
                    ]),
                  ]),
                  TextSpan(text: "六、信息安全\n", children: [
                    TextSpan(text: "1、", style: AppTS.textTitle2, children: [
                      TextSpan(
                          text:
                              "本应用帐号均有安全保护功能，请妥善保管您的用户名及密码信息。本应用将通过对用户密码进行加密等安全措施确保您的信息不丢失，不被滥用和变造。尽管有前述安全措施，但同时也请您注意在信息网络上不存在“完善的安全措施”。\n",
                          style: AppTS.textBody)
                    ]),
                    TextSpan(text: "2、", style: AppTS.textTitle2, children: [
                      TextSpan(
                          text:
                              "在使用本应用网络服务进行网上交易时，您不可避免的要向交易对方或潜在的交易对方提供用户名及密码信息，请您确保对方不会滥用您的信息。\n",
                          style: AppTS.textBody)
                    ]),
                  ]),
                ]),
          ),
        ),
      ),
    );
  }
}
