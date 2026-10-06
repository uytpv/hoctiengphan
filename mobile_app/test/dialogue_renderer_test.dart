import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/core/common/widgets/markdown_content_renderer.dart';

void main() {
  testWidgets('Test MarkdownContentRenderer parses all standardized dialogue lessons cleanly', (WidgetTester tester) async {
    final lessonFiles = [
      '../content/lessons/chapter_01_lessons.json',
      '../content/lessons/chapter_02_lessons.json',
      '../content/lessons/chapter_03_lessons.json',
      '../content/lessons/chapter_04_lessons.json',
      '../content/lessons/chapter_05_lessons.json',
      '../content/lessons/chapter_07_lessons.json',
      '../content/lessons/chapter_08_lessons.json',
      '../content/lessons/chapter_09_lessons.json',
    ];

    final targetLessonIds = [
      'w1_d1_thoai_heijatervetuloa',
      'w3_d1_thoai_minkamaalainen',
      'w3_d3_giaotiep_jatskikiskalla',
      'w5_d3_giaotiep_hinnat_puhekieli',
      'w6_d1_thoai_pedro_soittaa_mikolle',
      'w6_d4_luyennghe_saakeskustelu',
      'w7_d1_giaotiep_dangky_khoahoc',
      'w8_d3_giaotiep_lomake',
      'w9_d1_thoai_mina',
      'w9_d3_tuvung_vaatteet_varit',
      'w11_d3_khoidong_kappale5',
      'w12_d1_tuvung_sinhhoat_hangngay',
      'w14_d3_khoidong_kappale6',
      'w18_d1_tuvung_matkustaminen_hotelli',
      'w20_d1_tuvung_kulkuvalineet_liikenne',
      'w23_d1_giaotiep_laakarissa_terveyskeskus',
    ];

    for (final filepath in lessonFiles) {
      final file = File(filepath);
      if (!file.existsSync()) continue;

      final data = jsonDecode(file.readAsStringSync());
      final lessons = data['lessons'] as List<dynamic>;

      for (final rawLesson in lessons) {
        final id = rawLesson['id'] as String;
        if (!targetLessonIds.contains(id)) continue;

        final content = rawLesson['content'] as String;
        expect(content, isNotEmpty);
        expect(content.contains('[dialogue:') || content.contains('[reader:'), isTrue,
            reason: 'Lesson $id should contain [dialogue:] or [reader:] tags');

        // Test rendering inside a MaterialApp
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: MarkdownContentRenderer(content: content),
              ),
            ),
          ),
        );

        // Verify widgets pump without crashing
        expect(tester.takeException(), isNull, reason: 'Rendering lesson $id should not throw an exception');
      }
    }
  });
}
