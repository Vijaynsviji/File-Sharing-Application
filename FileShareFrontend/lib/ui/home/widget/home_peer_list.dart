import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/core/enums/image_source_enum.dart';
import 'package:file_share_application_frontend/global/Providers/PeerDeviceNotifier.dart';
import 'package:file_share_application_frontend/ui/home/widget/home_peer_card_view.dart';
import 'package:file_share_application_frontend/ui/onboarding/profile_image_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/models/app_colors.dart';
import '../../../global/models/peer_device.dart';

class HomePeerList extends StatelessWidget {
  const HomePeerList({super.key});

  @override
  Widget build(BuildContext context) {
    final peerList = context.select<PeerDeviceNotifier, List<PeerDevice>>(
      (viewModel) => viewModel.peerDevices,
    );

    final isPeerListEmpty = peerList.isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 30,
      children: [
        Text(context.strings.shareWithFriends, style: context.styles.label),
        isPeerListEmpty
            ? Center(
                child: Text(
                  context.strings.noTransfersTitle,
                  style: context.styles.caption,
                ),
              )
            : SizedBox(
                height:
                    120.0, // 🟢 You must define a fixed height for the horizontal container
                child: ListView.builder(
                  scrollDirection: Axis
                      .horizontal, // 🟢 Changes scroll direction from vertical to horizontal
                  itemCount: peerList.length,
                  itemBuilder: (context, index) {
                    final peerDevice = peerList[index];
                    return HomePeerCardView(
                      profileImageModel: ProfileImageModel(
                        path: peerDevice.profileImage,
                        name: '',
                        sourceType: ImageSourceType.base64,
                      ),
                      peerDevice: peerDevice,
                    );
                  },
                ),
              ),
      ],
    );
  }
}
