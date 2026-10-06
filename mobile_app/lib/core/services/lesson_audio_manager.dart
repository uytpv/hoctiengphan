import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';

/// Quản lý phát âm thanh tập trung cho toàn bộ màn hình bài học.
/// Đảm bảo tại một thời điểm CHỈ CÓ DUY NHẤT 1 file âm thanh được phát.
/// Tự động dừng file trước đó khi bấm phát file mới.
class LessonAudioManager extends ChangeNotifier {
  static final LessonAudioManager instance = LessonAudioManager._internal();

  LessonAudioManager._internal() {
    _init();
  }

  final AudioPlayer _player = AudioPlayer();
  String? _currentUrl;
  String _title = '';
  PlayerState _playerState = PlayerState.stopped;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  double _speed = 1.0;

  String? get currentUrl => _currentUrl;
  String get title => _title;
  PlayerState get playerState => _playerState;
  bool get isPlaying => _playerState == PlayerState.playing;
  bool get hasTrack => _currentUrl != null && _currentUrl!.isNotEmpty;
  Duration get duration => _duration;
  Duration get position => _position;
  double get speed => _speed;

  void _init() {
    _player.onDurationChanged.listen((d) {
      _duration = d;
      notifyListeners();
    });

    _player.onPositionChanged.listen((p) {
      _position = p;
      notifyListeners();
    });

    _player.onPlayerStateChanged.listen((state) {
      _playerState = state;
      notifyListeners();
    });
  }

  /// Phát audio từ URL. Nếu URL trùng đang phát thì tạm dừng / tiếp tục.
  /// Nếu là URL mới thì dừng ngay bài cũ và bắt đầu bài mới.
  Future<void> play(String url, {String? title}) async {
    if (url.isEmpty) return;

    if (_currentUrl == url) {
      if (isPlaying) {
        await _player.pause();
      } else {
        await _player.resume();
      }
      return;
    }

    // Đang phát bài khác -> dừng ngay bài cũ
    await _player.stop();
    _currentUrl = url;
    _title = title ?? _guessTitleFromUrl(url);
    _position = Duration.zero;
    _duration = Duration.zero;
    notifyListeners();

    try {
      await _player.setPlaybackRate(_speed);
      await _player.play(UrlSource(url));
    } catch (e) {
      debugPrint('[LessonAudioManager] Error playing audio: $e');
    }
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> resume() async {
    if (hasTrack) {
      await _player.resume();
    }
  }

  Future<void> togglePlay() async {
    if (isPlaying) {
      await pause();
    } else {
      await resume();
    }
  }

  Future<void> seek(Duration pos) async {
    if (hasTrack) {
      await _player.seek(pos);
    }
  }

  /// Tua nhanh hoặc lùi lại số giây tương đối (vd: -5 hoặc +5 giây)
  Future<void> seekRelative(int seconds) async {
    if (!hasTrack) return;
    var newPos = _position + Duration(seconds: seconds);
    if (newPos < Duration.zero) newPos = Duration.zero;
    if (_duration > Duration.zero && newPos > _duration) newPos = _duration;
    await seek(newPos);
  }

  /// Đổi tốc độ phát: 0.8x -> 1.0x -> 1.2x -> 0.8x
  Future<void> cycleSpeed() async {
    double nextSpeed;
    if (_speed < 0.9) {
      nextSpeed = 1.0;
    } else if (_speed < 1.1) {
      nextSpeed = 1.2;
    } else {
      nextSpeed = 0.8;
    }
    await setSpeed(nextSpeed);
  }

  Future<void> setSpeed(double newSpeed) async {
    _speed = newSpeed;
    if (hasTrack) {
      await _player.setPlaybackRate(_speed);
    }
    notifyListeners();
  }

  /// Tắt hoàn toàn player và reset trạng thái
  Future<void> stop() async {
    await _player.stop();
    _currentUrl = null;
    _title = '';
    _position = Duration.zero;
    _duration = Duration.zero;
    notifyListeners();
  }

  /// Reset khi rời khỏi màn hình bài học
  void reset() {
    _player.stop();
    _currentUrl = null;
    _title = '';
    _position = Duration.zero;
    _duration = Duration.zero;
    _speed = 1.0;
    notifyListeners();
  }

  String _guessTitleFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final seg = uri.pathSegments.last;
      final decoded = Uri.decodeComponent(seg);
      // Lấy tên file
      final fileName = decoded.split('/').last.split('?').first;
      return fileName.replaceAll('_', ' ').replaceAll('.mp3', '');
    } catch (_) {
      return 'Âm thanh bài học';
    }
  }
}
