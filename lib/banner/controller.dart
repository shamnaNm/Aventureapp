
import 'package:get/get.dart';
class MyController extends GetxController{
  static MyController get instance => Get.find();
  final carousalCurrentIndex= 0.obs;
  void updatePageIndicator(index){
    carousalCurrentIndex.value=index;
  }
}