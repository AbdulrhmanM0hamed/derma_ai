import 'package:flutter/material.dart';
import '../widgets/community_body.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
      //    const CommunityAppBar(),
          SliverFillRemaining(
            child: SafeArea(child: const CommunityBody()),
          ),
        ],
      ),
    );
  }
}
