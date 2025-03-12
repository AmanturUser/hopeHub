import 'package:flutter/material.dart';
import 'package:hope_hub/core/style/app_colors.dart';
class CustomAlertDialog extends StatelessWidget {
  final Color bgColor;
  final String title;
  final String message;
  final String positiveBtnText;
  final String negativeBtnText;
  final Function onPostivePressed;
  final Function onNegativePressed;
  final double circularBorderRadius;

  CustomAlertDialog({
    required this.title,
    required this.message,
    this.circularBorderRadius = 15.0,
    this.bgColor = Colors.white,
    required this.positiveBtnText,
    required this.negativeBtnText,
    required this.onPostivePressed,
    required this.onNegativePressed,
  })  : assert(bgColor != null),
        assert(circularBorderRadius != null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null ? Text(title) : null,
      content: message != null ? Text(message) : null,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius)),
      actions: <Widget>[
        if (negativeBtnText != null) TextButton(
          child: Text(negativeBtnText,style: const TextStyle(color:AppColors.mainGreen),),
          onPressed: () {
            Navigator.of(context).pop();
            if (onNegativePressed != null) {
              onNegativePressed();
            }
          },
        ),
        if (positiveBtnText != null) TextButton(
          child: Text(positiveBtnText,style: const TextStyle(color: Colors.red),),
          onPressed: () {
            if (onPostivePressed != null) {
              onPostivePressed();
            }
          },
        ),
      ],
    );
  }
}