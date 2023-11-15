import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingPage extends StatelessWidget {
  final Future future;

  const LoadingPage({Key? key, required this.future}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Get.back(result: snapshot.data);
            return const SizedBox();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
