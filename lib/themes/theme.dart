import 'package:flutter/material.dart';

import 'colors.dart';

extension CustomTextStyles on TextTheme {

  TextStyle get xlargerBoldRed => const TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    fontSize: 30,
  );

  TextStyle get xlargerBoldBlack => const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 30,
  );

  TextStyle get boldRed => const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.red,
    fontSize: 18,
  );

  TextStyle get largeBoldRed => const TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );

  TextStyle get largerBold => const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );

  TextStyle get large => const TextStyle(
    fontSize: 22,
  );

  TextStyle get largeBold => const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );

  TextStyle get largeLineThrough => const TextStyle(
    decoration: TextDecoration.lineThrough,
    fontSize: 22,
  );

  TextStyle get verySmallLineThrough => const TextStyle(
    decoration: TextDecoration.lineThrough,
    fontSize: 14,
  );

  TextStyle get largeWhite => const TextStyle(
    color: Colors.white,
    fontSize: 22,
  );

  TextStyle get largeBoldWhite => const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );

  TextStyle get smallerVerySmallWhite => const TextStyle(
    color: Colors.white,
    fontSize: 12,
  );

  TextStyle get verySmallWhite => const TextStyle(
    color: Colors.white,
    fontSize: 14,
  );

  TextStyle get smallWhite => const TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  TextStyle get smallBoldWhite => const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 16,
  );

  TextStyle get normalWhite => const TextStyle(
    color: Colors.white,
    fontSize: 18,
  );

  TextStyle get normalBoldWhite => const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 18,
  );

  TextStyle get largeGreen => const TextStyle(
    color: Colors.green,
    fontSize: 22,
  );

  TextStyle get largeBoldGreen => const TextStyle(
    color: Colors.green,
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );

  TextStyle get smallerVerySmallGreen => const TextStyle(
    color: Colors.green,
    fontSize: 12,
  );

  TextStyle get verySmallGreen => const TextStyle(
    color: Colors.green,
    fontSize: 14,
  );

  TextStyle get smallGreen => const TextStyle(
    color: Colors.green,
    fontSize: 16,
  );

  TextStyle get smallBoldGreen => const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.green,
    fontSize: 16,
  );

  TextStyle get normalGreen => const TextStyle(
    color: Colors.green,
    fontSize: 18,
  );

  TextStyle get normalBoldGreen => const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.green,
    fontSize: 18,
  );

  TextStyle get small => const TextStyle(
    fontSize: 16,
  );

  TextStyle get normal => const TextStyle(
    fontSize: 18,
  );

  TextStyle get normalBold => const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );


  TextStyle get normalBoldAccent => const TextStyle(
    fontWeight: FontWeight.bold,
    color: colorAccent,
    fontSize: 18,
  );

  TextStyle get largerNormalGrey => const TextStyle(
    color: Colors.grey,
    fontSize: 20,
  );

  TextStyle get normalGrey => const TextStyle(
    color: Colors.grey,
    fontSize: 18,
  );

  TextStyle get smallGrey => const TextStyle(
    color: Colors.grey,
    fontSize: 16,
  );

  TextStyle get smallBold => const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  TextStyle get largeBlue => const TextStyle(
    color: Colors.blue,
    fontSize: 22,
  );

  TextStyle get largeBoldBlue => const TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );

  TextStyle get normalBlue => const TextStyle(
    color: Colors.blue,
    fontSize: 18,
  );

  TextStyle get normalBoldBlue => const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.blue,
    fontSize: 18,
  );

  TextStyle get verySmallBlack => const TextStyle(
    color: Colors.black,
    fontSize: 12,
  );

  TextStyle get verySmallBoldBlack => const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 12,
  );

  TextStyle get smallerBlack => const TextStyle(
    color: Colors.black,
    fontSize: 14,
  );

  TextStyle get smallerBoldBlack => const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 14,
  );


  TextStyle get smallBlack => const TextStyle(
    color: Colors.black,
    fontSize: 16,
  );

  TextStyle get smallBoldBlack => const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 16,
  );

  TextStyle get normalBlack => const TextStyle(
    color: Colors.black,
    fontSize: 18,
  );

  TextStyle get boldBlack => const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 18,
  );

  TextStyle get largerNormalBlack => const TextStyle(
    color: Colors.black,
    fontSize: 20,
  );

  TextStyle get largerNormalBoldBlack => const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  TextStyle get normalBoldBlack => const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  TextStyle get normalBoldBlackThrough => const TextStyle(
    color: Colors.black,
    decoration: TextDecoration.lineThrough,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  TextStyle get largeBlack => const TextStyle(
    color: Colors.black,
    fontSize: 22,
  );

  TextStyle get largeBoldBlack => const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );

  TextStyle get largerBoldBlack => const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );

  TextStyle get smallOrange => const TextStyle(
    color: Colors.orange,
    fontSize: 16,
  );

  TextStyle get normalOrange => const TextStyle(
    color: Colors.orange,
    fontSize: 18,
  );

  TextStyle get boldOrange => const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.orange,
    fontSize: 18,
  );

  TextStyle get largerNormalOrange => const TextStyle(
    color: Colors.orange,
    fontSize: 20,
  );

  TextStyle get normalBoldOrange => const TextStyle(
    color: Colors.orange,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  TextStyle get largeOrange => const TextStyle(
    color: Colors.orange,
    fontSize: 22,
  );

  TextStyle get largeBoldOrange => const TextStyle(
    color: Colors.orange,
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );

  TextStyle get largerBoldOrange => const TextStyle(
    color: Colors.orange,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );

  BoxDecoration get boxDecorationExpandableWhite => const BoxDecoration(
    color: Colors.white,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    boxShadow: [
      BoxShadow(
        color: Colors.grey,
      ),
    ],
  );

  BoxDecoration get boxDecorationExpandablePrimary => const BoxDecoration(
    color: colorPrimary,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    boxShadow: [
      BoxShadow(
        color: Colors.grey,
      ),
    ],
  );
}
