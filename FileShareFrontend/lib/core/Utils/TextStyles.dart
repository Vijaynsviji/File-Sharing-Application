import 'package:flutter/material.dart';

import '../../global/models/app_colors.dart';

class AppStyles extends ThemeExtension<AppStyles> {
  final TextStyle header; // screen titles
  final TextStyle secondaryHeader; // app bar / panel titles
  final TextStyle body; // default muted text
  final TextStyle subtitle; // text under a screen title
  final TextStyle label; // section + field labels
  final TextStyle listTitle; // names in lists (users, files)
  final TextStyle input; // text inside text fields
  final TextStyle caption; // small helper text
  final TextStyle micro; // sizes, stat labels, hints
  final TextStyle statValue; // numbers in the stat strip
  final TextStyle statusLabel; // Done / Queued / 64%
  final TextStyle tab; // tab bar items
  final TextStyle link; // Change photo, View, Connect
  final TextStyle buttonPrimary; // text on filled indigo buttons
  final TextStyle buttonSecondary; // ghost buttons (I'll do this later)
  final TextStyle ringValue;
  final TextStyle toast;

  AppStyles({
    required this.header,
    required this.secondaryHeader,
    required this.body,
    required this.subtitle,
    required this.label,
    required this.listTitle,
    required this.input,
    required this.caption,
    required this.micro,
    required this.statValue,
    required this.statusLabel,
    required this.tab,
    required this.link,
    required this.buttonPrimary,
    required this.buttonSecondary,
    required this.ringValue,
    required this.toast,
  });

  factory AppStyles.fromColors(AppColors colors) {
    TextStyle t(
      double size,
      Color? color, {
      FontWeight weight = FontWeight.normal,
      double? height,
    }) => TextStyle(
      fontFamily: 'Poppins',
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
    );

    return AppStyles(
      header: t(24, colors.ink, weight: FontWeight.bold),
      secondaryHeader: t(16, colors.ink, weight: FontWeight.bold),
      body: t(12, colors.sub),
      subtitle: t(13, colors.sub, height: 1.5),
      label: t(12, colors.ink, weight: FontWeight.w700),
      listTitle: t(13.5, colors.ink, weight: FontWeight.w700),
      input: t(13.5, colors.ink),
      caption: t(11, colors.sub),
      micro: t(10.5, colors.sub),
      statValue: t(14, colors.ink, weight: FontWeight.w800),
      statusLabel: t(10.5, colors.sub, weight: FontWeight.w700),
      tab: t(13, colors.sub, weight: FontWeight.w700),
      link: t(12, colors.indigo, weight: FontWeight.w700),
      buttonPrimary: t(14.5, Colors.white, weight: FontWeight.w700),
      buttonSecondary: t(13.5, colors.sub, weight: FontWeight.w600),
      ringValue: t(
        26,
        colors.ink,
        weight: FontWeight.w800,
      ), // big numbers: "80%", connected count
      toast: t(
        13,
        colors.ink,
        weight: FontWeight.w600,
      ), // snackbar / toast messages
    );
  }

  @override
  AppStyles copyWith({
    TextStyle? header,
    TextStyle? secondaryHeader,
    TextStyle? body,
    TextStyle? subtitle,
    TextStyle? label,
    TextStyle? listTitle,
    TextStyle? input,
    TextStyle? caption,
    TextStyle? micro,
    TextStyle? statValue,
    TextStyle? statusLabel,
    TextStyle? tab,
    TextStyle? link,
    TextStyle? buttonPrimary,
    TextStyle? buttonSecondary,
    TextStyle? ringValue,
    TextStyle? toast,
  }) {
    return AppStyles(
      header: header ?? this.header,
      secondaryHeader: secondaryHeader ?? this.secondaryHeader,
      body: body ?? this.body,
      subtitle: subtitle ?? this.subtitle,
      label: label ?? this.label,
      listTitle: listTitle ?? this.listTitle,
      input: input ?? this.input,
      caption: caption ?? this.caption,
      micro: micro ?? this.micro,
      statValue: statValue ?? this.statValue,
      statusLabel: statusLabel ?? this.statusLabel,
      tab: tab ?? this.tab,
      link: link ?? this.link,
      buttonPrimary: buttonPrimary ?? this.buttonPrimary,
      buttonSecondary: buttonSecondary ?? this.buttonSecondary,
      ringValue: ringValue ?? this.ringValue,
      toast: toast ?? this.toast,
    );
  }

  @override
  AppStyles lerp(ThemeExtension<AppStyles>? other, double t) {
    if (other is! AppStyles) return this;
    return AppStyles(
      header: TextStyle.lerp(header, other.header, t)!,
      secondaryHeader: TextStyle.lerp(
        secondaryHeader,
        other.secondaryHeader,
        t,
      )!,
      body: TextStyle.lerp(body, other.body, t)!,
      subtitle: TextStyle.lerp(subtitle, other.subtitle, t)!,
      label: TextStyle.lerp(label, other.label, t)!,
      listTitle: TextStyle.lerp(listTitle, other.listTitle, t)!,
      input: TextStyle.lerp(input, other.input, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
      micro: TextStyle.lerp(micro, other.micro, t)!,
      statValue: TextStyle.lerp(statValue, other.statValue, t)!,
      statusLabel: TextStyle.lerp(statusLabel, other.statusLabel, t)!,
      tab: TextStyle.lerp(tab, other.tab, t)!,
      link: TextStyle.lerp(link, other.link, t)!,
      buttonPrimary: TextStyle.lerp(buttonPrimary, other.buttonPrimary, t)!,
      buttonSecondary: TextStyle.lerp(
        buttonSecondary,
        other.buttonSecondary,
        t,
      )!,
      ringValue: TextStyle.lerp(ringValue, other.ringValue, t)!,
      toast: TextStyle.lerp(toast, other.toast, t)!,
    );
  }
}

extension AppStylesBuildContext on BuildContext {
  AppStyles get styles => Theme.of(this).extension<AppStyles>()!;
}
