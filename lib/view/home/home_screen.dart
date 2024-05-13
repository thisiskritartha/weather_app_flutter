import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_flutter/model/weather_data.dart';
import 'package:weather_app_flutter/resources/app_color.dart';
import 'package:weather_app_flutter/resources/app_images.dart';
import 'package:weather_app_flutter/view/home/controller/home_screen_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomescreenController controller = Get.put(HomescreenController());

  @override
  Widget build(BuildContext context) {
    controller.getWeather(27.70, 85.30);
    var date = DateFormat("yMMMMd").format(DateTime.now());
    var theme = Theme.of(context);
    return Scaffold(
        //backgroundColor: theme.scaffoldBackgroundColor,
        backgroundColor: whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TextField(
            onChanged: controller.onSearchTextChanged,
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(
                Icons.search,
                size: 30.0.r,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: null,
              child: Text(
                "Save",
                style: TextStyle(
                  fontSize: 18.0.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: 10.0.w),
          ],
        ),
        body: Obx(
          () => controller.isLoaded.value
              ? Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0.r),
                        bottomRight: Radius.circular(40.0.r),
                      ),
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.grey,
                          width: 3.0.w, 
                        ),
                    )
                  ),
                  child: FutureBuilder(
                    future: controller.getWeather(27.70, 85.30),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        WeatherData data = snapshot.data;

                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                data.name!,
                                style: TextStyle(
                                  fontSize: 40.0.sp,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.6,
                                ),
                              ),
                              Text(
                                date,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0.h),
                                child: Image.asset(
                                  "assets/weather/${data.weather![0].icon}.png",
                                  width: 140.0.w,
                                  height: 140.0.h,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                data.weather![0].main!,
                                style: TextStyle(
                                  fontSize: 28.0.sp,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 2.5,
                                  color: theme.primaryColor,
                                ),
                              ),
                              Text(
                                "${data.main!.temp!}°",
                                style: TextStyle(
                                  fontSize: 80.0.sp,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 2.5,
                                  color: theme.primaryColor,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(3, (index) {
                                  var iconsList = [clouds, humidity, windspeed];
                                  var values = [
                                    "${data.clouds!.all}%",
                                    "${data.main!.humidity}%",
                                    "${data.wind!.speed} km/h"
                                  ];
                                  return Column(
                                    children: [
                                      Image.asset(
                                        iconsList[index],
                                        width: 60,
                                        height: 60,
                                      ),
                                      SizedBox(height: 4.0.h),
                                      Text(
                                        values[index],
                                        style: TextStyle(
                                          fontSize: 18.0.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black
                                              .withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                              
                            ],
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }
}
