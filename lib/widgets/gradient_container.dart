import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GradientContainer extends StatelessWidget {
  final String title;
  final String value;
  const GradientContainer({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.sp),
      decoration: BoxDecoration(
        //Applying Gradient
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            const Color.fromARGB(255, 148, 206, 253)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.white),
            ),
            Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white, fontSize: 20.sp),
            ),
          ],
        ),
      ),
    );
  }
}
