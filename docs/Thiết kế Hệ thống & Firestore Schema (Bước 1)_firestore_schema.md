# Thiết kế Hệ thống & Firestore Schema (Bước 1)

Dự án: **Opi Suomea** (Học tiếng Phần Lan)

Dưới đây là cấu trúc CSDL NoSQL tập trung vào việc **tối ưu số lượng Read/Write** (gộp dữ liệu vào document khi hợp lý để giảm thiểu số lần đọc, nhưng vẫn giữ Document < 1MB) và thiết lập **Tuyên bố phân quyền (Security Rules)** chặt chẽ.

---

## 1. Cấu trúc Collections & Documents (JSON Schema)

### 1.1 `users` Collection
Lưu trữ hồ sơ cá nhân của người dùng.
```json
// Path: users/{uid}
{
  "uid": "firebase_auth_uid",
  "displayName": "Nguyen Van A",
  "email": "a@example.com",
  "photoUrl": "...",
  "createdAt": "2024-05-01T00:00:00Z",
  "lastLoginAt": "2024-05-01T00:00:00Z",
  // Phân quyền admin sẽ dùng Custom Claims (admin: true) trên Firebase Auth thay vì lưu ở đây
}
```

### 1.2 `user_progress` Collection
Để hạn chế việc đọc quá nhiều Document con, tiến độ của người dùng nên được nhóm theo **[Lộ trình Từng Tuần]** thay vì tạo Document riêng cho từng Task.
```json
// Path: user_progress/{uid}/weekly_progress/{weekId} (VD weekId: "m1w1")
{
  "weekId": "m1w1",
  "completedTasks": {
    "task_abc123": true, // ID của task -> trạng thái hoàn thành
    "task_def456": true 
  },
  "progressPercentage": 25.5, // 25.5% tuần 1 tháng 1
  "updatedAt": "2024-05-01T10:00:00Z"
}
```

### 1.3 `roadmaps` Collection
Vì 1 tuần có khoảng 7 ngày x 3-4 tasks = ~20-30 tasks (Rất nhẹ). Chúng ta nên lưu gộp lộ trình **theo Tuần** vào 1 Document. Khi người dùng mở app lên ở tuần nào, chỉ tốn **đúng 1 Read** để lấy toàn bộ lịch học của tuần đó.
```json
// Path: roadmaps/{weekId} (VD: "m1w1" - Month 1, Week 1)
{
  "id": "m1w1",
  "month": 1,
  "week": 1,
  "title": "Tuần 1: Chào hỏi cơ bản",
  "days": {
    "monday": [
        {
          "id": "task_abc123",
          "title": "Nghe hội thoại trang 12",
          "detail": "Mở file audio 1.2 và lặp lại.",
          "iconType": "audio",
          "grammarLink": "grammar_kappale1_verb" // Trỏ sang ID của bài ngữ pháp nếu có
        }
    ],
    "tuesday": [ /* ... */ ],
    "wednesday": [ /* ... */ ]
  },
  "createdAt": "...",
  "updatedBy": "admin_uuid"
}
```

### 1.4 `vocabularies` Collection
Gộp chung cả Từ vựng Global và Personal vào 1 collection. Ta sẽ truy vấn dựa trên trường `isGlobal` và `userId`.
```json
// Path: vocabularies/{vocabId}
{
  "id": "vocabId_123",
  "finnish": "Moi",
  "english": "Hello",
  "vietnamese": "Xin chào",
  "category": "Greeting",
  
  "isGlobal": true, // Nếu false thì đây là từ vựng cá nhân
  "userId": "firebase_auth_uid", // Null nếu là Global, chứa UID nếu là Personal
  
  "createdAt": "...",
}
```

### 1.5 `grammar_lessons` Collection
Lưu trữ nội dung ngữ pháp. Rich Text / HTML có thể khá tốn text nên lưu riêng biệt để lúc nào List Chapter thì không cần tải HTML, lúc bào xem Detail mới tải.
```json
// Path: grammar_lessons/{lessonId} (VD: "grammar_kappale1_verb")
{
  "id": "grammar_kappale1_verb",
  "chapter": 1, 
  "chapterName": "Kappale 1",
  "title": "Động từ nhóm 1 (Verbityyppi 1)",
  "shortDescription": "Cách chia động từ kết thúc bằng 2 nguyên âm.",
  "htmlContent": "<h1>Verbityyppi 1</h1>...", // Có thể đẩy sang sub-collection nếu HTML quá dài, nhưng cơ bản < 1MB thì lưu trực tiếp vẫn ổn.
  "createdAt": "..."
}
```

---

## 2. Firebase Security Rules (Phân quyền truy cập cơ sở dữ liệu)

Thiết lập các logic sau trong `firestore.rules` để bảo vệ dữ liệu, chống rò rỉ:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Hàm phụ trợ kiểm tra quyền (Xác nhận Custom Claims hoặc Document liên kết)
    function isAuthenticated() {
      return request.auth != null;
    }
    function isAdmin() {
      return request.auth != null && request.auth.token.admin == true;
    }
    function isOwner(uid) {
      return request.auth != null && request.auth.uid == uid;
    }

    // 1. users: Ai cũng có thể đọc/ghi profile CỦA CHÍNH MÌNH. Admin có toàn quyền.
    match /users/{uid} {
      allow read, write: if isOwner(uid) || isAdmin();
    }

    // 2. user_progress: Chỉ bản thân user xem và cập nhật được tiến độ học. Admin được read.
    match /user_progress/{uid}/weekly_progress/{weekId} {
      allow read: if isOwner(uid) || isAdmin();
      allow write: if isOwner(uid);
    }

    // 3. roadmaps & grammar_lessons: Ai cũng ĐỌC được, CHỈ ADMIN được tạo/sửa/xoá.
    match /roadmaps/{roadmapId} {
      allow read: if isAuthenticated();
      allow write: if isAdmin();
    }
    match /grammar_lessons/{lessonId} {
      allow read: if isAuthenticated();
      allow write: if isAdmin();
    }

    // 4. vocabularies: Quyền phức tạp hơn
    // - Ai cũng đọc được từ vựng Global.
    // - Chỉ đọc được từ vựng CÁ NHÂN nếu trùng thẻ userId.
    // - Admin tạo được bài Global. User tạo được bản ghi cá nhân của họ.
    match /vocabularies/{vocabId} {
      allow read: if isAuthenticated() && (resource.data.isGlobal == true || resource.data.userId == request.auth.uid || isAdmin());
      
      allow create: if isAuthenticated() && (
        (request.resource.data.isGlobal == false && request.resource.data.userId == request.auth.uid) || 
        isAdmin()
      );
      
      allow update, delete: if isAuthenticated() && (
        (resource.data.isGlobal == false && resource.data.userId == request.auth.uid) || 
        isAdmin()
      );
    }
  }
}
```

### Ưu điểm của cấu trúc này:
1. **Tối thiểu hoá Read Operations:** Quá trình render lịch học Daily routine theo tuần cực kỳ mượt và chỉ tốn 1 Read duy nhất (lấy toàn bộ object array từ document m1w1).
2. **Chi phí truy vấn từ vựng tối ưu:** Admin tool hay User App truy xuất đều có Index dễ dàng trên `(isGlobal, category)` hoặc `(userId, category)`.
3. **Security mạnh mẽ:** Hỗ trợ Custom Claim chặn đứng mọi ý đồ thay đổi từ bên thứ ba (Web/App giả mạo API). 

---
> Quá trình hoàn thành Bước 1 đã xong, vui lòng báo lại cho tôi nếu thiết kế sơ đồ này hợp lý để chúng ta tiếp tục sang **Bước 2: Dựng backend NestJS và các DTOs/Controllers** nhé!
