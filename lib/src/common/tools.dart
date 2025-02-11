import 'package:flutter/material.dart';

class FLThemeColors {
  static const String primaryColor = 'primaryColor';
  static const String primaryColorLight = 'primaryColorLight';
  static const String primaryColorDark = 'primaryColorDark';
  static const String accentColor = 'accentColor';
  static const String canvasColor = 'canvasColor';
  static const String scaffoldBackgroundColor = 'scaffoldBackgroundColor';
  static const String bottomAppBarColor = 'bottomAppBarColor';
  static const String cardColor = 'cardColor';
  static const String dividerColor = 'dividerColor';
  static const String focusColor = 'focusColor';
  static const String hoverColor = 'hoverColor';
  static const String highlightColor = 'highlightColor';
  static const String splashColor = 'splashColor';
  static const String selectedRowColor = 'selectedRowColor';
  static const String unselectedWidgetColor = 'unselectedWidgetColor';
  static const String disabledColor = 'disabledColor';
  static const String buttonColor = 'buttonColor';
  static const String secondaryHeaderColor = 'secondaryHeaderColor';
  static const String textSelectionColor = 'textSelectionColor';
  static const String cursorColor = 'cursorColor';
  static const String textSelectionHandleColor = 'textSelectionHandleColor';
  static const String backgroundColor = 'backgroundColor';
  static const String dialogBackgroundColor = 'dialogBackgroundColor';
  static const String indicatorColor = 'indicatorColor';
  static const String hintColor = 'hintColor';
  static const String errorColor = 'errorColor';
  static const String toggleableActiveColor = 'toggleableActiveColor';
}

class FLThemeTextStyles {
  static const String display4 = 'display4';
  static const String headline1 = 'headline1';
  static const String display3 = 'display3';
  static const String headline2 = 'headline2';
  static const String display2 = 'display2';
  static const String headline3 = 'headline3';
  static const String display1 = 'display1';
  static const String headline4 = 'headline4';
  static const String headline = 'headline';
  static const String headline5 = 'headline5';
  static const String title = 'title';
  static const String headline6 = 'headline6';
  static const String subhead = 'subhead';
  static const String subtitle1 = 'subtitle1';
  static const String body2 = 'body2';
  static const String bodyText1 = 'bodyText1';
  static const String body1 = 'body1';
  static const String bodyText2 = 'bodyText2';
  static const String caption = 'caption';
  static const String button = 'button';
  static const String subtitle = 'subtitle';
  static const String subtitle2 = 'subtitle2';
  static const String overline = 'overline';
}

class FLThemeTool {
  static Color? parseColor(String? colorStr, BuildContext ctx) {
    if (colorStr == null) return null;
    if (colorStr.startsWith('@theme')) {
      // built in theme pattern like '@theme.primaryColor'.
      var descriptor = colorStr.split('.').last;
      ThemeData theme = Theme.of(ctx);
      switch (descriptor) {
        case FLThemeColors.primaryColor:
          return theme.primaryColor;
        case FLThemeColors.primaryColorLight:
          return theme.primaryColorLight;
        case FLThemeColors.primaryColorDark:
          return theme.primaryColorDark;
        case FLThemeColors.accentColor:
          return theme.colorScheme.secondary;
        case FLThemeColors.canvasColor:
          return theme.canvasColor;
        case FLThemeColors.scaffoldBackgroundColor:
          return theme.scaffoldBackgroundColor;
        case FLThemeColors.cardColor:
          return theme.cardColor;
        case FLThemeColors.dividerColor:
          return theme.dividerColor;
        case FLThemeColors.focusColor:
          return theme.focusColor;
        case FLThemeColors.hoverColor:
          return theme.hoverColor;
        case FLThemeColors.highlightColor:
          return theme.highlightColor;
        case FLThemeColors.splashColor:
          return theme.splashColor;
        case FLThemeColors.unselectedWidgetColor:
          return theme.unselectedWidgetColor;
        case FLThemeColors.disabledColor:
          return theme.disabledColor;
        case FLThemeColors.secondaryHeaderColor:
          return theme.secondaryHeaderColor;
        case FLThemeColors.textSelectionColor:
          return theme.textSelectionTheme.selectionColor;
        case FLThemeColors.cursorColor:
          return theme.textSelectionTheme.cursorColor;
        case FLThemeColors.textSelectionHandleColor:
          return theme.textSelectionTheme.selectionHandleColor;
        case FLThemeColors.dialogBackgroundColor:
          return theme.dialogBackgroundColor;
        case FLThemeColors.indicatorColor:
          return theme.indicatorColor;
        case FLThemeColors.hintColor:
          return theme.hintColor;
        default:
          return null;
      }
    } else {
      return Color(num.parse(colorStr) as int);
    }
  }

  static TextStyle? parseTextStyle(String themeStyle, BuildContext ctx) {
    if (themeStyle.startsWith('@textTheme')) {
      var descriptor = themeStyle.split('.').last;
      TextTheme textTheme = Theme.of(ctx).textTheme;
      switch (descriptor) {
        case FLThemeTextStyles.display4:
        case FLThemeTextStyles.headline1:
          return textTheme.displayLarge;
        case FLThemeTextStyles.display3:
        case FLThemeTextStyles.headline2:
          return textTheme.displayMedium;
        case FLThemeTextStyles.display2:
        case FLThemeTextStyles.headline3:
          return textTheme.displaySmall;
        case FLThemeTextStyles.display1:
        case FLThemeTextStyles.headline4:
          return textTheme.headlineMedium;
        case FLThemeTextStyles.headline:
        case FLThemeTextStyles.headline5:
          return textTheme.headlineSmall;
        case FLThemeTextStyles.title:
        case FLThemeTextStyles.headline6:
          return textTheme.titleLarge;
        case FLThemeTextStyles.subhead:
        case FLThemeTextStyles.subtitle1:
          return textTheme.titleMedium;
        case FLThemeTextStyles.body2:
        case FLThemeTextStyles.bodyText1:
          return textTheme.bodyLarge;
        case FLThemeTextStyles.body1:
        case FLThemeTextStyles.bodyText2:
          return textTheme.bodyMedium;
        case FLThemeTextStyles.caption:
          return textTheme.bodySmall;
        case FLThemeTextStyles.button:
          return textTheme.labelLarge;
        case FLThemeTextStyles.subtitle:
        case FLThemeTextStyles.subtitle2:
          return textTheme.titleSmall;
        case FLThemeTextStyles.overline:
          return textTheme.labelSmall;
        default:
          return null;
      }
    } else {
      return null;
    }
  }
}
