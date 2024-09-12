import 'package:flutter/material.dart';

Future<dynamic> customBottomSheet(BuildContext context,
    {required Widget widget,
      ValueGetter? onHide,
      bool dismissible = true,
      bool transparent = false}) async {
  final deviceHeight = MediaQuery.of(context).size.height;
  final notchPadding = MediaQuery.of(context).padding.top;
  final maxHeight = deviceHeight - notchPadding;
  try {
    var response = await showModalBottomSheet(
      context: context,
      barrierColor: transparent ? Colors.black.withAlpha(1) : null,
      isDismissible: dismissible,
      isScrollControlled: true,
      enableDrag: dismissible,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: maxHeight,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (dismissible) ...[
                const SizedBox(height: 20 / 2),
                // const ArrowIndicator()
              ],
              Flexible(
                child: SingleChildScrollView(
                  child: PopScope(
                    canPop: dismissible,
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: widget,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    if (onHide != null) {
      onHide();
    }
    return response;
  } on Exception catch (e) {
    print("Error $e");
    return null;
  }
}