import 'package:file_share_application_frontend/ui/appbar/app_bar_title.dart';
import 'package:flutter/material.dart';

import '../../core/Language/l10n_extensions.dart';

// 1. 🟢 Add 'implements PreferredSizeWidget' to the class signature
class Appbar extends StatelessWidget implements PreferredSizeWidget {
  const Appbar({super.key});

  // 2. 🟢 Add this override field to declare the appbar's height dimensions
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const AppBarTitle(),
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      // leading: ,
    );
  }
}
