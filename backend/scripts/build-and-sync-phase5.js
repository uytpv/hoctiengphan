const fs = require('fs');
const path = require('path');
const admin = require('firebase-admin');
const serviceAccount = require('../hoc-tieng-phan-firebase-adminsdk-fbsvc-cbfffbc13f.json');

if (!admin.apps.length) {
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    storageBucket: 'hoc-tieng-phan.firebasestorage.app'
  });
}

const db = admin.firestore();

// ==========================================
// 1. EXERCISES (chapter_05_exercises.json)
// ==========================================
const exercises = [
  {
    id: "ex_w12_d2_kello_aika",
    title: "Cách xem giờ đồng hồ (Paljonko kello on?)",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Khi đồng hồ chỉ 7:30 (bảy giờ rưỡi), người Phần Lan nói:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Kello on puoli kahdeksan (nửa của tám giờ)",
          "Kello on puoli seitsemän",
          "Kello on seitsemän ja kolmekymmentä"
        ],
        correctIndex: 0,
        explanation: "ĐẶC TRƯNG TIẾNG PHẦN: 'puoli + số tiếp theo' = nửa tiếng trước giờ đó. 7:30 = puoli kahdeksan (nửa của 8h)."
      },
      {
        prompt: "Cụm từ 'varttia yli kymmenen' chỉ mấy giờ?",
        type: "MULTIPLE_CHOICE",
        options: [
          "10:15 (10 giờ qua 15 phút)",
          "9:45",
          "10:45"
        ],
        correctIndex: 0,
        explanation: "'vartti' = 15 phút, 'yli' = qua/hơn. 'varttia yli kymmenen' = 10 giờ 15 phút."
      },
      {
        prompt: "Cụm từ 'kymmentä vaille kaksi' chỉ mấy giờ?",
        type: "MULTIPLE_CHOICE",
        options: [
          "1:50 (2 giờ kém 10 phút)",
          "2:10",
          "10:02"
        ],
        correctIndex: 0,
        explanation: "'vaille' = kém/thiếu. 'kymmentä vaille kaksi' = kém 10 phút là đến 2 giờ."
      }
    ]
  },
  {
    id: "ex_w13_d1_verbityypit_5",
    title: "Phân loại và chia 5 Nhóm động từ (Verbityypit 1 - 5)",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Động từ 'syödä' (ăn) và 'juoda' (uống) thuộc nhóm động từ nào?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Nhóm 2 (Verbityyppi 2: tận cùng -da/-dä)",
          "Nhóm 1",
          "Nhóm 3"
        ],
        correctIndex: 0,
        explanation: "Nhóm 2 kết thúc bằng -da/-dä. Bỏ -da/-dä để tìm thân từ: syö-, juo-."
      },
      {
        prompt: "Động từ 'tulla' (đến) và 'mennä' (đi) thuộc nhóm động từ nào?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Nhóm 3 (Verbityyppi 3: -la/-lä, -na/-nä, -ra/-rä, -sta/-stä)",
          "Nhóm 2",
          "Nhóm 4"
        ],
        correctIndex: 0,
        explanation: "Nhóm 3 khi chia ngôi minä phải chèn thêm nguyên âm 'e': tulla -> tul- -> minä tulen."
      },
      {
        prompt: "Động từ 'herätä' (thức dậy) và 'pelata' (chơi thể thao) thuộc nhóm 4 (-ata/-ätä). Khi chia ngôi 'minä', từ biến đổi thế nào?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Bỏ -t-, nhân đôi nguyên âm rồi thêm -n: herää- -> herään, pelaa- -> pelaan",
          "herätän, pelatän",
          "herän, pelan"
        ],
        correctIndex: 0,
        explanation: "Quy tắc nhóm 4: -t- biến mất, nguyên âm kéo dài: herätä -> herään, pelata -> pelaan."
      }
    ]
  },
  {
    id: "ex_w13_d3_dongtu_dongtu",
    title: "Cấu trúc kết hợp: Động từ + Động từ (Infinitive)",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "'Tôi muốn học tiếng Phần Lan' được dịch sang tiếng Phần là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Minä haluan opiskella suomea.",
          "Minä haluan opiskelen suomea.",
          "Minä haluaa opiskella suomea."
        ],
        correctIndex: 0,
        explanation: "Động từ thứ hai đi sau 'haluta' luôn ở thể nguyên mẫu (Infinitive 1): haluan + opiskella."
      },
      {
        prompt: "'Bạn có thể giúp tôi được không?' là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Voitko auttaa minua?",
          "Voitko autat minua?",
          "Osaatko auttaa minua?"
        ],
        correctIndex: 0,
        explanation: "'voida' (có thể) + nguyên mẫu 'auttaa': Voitko auttaa...?"
      }
    ]
  },
  {
    id: "ex_w14_d5_kiemtra_kappale5",
    title: "Đề kiểm tra đánh giá năng lực toàn diện Chương 5",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Khi hỏi bạn 'Mihin aikaan sinä heräät aamulla?' (Mấy giờ bạn thức dậy buổi sáng?), câu trả lời chuẩn là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Herään kello seitsemän.",
          "Herään puoli seitsemän kello.",
          "Herään aika seitsemän."
        ],
        correctIndex: 0,
        explanation: "Herään kello seitsemän = Tôi thức dậy lúc 7 giờ."
      },
      {
        prompt: "Chia động từ 'tarvita' (cần thiết - Nhóm 5) cho ngôi 'me' (chúng tôi):",
        type: "MULTIPLE_CHOICE",
        options: [
          "me tarvitsemme (chèn đuôi -se-)",
          "me tarvimme",
          "me tarvitamme"
        ],
        correctIndex: 0,
        explanation: "Quy tắc nhóm 5 (-ita/-itä): Thay -ita bằng -itse- rồi thêm đuôi cá nhân: tarvita -> tarvitse- -> me tarvitsemme."
      }
    ]
  }
];

// ==========================================
// 2. LESSONS (chapter_05_lessons.json)
// ==========================================
const lessons = [
  // TUẦN 12
  {
    id: "w12_d1_tuvung_sinhhoat_hangngay",
    title: "Kappale 5: Từ vựng Các hoạt động sinh hoạt trong ngày (Trang 117-119)",
    chapter: "Kappale 5",
    week: 12,
    description: "Làm quen với nhịp sinh hoạt một ngày từ sáng thức giấc đến tối đi ngủ.",
    content: `# ⏰ Kappale 5: Tavallinen päivä (Một ngày bình thường)

Chào mừng bạn đến với **Chương 5 (Kappale 5)** của *Suomen Mestari 1*! Hôm nay chúng ta sẽ bước vào đời sống sinh hoạt hàng ngày của người dân Phần Lan.

---

### ☀️ 1. Lịch trình sinh hoạt từ sáng đến tối

| Hoạt động tiếng Phần | Nghĩa tiếng Việt | Loại động từ & Thân từ |
| :--- | :--- | :--- |
| **herätä** | thức dậy | Nhóm 4 (*herää-*) |
| **nousta ylös** | rời khỏi giường | Nhóm 3 (*nouse- ylös*) |
| **pestä hampaat** | đánh răng | Nhóm 3 (*pese- hampaat*) |
| **käydä suihkussa** | tắm vòi sen | Nhóm 2 (*käy- suihkussa*) |
| **keittää kahvia** | pha cà phê | Nhóm 1 (*keitä- kahvia*) |
| **syödä aamiaista** | ăn bữa sáng | Nhóm 2 (*syö- aamiaista*) |
| **lähteä töihin / kouluun**| đi làm / đi học | Nhóm 1 (*lähde- töihin*) |
| **tehdä töitä** | làm việc | Động từ đặc biệt (*tee- töitä*) |
| **syödä lounasta** | ăn bữa trưa | Nhóm 2 (*syö- lounasta*) |
| **tulla kotiin** | về nhà | Nhóm 3 (*tule- kotiin*) |
| **tehdä ruokaa** | nấu ăn | (*tee- ruokaa*) |
| **katsoa televisiota** | xem TV | Nhóm 1 (*katso- televisiota*) |
| **mennä nukkumaan** | đi ngủ | Nhóm 3 (*mene- nukkumaan*) |`
  },
  {
    id: "w12_d2_nguphap_xemgio_kello",
    title: "Ngữ pháp: Cách xem giờ đồng hồ (Paljonko kello on?) (Trang 120-122)",
    chapter: "Kappale 5",
    week: 12,
    description: "Học cách hỏi và nói giờ chuẩn mực: giờ đúng, giờ rưỡi, giờ hơn và giờ kém.",
    content: `# ⏱️ Ngữ pháp: Cách xem giờ (Kello ja aika)

---

### ❓ 1. Hai câu hỏi giờ thông dụng nhất
* **Paljonko kello on?** = Mấy giờ rồi?
* **Mitä kello on?** = Đồng hồ chỉ mấy giờ?
* 👉 Trả lời: **Kello on...** (Bây giờ là... giờ)

---

### 🧭 2. 4 Mốc xem giờ cốt lõi của người Phần Lan

#### A. Giờ đúng: Kello on + số
* 8:00 = **Kello on kahdeksan.**

#### B. Giờ rưỡi: Kello on PUOLI + số tiếp theo
> ⚠️ **ĐẶC BIỆT LƯU Ý:** Người Phần không nói 7 rưỡi, mà nói "nửa của 8 giờ"!
* 7:30 = **Kello on puoli kahdeksan.**
* 12:30 = **Kello on puoli yksi.**

#### C. Giờ hơn: Số phút + YLI + số giờ
* 8:10 = **Kello on kymmenen yli kahdeksan.** (10 phút qua 8 giờ).
* 8:15 = **Kello on varttia yli kahdeksan.** (*vartti* = 15 phút).

#### D. Giờ kém: Số phút + VAILLE + số giờ tiếp theo
* 7:50 = **Kello on kymmentä vaille kahdeksan.** (Kém 10 phút đến 8 giờ).
* 7:45 = **Kello on varttia vaille kahdeksan.** (Kém 15 phút đến 8 giờ).

---

### 📝 3. Thử thách xem giờ
[exercise:ex_w12_d2_kello_aika]`
  },
  {
    id: "sign_kahvikulttuuri_suomi",
    title: "Immersion Văn hóa: Cà phê Phần Lan - Quán quân tiêu thụ thế giới",
    chapter: "Kappale 5",
    week: 12,
    description: "Khám phá vì sao người Phần Lan uống tới 12 kg cà phê mỗi năm / đầu người.",
    content: `# ☕ Immersion Văn hóa: KAHVIKULTTUURI (Văn hóa Cà phê Phần Lan)

Theo thống kê của Hiệp hội Cà phê Quốc tế, **Phần Lan là quốc gia tiêu thụ cà phê số 1 thế giới**, trung bình mỗi người dân uống **4-5 tách cà phê mỗi ngày**!

---

### 🥐 Bộ đôi huyền thoại: Kahvi ja Pulla
* ☕ **Kahvitauko**: Giờ nghỉ uống cà phê bắt buộc được luật lao động Phần Lan quy định trong mọi công sở (15 phút buổi sáng và 15 phút buổi chiều).
* 🥮 **Korvapuusti**: Bánh cuộn quế thơm lừng rắc đường hạt lựu - món bánh ngọt truyền thống sinh ra để nhâm nhi cùng cà phê nóng giữa mùa đông tuyết rơi.`
  },
  {
    id: "w12_d7_tonghop_tuan12",
    title: "Tổng kết & Củng cố Tuần 12 (Kappale 5)",
    chapter: "Kappale 5",
    week: 12,
    description: "Ôn tập các hoạt động sinh hoạt hàng ngày, cách xem giờ và văn hóa cà phê.",
    content: `# 🏆 Tổng kết & Củng cố Tuần 12

* ✅ Nói được toàn bộ lịch trình một ngày từ lúc thức dậy *herätä* đến khi đi ngủ *mennä nukkumaan*.
* ✅ Thành thạo cách xem giờ hơn *yli*, giờ kém *vaille* và giờ rưỡi *puoli*.
* ✅ Hiểu nét văn hóa giờ giải lao cà phê *kahvitauko* tại công sở Phần Lan.`
  },

  // TUẦN 13
  {
    id: "w13_d1_nguphap_5_nhom_dongtu",
    title: "Ngữ pháp: Toàn cảnh 5 Nhóm động từ (Verbityypit 1 - 5) (Trang 123-125)",
    chapter: "Kappale 5",
    week: 13,
    description: "Bản đồ phân loại toàn diện 5 nhóm động từ trong tiếng Phần Lan và quy tắc tìm thân từ.",
    content: `# 🗺️ Ngữ pháp: 5 Nhóm Động từ tiếng Phần Lan (Verbityypit 1 - 5)

Mọi động từ trong tiếng Phần Lan đều rơi vào một trong 5 nhóm sau đây:

---

### 📋 Bảng tổng hợp nhận diện & Quy tắc tìm thân từ

| Nhóm | Đuôi nguyên thể | Động từ ví dụ | Quy tắc tìm thân từ | Chia ngôi minä |
| :--- | :--- | :--- | :--- | :--- |
| **Nhóm 1** | **-V + a / ä** (2 nguyên âm) | *puhua, asua* | Bỏ **-a/-ä** (áp dụng KPT) | *puhun, asun* |
| **Nhóm 2** | **-da / -dä** | *syödä, juoda* | Bỏ **-da/-dä** (không KPT) | *syön, juon* |
| **Nhóm 3** | **-la, -na, -ra, -sta** | *tulla, mennä, nousta*| Bỏ đuôi, chèn **-e-** | *tulen, menen, nousen* |
| **Nhóm 4** | **-ata, -ota, -uta** | *herätä, pelata, tavata*| Bỏ **-t-**, kéo dài nguyên âm | *herään, pelaan, tapaan* |
| **Nhóm 5** | **-ita / -itä** | *tarvita, valita* | Thay bằng **-itse-** | *tarvitsen, valitsen* |

---

### 📝 Thử thách 5 nhóm động từ
[exercise:ex_w13_d1_verbityypit_5]`
  },
  {
    id: "w13_d2_nguphap_dongtu_dongtu",
    title: "Ngữ pháp: Cấu trúc Động từ + Động từ (Verbiketju) (Trang 125)",
    chapter: "Kappale 5",
    week: 13,
    description: "Cách kết hợp hai động từ liên tiếp trong một câu: Động từ 1 chia, Động từ 2 nguyên mẫu.",
    content: `# 🔗 Ngữ pháp: Chuỗi động từ (Verbiketju)

Khi trong câu có 2 hành động đi liền nhau (ví dụ: *Tôi muốn học, Tôi có thể giúp, Tôi bắt đầu làm*):
> 👉 **Động từ thứ nhất chia theo ngôi; Động từ thứ hai giữ NGUYÊN MẪU (Infinitive 1).**

---

### 💡 Các trợ động từ phổ biến nhất
* **haluta** (muốn): *Minä haluan **nukkua**.* (Tôi muốn ngủ).
* **osata** (biết làm/có kỹ năng): *Osaatko **uida**?* (Bạn có biết bơi không?).
* **voida** (có thể): *Voitko **auttaa** minua?* (Bạn có thể giúp tôi không?).
* **täytyy / pitää** (phải): *Minun täytyy **mennä** töihin.* (Tôi phải đi làm).

---

### 📝 Bài tập tương tác
[exercise:ex_w13_d3_dongtu_dongtu]`
  },
  {
    id: "w13_d7_tonghop_tuan13",
    title: "Tổng kết & Củng cố Tuần 13 (Kappale 5)",
    chapter: "Kappale 5",
    week: 13,
    description: "Ôn tập bản đồ 5 nhóm động từ và cấu trúc kết hợp động từ.",
    content: `# 🏆 Tổng kết & Củng cố Tuần 13

* ✅ Nắm vững dấu hiệu nhận biết 5 nhóm động từ (*Verbityypit 1 - 5*).
* ✅ Biết cách chia động từ nhóm 2 (*syödä* -> *syön*), nhóm 3 (*tulla* -> *tulen*), nhóm 4 (*pelata* -> *pelaan*), nhóm 5 (*tarvita* -> *tarvitsen*).
* ✅ Thành thạo ghép chuỗi động từ: *haluan opiskella, osaan uida*.`
  },

  // TUẦN 14
  {
    id: "w14_d1_baitap_harjoitus20_29",
    title: "Bài tập thực hành: Harjoitus 20 - 29 Chương 5 (Trang 136-140)",
    chapter: "Kappale 5",
    week: 14,
    description: "Luyện giải bài tập đọc hiểu và chia động từ tổng hợp Chương 5.",
    content: `# ✍️ Bài tập thực hành: Harjoitus 20 - 29 (Trang 136-140)

Tuần thứ 14 dành cho việc củng cố phản xạ giải bài tập và làm bài kiểm tra hoàn tất Chương 5.`
  },
  {
    id: "w14_d3_khoidong_kappale6",
    title: "Khởi động Chương 6: Hội thoại Pedro ja Hanna etsivät asuntoa (Trang 146-148)",
    chapter: "Kappale 6",
    week: 14,
    description: "Mở đầu Chương 6: Tình huống tìm nhà thuê và chuyển nhà tại Phần Lan.",
    content: `# 🏠 Mở đầu Kappale 6: Etsitään asuntoa (Tìm nhà mới)

Pedro và Hanna đang chuẩn bị chuyển nhà (*muutto*). Họ vào các trang web thuê nhà như *Oikotie* và *Vuokraovi* để tìm kiếm căn hộ chung cư (*kerrostalo*) gần ga tàu điện ngầm.`
  },
  {
    id: "w14_d5_kiemtra_tongket_kappale5",
    title: "Đề kiểm tra đánh giá năng lực toàn diện: Kappale 5 (Trang 144-145)",
    chapter: "Kappale 5",
    week: 14,
    description: "Bài kiểm tra chuẩn hóa tổng kết toàn diện kiến thức Chương 5.",
    content: `# 🎓 Đề kiểm tra năng lực toàn diện: Kappale 5

Kiểm tra 3 trụ cột:
1. Từ vựng sinh hoạt thường nhật.
2. Cách xem giờ chính xác (giờ đúng, giờ rưỡi, giờ hơn, giờ kém).
3. Chia chuẩn xác 5 nhóm động từ tiếng Phần Lan.

---

### ✍️ Bắt đầu làm bài kiểm tra tương tác
[exercise:ex_w14_d5_kiemtra_kappale5]`
  },
  {
    id: "w14_d7_tongket_kappale5",
    title: "Tổng kết Giai đoạn 3: Vượt mốc 58% chặng đường!",
    chapter: "Kappale 5",
    week: 14,
    description: "Nhìn lại 14 tuần bền bỉ: Nắm vững hệ thống động từ hoàn chỉnh.",
    content: `# 🏆 Chúc mừng bạn đã hoàn thành xuất sắc Chương 5!

Bạn đã đi qua **14 / 24 tuần (Vượt qua 58% toàn bộ giáo trình Suomen Mestari 1)**!
Hệ thống động từ tiếng Phần Lan không còn là rào cản đối với bạn nữa.

Tuần tới, chúng ta sẽ bước sang **Chương 6 (Tuần 15 - 17): Nhà cửa, Đồ nội thất và Hệ thống biến cách nơi chốn Missä / Mistä / Mihin (Paikansijat)**!`
  }
];

// ==========================================
// 3. CURRICULUM WEEKS 12, 13, 14
// ==========================================
const week12 = {
  id: "week_12",
  planId: "6iWorOc6mZtnINIFBH8a",
  weekNumber: 12,
  title: "Tháng 3 - Tuần 12: Khởi động Chương 5: Sinh hoạt hàng ngày & Xem giờ",
  description: "Bắt đầu Chương 5 (Kappale 5): Từ vựng sinh hoạt từ sáng đến tối (Trang 117-119), Cách xem giờ đồng hồ Paljonko kello on? (Trang 120-122), Văn hóa cà phê số 1 thế giới Kahvikulttuuri & Pulla.",
  chapter: "Kappale 5",
  bookPages: "117-122, 126-128",
  days: [
    {
      dayIndex: 1,
      dayName: "Thứ 2",
      actions: [
        {
          id: "w12_d1_act1",
          type: "lesson_full",
          title: "Kappale 5: Từ vựng Các hoạt động sinh hoạt trong ngày (Trang 117-119)",
          goal: "Nắm vững danh sách động từ sinh hoạt từ thức dậy đến đi ngủ.",
          estimatedMinutes: 25,
          targetRefId: "w12_d1_tuvung_sinhhoat_hangngay",
          steps: [
            { stepNumber: 1, instruction: "Học các động từ herätä, nousta ylös, keittää kahvia, lähteä töihin." }
          ]
        }
      ]
    },
    {
      dayIndex: 2,
      dayName: "Thứ 3",
      actions: [
        {
          id: "w12_d2_act1",
          type: "grammar_point",
          title: "Ngữ pháp: Cách xem giờ đồng hồ (Paljonko kello on?) (Trang 120-122)",
          goal: "Làm chủ 4 cách xem giờ: đúng, rưỡi (puoli), hơn (yli), kém (vaille).",
          estimatedMinutes: 30,
          targetRefId: "w12_d2_nguphap_xemgio_kello",
          steps: [
            { stepNumber: 1, instruction: "Học quy tắc puoli, yli, vaille." },
            { stepNumber: 2, instruction: "Làm bài tập tương tác xem giờ." }
          ]
        }
      ]
    },
    {
      dayIndex: 3,
      dayName: "Thứ 4",
      actions: [
        {
          id: "w12_d3_act1",
          type: "immersion_sign",
          title: "Immersion Văn hóa: Cà phê Phần Lan - Quán quân tiêu thụ thế giới",
          goal: "Khám phá nét văn hóa Kahvitauko và bánh quế Korvapuusti.",
          estimatedMinutes: 15,
          targetRefId: "sign_kahvikulttuuri_suomi",
          steps: [
            { stepNumber: 1, instruction: "Đọc cẩm nang về văn hóa cà phê Phần Lan." }
          ]
        }
      ]
    },
    {
      dayIndex: 4,
      dayName: "Thứ 5",
      actions: [
        {
          id: "w12_d4_act1",
          type: "exercise_set",
          title: "Bài tập thực hành: Harjoitus 3 - 9 Chương 5 (Trang 126-128)",
          goal: "Rèn luyện giải bài tập xem giờ và điền động từ sinh hoạt.",
          estimatedMinutes: 25,
          targetRefId: "w12_d1_tuvung_sinhhoat_hangngay",
          steps: [
            { stepNumber: 1, instruction: "Thực hành giải bài tập trong sách." }
          ]
        }
      ]
    },
    {
      dayIndex: 5,
      dayName: "Thứ 6",
      actions: [
        {
          id: "w12_d5_act1",
          type: "lesson_slice",
          title: "Thực hành: Kể lại một ngày sinh hoạt của bạn bằng tiếng Phần",
          goal: "Tự viết thời gian biểu một ngày của chính mình.",
          estimatedMinutes: 20,
          targetRefId: "w12_d1_tuvung_sinhhoat_hangngay",
          steps: [
            { stepNumber: 1, instruction: "Viết 5 câu miêu tả thời gian biểu trong ngày." }
          ]
        }
      ]
    },
    {
      dayIndex: 6,
      dayName: "Thứ 7",
      actions: [
        {
          id: "w12_d6_act1",
          type: "custom",
          title: "Tổng kết & Củng cố Tuần 12 (Kappale 5)",
          goal: "Ôn tập toàn bộ kiến thức tuần 12.",
          estimatedMinutes: 15,
          targetRefId: "w12_d7_tonghop_tuan12",
          steps: [
            { stepNumber: 1, instruction: "Đọc tóm tắt tuần 12." }
          ]
        }
      ]
    },
    {
      dayIndex: 7,
      dayName: "Chủ Nhật",
      actions: [
        {
          id: "w12_d7_act1",
          type: "custom",
          title: "Nghỉ ngơi thư giãn (Ota rennosti)",
          goal: "Thư giãn nạp năng lượng.",
          estimatedMinutes: 15,
          targetRefId: "w12_d7_tonghop_tuan12",
          steps: [
            { stepNumber: 1, instruction: "Nghỉ ngơi cuối tuần." }
          ]
        }
      ]
    }
  ]
};

const week13 = {
  id: "week_13",
  planId: "6iWorOc6mZtnINIFBH8a",
  weekNumber: 13,
  title: "Tháng 4 - Tuần 13: Ngữ pháp Toàn cảnh 5 Nhóm Động từ (Verbityypit 1 - 5)",
  description: "Trọng tâm ngữ pháp Chương 5: Bản đồ phân loại 5 nhóm động từ tiếng Phần Lan, Quy tắc tìm thân từ và chia đuôi, Chuỗi động từ Verbiketju (Động từ + Động từ).",
  chapter: "Kappale 5",
  bookPages: "123-125, 129-135",
  days: [
    {
      dayIndex: 1,
      dayName: "Thứ 2",
      actions: [
        {
          id: "w13_d1_act1",
          type: "grammar_point",
          title: "Ngữ pháp: Toàn cảnh 5 Nhóm động từ (Verbityypit 1 - 5) (Trang 123-125)",
          goal: "Làm chủ dấu hiệu nhận biết và cách chia của cả 5 nhóm động từ.",
          estimatedMinutes: 30,
          targetRefId: "w13_d1_nguphap_5_nhom_dongtu",
          steps: [
            { stepNumber: 1, instruction: "Học bảng so sánh 5 nhóm động từ." },
            { stepNumber: 2, instruction: "Làm bài tập tương tác nhận diện nhóm." }
          ]
        }
      ]
    },
    {
      dayIndex: 2,
      dayName: "Thứ 3",
      actions: [
        {
          id: "w13_d2_act1",
          type: "grammar_point",
          title: "Ngữ pháp: Cấu trúc Động từ + Động từ (Verbiketju) (Trang 125)",
          goal: "Thành thạo ghép chuỗi trợ động từ haluta, voida, osata + Infinitive.",
          estimatedMinutes: 25,
          targetRefId: "w13_d2_nguphap_dongtu_dongtu",
          steps: [
            { stepNumber: 1, instruction: "Học cách kết hợp haluan opiskella, osaan uida." },
            { stepNumber: 2, instruction: "Làm bài tập tương tác ghép câu." }
          ]
        }
      ]
    },
    {
      dayIndex: 3,
      dayName: "Thứ 4",
      actions: [
        {
          id: "w13_d3_act1",
          type: "exercise_set",
          title: "Bài tập thực hành: Harjoitus 10 - 15 Chương 5 (Trang 129-132)",
          goal: "Rèn luyện chia các nhóm động từ 2, 3, 4, 5.",
          estimatedMinutes: 25,
          targetRefId: "w13_d1_nguphap_5_nhom_dongtu",
          steps: [
            { stepNumber: 1, instruction: "Làm bài tập chia động từ trong câu hoàn chỉnh." }
          ]
        }
      ]
    },
    {
      dayIndex: 4,
      dayName: "Thứ 5",
      actions: [
        {
          id: "w13_d4_act1",
          type: "exercise_set",
          title: "Bài tập thực hành: Harjoitus 16 - 19 Chương 5 (Trang 133-135)",
          goal: "Hoàn thiện bài tập chia câu phủ định của 5 nhóm động từ.",
          estimatedMinutes: 25,
          targetRefId: "w13_d1_nguphap_5_nhom_dongtu",
          steps: [
            { stepNumber: 1, instruction: "Thực hành chuyển đổi câu khẳng định sang phủ định." }
          ]
        }
      ]
    },
    {
      dayIndex: 5,
      dayName: "Thứ 6",
      actions: [
        {
          id: "w13_d5_act1",
          type: "lesson_slice",
          title: "Luyện tập phản xạ: Đặt câu hỏi với trợ động từ voida / osata",
          goal: "Tập giao tiếp hỏi khả năng và yêu cầu giúp đỡ.",
          estimatedMinutes: 20,
          targetRefId: "w13_d2_nguphap_dongtu_dongtu",
          steps: [
            { stepNumber: 1, instruction: "Thực hành các câu Voitko auttaa minua?, Osaatko puhua englantia?" }
          ]
        }
      ]
    },
    {
      dayIndex: 6,
      dayName: "Thứ 7",
      actions: [
        {
          id: "w13_d6_act1",
          type: "custom",
          title: "Tổng kết & Củng cố Tuần 13 (Kappale 5)",
          goal: "Ôn tập 5 nhóm động từ.",
          estimatedMinutes: 15,
          targetRefId: "w13_d7_tonghop_tuan13",
          steps: [
            { stepNumber: 1, instruction: "Đọc tóm tắt tuần 13." }
          ]
        }
      ]
    },
    {
      dayIndex: 7,
      dayName: "Chủ Nhật",
      actions: [
        {
          id: "w13_d7_act1",
          type: "custom",
          title: "Nghỉ ngơi nạp năng lượng (Ota rennosti)",
          goal: "Thư giãn cuối tuần.",
          estimatedMinutes: 15,
          targetRefId: "w13_d7_tonghop_tuan13",
          steps: [
            { stepNumber: 1, instruction: "Nghỉ ngơi thư giãn." }
          ]
        }
      ]
    }
  ]
};

const week14 = {
  id: "week_14",
  planId: "6iWorOc6mZtnINIFBH8a",
  weekNumber: 14,
  title: "Tháng 4 - Tuần 14: Hoàn thiện Chương 5 & Khởi động Chương 6",
  description: "Hoàn thiện 100% bài tập Chương 5 (Harjoitus 20 - 29), Đọc hiểu văn bản dài, Khởi động Chương 6 (Etsitään asuntoa - Tìm nhà), và Đề kiểm tra đánh giá năng lực toàn diện Kappale 5 (Vượt mốc 58% giáo trình).",
  chapter: "Kappale 5",
  bookPages: "136-148",
  days: [
    {
      dayIndex: 1,
      dayName: "Thứ 2",
      actions: [
        {
          id: "w14_d1_act1",
          type: "exercise_set",
          title: "Bài tập thực hành: Harjoitus 20 - 29 Chương 5 (Trang 136-140)",
          goal: "Giải quyết toàn bộ bài tập còn lại của Chương 5.",
          estimatedMinutes: 25,
          targetRefId: "w14_d1_baitap_harjoitus20_29",
          steps: [
            { stepNumber: 1, instruction: "Làm bài tập đọc hiểu và chia động từ tổng hợp." }
          ]
        }
      ]
    },
    {
      dayIndex: 2,
      dayName: "Thứ 3",
      actions: [
        {
          id: "w14_d2_act1",
          type: "lesson_slice",
          title: "Đọc hiểu: Một ngày bận rộn của người đi làm tại Phần Lan",
          goal: "Đọc hiểu văn bản dài vận dụng toàn bộ từ vựng và ngữ pháp đã học.",
          estimatedMinutes: 20,
          targetRefId: "w14_d1_baitap_harjoitus20_29",
          steps: [
            { stepNumber: 1, instruction: "Đọc bài và trả lời câu hỏi đọc hiểu." }
          ]
        }
      ]
    },
    {
      dayIndex: 3,
      dayName: "Thứ 4",
      actions: [
        {
          id: "w14_d3_act1",
          type: "lesson_slice",
          title: "Khởi động Chương 6: Hội thoại Pedro ja Hanna etsivät asuntoa (Trang 146-148)",
          goal: "Làm quen với chủ đề tìm nhà và chuyển nhà tại Phần Lan.",
          estimatedMinutes: 20,
          targetRefId: "w14_d3_khoidong_kappale6",
          steps: [
            { stepNumber: 1, instruction: "Đọc đoạn hội thoại tìm nhà thuê." }
          ]
        }
      ]
    },
    {
      dayIndex: 4,
      dayName: "Thứ 5",
      actions: [
        {
          id: "w14_d4_act1",
          type: "lesson_full",
          title: "Đề kiểm tra đánh giá năng lực toàn diện: Kappale 5 (Trang 144-145)",
          goal: "Kiểm tra toàn diện trước khi bước sang Chương 6.",
          estimatedMinutes: 30,
          targetRefId: "w14_d5_kiemtra_tongket_kappale5",
          steps: [
            { stepNumber: 1, instruction: "Làm bài kiểm tra tương tác tổng kết Chương 5." }
          ]
        }
      ]
    },
    {
      dayIndex: 5,
      dayName: "Thứ 6",
      actions: [
        {
          id: "w14_d5_act2",
          type: "custom",
          title: "Tổng kết Giai đoạn 3: Vượt mốc 58% chặng đường!",
          goal: "Nhìn lại hành trình 14 tuần đã qua.",
          estimatedMinutes: 15,
          targetRefId: "w14_d7_tongket_kappale5",
          steps: [
            { stepNumber: 1, instruction: "Đọc bản tổng kết tuần 14." }
          ]
        }
      ]
    },
    {
      dayIndex: 6,
      dayName: "Thứ 7",
      actions: [
        {
          id: "w14_d6_act1",
          type: "custom",
          title: "Nghỉ ngơi thư giãn (Ota rennosti)",
          goal: "Nạp năng lượng chuẩn bị đón nhận Chương 6: Nhà cửa & Nơi chốn Paikansijat.",
          estimatedMinutes: 15,
          targetRefId: "w14_d7_tongket_kappale5",
          steps: [
            { stepNumber: 1, instruction: "Thư giãn cuối tuần." }
          ]
        }
      ]
    },
    {
      dayIndex: 7,
      dayName: "Chủ Nhật",
      actions: [
        {
          id: "w14_d7_act1",
          type: "custom",
          title: "Thư giãn ngày Chủ nhật",
          goal: "Chuẩn bị cho tuần mới.",
          estimatedMinutes: 15,
          targetRefId: "w14_d7_tongket_kappale5",
          steps: [
            { stepNumber: 1, instruction: "Nghỉ ngơi." }
          ]
        }
      ]
    }
  ]
};

// ==========================================
// 4. GENERATE FILES & SYNC TO FIRESTORE
// ==========================================
async function buildAndSyncPhase5() {
  console.log('🚀 === GENERATING AND SYNCING PHASE 5 (WEEKS 12, 13, 14 - CHAPTER 5) ===\n');

  const currDir = path.resolve(__dirname, '../../content/curriculum');
  const lessDir = path.resolve(__dirname, '../../content/lessons');

  // Save local files
  fs.writeFileSync(path.join(currDir, 'chapter_05_exercises.json'), JSON.stringify({ exercises }, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/chapter_05_exercises.json');

  fs.writeFileSync(path.join(lessDir, 'chapter_05_lessons.json'), JSON.stringify({ lessons }, null, 2), 'utf8');
  console.log('✅ Generated content/lessons/chapter_05_lessons.json');

  fs.writeFileSync(path.join(currDir, 'week_12.json'), JSON.stringify(week12, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/week_12.json');

  fs.writeFileSync(path.join(currDir, 'week_13.json'), JSON.stringify(week13, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/week_13.json');

  fs.writeFileSync(path.join(currDir, 'week_14.json'), JSON.stringify(week14, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/week_14.json');

  // Sync Exercises to Firestore
  console.log('\n📝 1. Synchronizing Phase 5 Interactive Exercises into Firestore `exercises`...');
  for (const ex of exercises) {
    await db.collection('exercises').doc(ex.id).set({
      id: ex.id,
      title: ex.title,
      type: ex.type || 'MULTIPLE_CHOICE',
      questions: ex.questions,
      updatedAt: admin.firestore.FieldValue.serverTimestamp()
    }, { merge: true });
    console.log(`   ✅ Synced Exercise: [${ex.id}] ${ex.title} (${ex.questions.length} questions)`);
  }

  // Sync Lessons to Firestore
  console.log('\n📚 2. Synchronizing Phase 5 Rich Interactive Lessons into Firestore `lessons`...');
  for (const rawLesson of lessons) {
    await db.collection('lessons').doc(rawLesson.id).set({
      id: rawLesson.id,
      title: rawLesson.title,
      chapter: rawLesson.chapter || 'Kappale 5',
      week: rawLesson.week || 12,
      description: rawLesson.description || '',
      audioUrls: [],
      content: rawLesson.content,
      updatedAt: admin.firestore.FieldValue.serverTimestamp()
    }, { merge: true });

    if (rawLesson.id.startsWith('sign_') || rawLesson.id.startsWith('song_') || rawLesson.id.startsWith('video_')) {
      await db.collection('immersion_resources').doc(rawLesson.id).set({
        id: rawLesson.id,
        title: rawLesson.title,
        chapter: rawLesson.chapter || 'Kappale 5',
        description: rawLesson.description || '',
        content: rawLesson.content,
        type: rawLesson.id.startsWith('sign_') ? 'sign' : (rawLesson.id.startsWith('song_') ? 'music' : 'video'),
        updatedAt: admin.firestore.FieldValue.serverTimestamp()
      }, { merge: true });
    }

    console.log(`   ✅ Synced Lesson: [${rawLesson.id}] ${rawLesson.title}`);
  }

  // Sync Weeks 12, 13, 14 to Firestore
  console.log('\n📅 3. Synchronizing Study Plan Weeks 12, 13, 14 into Firestore `study_plan_weeks`...');
  const planId = '6iWorOc6mZtnINIFBH8a';
  const week12DocId = 'XaXj46Z8HzyPtRGrg6rb';
  const week13DocId = '4AsLMckqpKpTH3QbIcXv';
  const week14DocId = 'KJPONDdetNAP0ucijMhF';

  await db.collection('study_plan_weeks').doc(week12DocId).set({
    planId: planId,
    weekNumber: 12,
    title: week12.title,
    description: week12.description,
    days: week12.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Week 12 (doc: ${week12DocId})`);

  await db.collection('study_plan_weeks').doc(week13DocId).set({
    planId: planId,
    weekNumber: 13,
    title: week13.title,
    description: week13.description,
    days: week13.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Week 13 (doc: ${week13DocId})`);

  await db.collection('study_plan_weeks').doc(week14DocId).set({
    planId: planId,
    weekNumber: 14,
    title: week14.title,
    description: week14.description,
    days: week14.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Week 14 (doc: ${week14DocId})`);

  console.log('\n🎉 ALL PHASE 5 (WEEKS 12, 13, 14) CONTENT SYNCED SUCCESSFULLY TO FIRESTORE PRODUCTION!');
}

buildAndSyncPhase5().catch(err => {
  console.error('❌ Phase 5 Build & Sync failed:', err);
  process.exit(1);
});
