import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_tool/features/activity/data/activity_repository.dart';
import 'package:admin_tool/features/activity/domain/activity.dart';
import 'package:admin_tool/features/activity/presentation/widgets/activity_form_dialog.dart';

class ActivityListScreen extends ConsumerStatefulWidget {
  const ActivityListScreen({super.key});

  @override
  ConsumerState<ActivityListScreen> createState() => _ActivityListScreenState();
}

class _ActivityListScreenState extends ConsumerState<ActivityListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activitiesAsync = ref.watch(activitiesStreamProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Activity List'),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton.icon(
              onPressed: () => _showFormDialog(null),
              icon: const Icon(Icons.add),
              label: const Text('ADD ACTIVITY'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent.shade700,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search activity...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => setState(() => _searchQuery = v),
            ),
          ),
          Expanded(
            child: activitiesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text('Error: $e')),
              data: (activities) {
                final filteredItems = activities.where((a) {
                  return a.title.toLowerCase().contains(
                    _searchQuery.toLowerCase(),
                  );
                }).toList();

                if (filteredItems.isEmpty) {
                  return const Center(child: Text('No activities found.'));
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredItems.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return ListTile(
                      title: Text(
                        item.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${item.type.name.toUpperCase()} | ID: ${item.id}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showFormDialog(item),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _confirmDelete(item.id),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFormDialog(Activity? activity) {
    showDialog(
      context: context,
      builder: (context) => ActivityFormDialog(activity: activity),
    );
  }

  void _confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Activity?'),
        content: const Text('Are you sure you want to delete this activity?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(activityRepositoryProvider).deleteActivity(id);
              if (mounted) Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
