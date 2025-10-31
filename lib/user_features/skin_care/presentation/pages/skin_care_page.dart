import 'package:flutter/material.dart';
import '../widgets/skin_care_app_bar.dart';
import '../widgets/skin_care_body.dart';

class SkinCarePage extends StatefulWidget {
  const SkinCarePage({super.key});

  @override
  State<SkinCarePage> createState() => _SkinCarePageState();
}

class _SkinCarePageState extends State<SkinCarePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          const SkinCareAppBar(),
          const SliverToBoxAdapter(
            child: SkinCareBody(),
          ),
        ],
      ),
    );
  }
}

