import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/service_locatores.dart';
import '../bloc/health_tips_cubit.dart';
import '../widgets/health_tips_app_bar.dart';
import '../widgets/health_tips_body.dart';

class HealthTipsPage extends StatefulWidget {
  const HealthTipsPage({super.key});

  @override
  State<HealthTipsPage> createState() => _HealthTipsPageState();
}

class _HealthTipsPageState extends State<HealthTipsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HealthTipsCubit>(
      create: (context) => sl<HealthTipsCubit>(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            const HealthTipsAppBar(),
            const SliverToBoxAdapter(
              child: HealthTipsBody(),
            ),
          ],
        ),
      ),
    );
  }
}

