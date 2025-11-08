import 'package:flutter/material.dart';

// Modern Medical Theme Colors - Dark Mode
class DarkThemeColors
{
  // PRIMARY - Medical Blue (lighter for dark mode)
  static const Color primaryColor = Color(0xFF64B5F6);
  static const Color primaryLight = Color(0xFF9BE7FF);
  static const Color primaryDark = Color(0xFF2286C3);

  // SECONDARY - Health Green
  static const Color accentColor = Color(0xFF69F0AE);
  static const Color accentLight = Color(0xFF9FFFE0);
  static const Color accentDark = Color(0xFF2BDE7E);

  //Appbar
  static const Color appbarColor = Color(0xFF1E1E1E);

  //SCAFFOLD
  static const Color scaffoldBackgroundColor = Color(0xFF121212);
  static const Color backgroundColor = Color(0xFF1E1E1E);
  static const Color dividerColor = Color(0xFF424242);
  static const Color cardColor = Color(0xFF2C2C2C);
  static const Color cardShadowColor = Color(0x33000000);

  //ICONS
  static const Color appBarIconsColor = Colors.white;
  static const Color iconColor = Color(0xFFE0E0E0);
  static const Color iconColorLight = Color(0xFFBDBDBD);

  //BUTTON
  static const Color buttonColor = primaryColor;
  static const Color buttonTextColor = Color(0xFF121212);
  static const Color buttonDisabledColor = Color(0xFF424242);
  static const Color buttonDisabledTextColor = Color(0xFF757575);

  //TEXT
  static const Color bodyTextColor = Color(0xFFE0E0E0);
  static const Color displayTextColor = Color(0xFFFFFFFF);
  static const Color bodySmallTextColor = Color(0xFFBDBDBD);
  static const Color hintTextColor = Color(0xFF757575);

  //chip
  static const Color chipBackground = Color(0xFF1E3A5F);
  static const Color chipTextColor = primaryColor;

  // progress bar indicator
  static const Color progressIndicatorColor = accentColor;

  // list tile
  static const Color listTileTitleColor = Color(0xFFE0E0E0);
  static const Color listTileSubtitleColor = Color(0xFFBDBDBD);
  static const Color listTileBackgroundColor = Color(0xFF2C2C2C);
  static const Color listTileIconColor = Color(0xFFBDBDBD);

  // Status Colors
  static const Color successColor = Color(0xFF66BB6A);
  static const Color warningColor = Color(0xFFFFB74D);
  static const Color errorColor = Color(0xFFEF5350);
  static const Color infoColor = Color(0xFF42A5F5);

  // Prescription Status Colors
  static const Color statusPending = Color(0xFFFFB74D);
  static const Color statusApproved = Color(0xFF66BB6A);
  static const Color statusRejected = Color(0xFFEF5350);
  static const Color statusDelivered = Color(0xFF42A5F5);

  //------------------- custom theme (extensions) ------------------- //
  // header containers
  static const Color headerContainerBackgroundColor = Color(0xFF1E3A5F);
  static const Color headerContainerGradientStart = Color(0xFF1E3A5F);
  static const Color headerContainerGradientEnd = Color(0xFF2C4A6F);

  // beneficiary/employee list item
  static const Color employeeListItemBackgroundColor = Color(0xFF2C2C2C);
  static const Color employeeListItemNameColor = Color(0xFFE0E0E0);
  static const Color employeeListItemSubtitleColor = Color(0xFFBDBDBD);
  static const Color employeeListItemIconsColor = primaryColor;

}