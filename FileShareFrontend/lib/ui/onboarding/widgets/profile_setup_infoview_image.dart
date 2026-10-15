import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/ui/common/widget/circular_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../profile_image_model.dart';
import '../profile_setup_view_model.dart';

class ProfileSetupInfoviewImage extends StatelessWidget {
  final ProfileImageModel profileImageModel;
  final void Function() handleOnClick;
  const ProfileSetupInfoviewImage({
    super.key,
    required this.profileImageModel,
    required this.handleOnClick,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 10,
      children: [
        CircularAvatar(imageModel: profileImageModel, width: 100),
        GestureDetector(
          onTap: handleOnClick,
          child: Text(context.strings.changePhoto, style: context.styles.link),
        ),
      ],
    );
  }
}
