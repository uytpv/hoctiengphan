# Tổng quan NestJS API Boilerplate (Bước 2)

**Bước 2** đã được thực thi thành công mỹ mãn. Dưới đây là kiến trúc Backend mà hệ thống vừa khởi tạo dựa trên tài liệu thiết kế của bạn.

---

### Xác thực & Phân quyền (Auth & Guards)

Toàn bộ hệ thống được bảo vệ bởi hai Guard tuỳ biến:

1. **`AuthGuard` (Người dùng cơ bản)**
   Sử dụng thư viện `firebase-admin` để verify JWT ID Token. Nếu Token hợp lệ, Guard này đẩy payload người dùng vào một custom decorator `@CurrentUser()`.

2. **`AdminGuard` (Biện pháp bảo vệ cấp cao)**
   Thay vì chỉ kiểm tra custom claims hay token, Guard này được thiết lập để trực tiếp đọc Document của người dùng trên collection `users`. Nếu `isAdmin !== true` hệ thống sẽ ném `ForbiddenException` và block request.

### DTOs & Validation

Tất cả các body payload nhận vào được định dạng trong thư mục `/dto` và được ràng buộc chặt chẽ bằng thư viện Validator (`class-validator`). Việc này đảm bảo hệ thống bạn không gặp lỗi parse dữ liệu (như truyền Type nhầm lẫn, hoặc thiếu Param Request).

```typescript
// NestJS main.ts
app.useGlobalPipes(new ValidationPipe({ whitelist: true, transform: true }));
```

### Business Modules (Controllers & Services)

Tôi đã thiết lập logic mapping Controller Request sang Firestore thông qua 4 layer tách biệt ở thư mục `backend/src`:

*   `/vocabulary`: Endpoints quản lý và thêm từ vựng (Kiểm soát riêng lẻ `Global` list vs `Personal` list).  
*   `/grammar`: Endpoints quản lý chi tiết bài giảng ngữ pháp.  
*   `/study-plan`: Endpoints cung cấp lộ trình (roadmaps) cấu trúc.  
*   `/progress`: Endpoints Get và Update trạng thái hoàn thành task `/user/progress`.  

> [!TIP]
> Hệ thống Backend đã được compile thành công (`npm run build` kết xuất 0 lỗi). Module `FirebaseService` sẽ đảm nhiệm injection singleton giúp kết nối Firestore tái sử dụng được ở toàn bộ Controllers. 

---

### Xác nhận chuyển tiếp

Toàn bộ phần lõi thao tác REST API tới Database Firebase Model từ Server-Side coi như sẵn sàng. 

Lúc này, chúng ta sẽ bắt đầu chuyển sang **Bước 3: Flutter Mobile - Cấu trúc thư mục, State Management (Riverpod / BLoC) và Data Models.** Xin vui lòng cho tôi biết bạn đang muốn sử dụng `Riverpod` hay `BLoC` trước khi bắt đầu!
