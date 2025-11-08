import 'package:flutter/material.dart';

// Modern Medical Theme Colors - Professional and Trustworthy
class LightThemeColors
{
  // PRIMARY - Medical Blue
  static const Color primaryColor = Color(0xFF0D47A1); // Deep Professional Blue
  static const Color primaryLight = Color(0xFF5472D3);
  static const Color primaryDark = Color(0xFF002171);

  // SECONDARY COLOR - Health Green
  static const Color accentColor = Color(0xFF00C853); // Fresh Medical Green
  static const Color accentLight = Color(0xFF5EFC82);
  static const Color accentDark = Color(0xFF009624);

  //APPBAR
  static const Color appBarColor = primaryColor;

  //SCAFFOLD
  static const Color scaffoldBackgroundColor = Color(0xFFF5F7FA); // Soft Grey Background
  static const Color backgroundColor = Colors.white;
  static const Color dividerColor = Color(0xFFE0E0E0);
  static const Color cardColor = Colors.white;
  static const Color cardShadowColor = Color(0x1A000000);

  //ICONS
  static const Color appBarIconsColor = Colors.white;
  static const Color iconColor = Color(0xFF424242);
  static const Color iconColorLight = Color(0xFF757575);

  //BUTTON
  static const Color buttonColor = primaryColor;
  static const Color buttonTextColor = Colors.white;
  static const Color buttonDisabledColor = Color(0xFFBDBDBD);
  static const Color buttonDisabledTextColor = Color(0xFF757575);

  //TEXT
  static const Color bodyTextColor = Color(0xFF212121);
  static const Color displayTextColor = Color(0xFF1A1A1A);
  static const Color bodySmallTextColor = Color(0xFF757575);
  static const Color hintTextColor = Color(0xFF9E9E9E);

  //chip
  static const Color chipBackground = Color(0xFFE3F2FD);
  static const Color chipTextColor = primaryColor;

  // progress bar indicator
  static const Color progressIndicatorColor = accentColor;

  // list tile
  static const Color listTileTitleColor = Color(0xFF212121);
  static const Color listTileSubtitleColor = Color(0xFF757575);
  static const Color listTileBackgroundColor = Colors.white;
  static const Color listTileIconColor = Color(0xFF616161);

  // Status Colors
  static const Color successColor = Color(0xFF4CAF50);
  static const Color warningColor = Color(0xFFFFA726);
  static const Color errorColor = Color(0xFFEF5350);
  static const Color infoColor = Color(0xFF42A5F5);

  // Prescription Status Colors
  static const Color statusPending = Color(0xFFFF9800);
  static const Color statusApproved = Color(0xFF4CAF50);
  static const Color statusRejected = Color(0xFFF44336);
  static const Color statusDelivered = Color(0xFF2196F3);

  //------------------- custom theme (extensions) ------------------- //
  // header containers
  static const Color headerContainerBackgroundColor = primaryColor;
  static const Color headerContainerGradientStart = primaryColor;
  static const Color headerContainerGradientEnd = primaryLight;

  // beneficiary/employee list item
  static const Color employeeListItemBackgroundColor = Colors.white;
  static const Color employeeListItemNameColor = Color(0xFF212121);
  static const Color employeeListItemSubtitleColor = Color(0xFF757575);
  static const Color employeeListItemIconsColor = primaryColor;
}