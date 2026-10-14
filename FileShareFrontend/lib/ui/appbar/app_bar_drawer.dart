import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/global/models/app_colors.dart';
import 'package:file_share_application_frontend/ui/appbar/widget/app_bar_drawer_listview.dart';
import 'package:file_share_application_frontend/ui/appbar/widget/app_bar_drawer_profile.dart';
import 'package:flutter/material.dart';

class AppBarDrawer extends StatelessWidget {
  const AppBarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            spacing: 30,
            children: [
              Text(
                context.strings.editProfile,
                style: context.styles.secondaryHeader,
              ),
              Container(
                // padding: EdgeInsets.all(15),
                child: Column(
                  spacing: 40,
                  children: [AppBarDrawerProfile(), AppBarDrawerListview()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
