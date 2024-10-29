import 'package:flutter/material.dart';

import '../buttons/toogle_theme_btn.dart';

PreferredSizeWidget myAppBar({Widget? title}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    title: title,
    centerTitle: true,
    actions: const [
      Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: ToogleThemeBtn(),
      ),
    ],
  );
}
