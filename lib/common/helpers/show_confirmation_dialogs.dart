import 'package:flutter/material.dart';
import 'package:urban_match_task/common/constants/custom_colors.dart';
import 'package:urban_match_task/common/widgets/confirmation_dialog.dart';

Future<bool?> confirmCloseDialog({
  required BuildContext context,
  String? title,
  String? subTitle,
}) async {
  final res = await showDialog<bool?>(
    context: context,
    builder:
        (context) => ConfirmationDialog(
          title: title ?? "Close this screen?",
          subTitle: subTitle ?? "Any new changes on this screen will be reset",
        ),
  );

  return res;
}

Future<bool?> confirmationDialog({
  required BuildContext context,
  String? title,
  String? subTitle,
}) async {
  final res = await showDialog<bool?>(
    context: context,
    builder:
        (context) => ConfirmationDialog(
          title: title ?? "Close this screen?",
          subTitle: subTitle ?? "Any new changes on this screen will be reset",
          icon: const Icon(
            Icons.warning_amber_rounded,
            size: 96,
            color: CustomColors.warningColor,
          ),
        ),
  );

  return res;
}
