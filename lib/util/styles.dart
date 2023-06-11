import 'package:flutter/material.dart';
import 'package:get/get.dart';

const robotoRegular = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w400,
);

const robotoMedium = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
);

const robotoBold = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w700,
);

const robotoBlack = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w900,
);


const poppinsRegular = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w400,
);

const poppinsMedium = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
);

const poppinsBold = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w700,
);

const poppinsBlack = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w900,
);


const DMSansRegular = TextStyle(
  fontFamily: 'DMSans',
  fontWeight: FontWeight.w400,
);

const DMSansMedium = TextStyle(
  fontFamily: 'DMSans',
  fontWeight: FontWeight.w600,
);

const DMSansBold = TextStyle(
  fontFamily: 'DMSans',
  fontWeight: FontWeight.w700,
);

//card boxShadow
List<BoxShadow> cardShadow = Get.isDarkMode? null:[BoxShadow(
  offset: Offset(0, 1),
  blurRadius: 2,
  color: Colors.black.withOpacity(0.15),
)];
