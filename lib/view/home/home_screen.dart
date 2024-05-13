import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_flutter/model/weather_data.dart';
import 'package:weather_app_flutter/resources/app_color.dart';
import 'package:weather_app_flutter/resources/app_images.dart';
import 'package:weather_app_flutter/view/home/controller/home_screen_controller.dart';
import 'package:weather_app_flutter/view/splash/splash_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomescreenController controller = Get.put(HomescreenController());

  @override
  Widget build(BuildContext context) {
    controller.isLocationBlank.value
        ? controller.getWeatherUsingLatLon()
        : controller.getWeatherUsingLocation();
    var date = DateFormat("yMMMMd").format(DateTime.now());
    var theme = Theme.of(context);

    return Obx(() => Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: TextField(
              onChanged: controller.onSearchTextChanged,
              decoration: InputDecoration(
                hintText: 'Search Location...',
                labelText: controller.isLocationBlank.value
                    ? ""
                    : controller.searchLocation.value,
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
                onTap: controller.search,
                child: Text(
                  controller.isLocationBlank.value ? "Save" : "Update",
                  style: TextStyle(
                    fontSize: 18.0.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(width: 16.0.w),
              GestureDetector(
                onTap: () {
                  Get.to(() => const SplashScreen());
                },
                child: Text(
                  "Help",
                  style: TextStyle(
                    fontSize: 18.0.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(width: 10.0.w),
            ],
          ),
          body: controller.isError.value
              ? const Center(
                  child: Text("Please try again."),
                )
              : controller.isLoaded.value
                  ? SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
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
                              ),
                            ),
                            child: FutureBuilder(
                              future: controller.isLocationBlank.value
                                  ? controller.getWeatherUsingLatLon()
                                  : controller.getWeatherUsingLocation(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  WeatherData data = snapshot.data;
                                  return SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0.h),
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
                                            var iconsList = [
                                              clouds,
                                              humidity,
                                              windspeed
                                            ];
                                            var key = [
                                              "Clouds",
                                              "Humidity",
                                              "Windspeed"
                                            ];
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
                                                        .withOpacity(0.8),
                                                  ),
                                                ),
                                                Text(
                                                  key[index],
                                                  style: TextStyle(
                                                    fontSize: 18.0.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                        ),
                                        SizedBox(height: 15.0.h),
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
                          ),
                          SizedBox(height: 30.0.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(3, (index) {
                              List<String> tempKey = [
                                "Min Temperature",
                                "Feels Like",
                                "Max Temperature"
                              ];
                              List tempValue = [
                                "${controller.minTemp}°",
                                "${controller.feelsLike}°",
                                "${controller.maxTemp}°"
                              ];
                              return Column(children: [
                                Text(
                                  tempKey[index],
                                  style: TextStyle(
                                    fontSize: 18.0.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(0.8),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  tempValue[index],
                                  style: TextStyle(
                                    fontSize: 24.0.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ),
                              ]);
                            }),
                          ),
                          SizedBox(height: 20.0.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(2, (index) {
                              List key = ["Latitude", "Longitude"];
                              List value = [
                                "${controller.lat.value}",
                                "${controller.lon.value}"
                              ];
                              return Column(
                                children: [
                                  Text(
                                    key[index],
                                    style: TextStyle(
                                      fontSize: 18.0.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.8),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    value[index],
                                    style: TextStyle(
                                      fontSize: 22.0.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          )
                        ],
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
        ));
  }
}
