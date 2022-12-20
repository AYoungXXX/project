import 'package:untitled/data/iptv_bean.dart';
import 'package:untitled/data/source/iptv_loader.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;

class LocalIptvLoader implements IptvLoader {
  @override
  Future<List<IptvBean>> loadIptv() async {
    final String iptvSource = await rootBundle.loadString("assets/iptv.txt");
    var iptvList = <IptvBean>[];
    for (var line in iptvSource.split('\n')) {
      if (line.trim().isEmpty) {
        continue;
      }
      print("正在加载:$line");
      var arr = line.split(',');
      iptvList.add(IptvBean(name: arr[0], playUrl: arr[1]));
    }
    return iptvList;
  }
}
