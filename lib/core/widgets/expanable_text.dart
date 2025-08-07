import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({
    super.key,
    required this.text,
    this.fontSize,
    this.color = AppColors.grey,
    this.maxLines = 3,
    this.expandText = "Show more",
    this.collapseText = "Show less",
  });

  final String text;
  final double? fontSize;
  final Color color;
  final int maxLines;
  final String expandText;
  final String collapseText;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;
  bool _hasOverflow = false;
  late TextSpan _textSpan;
  late TextPainter _textPainter;
  double? _lastMaxWidth;

  @override
  void initState() {
    super.initState();
    _initializeTextPainter();
  }

  @override
  void didUpdateWidget(ExpandableText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text ||
        oldWidget.fontSize != widget.fontSize ||
        oldWidget.color != widget.color) {
      _initializeTextPainter();
    }
  }

  void _initializeTextPainter() {
    final fontSize = (widget.fontSize ?? 14).clamp(8.0, double.infinity);
    _textSpan = TextSpan(
      text: widget.text,
      style: getRegularStyle(
        fontSize: fontSize,
        color: widget.color,
      ),
    );
    _textPainter = TextPainter(
      text: _textSpan,
      textDirection: TextDirection.ltr,
      maxLines: widget.maxLines,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _checkOverflow();
    });
  }

  void _checkOverflow() {
    final maxWidth = MediaQuery.of(context).size.width - 32;
    if (_lastMaxWidth == maxWidth) return; // Only recalc if width changed
    _lastMaxWidth = maxWidth;
    _textPainter.layout(maxWidth: maxWidth);
    final hasOverflow = _textPainter.didExceedMaxLines;
    if (hasOverflow != _hasOverflow && mounted) {
      setState(() {
        _hasOverflow = hasOverflow;
      });
    }
  }

  void _toggleExpanded() {
    if (mounted) {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = (widget.fontSize ?? 14).clamp(8.0, double.infinity);
    if (!_hasOverflow) {
      return Text(
        widget.text,
        style: getRegularStyle(
          fontSize: fontSize,
          color: widget.color,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: getRegularStyle(
            fontSize: fontSize,
            color: widget.color,
          ),
          maxLines: _isExpanded ? null : widget.maxLines,
          overflow: _isExpanded ? null : TextOverflow.ellipsis,
        ),
        SizedBox(height: 4.h),
        GestureDetector(
          onTap: _toggleExpanded,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _isExpanded ? widget.collapseText : widget.expandText,
                style: getLightStyle(
                  fontSize: (fontSize - 1).clamp(8.0, double.infinity),
                  color: AppColors.mainBlue,
                ),
              ),
              SizedBox(width: 4.w),
              Icon(
                _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: AppColors.mainBlue,
                size: fontSize + 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
