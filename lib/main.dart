import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/main_controller.dart';
import 'package:untitled/data/iptv_bean.dart';
import 'package:untitled/data/source/iptv_loader.dart';
import 'package:untitled/data/source/local_iptv_loader.dart';
import 'package:untitled/widget/tv_list_widget.dart';
import 'package:untitled/widget/tv_play_widget.dart';

import 'focuse_item.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GetInstance().lazyPut(() => MainController(), fenix: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
      },
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final IptvLoader loader = LocalIptvLoader();
    loader.loadIptv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Obx(() {
              var data = Get.find<MainController>().playData.value;
              if (data == null) {
                return const SizedBox.shrink();
              }
              return TvPlayWidget(
                playData: data,
                key: ValueKey(data.playUrl),
              );
            }),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Obx(() {
              var data = Get.find<MainController>().iptvData.value;
              return TvListWidget(
                  data: data,
                  onSelect: (IptvBean value) {
                    Get.find<MainController>().setPlayInfo(value);
                  });
            }),
          ),
        ],
      ),
    );
  }
}

extension ExtWidget on Widget {
  Widget focusItem(Function()? onTap) {
    return FocusItem(onTap: onTap, child: this);
  }
}
