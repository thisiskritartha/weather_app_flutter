import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:weather_app_flutter/resources/app_color.dart';
import 'package:weather_app_flutter/view/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Get.to(() => const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg_img.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "We show weather for you.",
                style: TextStyle(
                  fontSize: 28.0.sp,
                  fontWeight: FontWeight.w900,
                  color: textColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 150.0.h),
              GestureDetector(
                onTap: () {
                  Get.to(const HomeScreen());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 80.0.w,
                    vertical: 10.0.h,
                  ),
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(18.0.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Skip",
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.6.sp,
                        ),
                      ),
                      SizedBox(width: 20.0.w),
                      Icon(
                        Icons.arrow_forward,
                        size: 30.0.r,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
