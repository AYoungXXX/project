import 'package:flutter/material.dart';
import 'package:untitled/data/iptv_bean.dart';
import 'package:untitled/focuse_item.dart';

class TvListWidget extends StatefulWidget {
  final List<IptvBean> data;
  final Function(IptvBean value)? onSelect;
  const TvListWidget({Key? key,required this.data,required this.onSelect}) : super(key: key);

  @override
  State<TvListWidget> createState() => _TvListWidgetState();
}

class _TvListWidgetState extends State<TvListWidget> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.7),
      ),
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return FocusItem(
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
}
