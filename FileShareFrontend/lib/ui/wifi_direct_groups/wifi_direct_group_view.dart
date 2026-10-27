import 'package:file_share_application_frontend/ui/wifi_direct_groups/widget/wifi_direct_group_receiver_manage_view.dart';
import 'package:file_share_application_frontend/ui/wifi_direct_groups/wifi_direct_group_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/Language/l10n_extensions.dart';
import '../../core/Utils/TextStyles.dart';
import '../AppScaffold.dart';

class WifiDirectGroupView extends StatelessWidget {
  final wifiViewModel = WifiDirectGroupViewModel();
  WifiDirectGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          context.strings.discoverGroupsTitle,
          style: context.styles.secondaryHeader,
        ),
      ),
      body: ChangeNotifierProvider.value(
        value: wifiViewModel,
        child: WifiDirectGroupReceiverManageView(),
      ),
    );
    ;
  }
}
