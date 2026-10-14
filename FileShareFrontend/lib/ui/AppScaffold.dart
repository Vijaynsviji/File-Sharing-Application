import 'package:flutter/material.dart';

import '../global/models/app_colors.dart';
// Import your theme extension file here to resolve context.colors

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? drawer;
  final Widget? bottomNavigationBar;

  const AppScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.drawer,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: appBar,
      drawer: drawer,
      bottomNavigationBar: bottomNavigationBar,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            decoration: BoxDecoration(
              // Enforces your global gradient background across every view
              gradient: context.colors.bgPage,
            ),
            child: SafeArea(child: body),
          );
        },
      ),
    );
  }
}
