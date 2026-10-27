import 'package:file_share_application_frontend/global/Providers/CurrentUserNotifier.dart';
import 'package:file_share_application_frontend/global/Providers/EngineNotifier.dart';
import 'package:file_share_application_frontend/global/models/user_model.dart';
import 'package:file_share_application_frontend/ui/sender/sender_view_model.dart';
import 'package:file_share_application_frontend/ui/sender/widget/sender_near_by_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/Language/l10n_extensions.dart';
import '../../native_bridge/engine.dart';
import '../find_near_by/find_near_by_permission_view.dart';
import '../find_near_by/find_near_by_view.dart';
import '../receiver/widget/receiver_header_view.dart';
import '../receiver/widget/receiver_icon_animated_view.dart';
import '../receiver/widget/receiver_near_by_list_view.dart';
import '../receiver/widget/receiver_settings_view.dart';

class SenderView extends StatelessWidget {
  const SenderView({super.key});

  @override
  Widget build(BuildContext context) {
    final engine = context.select<EngineNotifier, Engine?>(
      (viewModel) => viewModel.engine,
    );
    final currentUser = context.select<Currentusernotifier, User?>(
      (viewModel) => viewModel.currentUser,
    );
    return ChangeNotifierProvider(
      create: (_) => SenderViewModel(engine: engine, currentUser: currentUser),
      child: BaseTransferView(
        title: context.strings.receive,
        headerView: const ReceiverHeaderView(),
        // animatedIconView: const ReceiverIconAnimatedView(),
        animatedIconView: const Text("Hello"),
        contentView: PermissionGateView(
          onGrantedView: const SenderNearByListView(),
          onSettingsView:
              const ReceiverSettingsView(), // Note: Make this generic too if Sender uses the exact same UI!
        ),
      ),
    );
    ;
  }
}
