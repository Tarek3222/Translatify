import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({
    super.key,
    required this.text,
    this.fontSize,
    this.color = AppColors.grey,
  });
  final String text;
  final double? fontSize;
  final Color color;
  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  String firstHalf = "";
  String secondHalf = "";
  bool hiddenText = true;
  late double textHeight;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final textHeight = ScreenUtil().screenHeight / 5.63;

      if (widget.text.length > textHeight) {
        setState(() {
          firstHalf = widget.text.substring(0, textHeight.toInt());
          secondHalf =
              widget.text.substring(textHeight.toInt() + 1, widget.text.length);
        });
      } else {
        setState(() {
          firstHalf = widget.text;
          secondHalf = "";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return secondHalf.isEmpty
        ? Text(
            firstHalf,
            style: getRegularStyle(
              fontSize: widget.fontSize ?? 14,
              overflow: TextOverflow.visible,
              color: widget.color,
            ),
          )
        : Column(
            children: [
              Text(
                hiddenText ? "$firstHalf..." : "$firstHalf$secondHalf",
                style: getRegularStyle(
                  fontSize: widget.fontSize ?? 14.sp,
                  overflow: TextOverflow.visible,
                  color: widget.color,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    hiddenText = !hiddenText;
                  });
                },
                child: Row(
                  children: [
                    Text(
                      hiddenText ? "Show more" : "Show less",
                      style: getLightStyle(
                        fontSize: widget.fontSize ?? 14.sp,
                        color: AppColors.mainBlue,
                      ),
                    ),
                    Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.mainBlue),
                  ],
                ),
              ),
            ],
          );
  }
}
