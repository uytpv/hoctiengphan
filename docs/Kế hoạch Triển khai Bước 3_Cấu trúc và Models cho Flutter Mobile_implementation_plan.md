# Kế hoạch Triển khai Bước 3: Cấu trúc & Models cho Flutter Mobile 

Dự án mobile sẽ sử dụng **Riverpod** làm State Management Framework chủ đạo kết hợp với nguyên tắc mô đun hóa theo tính năng (Feature-first architecture). Điều này sẽ mang lại khả năng mở rộng cao và theo dõi luồng State một cách dễ dàng.

## User Review Required

> [!IMPORTANT]
> - Tôi đề xuất kiến trúc **Feature-first** (gói mọi code vào feature folder như `/features/vocabulary` thay vì phân mảnh ra `/models`, `/screens`, `/controllers`). Bạn đồng ý chứ?
> - Các class model dưới đây sẽ dự định tích hợp thêm framework **Freezed** + **json_serializable** để tự động bind dữ liệu (FromJson/ToJson) cực kỳ an toàn mà không phải code tay.
> - Sau khi bạn xem qua danh sách Model bên dưới, hãy phản hồi để tôi bắt đầu sinh file code `.dart` tương ứng vào source Flutter nhé!

---

## 1. Đề xuất Cấu trúc Thư mục (Directory Structure)

Thư mục `mobile_app/lib/` sẽ chia làm hai vùng chính: `core` (dùng chung) và `features` (chia nhỏ theo tính năng).

```text
lib/
├── core/                       # Lớp lõi chia sẻ
│   ├── constants/              # String constants, config endpoints
│   ├── network/                # ApiClient, Dio interceptors 
│   ├── theme/                  # Định nghĩa Colors, TextStyles, Theme
│   ├── utils/                  # Các hàm helpers, formatters
│   └── widgets/                # Widgets dùng chung (PrimaryButton, AppLoading, ...)
├── features/                   # Mô-đun theo tính năng (Feature-first)
│   ├── auth/                   # Xử lý Login, Logout, User Profile
│   │   ├── data/               # Repositories (Gọi API hoặc Firestore)
│   │   ├── domain/             # Models đặc thù của feature này
│   │   └── presentation/       # UI (Screens, Widgets) và Controllers (Riverpod Providers)
│   ├── grammar/                # Khối Bài tập Ngữ pháp
│   ├── roadmap/                # Khối Lộ trình hiển thị Tasks
│   ├── progress/               # Khối Xử lý đánh dấu Done tasks
│   └── vocabulary/             # Khối Flashcards / Quản lý Từ vựng cá nhân
└── main.dart                   # Entry point (Setup Firebase, RunApp, ProviderScope)
```

---

## 2. Thiết kế Models (Dart Classes)

Chúng ta sẽ định hình các Models khớp 100% với JSON/API được thiết kế ở Bước 1 & Bước 2.

### 2.1 User Model
Đại diện cho thông tin người học.
```dart
class UserModel {
  final String uid;
  final String email;
  final String? displayName;
  final bool isAdmin;
  
  // Chuyển đổi Firestore Timestamp hoặc ISO String từ Backend API
  final DateTime createdAt; 
  final DateTime lastLogin;
}
```

### 2.2 Vocabulary Model
Phản chiếu danh sách từ vựng Global và Personal.
```dart
class Vocabulary {
  final String id;
  final String finnish;
  final String? english;
  final String vietnamese;
  final String category;
  
  final String? authorId; // Null nếu là global
}
```

### 2.3 Grammar Model
Một bài học ngữ pháp độc lập.
```dart
class GrammarTopic {
  final String id;
  final String chapter;
  final String title;
  final String? desc;
  
  // Chứa HTML Text hoặc nested List/Map tuỳ bạn quy định ở Editor JSON
  // List<dynamic> hoặc dynamic object nếu API trả JSON block, 
  // String nếu hệ thống API trả HTML.
  final dynamic content; 
}
```

### 2.4 Study Plan & Task Models
Kiến trúc Roadmap tương đối sâu. Model sẽ được tách nhỏ để tái sử dụng.
```dart
class StudyPlan {
  final String id;
  final String title;
  final List<StudyMonth> months;
}

class StudyMonth {
  final int id;
  final String title;
  final List<StudyWeek> weeks;
}

class StudyWeek {
  final int id;
  final String title;
  final List<StudyDay> days;
}

class StudyDay {
  final String dayName;
  final List<StudyTask> tasks;
}

class StudyTask {
  final String id;
  final String title;
  final String detail;
  final String iconType;       // enum gán với Material/Cupertino Icons
  final String? grammarLink;   // Trỏ sang id của GrammarTopic
}
```

### 2.5 Progress Model
Dùng để đối chiếu và fetch về khi mở Roadmap, lấy UID làm root. Trả về cho UI một bộ Set các Tasks để mapping icon "Check-mark".
```dart
class UserProgress {
  final String userId;
  final List<String> completedTaskIds; 
}
```

---

## Next Steps / Execution Plan

Nếu bạn đồng ý với đề xuất cấu trúc `Feature-first` kết hợp với sơ đồ Models như trên, tôi sẽ bắt đầu sử dụng lệnh ghi file lên dự án `mobile_app` để tạo toàn bộ Folder structure này và cấu hình dependency liên quan đến **Riverpod** và **Freezed**. Vui lòng nhận xét nhé!
