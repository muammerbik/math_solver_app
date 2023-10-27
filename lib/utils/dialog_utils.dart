import 'package:flutter/cupertino.dart';
import 'package:math_solver_app/utils/text_utils.dart';

class DialogUtils {
  static void showCupertinoActionSheet(BuildContext context,
      VoidCallback cameraTapped, VoidCallback galleryTapped) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: TextUtils.buildTextWidget(
            "Add math problem",
            13,
            const Color(0x993C3C43),
          ),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: TextUtils.buildTextWidget(
                "Take a picture",
                20,
                const Color(0xFF007AFF),
              ),
              onPressed: () {
                cameraTapped();

                Navigator.of(context).pop();
              },
            ),
            CupertinoActionSheetAction(
              child:TextUtils. buildTextWidget(
                "Upload from photos",
                20,
                const Color(0xFF007AFF),
              ),
              onPressed: () {
                galleryTapped();

                Navigator.pop(context);
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: TextUtils. buildTextWidget(
                "Cencel", 20, const Color(0xFF007AFF), FontWeight.w900),
          ),
        );
      },
    );
  }

}
