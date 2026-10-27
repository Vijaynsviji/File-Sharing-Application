import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'find_near_by_view_model.dart';

class PermissionGateView extends StatelessWidget {
  final Widget onGrantedView;
  final Widget onSettingsView;

  const PermissionGateView({
    super.key,
    required this.onGrantedView,
    required this.onSettingsView,
  });

  @override
  Widget build(BuildContext context) {
    final isPermissionGiven = context.select<DevicePermissionViewModel, bool>(
      (viewModel) => viewModel.isBothPermissionGiven,
    );

    return isPermissionGiven ? onGrantedView : onSettingsView;
  }
}
