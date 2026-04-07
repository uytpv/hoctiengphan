import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dashboard',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatCard('Total Users', '1,245', Colors.blue),
            _buildStatCard('Total Vocabulary', '300+', Colors.orange),
            _buildStatCard('Completed Plans', '12', Colors.green),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String count, Color color) {
    return Card(
      elevation: 2,
      child: Container(
        width: 250,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Text(
              count,
              style: TextStyle(
                color: color,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
