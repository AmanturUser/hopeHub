import 'package:flutter/material.dart';
import 'package:hope_hub/core/style/app_text_styles.dart';
import 'package:hope_hub/core/style/sizedBoxHeight.dart';
import 'package:hope_hub/feature/action/domain/action_model.dart';
import 'package:hope_hub/feature/dashboard/domain/dashboard_model.dart';

import '../../../../core/const/helper.dart';
import 'detail.dart';

class EventListScreen extends StatelessWidget {
  const EventListScreen({super.key, required this.events});

  final List<Events> events;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Календарь событий',
          style: AppTextStyles.appBar,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          for (var item in events)
            _buildProjectCard(
              item.date!,
              item.title!,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EventDetailScreen(event: item)));
                // Handle tap
              },
            ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(String date,String title, {required VoidCallback onTap}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatDate(date),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
