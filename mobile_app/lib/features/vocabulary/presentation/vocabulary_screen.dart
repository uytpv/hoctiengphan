import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../data/vocabulary_repository.dart';
import '../domain/vocabulary.dart';
import 'widgets/flashcard_view.dart';

final vocabularyCategoryFilterProvider = StateProvider<String?>((ref) => null);
final vocabularySearchQueryProvider = StateProvider<String>((ref) => '');

final vocabulariesListStreamProvider = StreamProvider<List<Vocabulary>>((ref) {
  final repo = ref.watch(vocabularyRepositoryProvider);
  final category = ref.watch(vocabularyCategoryFilterProvider);
  return repo.watchVocabularies(category: category);
});

final vocabularyCategoriesFutureProvider = FutureProvider<List<String>>((ref) {
  final repo = ref.watch(vocabularyRepositoryProvider);
  return repo.getCategories();
});

class VocabularyScreen extends ConsumerStatefulWidget {
  const VocabularyScreen({super.key});

  @override
  ConsumerState<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends ConsumerState<VocabularyScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final AudioPlayer _listAudioPlayer = AudioPlayer();
  final FlutterTts _listTts = FlutterTts();

  int _currentCardIndex = 0;
  List<Vocabulary> _shuffledList = [];
  bool _isShuffled = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _listAudioPlayer.dispose();
    _listTts.stop();
    super.dispose();
  }

  Future<void> _playWordAudio(String text, {String? url}) async {
    try {
      if (url != null && url.isNotEmpty) {
        await _listAudioPlayer.stop();
        await _listAudioPlayer.play(UrlSource(url));
      } else {
        await _listTts.stop();
        await _listTts.setLanguage('fi-FI');
        await _listTts.setSpeechRate(0.85);
        await _listTts.speak(text);
      }
    } catch (_) {}
  }

  void _shuffleCards(List<Vocabulary> original) {
    setState(() {
      _shuffledList = List<Vocabulary>.from(original)..shuffle(Random());
      _isShuffled = true;
      _currentCardIndex = 0;
    });
  }

  void _resetShuffle() {
    setState(() {
      _isShuffled = false;
      _currentCardIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final vocabulariesAsync = ref.watch(vocabulariesListStreamProvider);
    final categoriesAsync = ref.watch(vocabularyCategoriesFutureProvider);
    final selectedCategory = ref.watch(vocabularyCategoryFilterProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sanasto • Từ vựng',
              style: AppTextStyles.headingMd.copyWith(color: AppColors.surfaceDark),
            ),
            Text(
              'Opi ja kertaa suomea • Ôn luyện flashcard & tra cứu',
              style: AppTextStyles.caption.copyWith(color: AppColors.neutral),
            ),
          ],
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: AppColors.surface,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.neutral,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              labelStyle: AppTextStyles.labelMd,
              tabs: const [
                Tab(
                  icon: Icon(Icons.style_outlined, size: 20),
                  text: 'Flashcard',
                ),
                Tab(
                  icon: Icon(Icons.menu_book_outlined, size: 20),
                  text: 'Sổ từ (Luettelo)',
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Filter chip list
          _buildCategoryFilters(categoriesAsync, selectedCategory),

          // Content body
          Expanded(
            child: vocabulariesAsync.when(
              data: (items) {
                if (items.isEmpty) {
                  return _buildEmptyState(
                    title: 'Ei sanoja löytynyt • Không tìm thấy từ vựng',
                    subtitle: selectedCategory != null
                        ? 'Kategoriassa "$selectedCategory" ei ole vielä sanoja.'
                        : 'Sanastoa ladataan tai se on tyhjä.',
                  );
                }

                return TabBarView(
                  controller: _tabController,
                  children: [
                    _buildFlashcardTab(items),
                    _buildListTab(items),
                  ],
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (err, stack) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline_rounded,
                          size: 48, color: AppColors.error),
                      const SizedBox(height: 12),
                      Text(
                        'Virhe ladattaessa sanastoa\nLỗi tải dữ liệu từ vựng',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.headingSm,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        err.toString(),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.caption,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref.invalidate(vocabulariesListStreamProvider),
                        child: const Text('Yritä uudelleen • Thử lại'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilters(
    AsyncValue<List<String>> categoriesAsync,
    String? selectedCategory,
  ) {
    return Container(
      color: AppColors.surface,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: categoriesAsync.when(
        data: (categories) {
          final allChips = ['Kaikki', ...categories];
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: allChips.map((cat) {
                final isAll = cat == 'Kaikki';
                final isSelected = isAll
                    ? selectedCategory == null
                    : selectedCategory == cat;

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(
                      isAll ? 'Kaikki • Tất cả' : cat,
                      style: AppTextStyles.caption.copyWith(
                        color: isSelected ? Colors.white : AppColors.surfaceDark,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.background,
                    checkmarkColor: Colors.white,
                    showCheckmark: false,
                    onSelected: (selected) {
                      ref.read(vocabularyCategoryFilterProvider.notifier).state =
                          isAll ? null : cat;
                      _currentCardIndex = 0;
                      _isShuffled = false;
                    },
                  ),
                );
              }).toList(),
            ),
          );
        },
        loading: () => const SizedBox(height: 32),
        error: (_, __) => const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildFlashcardTab(List<Vocabulary> items) {
    final activeList = _isShuffled ? _shuffledList : items;
    if (activeList.isEmpty) {
      return _buildEmptyState(
        title: 'Ei kortteja • Không có thẻ',
        subtitle: 'Valitse toinen kategoria • Hãy chọn danh mục khác',
      );
    }

    if (_currentCardIndex >= activeList.length) {
      _currentCardIndex = 0;
    }

    final currentVocab = activeList[_currentCardIndex];
    final total = activeList.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Counter & Control row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Kortti ${_currentCardIndex + 1} / $total',
                  style: AppTextStyles.labelMd.copyWith(color: AppColors.primary),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.shuffle_rounded,
                      color: _isShuffled ? AppColors.primary : AppColors.neutral,
                    ),
                    tooltip: _isShuffled
                        ? 'Palauta järjestys • Bỏ xáo trộn'
                        : 'Sekoita kortit • Xáo trộn thẻ',
                    onPressed: () {
                      if (_isShuffled) {
                        _resetShuffle();
                      } else {
                        _shuffleCards(items);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Central Flashcard with Key for smooth flip reset on item change
          FlashcardView(
            key: ValueKey(currentVocab.id),
            vocabulary: currentVocab,
          ),

          const SizedBox(height: 24),

          // Action Buttons: Previous, Progress Bar, Next
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton.icon(
                onPressed: _currentCardIndex > 0
                    ? () => setState(() => _currentCardIndex--)
                    : null,
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('Edellinen'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.border),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _currentCardIndex < total - 1
                    ? () => setState(() => _currentCardIndex++)
                    : () => setState(() => _currentCardIndex = 0),
                icon: Icon(_currentCardIndex < total - 1
                    ? Icons.arrow_forward_rounded
                    : Icons.replay_rounded),
                label: Text(_currentCardIndex < total - 1
                    ? 'Seuraava'
                    : 'Aloita alusta'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListTab(List<Vocabulary> items) {
    final query = ref.watch(vocabularySearchQueryProvider).toLowerCase().trim();
    final filtered = items.where((v) {
      if (query.isEmpty) return true;
      return v.finnish.toLowerCase().contains(query) ||
          v.vietnamese.toLowerCase().contains(query) ||
          v.english.toLowerCase().contains(query);
    }).toList();

    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: _searchController,
            onChanged: (val) {
              ref.read(vocabularySearchQueryProvider.notifier).state = val;
            },
            decoration: InputDecoration(
              hintText: 'Hae sanastoa • Tìm từ vựng (suomi, tiếng Việt)...',
              hintStyle: AppTextStyles.bodyMd.copyWith(color: AppColors.neutralLight),
              prefixIcon: const Icon(Icons.search_rounded, color: AppColors.neutral),
              suffixIcon: query.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded, size: 20),
                      onPressed: () {
                        _searchController.clear();
                        ref.read(vocabularySearchQueryProvider.notifier).state = '';
                      },
                    )
                  : null,
              filled: true,
              fillColor: AppColors.surface,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.border),
              ),
            ),
          ),
        ),

        // List
        Expanded(
          child: filtered.isEmpty
              ? _buildEmptyState(
                  title: 'Ei tuloksia • Không tìm thấy từ phù hợp',
                  subtitle: 'Kokeile toista hakusanaa • Thử từ khóa khác',
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = filtered[index];
                    return _buildVocabListItem(item);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildVocabListItem(Vocabulary item) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Row(
          children: [
            Text(
              item.finnish,
              style: AppTextStyles.bilingualPrimary.copyWith(
                fontSize: 17,
                color: AppColors.surfaceDark,
              ),
            ),
            if (item.pronunciation != null && item.pronunciation!.isNotEmpty) ...[
              const SizedBox(width: 8),
              Text(
                '/${item.pronunciation}/',
                style: AppTextStyles.caption.copyWith(
                  fontStyle: FontStyle.italic,
                  color: AppColors.neutral,
                ),
              ),
            ],
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.vietnamese,
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (item.english.isNotEmpty)
                Text(
                  item.english,
                  style: AppTextStyles.caption.copyWith(color: AppColors.neutral),
                ),
            ],
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.volume_up_rounded, color: AppColors.primary),
          onPressed: () => _playWordAudio(item.finnish, url: item.audioUrl),
          tooltip: 'Kuuntele • Nghe phát âm',
        ),
        onTap: () => _showDetailSheet(item),
      ),
    );
  }

  void _showDetailSheet(Vocabulary item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.finnish,
                          style: AppTextStyles.headingLg,
                        ),
                        if (item.pronunciation != null &&
                            item.pronunciation!.isNotEmpty)
                          Text(
                            '/${item.pronunciation}/',
                            style: AppTextStyles.bodyMd.copyWith(
                              fontStyle: FontStyle.italic,
                              color: AppColors.neutral,
                            ),
                          ),
                      ],
                    ),
                  ),
                  IconButton.filledTonal(
                    icon: const Icon(Icons.volume_up_rounded, color: AppColors.primary),
                    onPressed: () => _playWordAudio(item.finnish, url: item.audioUrl),
                  ),
                ],
              ),
              const Divider(height: 24),
              Text(
                'Tiếng Việt: ${item.vietnamese}',
                style: AppTextStyles.bodyLg.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryDark,
                ),
              ),
              if (item.english.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  'English: ${item.english}',
                  style: AppTextStyles.bodyMd.copyWith(color: AppColors.neutral),
                ),
              ],
              if (item.example != null && item.example!.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Esimerkki • Ví dụ:',
                        style: AppTextStyles.labelMd.copyWith(color: AppColors.primary),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.example!,
                        style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w500),
                      ),
                      if (item.exampleTranslation != null &&
                          item.exampleTranslation!.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          item.exampleTranslation!,
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState({required String title, required String subtitle}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.style_outlined, size: 64, color: AppColors.neutralLight),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.headingSm.copyWith(color: AppColors.surfaceDark),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMd.copyWith(color: AppColors.neutral),
            ),
          ],
        ),
      ),
    );
  }
}
