import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'bubble_menu.dart';

final _kCopyValue = Random();

class FLCopyableLabel extends StatelessWidget {
  const FLCopyableLabel(
      {Key? key,
      required this.copyData,
      this.showMenu = false,
      required this.child,
      this.afterCopyCallback})
      : super(key: key);

  final String copyData;
  final bool showMenu;
  final Widget child;
  final VoidCallback? afterCopyCallback;

  void _performCopyAction() {
    Clipboard.setData(ClipboardData(text: copyData));
    if (afterCopyCallback != null) afterCopyCallback!();
  }

  Widget _buildGestureWidget() {
    return GestureDetector(
      onLongPress: _performCopyAction,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (showMenu) {
      return FLBubbleMenuWidget(
          child: child,
          onSelected: (dynamic value) {
            if (value == _kCopyValue) {
              _performCopyAction();
            }
          },
          itemBuilder: (BuildContext context) {
            return <FLBubbleMenuItem>[
              FLBubbleMenuItem(
                  text: CupertinoLocalizations.of(context).copyButtonLabel,
                  value: _kCopyValue)
            ];
          });
    } else {
      return _buildGestureWidget();
    }
  }
}
