import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/immersion_resource.dart';
import '../data/immersion_repository.dart';
import 'widgets/immersion_form_dialog.dart';

class ImmersionListScreen extends ConsumerStatefulWidget {
  const ImmersionListScreen({super.key});

  @override
  ConsumerState<ImmersionListScreen> createState() => _ImmersionListScreenState();
}

class _ImmersionListScreenState extends ConsumerState<ImmersionListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showFormDialog(BuildContext context, [ImmersionResource? resource]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ImmersionFormDialog(initialResource: resource),
    );
  }

  Future<void> _handleDelete(BuildContext context, ImmersionResource item) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xác nhận xóa tài nguyên'),
        content: Text('Bạn có chắc muốn xóa "${item.title}" khỏi kho tài nguyên?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await ref.read(immersionRepositoryProvider).deleteImmersionResource(item.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đã xóa "${item.title}"')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Kho Tài Nguyên Đời Sống Thực Tế (Immersion Hub)'),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton.icon(
              onPressed: () => _showFormDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('THÊM TÀI NGUYÊN'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent.shade700,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blueAccent.shade700,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blueAccent.shade700,
          tabs: const [
            Tab(icon: Icon(Icons.all_inclusive), text: 'Tất cả'),
            Tab(icon: Icon(Icons.music_note), text: '🎵 Bài hát'),
            Tab(icon: Icon(Icons.movie), text: '🎬 Video & Phim'),
            Tab(icon: Icon(Icons.traffic), text: '🚏 Biển báo đường phố'),
            Tab(icon: Icon(Icons.shopping_cart), text: '🛒 Đời sống thực tế'),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (val) => setState(() => _searchQuery = val.trim().toLowerCase()),
              decoration: InputDecoration(
                hintText: 'Tìm kiếm theo tiêu đề, từ khóa hoặc thẻ tags...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildResourceList(null),
                _buildResourceList(ImmersionType.music),
                _buildResourceList(ImmersionType.movie),
                _buildResourceList(ImmersionType.streetSign),
                _buildResourceList(ImmersionType.practicalLife),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourceList(ImmersionType? type) {
    final resourcesAsync = ref.watch(immersionListProvider(type));

    return resourcesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Lỗi tải dữ liệu: $e')),
      data: (items) {
        final filtered = items.where((item) {
          if (_searchQuery.isEmpty) return true;
          final matchTitle = item.title.toLowerCase().contains(_searchQuery);
          final matchDesc = item.description.toLowerCase().contains(_searchQuery);
          final matchTag = item.tags.any((t) => t.toLowerCase().contains(_searchQuery));
          return matchTitle || matchDesc || matchTag;
        }).toList();

        if (filtered.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.folder_open, size: 64, color: Colors.grey.shade400),
                const SizedBox(height: 12),
                Text(
                  'Chưa có tài nguyên nào trong mục này.',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () => _showFormDialog(context),
                  icon: const Icon(Icons.add),
                  label: const Text('Thêm tài nguyên đầu tiên'),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: filtered.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = filtered[index];
            return _ResourceCard(
              resource: item,
              onEdit: () => _showFormDialog(context, item),
              onDelete: () => _handleDelete(context, item),
            );
          },
        );
      },
    );
  }
}

class _ResourceCard extends StatelessWidget {
  final ImmersionResource resource;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _ResourceCard({
    required this.resource,
    required this.onEdit,
    required this.onDelete,
  });

  IconData _getTypeIcon(ImmersionType type) {
    switch (type) {
      case ImmersionType.music:
        return Icons.music_note;
      case ImmersionType.movie:
        return Icons.movie;
      case ImmersionType.streetSign:
        return Icons.traffic;
      case ImmersionType.practicalLife:
        return Icons.storefront;
    }
  }

  Color _getTypeColor(ImmersionType type) {
    switch (type) {
      case ImmersionType.music:
        return Colors.purple;
      case ImmersionType.movie:
        return Colors.deepOrange;
      case ImmersionType.streetSign:
        return Colors.teal;
      case ImmersionType.practicalLife:
        return Colors.indigo;
    }
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = _getTypeColor(resource.type);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: typeColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(_getTypeIcon(resource.type), color: typeColor, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: typeColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          resource.type.name.toUpperCase(),
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: typeColor),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          resource.title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (resource.description.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      resource.description,
                      style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (resource.mediaUrl != null && resource.mediaUrl!.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.link, size: 14, color: Colors.blueAccent),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            resource.mediaUrl!,
                            style: const TextStyle(fontSize: 12, color: Colors.blueAccent),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (resource.tags.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      children: resource.tags.map((tag) {
                        return Chip(
                          label: Text(tag, style: const TextStyle(fontSize: 11)),
                          padding: EdgeInsets.zero,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          backgroundColor: Colors.grey.shade200,
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blueGrey),
                  tooltip: 'Chỉnh sửa',
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                  tooltip: 'Xóa',
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
