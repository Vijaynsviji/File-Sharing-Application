import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/Utils/TextStyles.dart';
import '../AppScaffold.dart';
import 'find_near_by_view_model.dart';

class BaseTransferView extends StatelessWidget {
  final String title;
  final Widget headerView;
  final Widget animatedIconView;
  final Widget contentView;

  const BaseTransferView({
    super.key,
    required this.title,
    required this.headerView,
    required this.animatedIconView,
    required this.contentView,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(title, style: context.styles.secondaryHeader),
      ),
      body: ChangeNotifierProvider(
        create: (_) => DevicePermissionViewModel(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 20,
          children: [
            headerView,
            animatedIconView,
            Expanded(child: contentView),
          ],
        ),
      ),
    );
  }
}
