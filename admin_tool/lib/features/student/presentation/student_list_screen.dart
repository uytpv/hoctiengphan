import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_tool/features/student/data/user_repository.dart';
import 'package:admin_tool/features/student/domain/user_progress.dart';
import 'package:uuid/uuid.dart';

class StudentListScreen extends ConsumerWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản Lý Học Viên'),
        actions: [
          IconButton(
            onPressed: () => _seedDummyStudents(ref),
            icon: const Icon(Icons.person_add_alt),
            tooltip: 'Thêm học viên mẫu',
          ),
        ],
      ),
      body: usersAsync.when(
        data: (users) {
          if (users.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   const Text('Chưa có học viên nào.'),
                   const SizedBox(height: 16),
                   ElevatedButton(onPressed: () => _seedDummyStudents(ref), child: const Text('Tạo học viên mẫu')),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: DataTable(
              headingTextStyle: const TextStyle(fontWeight: FontWeight.bold),
              columns: const [
                DataColumn(label: Text('Thông tin học viên')),
                DataColumn(label: Text('Lộ trình đang học')),
                DataColumn(label: Text('Tiến độ')),
                DataColumn(label: Text('Trạng thái')),
              ],
              rows: users.expand((user) {
                if (user.enrollments.isEmpty) {
                  return [
                    DataRow(cells: [
                      DataCell(Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(user.displayName, style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(user.email, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      )),
                      const DataCell(Text('-')),
                      const DataCell(Text('0%')),
                      const DataCell(Chip(label: Text('Chưa đăng ký'), padding: EdgeInsets.zero)),
                    ])
                  ];
                }

                return user.enrollments.map((enr) => DataRow(cells: [
                  DataCell(Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(user.displayName, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(user.email, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  )),
                  DataCell(Text(enr.planTitle)),
                  DataCell(SizedBox(
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LinearProgressIndicator(value: enr.progressPercent / 100, minHeight: 4, borderRadius: BorderRadius.circular(2)),
                        const SizedBox(height: 4),
                        Text('${enr.progressPercent.toInt()}%', style: const TextStyle(fontSize: 10)),
                      ],
                    ),
                  )),
                  DataCell(Chip(
                    label: Text(enr.status == 'completed' ? 'Hoàn thành' : 'Đang học', style: const TextStyle(fontSize: 10, color: Colors.white)),
                    backgroundColor: enr.status == 'completed' ? Colors.green : Colors.blue,
                    padding: EdgeInsets.zero,
                  )),
                ])).toList();
              }).toList(),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Future<void> _seedDummyStudents(WidgetRef ref) async {
    final repo = ref.read(userRepositoryProvider);
    final uuid = const Uuid();

    final students = [
      UserProfile(
        id: uuid.v4(),
        email: 'hocvien1@gmail.com',
        displayName: 'Trần Văn A',
        enrollments: [
          Enrollment(
            planId: 'sm1-plan-id',
            planTitle: 'Lộ trình 6 tháng Suomen Mestari 1',
            progressPercent: 25,
            status: 'active',
            startDate: DateTime.now().subtract(const Duration(days: 30)),
          ),
        ],
      ),
      UserProfile(
        id: uuid.v4(),
        email: 'hocvien2@gmail.com',
        displayName: 'Lê Thị B',
        enrollments: [
          Enrollment(
            planId: 'sm1-plan-id',
            planTitle: 'Lộ trình 6 tháng Suomen Mestari 1',
            progressPercent: 100,
            status: 'completed',
            startDate: DateTime.now().subtract(const Duration(days: 180)),
          ),
          Enrollment(
            planId: 'sm2-plan-id',
            planTitle: 'Lộ trình 6 tháng Suomen Mestari 2',
            progressPercent: 1,
            status: 'active',
            startDate: DateTime.now().subtract(const Duration(days: 2)),
          ),
        ],
      ),
    ];

    for (final student in students) {
      await repo.createUser(student);
    }
  }
}
