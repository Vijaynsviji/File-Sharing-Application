import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/global/models/app_colors.dart';
import 'package:file_share_application_frontend/global/models/peer_device.dart';
import 'package:file_share_application_frontend/ui/common/widget/Avatar.dart';
import 'package:file_share_application_frontend/ui/onboarding/profile_image_model.dart';
import 'package:flutter/material.dart';

class HomePeerCardView extends StatelessWidget {
  final ProfileImageModel profileImageModel;
  final PeerDevice peerDevice;
  const HomePeerCardView({
    super.key,
    required this.profileImageModel,
    required this.peerDevice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.card,
      child: Row(
        children: [
          Avatar(profileImageModel: profileImageModel, isAvatarSelected: false),
          Text(peerDevice.name, style: context.styles.buttonSecondary),
        ],
      ),
    );
  }
}
