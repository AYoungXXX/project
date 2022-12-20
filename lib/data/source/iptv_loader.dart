
import '../iptv_bean.dart';

abstract class IptvLoader{
  Future<List<IptvBean>> loadIptv();
}