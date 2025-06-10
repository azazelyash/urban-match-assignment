import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:urban_match_task/common/constants/custom_colors.dart';
import 'package:urban_match_task/screens/widgets/custom_navigation_bar.dart';
import 'package:urban_match_task/screens/widgets/events_page.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 3, initialIndex: 1);

    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      bottomNavigationBar: SafeArea(
        child: CustomNavigationBar(tabController: tabController),
      ),
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          Center(
            child: Text(
              "Search",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          EventsPage(),
          Center(
            child: Text(
              "Notification",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
