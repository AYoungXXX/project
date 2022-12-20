import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class FocusItem extends StatefulWidget {
  final Widget child;
  final Function()? onTap;

  const FocusItem({Key? key, required this.child, this.onTap})
      : super(key: key);

  @override
  State<FocusItem> createState() => _FocusItemState();
}

class _FocusItemState extends State<FocusItem> {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {});
      if (focusNode.hasFocus) {
        // print("当前获取焦点");
        var scrollable = Scrollable.of(context);
        // print("controller=${scrollable}");
        if (scrollable != null) {
          // var visibleArea = scrollable.position.viewportDimension;
          // var curPos = scrollable.position.pixels;
          // // controller.position.ensureVisible(object)
          // // controller.position.context
          // final RenderAbstractViewport viewport =
          //     RenderAbstractViewport.of(context.findRenderObject())!;
          // var rect = viewport.paintBounds;
          scrollable.position.ensureVisible(context.findRenderObject()!,
              alignment: 0.5, duration: const Duration(milliseconds: 200));
          // print("left:${rect.left} top:${rect.top} bottom:${rect.bottom}");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.requestFocus();
      },
      child: RawKeyboardListener(
        onKey: (RawKeyEvent key) {
          var curId = key.logicalKey.keyId;
          var targetId = LogicalKeyboardKey.select.keyId;
          if (curId == targetId && key is RawKeyUpEvent) {
            print("按键详情:${key.logicalKey}");
            widget.onTap?.call();
          }
        },
        focusNode: focusNode,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 400),
          scale: focusNode.hasFocus ? 2.5 : 1.0,
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}
