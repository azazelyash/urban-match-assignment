import 'package:flutter/material.dart';
import 'package:urban_match_task/common/constants/custom_colors.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
          color: CustomColors.primaryColor,
          border: Border(
            top: BorderSide(color: CustomColors.accentColor, width: 0.4),
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: TabBar(
          controller: tabController,
          indicator: BoxDecoration(
            color: CustomColors.secondaryColor,
            borderRadius: BorderRadius.circular(40),
          ),
          unselectedLabelColor: CustomColors.accentColor,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Tab(
              icon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(Icons.search),
              ),
            ),
            Tab(
              icon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(Icons.event),
              ),
            ),
            Tab(
              icon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(Icons.circle_notifications_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
