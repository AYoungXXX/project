import 'package:flutter/material.dart';
import 'package:untitled/data/iptv_bean.dart';
import 'package:untitled/widget/focuse_item.dart';

class TvListWidget extends StatefulWidget {
  final List<IptvBean> data;
  final Function(IptvBean value)? onSelect;
  final bool show;

  const TvListWidget(
      {Key? key, required this.data, required this.onSelect, this.show = false})
      : super(key: key);

  @override
  State<TvListWidget> createState() => _TvListWidgetState();
}

class _TvListWidgetState extends State<TvListWidget>
    with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {
  FocusNode? _currentFocus;
  late final AnimationController animController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 400));

  @override
  void didUpdateWidget(TvListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show) {
      animController.forward(from: 0);
    } else {
      animController.reverse(from: 1);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimatedBuilder(
      builder: (BuildContext context, Widget? child) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: Tween(begin: 0.0, end: 180.0).evaluate(animController),
          // width: 240,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.7),
          ),
          child: Transform.translate(
            offset: Tween<Offset>(
                    begin: const Offset(-180, 0), end: const Offset(0, 0))
                .evaluate(animController),
            child: child,
          ),
        );
      },
      animation: animController,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return FocusItem(
            onFocus: (focus) {
              _currentFocus = focus;
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.data[index].name,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            onTap: () {
              print("点击了:$index");
              widget.onSelect?.call(widget.data[index]);
            },
          );
        },
        itemCount: widget.data.length,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
