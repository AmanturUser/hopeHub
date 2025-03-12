import 'package:flutter/material.dart';
import 'package:hope_hub/core/style/app_text_styles.dart';
import 'package:hope_hub/core/style/sizedBoxHeight.dart';
import 'package:hope_hub/feature/dashboard/domain/dashboard_model.dart';

import 'detail.dart';

class ProjectListScreen extends StatelessWidget {
  const ProjectListScreen({super.key, required this.projects});

  final List<Projects> projects;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Участие в проектах',
          style: AppTextStyles.appBar,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          for (var item in projects)
            _buildProjectCard(
              item.name!,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProjectDetailScreen(project: item)));
                // Handle tap
              },
            ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(String title, {required VoidCallback onTap}) {
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
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
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
