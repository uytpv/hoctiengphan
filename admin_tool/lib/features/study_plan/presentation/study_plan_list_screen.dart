import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_tool/features/study_plan/data/study_plan_repository.dart';
import 'package:admin_tool/features/study_plan/data/study_plan_service.dart';
import 'package:admin_tool/features/study_plan/domain/study_plan.dart';
import 'package:go_router/go_router.dart';
import 'providers/study_plan_filter_provider.dart';
import 'providers/filtered_study_plans_provider.dart';

class StudyPlanListScreen extends ConsumerWidget {
  const StudyPlanListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(paginatedStudyPlansProvider);
    final allPlansAsync = ref.watch(filteredStudyPlansProvider);
    final filters = ref.watch(studyPlanFilterProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Study Plans'),
        backgroundColor: Colors.white,
        actions: [
          TextButton.icon(
            onPressed: () => _handleSeed(context, ref),
            icon: const Icon(Icons.auto_awesome),
            label: const Text('Seed Standard Plan'),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: () {
              // Open Form for new plan (manual)
            },
            icon: const Icon(Icons.add),
            label: const Text('ADD PLAN'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.6),
            child: TextField(
              onChanged: (val) =>
                  ref.read(studyPlanFilterProvider.notifier).updateSearch(val),
              decoration: const InputDecoration(
                hintText: 'Search plans...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: plansAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text('Error: $e')),
              data: (items) {
                final totalItems = allPlansAsync.value?.length ?? 0;
                final totalPages = (totalItems / filters.pageSize).ceil();

                if (items.isEmpty && filters.searchQuery.isEmpty) {
                  return const Center(child: Text('No study plans found.'));
                }

                if (items.isEmpty && filters.searchQuery.isNotEmpty) {
                  return const Center(child: Text('No plans match search.'));
                }

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final plan = items[index];
                          return Card(
                            child: ListTile(
                              leading: const Icon(Icons.map,
                                  size: 40, color: Colors.blue),
                              title: Text(
                                plan.title,
                                style:
                                    const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                '${plan.durationWeeks} tuần • ${plan.description}',
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon:
                                        const Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () => _editPlan(context, ref, plan),
                                  ),
                                  IconButton(
                                    icon:
                                        const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () =>
                                        _confirmDelete(context, ref, plan),
                                  ),
                                  const Icon(Icons.chevron_right),
                                ],
                              ),
                              onTap: () {
                                context.go('/study-plans/${plan.id}');
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    _buildPagination(ref, filters, totalItems, totalPages),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination(
    WidgetRef ref,
    StudyPlanFilterState filters,
    int totalItems,
    int totalPages,
  ) {
    if (totalItems == 0) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total: $totalItems plans',
            style: const TextStyle(color: Colors.grey),
          ),
          Row(
            children: [
              IconButton(
                onPressed: filters.pageIndex > 0
                    ? () => ref
                        .read(studyPlanFilterProvider.notifier)
                        .setPage(filters.pageIndex - 1)
                    : null,
                icon: const Icon(Icons.chevron_left),
              ),
              Text('Page ${filters.pageIndex + 1} of $totalPages'),
              IconButton(
                onPressed: filters.pageIndex < totalPages - 1
                    ? () => ref
                        .read(studyPlanFilterProvider.notifier)
                        .setPage(filters.pageIndex + 1)
                    : null,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _handleSeed(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tạo lộ trình chuẩn?'),
        content: const Text(
          'Hệ thống sẽ tự động tạo lộ trình 26 tuần (6 tháng) dựa trên mẫu "Suomen Mestari 1".',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Tạo ngay'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await ref.read(studyPlanServiceProvider).seedStandardPlan();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Đã tạo lộ trình thành công!'),
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
        }
      }
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    StudyPlan plan,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận'),
        content: const Text('Bạn có chắc muốn xóa lộ trình này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Xóa',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      ref.read(studyPlanRepositoryProvider).deletePlan(plan.id);
    }
  }

  Future<void> _editPlan(
    BuildContext context,
    WidgetRef ref,
    StudyPlan plan,
  ) async {
    final titleController = TextEditingController(text: plan.title);
    final descController = TextEditingController(text: plan.description);

    final updatedData = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chỉnh sửa lộ trình'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Tiêu đề'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Mô tả'),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, {
              'title': titleController.text,
              'description': descController.text,
            }),
            child: const Text('Lưu'),
          ),
        ],
      ),
    );

    if (updatedData != null) {
      final updatedPlan = plan.copyWith(
        title: updatedData['title']!,
        description: updatedData['description']!,
      );
      ref.read(studyPlanRepositoryProvider).updatePlan(updatedPlan);
    }
  }
}
