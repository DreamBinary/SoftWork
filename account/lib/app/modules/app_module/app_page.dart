import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:account/app/modules/app_module/app_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class appPage extends GetView<appController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('app Page')),
      body: Container(
        child: Obx(()=>Container(child: Text(controller.obj),)),
      ),
    );
  }
}
