import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/ui/receiver/receiver_view_model.dart';
import 'package:file_share_application_frontend/ui/receiver/widget/receiver_header_view.dart';
import 'package:file_share_application_frontend/ui/receiver/widget/receiver_icon_animated_view.dart';
import 'package:file_share_application_frontend/ui/receiver/widget/receiver_near_by_list_view.dart';
import 'package:file_share_application_frontend/ui/receiver/widget/receiver_settings_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/Utils/TextStyles.dart';
import '../../global/Providers/EngineNotifier.dart';
import '../../native_bridge/engine.dart';
import '../AppScaffold.dart';
import '../find_near_by/find_near_by_permission_view.dart';
import '../find_near_by/find_near_by_view.dart';

class ReceiverView extends StatelessWidget {
  const ReceiverView({super.key});

  @override
  Widget build(BuildContext context) {
    // return AppScaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.transparent,
    //     elevation: 0,
    //     scrolledUnderElevation: 0,
    //     title: Text(
    //       context.strings.receive,
    //       style: context.styles.secondaryHeader,
    //     ),
    //   ),
    //   // body: ChangeNotifierProvider.value(
    //   //   value: settingViewModel,
    //   //   child: isProfileSettingsView
    //   //       ? SettingProfileView()
    //   //       : SettingsThemeLangView(),
    //   // ),
    //   // );
    //
    //   body: ChangeNotifierProvider.value(
    //     value: ReceiverViewModel(),
    //     child:
    //         // SingleChildScrollView(
    //         //   child:
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.stretch,
    //           spacing: 20,
    //           children: [
    //             ReceiverHeaderView(),
    //             ReceiverIconAnimatedView(),
    //             Expanded(child: ReceiverNearByView()),
    //           ],
    //         ),
    //     // ),
    //   ),
    // );

    final engine = context.select<EngineNotifier, Engine?>(
      (viewModel) => viewModel.engine,
    );

    return ChangeNotifierProvider(
      create: (_) => ReceiverViewModel(engine: engine),
      child: BaseTransferView(
        title: context.strings.receive,
        headerView: const ReceiverHeaderView(),
        // animatedIconView: const ReceiverIconAnimatedView(),
        animatedIconView: const Text("Animated View"),
        contentView: PermissionGateView(
          onGrantedView: const ReceiverNearByListView(),
          onSettingsView:
              const ReceiverSettingsView(), // Note: Make this generic too if Sender uses the exact same UI!
        ),
      ),
    );
  }
}
