import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_tool/features/student/data/user_repository.dart';
import 'package:admin_tool/features/student/domain/user_progress.dart';
import 'package:uuid/uuid.dart';
import 'providers/student_filter_provider.dart';
import 'providers/filtered_students_provider.dart';

class StudentListScreen extends ConsumerWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(paginatedStudentsProvider);
    final allUsersAsync = ref.watch(filteredStudentsProvider);
    final filters = ref.watch(studentFilterProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Quản Lý Học Viên'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => _seedDummyStudents(ref),
            icon: const Icon(Icons.person_add_alt),
            tooltip: 'Thêm học viên mẫu',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (val) =>
                  ref.read(studentFilterProvider.notifier).updateSearch(val),
              decoration: const InputDecoration(
                hintText: 'Search student by name or email...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: usersAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text('Error: $e')),
              data: (users) {
                final totalItems = allUsersAsync.value?.length ?? 0;
                final totalPages = (totalItems / filters.pageSize).ceil();

                if (users.isEmpty && filters.searchQuery.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Chưa có học viên nào.'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => _seedDummyStudents(ref),
                          child: const Text('Tạo học viên mẫu'),
                        ),
                      ],
                    ),
                  );
                }

                if (users.isEmpty && filters.searchQuery.isNotEmpty) {
                  return const Center(child: Text('No students match search.'));
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              headingTextStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              columns: const [
                                DataColumn(label: Text('Thông tin học viên')),
                                DataColumn(label: Text('Lộ trình đang học')),
                                DataColumn(label: Text('Tiến độ')),
                                DataColumn(label: Text('Trạng thái')),
                              ],
                              rows: users.expand((user) {
                                final userEmail = user.email ?? 'Không có email';
                                final userData = user.displayName.isEmpty
                                    ? 'Học viên'
                                    : user.displayName;

                                if (user.enrollments.isEmpty) {
                                  return [
                                    DataRow(
                                      cells: [
                                        DataCell(
                                          SizedBox(
                                            width: 250,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  userData,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  userEmail,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const DataCell(Text('-')),
                                        const DataCell(Text('0%')),
                                        const DataCell(
                                          Chip(
                                            label: Text('Chưa đăng ký'),
                                            padding: EdgeInsets.zero,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ];
                                }

                                return user.enrollments
                                    .map(
                                      (enr) => DataRow(
                                        cells: [
                                          DataCell(
                                            SizedBox(
                                              width: 250,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    userData,
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    userEmail,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            SizedBox(
                                              width: 200,
                                              child: Text(
                                                enr.planTitle,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            SizedBox(
                                              width: 100,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  LinearProgressIndicator(
                                                    value: enr.progressPercent /
                                                        100,
                                                    minHeight: 4,
                                                    borderRadius:
                                                        BorderRadius.circular(2),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    '${enr.progressPercent.toInt()}%',
                                                    style: const TextStyle(
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Chip(
                                              label: Text(
                                                enr.status == 'completed'
                                                    ? 'Hoàn thành'
                                                    : 'Đang học',
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              backgroundColor:
                                                  enr.status == 'completed'
                                                      ? Colors.green
                                                      : Colors.blue,
                                              padding: EdgeInsets.zero,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList();
                              }).toList(),
                            ),
                          ),
                        ),
                        _buildPagination(ref, filters, totalItems, totalPages),
                      ],
                    ),
                  ),
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
    StudentFilterState filters,
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
            'Total: $totalItems students',
            style: const TextStyle(color: Colors.grey),
          ),
          Row(
            children: [
              IconButton(
                onPressed: filters.pageIndex > 0
                    ? () => ref
                        .read(studentFilterProvider.notifier)
                        .setPage(filters.pageIndex - 1)
                    : null,
                icon: const Icon(Icons.chevron_left),
              ),
              Text('Page ${filters.pageIndex + 1} of $totalPages'),
              IconButton(
                onPressed: filters.pageIndex < totalPages - 1
                    ? () => ref
                        .read(studentFilterProvider.notifier)
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
