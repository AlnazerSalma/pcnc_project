// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class Custombutton extends StatelessWidget {
//   final VoidCallback onPressed;
//   final String text;

//   const Custombutton({
//     super.key,
//     required this.onPressed,
//     required this.text,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.6),
//         elevation: 5,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.r),
//         ),
//         padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
//       ),
//       onPressed: onPressed,
//       child: Text(
//         text,
//         style: TextStyle(
//           fontSize: 14.sp,
//           color: Theme.of(context).colorScheme.surface,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.6),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}
