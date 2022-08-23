//import 'package:wave_flutter/local/app_local.dart';
import 'app_constant.dart';

class AppFonts {
  static const double x_x_x_small_font_size = 8.0;
  static const double x_x_small_font_size = 10.0;
  static const double x_small_font_size = 12.0;
  static const double small_font_size = 14.0;
  static const double medium_font_size = 16.0;
  static const double normal_font_size = 18.0;
  static const double large_font_size = 20.0;
  static const double x_large_font_size = 22.0;
  static const double xx_large_font_size = 24.0;
  static const double xxx_large_font_size = 26.0;
  static const double xxxx_large_font_size = 34.0;
  static const double xxxxx_large_font_size = 46.0;
  static const double most_large_font_size = 72.0;

  static String getFontFamily(String langCode) {
    if (langCode == 'en') {
      return 'Montserrat';
    } else if (langCode == 'ar') {
      return 'Montserrat';
    } else
      return 'Montserrat';
  }

  static double _getScale(context, bool withScreenMeasurement) {
    // final String langCode = AppLocalizations.of(context).locale.languageCode;
    double scale = 1;

    if (withScreenMeasurement) {
      if (AppConstant.screenSize.width <= 350) {
        scale = 0.50;
      } else if (AppConstant.screenSize.width > 350 &&
          AppConstant.screenSize.width <= 400) {
        // iPhone 4 & 5 (480 - 568)
        scale = 0.750;
      } else if (AppConstant.screenSize.width > 400 &&
          AppConstant.screenSize.width <= 620) {
        // iPhone 6 & 7 (667)
        scale = 0.85;
      } else {
        // iPhone 6+ & 7+ (736)
        scale = .95;
      }
    }
    // if (langCode != 'ar') {
    //   scale *= 1;
    // } else if (langCode == 'ar') {
    //   scale *= 0.9;
    // } else
    //   scale = 1;

    return scale;
  }

  static double getMostLarge(context, {bool withScreenMeasurement = true}) {
    return most_large_font_size * _getScale(context, withScreenMeasurement);
  }

  static double getXXXSmallFontSize(context,
      {bool withScreenMeasurement = true}) {
    return x_x_x_small_font_size * _getScale(context, withScreenMeasurement);
  }

  static double getXXSmallFontSize(context,
      {bool withScreenMeasurement = true}) {
    return x_x_small_font_size * _getScale(context, withScreenMeasurement);
  }

  static double getXSmallFontSize(context,
      {bool withScreenMeasurement = true}) {
    return x_small_font_size * _getScale(context, withScreenMeasurement);
  }

  static double getSmallFontSize(context, {bool withScreenMeasurement = true}) {
    return small_font_size * _getScale(context, withScreenMeasurement);
  }

  static double getMediumFontSize(context,
      {bool withScreenMeasurement = true}) {
    return medium_font_size * _getScale(context, withScreenMeasurement);
  }

  static double getNormalFontSize(context,
      {bool withScreenMeasurement = true}) {
    return normal_font_size * _getScale(context, withScreenMeasurement);
  }

  static double getLargeFontSize(context, {bool withScreenMeasurement = true}) {
    return large_font_size * _getScale(context, withScreenMeasurement);
  }

  static double getXLargeFontSize(context,
      {bool withScreenMeasurement = true}) {
    return x_large_font_size * _getScale(context, withScreenMeasurement);
  }

  static double getXXLargeFontSize(context,
      {bool withScreenMeasurement = true}) {
    return xx_large_font_size * _getScale(context, withScreenMeasurement);
  }

  static double getXXXLargeFontSize(context,
      {bool withScreenMeasurement = true}) {
    return xxx_large_font_size * _getScale(context, withScreenMeasurement);
  }

  static double getXXXXLargeFontSize(context,
      {bool withScreenMeasurement = true}) {
    return xxxx_large_font_size * _getScale(context, withScreenMeasurement);
  }

  static double getXXXXXLargeFontSize(context,
      {bool withScreenMeasurement = true}) {
    return xxxxx_large_font_size * _getScale(context, withScreenMeasurement);
  }
}
