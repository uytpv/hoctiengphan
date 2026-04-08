import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kSecondaryLanguageKey = 'secondary_language';

/// Secondary language preference — 'vi' or 'en'
class LanguageNotifier extends Notifier<String> {
  @override
  String build() => 'vi'; // default to Vietnamese

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_kSecondaryLanguageKey);
    if (saved != null) state = saved;
  }

  Future<void> setLanguage(String lang) async {
    state = lang;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kSecondaryLanguageKey, lang);
  }

  bool get isVietnamese => state == 'vi';
}

final languageProvider =
    NotifierProvider<LanguageNotifier, String>(LanguageNotifier.new);
