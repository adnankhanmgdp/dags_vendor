import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/image_res.dart';

Widget appImage(
    {String imagePath = ImageRes.idIcon,
    double width = 16,
    double height = 16}) {
  return Image.asset(
    imagePath,
    width: width,
    height: height,
  );
}

Widget appImageWithColor(
    {String imagePath = ImageRes.idIcon,
    double width = 16,
    double height = 16,
    Color imageColor = Colors.white}) {
  return Image.asset(
    imagePath,
    width: width,
    height: height,
    color: imageColor,
  );
}

Widget circularProfileImage(
    {double radius = 80,
    String imagePath =
        "https://as2.ftcdn.net/v2/jpg/00/89/55/15/1000_F_89551596_LdHAZRwz3i4EM4J0NHNHy2hEUYDfXc0j.jpg"}) {
  return Center(
    child: Container(
      child: CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(
          imagePath,
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Color.fromARGB(255, 0, 7, 112),
          width: 3.0,
        ),
      ),
    ),
  );
}
