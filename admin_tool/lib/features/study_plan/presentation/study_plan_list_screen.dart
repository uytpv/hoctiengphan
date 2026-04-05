import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_tool/features/study_plan/data/study_plan_repository.dart';
import 'package:admin_tool/features/study_plan/data/study_plan_service.dart';
import 'package:admin_tool/features/study_plan/domain/study_plan.dart';
import 'package:go_router/go_router.dart';

class StudyPlanListScreen extends ConsumerWidget {
  const StudyPlanListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(studyPlansStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Plans'),
        actions: [
          TextButton.icon(
            onPressed: () async {
              // Confirm before seeding
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Tạo lộ trình chuẩn?'),
                  content: const Text('Hệ thống sẽ tự động tạo lộ trình 26 tuần (6 tháng) dựa trên mẫu "Suomen Mestari 1".'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Hủy')),
                    ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Tạo ngay')),
                  ],
                ),
              );
              
              if (confirm == true) {
                try {
                  await ref.read(studyPlanServiceProvider).seedStandardPlan();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã tạo lộ trình thành công!')));
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
                  }
                }
              }
            },
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
      body: plansAsync.when(
        data: (plans) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: plans.length,
          itemBuilder: (context, index) {
            final plan = plans[index];
            return Card(
              child: ListTile(
                leading: const Icon(Icons.map, size: 40, color: Colors.blue),
                title: Text(plan.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${plan.durationWeeks} tuần • ${plan.description}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _editPlan(context, ref, plan),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                         final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Xác nhận'),
                            content: const Text('Bạn có chắc muốn xóa lộ trình này?'),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Hủy')),
                              TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Xóa', style: TextStyle(color: Colors.red))),
                            ],
                          ),
                        );
                        if (confirmed == true) {
                          ref.read(studyPlanRepositoryProvider).deletePlan(plan.id);
                        }
                      },
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
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Future<void> _editPlan(BuildContext context, WidgetRef ref, StudyPlan plan) async {
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
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
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
