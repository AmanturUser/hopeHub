import 'package:flutter/material.dart';

import '../../../../core/style/app_text_styles.dart';
import '../../domain/dashboard_model.dart';
import 'detail.dart';

class MyIdeasListScreen extends StatelessWidget {
  const MyIdeasListScreen({super.key, required this.ideas});

  final List<Ideas> ideas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Мои инициативы',
          style: AppTextStyles.appBar,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          for (var item in ideas)
            _buildProjectCard(
              item.name!,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MyIdeaDetailScreen(idea: item)));
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
