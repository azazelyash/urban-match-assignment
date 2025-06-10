import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_match_task/common/constants/custom_colors.dart';
import 'package:urban_match_task/common/widgets/custom_button.dart';
import 'package:urban_match_task/common/widgets/custom_dialog.dart';
import 'package:urban_match_task/common/widgets/custom_outlined_button.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.subTitle,
    this.icon,
  });

  final Icon? icon;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      content: Column(
        children: [
          icon ??
              const Icon(
                CupertinoIcons.exclamationmark_circle,
                size: 96,
                color: CustomColors.errorColor,
              ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: CustomColors.textColorLight2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: CustomColors.textColorLight,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  title: "No",
                  onPressed: () {
                    context.pop(false);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomElevatedButton(
                  text: "Yes",
                  onPressed: () {
                    context.pop(true);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
