import 'package:flutter/cupertino.dart';
import 'package:math_solver_app/app/constants/colors_constants.dart';
import 'package:math_solver_app/app/constants/text_constants.dart';
import 'package:math_solver_app/app/utils/text_utils.dart';

class DialogUtils {
  static void showCupertinoActionSheet(BuildContext context,
      VoidCallback cameraTapped, VoidCallback galleryTapped) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: TextUtils.buildTextWidget(
              TextContants.addMathProblem, 13, ColorConstants.blackColor),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: TextUtils.buildTextWidget(
                TextContants.takeaPicture,
                20,
                ColorConstants.dialogColor,
              ),
              onPressed: () {
                cameraTapped();

                Navigator.of(context).pop();
              },
            ),
            CupertinoActionSheetAction(
              child: TextUtils.buildTextWidget(
                TextContants.uploadFromPhoto,
                20,
                ColorConstants.dialogColor,
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
            child: TextUtils.buildTextWidget(TextContants.cencel, 20,
                ColorConstants.dialogColor, FontWeight.w900),
          ),
        );
      },
    );
  }
}
