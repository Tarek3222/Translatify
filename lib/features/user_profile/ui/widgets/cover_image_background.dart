import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoverImageBackground extends StatelessWidget {
  const CoverImageBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://res.cloudinary.com/dns6iddx7/image/upload/v1747299262/Graduation_Project/Users/et8v/Cover/f57wnvvuebqhkha45lmx.jpg",
      height: 200.h,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
