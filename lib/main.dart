import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/main_controller.dart';
import 'package:untitled/data/iptv_bean.dart';
import 'package:untitled/data/source/iptv_loader.dart';
import 'package:untitled/data/source/local_iptv_loader.dart';
import 'package:untitled/widget/tv_list_widget.dart';
import 'package:untitled/widget/tv_play_widget.dart';

import 'widget/focuse_item.dart';

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
  final MainController controller = Get.find();
  late final FocusNode focusNode = FocusNode(canRequestFocus: false);

  @override
  void initState() {
    super.initState();
    final IptvLoader loader = LocalIptvLoader();
    loader.loadIptv();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        body: KeyboardListener(
          autofocus: true,
          focusNode: focusNode,
          onKeyEvent: (KeyEvent keyEvent) {
            print("接收的事件:$keyEvent");
            if (keyEvent is KeyUpEvent) {
              if (keyEvent.logicalKey.keyId ==
                  LogicalKeyboardKey.goBack.keyId) {
                print("隐藏列表");
                controller.dismissTvList();
              }

              if (keyEvent.logicalKey.keyId ==
                      LogicalKeyboardKey.select.keyId &&
                  controller.tvListShow.isFalse) {
                print("显示列表");
                controller.showTvList();
              }
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                var data = controller.iptvData.value;
                return TvListWidget(
                    show: controller.tvListShow.value,
                    data: data,
                    onSelect: (IptvBean value) {
                      if (controller.tvListShow.isTrue) {
                        Get.find<MainController>().setPlayInfo(value);
                      }
                    });
              }),
              Expanded(
                child: Obx(() {
                  var data = controller.playData.value;
                  if (data == null) {
                    return const SizedBox.shrink();
                  }
                  return TvPlayWidget(
                    playData: data,
                    key: ValueKey(data.playUrl),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension ExtWidget on Widget {
  Widget focusItem(Function()? onTap) {
    return FocusItem(onTap: onTap, child: this);
  }
}
