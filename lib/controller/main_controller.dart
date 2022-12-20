import 'package:get/get.dart';
import 'package:untitled/data/iptv_bean.dart';
import 'package:untitled/data/source/iptv_loader.dart';
import 'package:untitled/data/source/local_iptv_loader.dart';

class MainController extends GetxController {
  RxList<IptvBean> iptvData = RxList();
  Rxn<IptvBean> playData = Rxn();
  late IptvLoader tvLoader = LocalIptvLoader();

  @override
  void onInit() {
    super.onInit();
    tvLoader.loadIptv().then((value) {
      iptvData.assignAll(value);
      playData.value = iptvData.first;
    });
  }

  void setPlayInfo(IptvBean data) {
    playData.value = data;
  }
}
