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
// 1. EXERCISES (chapter_08_exercises.json)
// ==========================================
const exercises = [
  {
    id: "ex_w20_d1_kulkuvalineet",
    title: "Từ vựng: Phương tiện Giao thông & Đi lại",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Trong tiếng Phần Lan, để nói 'Tôi đi làm bằng xe buýt', ta dùng cách ngữ pháp nào cho từ 'bussi'?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Menen töihin bussilla (-lla/llä: Adessiivi chỉ phương tiện)",
          "Menen töihin bussissa",
          "Menen töihin bussin"
        ],
        correctIndex: 0,
        explanation: "Phương tiện giao thông luôn dùng cách Adessiivi (-lla / -llä): autolla, junalla, pyörällä, metrolla."
      },
      {
        prompt: "Động từ nào có nghĩa là 'lái xe' (ô tô)?",
        type: "MULTIPLE_CHOICE",
        options: [
          "ajaa (Minä ajan autoa)",
          "kävellä",
          "matkustaa"
        ],
        correctIndex: 0,
        explanation: "ajaa = lái xe; kävellä = đi bộ; matkustaa = đi du lịch/hành trình."
      }
    ]
  },
  {
    id: "ex_w20_d3_imperfekti_positiivinen",
    title: "Ngữ pháp: Thì Quá khứ đơn (Imperfekti Khẳng định)",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Dấu hiệu ngữ pháp chung cốt lõi của thì Quá khứ đơn (Imperfekti) trong tiếng Phần Lan là chữ cái nào?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Chữ '-i-' gắn vào thân từ của động từ",
          "Chữ '-t-'",
          "Chữ '-k-'"
        ],
        correctIndex: 0,
        explanation: "Thì quá khứ đơn (Imperfekti) có dấu hiệu đặc trưng là nguyên âm '-i-': ostaa -> osti, puhua -> puhui, tulla -> tuli."
      },
      {
        prompt: "Động từ 'ostaa' (mua) ở ngôi 'hän' thì quá khứ (Anh ấy đã mua) là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Hän osti",
          "Hän ostaa",
          "Hän ostanut"
        ],
        correctIndex: 0,
        explanation: "ostaa -> thân từ osta- -> nguyên âm -a- đổi/thay thế bằng -i- trước -i-: osti."
      },
      {
        prompt: "Động từ 'syödä' (ăn) khi chia ở thì quá khứ 'Hôm qua tôi đã ăn phở' là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Eilen minä söin phoa (ö biến đổi trước i: söi-)",
          "Eilen minä syön phoa",
          "Eilen minä syöin phoa"
        ],
        correctIndex: 0,
        explanation: "Động từ 2 nguyên âm như syödä, juoda khi chuyển sang quá khứ nguyên âm thứ nhất biến đổi: syödä -> söi- -> söin; juoda -> joi- -> join."
      }
    ]
  },
  {
    id: "ex_w21_d1_imperfekti_kielto",
    title: "Ngữ pháp: Thì Quá khứ Phủ định (-nut / -nyt / -neet)",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Cấu trúc phủ định thì Quá khứ trong tiếng Phần Lan được tạo thành như thế nào?",
        type: "MULTIPLE_CHOICE",
        options: [
          "en / et / ei / emme / ette / eivät + phân từ quá khứ (-nut/-nyt số ít, -neet số nhiều)",
          "en / et / ei + động từ nguyên mẫu",
          "ei ole + động từ"
        ],
        correctIndex: 0,
        explanation: "Phủ định quá khứ = trợ động từ phủ định (en/et/ei...) + dạng phân từ quá khứ NUT/NYT (số ít) hoặc NEET (số nhiều): En ostanut, Emme ostaneet."
      },
      {
        prompt: "Câu 'Hôm qua chúng tôi đã không đi học' dịch sang tiếng Phần Lan là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Eilen me emme menneet kouluun.",
          "Eilen me emme mennä kouluun.",
          "Eilen me ei mene kouluun."
        ],
        correctIndex: 0,
        explanation: "Chủ ngữ số nhiều 'me' đi với 'emme' và phân từ đuôi số nhiều '-neet': emme menneet."
      }
    ]
  },
  {
    id: "ex_w21_d3_postpositiot",
    title: "Ngữ pháp: Hậu giới từ Vị trí (Postpositiot)",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Danh từ đứng trước các hậu giới từ như 'edessä' (phía trước), 'takana' (phía sau), 'vieressä' (bên cạnh) phải chia ở cách ngữ pháp nào?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Cách Sở hữu Genetiivi (-n)",
          "Cách Partitiivi (-a/-ä)",
          "Giữ nguyên dạng Nominatiivi"
        ],
        correctIndex: 0,
        explanation: "Hầu hết các hậu giới từ (Postpositiot) đòi hỏi danh từ đi trước phải ở cách Genetiivi (-n): auton edessä (trước xe ô tô), talon takana (sau nhà)."
      }
    ]
  },
  {
    id: "ex_w21_d5_kiemtra_kappale8",
    title: "Đề kiểm tra đánh giá năng lực toàn diện Chương 8",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Chọn câu viết đúng: 'Cuối tuần trước Pedro đã đi Tampere bằng tàu hỏa và anh ấy đã không lái xe':",
        type: "MULTIPLE_CHOICE",
        options: [
          "Viime viikonloppuna Pedro matkusti Tampereelle junalla eikä ajanut autolla.",
          "Viime viikonloppuna Pedro matkustaa Tampereelle junassa ja ei aja autolla.",
          "Viime viikonloppuna Pedro matkustanut junalle eikä ajanut autossa."
        ],
        correctIndex: 0,
        explanation: "matkustaa -> matkusti (quá khứ); junalla (Adessiivi phương tiện); eikä ajanut (phủ định quá khứ: ei + kä ajanut)."
      },
      {
        prompt: "Thẻ vé vùng HSL 'AB' có hiệu lực sử dụng trên các phương tiện nào tại Helsinki và Vantaa/Espoo vùng ven?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Tất cả các phương tiện: Metro, Xe buýt, Tàu điện Trams, Phà Suomenlinna và Tàu điện commuter trains (Lähijunat)",
          "Chỉ đi được tàu điện ngầm Metro",
          "Chỉ đi được xe buýt màu xanh"
        ],
        correctIndex: 0,
        explanation: "Hệ thống vé vùng HSL là hệ thống tích hợp liên thông toàn diện cho tất cả phương tiện công cộng trong khu vực thủ đô."
      }
    ]
  }
];

// ==========================================
// 2. LESSONS (chapter_08_lessons.json)
// ==========================================
const lessons = [
  // --- TUẦN 20 ---
  {
    id: "w20_d1_tuvung_kulkuvalineet_liikenne",
    title: "Kappale 8: Phương tiện Giao thông & Đi lại (Trang 209-213)",
    chapter: "Kappale 8",
    week: 20,
    description: "Khởi động Chương 8: Tên các phương tiện giao thông, cách dùng Adessiivi (-lla/-llä) và đối thoại mua vé tàu.",
    content: `# Kappale 8: Liikenne ja kulkuvälineet (Giao thông và Phương tiện)

Chào mừng bạn đến với **Chương 8 (Kappale 8)** của giáo trình *Suomen Mestari 1*! Đây là chương học cực kỳ quan trọng đưa bạn sang một bước ngoặt lớn về ngôn ngữ: **Thì Quá khứ đơn (Imperfekti)** và **Kể lại các sự kiện đã diễn ra**.

---

## 1. Bảng từ vựng Phương tiện giao thông (Kulkuvälineet)

Khi nói "đi bằng phương tiện gì", ta thêm hậu tố **-lla / -llä** vào danh từ phương tiện:

| Phương tiện (Nominatiivi) | Đi bằng phương tiện đó (Adessiivi) | Nghĩa tiếng Việt |
| :--- | :--- | :--- |
| **bussi** | bussi**lla** | bằng xe buýt |
| **juna** | juna**lla** | bằng tàu hỏa |
| **metro** | metro**lla** | bằng tàu điện ngầm |
| **raitiovaunu (ratikka)** | raitiovaunu**lla** (ratika**lla**) | bằng xe điện mặt đất |
| **auto** | auto**lla** | bằng xe hơi ô tô |
| **polkupyörä (pyörä)** | pyörä**llä** | bằng xe đạp |
| **laiva** | laiva**lla** | bằng tàu thủy / phà |
| **lentokone** | lentokonee**lla** | bằng máy bay |
| **kävellä / mennä jalan** | jalan | đi bộ |

---

## 2. Các động từ di chuyển cốt lõi

- **ajaa**: lái xe (*Minä ajan autoa*)
- **matkustaa**: đi du lịch, di chuyển hành trình (*Matkustamme junalla*)
- **pyöräillä**: đạp xe đạp (*Hän pyöräilee töihin*)
- **kävellä**: đi bộ (*Kävelen kotiin*)
- **vaihtaa**: đổi xe/chuyển tuyến (*Vaihdamme bussia Pasilassa*)

---

## 3. Luyện tập tương tác ngay

[exercise:ex_w20_d1_kulkuvalineet]`
  },
  {
    id: "w20_d2_tuvung_liput_ja_aikataulut",
    title: "Từ vựng: Mua vé & Xem lịch trình giao thông (Trang 214-216)",
    chapter: "Kappale 8",
    week: 20,
    description: "Học cách hỏi mua vé, hiểu các thuật ngữ vé một chiều, khứ hồi, giờ xuất bến và bảng giờ tàu xe.",
    content: `# Liput ja aikataulut (Vé và Lịch trình chuyến đi)

Khi di chuyển bằng phương tiện công cộng tại Phần Lan, bạn cần nắm vững các thuật ngữ sau:

---

## 1. Các loại vé thông dụng

- **Kertalippu**: Vé một lượt (dùng trong 80–100 phút tùy vùng)
- **Kausilippu**: Vé tháng / vé định kỳ
- **Vuorokausilippu**: Vé 24 giờ / vé ngày
- **Meno-paluulippu**: Vé khứ hồi (đi và về)
- **Yhdensuuntainen lippu**: Vé một chiều
- **Opiskelijalippu**: Vé giảm giá dành cho học sinh/sinh viên (giảm tới 45%)

---

## 2. Các từ vựng trên bảng điện tử (Aikataulunäyttö)

| Thuật ngữ tiếng Phần | Ý nghĩa đời sống |
| :--- | :--- |
| **Lähtee** | Giờ khởi hành / Xuất bến |
| **Saapuu** | Giờ đến bến |
| **Laituri / Raide** | Bến đậu xe buýt / Đường ray sân ga tàu hỏa |
| **Myöhässä** | Bị trễ giờ (Delayed) |
| **Peruttu** | Bị hủy chuyến (Cancelled) |
| **Aikataulussa** | Đúng giờ (On time) |`
  },
  {
    id: "w20_d3_nguphap_imperfekti_perusteet",
    title: "Ngữ pháp: Thì Quá khứ đơn Imperfekti Khẳng định (Trang 217-220)",
    chapter: "Kappale 8",
    week: 20,
    description: "Khám phá thì Quá khứ đơn: Bản chất chữ -i-, quy tắc biến đổi nguyên âm trước -i- và cách chia động từ.",
    content: `# Ngữ pháp: Thì Quá khứ đơn (Imperfekti)

Thì Quá khứ đơn (Imperfekti) trong tiếng Phần Lan được dùng để diễn tả **hành động đã bắt đầu và kết thúc hoàn toàn trong quá khứ**.

---

## 1. Dấu hiệu nhận biết: Chữ '-i-'

Tất cả các hình thức khẳng định của thì quá khứ đều chứa nguyên âm **-i-** đặt ngay sau thân từ và trước đuôi ngôi nhân xưng:
- Hiện tại: *Minä osta-n* (Tôi mua)
- Quá khứ: *Minä osta-**i**-n* ➔ **ostin** (Tôi đã mua)

---

## 2. Quy tắc biến đổi nguyên âm khi gặp '-i-'

Khi đuôi thì quá khứ **-i-** kết hợp vào cuối thân từ, các nguyên âm cuối sẽ biến đổi theo quy luật sau:

### Quy tắc A: Nguyên âm đơn biến mất trước '-i-'
- **-a / -ä / -e / -i** biến mất khi đứng trước -i- của thì quá khứ:
  - *ost**a**a* ➔ ost**i** (Hän osti)
  - *leikk**i**ä* ➔ leikk**i** (Hän leikki)
  - *itk**e**ä* ➔ itk**i** (Hän itki)

### Quy tắc B: Nguyên âm đôi (syödä, juoda, tuoda, viedä)
- Nguyên âm thứ nhất biến đổi thành **ö ➔ ö / u ➔ o / i ➔ e**:
  - *syödä* ➔ thân từ syö- ➔ **söi-** ➔ *söin, söit, söi...*
  - *juoda* ➔ thân từ juo- ➔ **joi-** ➔ *join, joit, joi...*
  - *saada* ➔ thân từ saa- ➔ **sai-** ➔ *sain, sait, sai...*

---

## 3. Bảng chia mẫu động từ ở thì Quá khứ

| Ngôi | ostaa (mua) | syödä (ăn) | tulla (đến) |
| :--- | :--- | :--- | :--- |
| **minä** | ost**in** | sö**in** | tul**in** |
| **sinä** | ost**it** | sö**it** | tul**it** |
| **hän** | ost**i** | sö**i** | tul**i** |
| **me** | ost**imme** | sö**imme** | tul**imme** |
| **te** | ost**itte** | sö**itte** | tul**itte** |
| **he** | ost**ivat** | sö**ivät** | tul**ivat** |

---

## Luyện tập tương tác ngay

[exercise:ex_w20_d3_imperfekti_positiivinen]`
  },
  {
    id: "sign_hsl_lippu_vyohyke",
    title: "Immersion Đời sống: Hệ thống Vé Vùng HSL & Cách mua vé trên App",
    chapter: "Kappale 8",
    week: 20,
    description: "Giải mã các vùng vé A, B, C, D tại khu vực thủ đô Helsinki và cách sử dụng ứng dụng di động HSL.",
    content: `# Immersion Đời sống: Hệ thống Giao thông Công cộng HSL

HSL (Helsingin seudun liikenne) là hệ thống giao thông công cộng hàng đầu thế giới bao phủ Helsinki, Espoo, Vantaa và Kauniainen.

---

## 1. Phân vùng vé (Vyöhykkeet: A, B, C, D)

- **Vùng A**: Trung tâm nội đô Helsinki.
- **Vùng B**: Ngoại thành Helsinki, phần lớn Espoo và Vantaa phía nam.
- **Vùng C**: Sân bay Helsinki-Vantaa (Lentoasema), Kivistö, ngoại ô Espoo.
- **Vùng D**: Các thị trấn vệ tinh xa hơn (Kerava, Kirkkonummi, Tuusula).

> **LƯU Ý CỰC KỲ QUAN TRỌNG**:
> - Không có vé bán lẻ chỉ riêng vùng A hoặc B!
> - Bạn luôn phải mua vé kết hợp: **AB**, **BC**, **CD**, hoặc **ABC**, **ABCD**.
> - Từ trung tâm Helsinki ra sân bay cần mua vé vùng: **ABC**.

---

## 2. Kiểm tra vé (Lipuntarkastus) & Mức phạt

Phần Lan không có cổng soát vé đóng mở tại các ga tàu hay xe buýt lớn. Hành khách tự giác mua vé. Tuy nhiên:
- Luôn có các đội soát vé mặc đồng phục xanh lá bất ngờ kiểm tra trên tàu/metro.
- Tiền phạt không có vé hợp lệ (Tarkastusmaksu) là: **80€** cộng với giá vé lượt.`
  },
  {
    id: "w20_d7_tonghop_tuan20",
    title: "Tổng kết & Củng cố Tuần 20 (Kappale 8)",
    chapter: "Kappale 8",
    week: 20,
    description: "Hệ thống hóa kiến thức tuần 20: Phương tiện đi lại, mua vé HSL và chia động từ khẳng định thì quá khứ.",
    content: `# Tổng kết & Củng cố Tuần 20

Chúc mừng bạn đã hoàn thành tuần thứ 20!

---

## Điểm nhấn bạn đã nắm vững:

1. **Phương tiện**: Gắn đuôi \`-lla / -llä\` (bussilla, autolla, junalla, pyörällä).
2. **Hệ thống vé**: Vùng HSL AB / ABC, thẻ vé Kertalippu, Kausilippu.
3. **Thì Quá khứ đơn**: Dấu hiệu chữ \`-i-\` và bảng chia ngôi khẳng định (ostin, söin, tulin).`
  },

  // --- TUẦN 21 ---
  {
    id: "w21_d1_nguphap_imperfekti_kielto_nut",
    title: "Ngữ pháp: Thì Quá khứ Phủ định (-nut / -nyt / -neet) (Trang 221-224)",
    chapter: "Kappale 8",
    week: 21,
    description: "Cách cấu tạo câu phủ định trong quá khứ với trợ động từ phủ định và phân từ quá khứ NUT/NYT/NEET.",
    content: `# Ngữ pháp: Phủ định Thì Quá khứ (Imperfektin kielto)

Trong tiếng Phần Lan, để nói "Tôi đã không làm gì đó trong quá khứ", ngôn ngữ sử dụng công thức:

$$\\text{Trợ động từ phủ định (en/et/ei...)} + \\text{Phân từ quá khứ (NUT / NYT / NEET)}$$

---

## 1. Công thức chi tiết

| Ngôi | Trợ động từ | Dạng phân từ quá khứ (Partisiippi) | Ví dụ với động từ ostaa |
| :--- | :--- | :--- | :--- |
| **minä** | **en** | thân nguyên mẫu + **-nut / -nyt** | En osta**nut** |
| **sinä** | **et** | thân nguyên mẫu + **-nut / -nyt** | Et osta**nut** |
| **hän** | **ei** | thân nguyên mẫu + **-nut / -nyt** | Ei osta**nut** |
| **me** | **emme** | thân nguyên mẫu + **-neet** | Emme osta**neet** |
| **te** | **ette** | thân nguyên mẫu + **-neet** | Ette osta**neet** |
| **he** | **eivät** | thân nguyên mẫu + **-neet** | Eivät osta**neet** |

---

## 2. Quy tắc biến âm phân từ theo nhóm động từ

- **Nhóm 1 (ostaa, puhua)**: ostanut / ostaneet, puhunut / puhuneet
- **Nhóm 2 (syödä, juoda)**: syönyt / syöneet, juonut / juoneet
- **Nhóm 3 (tulla, mennä, opiskella)**: đuôi đồng hóa theo phụ âm cuối:
  - *tulla* ➔ tul**lut** / tul**leet**
  - *mennä* ➔ men**nyt** / men**neet**
  - *pestä* ➔ pes**syt** / pes**seet**
- **Nhóm 4 (herätä, siivota)**: herännyt / heränneet, siivonnut / siivonneet

---

## Luyện tập tương tác ngay

[exercise:ex_w21_d1_imperfekti_kielto]`
  },
  {
    id: "w21_d3_nguphap_postpositiot_genetiivi",
    title: "Ngữ pháp: Hậu giới từ Vị trí (Postpositiot) kết hợp Genetiivi (Trang 225-227)",
    chapter: "Kappale 8",
    week: 21,
    description: "Nắm vững các từ chỉ vị trí không gian edessä, takana, vieressä, päällä, alla đi kèm sở hữu cách Genetiivi.",
    content: `# Ngữ pháp: Hậu giới từ Vị trí (Postpositiot)

Trong tiếng Việt ta nói *"ở trước xe ô tô"*, nhưng trong tiếng Phần Lan từ chỉ vị trí đứng **ở phía sau** danh từ, gọi là **Hậu giới từ (Postpositio)**.

> **QUY TẮC BẮT BUỘC**: Danh từ đứng trước Hậu giới từ phải luôn luôn ở **Cách Sở hữu Genetiivi (-n)**!

---

## Bảng các Hậu giới từ phổ biến nhất

| Hậu giới từ | Nghĩa | Ví dụ hoàn chỉnh | Nghĩa câu |
| :--- | :--- | :--- | :--- |
| **edessä** | ở phía trước | Auto**n** edessä | Ở phía trước xe hơi |
| **takana** | ở phía sau | Talo**n** takana | Ở phía sau ngôi nhà |
| **vieressä** | ở bên cạnh | Asema**n** vieressä | Ở ngay bên cạnh nhà ga |
| **päällä** | ở bên trên | Pöydä**n** päällä | Ở bên trên mặt bàn |
| **alla** | ở bên dưới | Sängy**n** alla | Ở bên dưới gầm giường |
| **välissä** | ở chính giữa (2 vật) | Tuolien välissä | Ở giữa những chiếc ghế |
| **lähellä** | ở gần | Keskusta**n** lähellä | Ở gần khu vực trung tâm |

---

## Luyện tập tương tác ngay

[exercise:ex_w21_d3_postpositiot]`
  },
  {
    id: "sign_vr_juna_liput",
    title: "Immersion Đời sống: Đi tàu hỏa liên tỉnh VR tại Phần Lan",
    chapter: "Kappale 8",
    week: 21,
    description: "Kinh nghiệm thực tế đi tàu liên tỉnh Phần Lan (VR): Đặt chỗ toa tĩnh lặng Ekstra, toa gia đình và mang theo xe đạp.",
    content: `# Immersion Đời sống: Đi tàu liên tỉnh VR (Valtionrautatiet)

VR là tập đoàn đường sắt quốc gia Phần Lan, kết nối mọi miền đất nước bằng các đoàn tàu cao tốc hiện đại hai tầng (InterCity và Pendolino).

---

## 1. Các tiện ích độc đáo trên tàu VR

- **Ekstra-luokka**: Toa hạng thương gia yên tĩnh, có cà phê, trà miễn phí và chỗ ngồi rộng rãi.
- **Ravintolavaunu**: Toa ẩm thực nhà hàng phục vụ món thịt viên nướng Lihapullat và súp cá hồi Lohikeitto nóng sốt.
- **Perhehytti**: Toa dành cho gia đình có trẻ em kèm khu vui chơi cầu trượt mini và thư viện sách truyện thiếu nhi.
- **Hiljainen vaunu**: Toa tĩnh lặng cấm nói chuyện điện thoại lớn tiếng.

---

## 2. Mang hành lý và xe đạp

- Bạn có thể đặt chỗ gửi xe đạp (Pyöräpaikka) trên tàu với giá khoảng 4-8€.
- Tàu luôn có mạng Wifi miễn phí chất lượng cao và ổ cắm sạc điện tại mọi ghế ngồi.`
  },
  {
    id: "w21_d4_baitap_harjoitus1_18",
    title: "Bài tập thực hành: Harjoitus 1 - 18 Chương 8 (Trang 228-232)",
    chapter: "Kappale 8",
    week: 21,
    description: "Thực hành giải bài tập tổng hợp thì quá khứ đơn, phủ định quá khứ và hậu giới từ theo sách Suomen Mestari 1.",
    content: `# Bài tập thực hành: Harjoitus Chương 8

Chào mừng bạn đến với buổi thực hành giải các bài tập trọng điểm của Chương 8.

---

## Các dạng bài tập cốt lõi:

1. **Harjoitus 5 & 6 (Trang 229)**: Chuyển các câu từ thì Hiện tại sang thì Quá khứ đơn khẳng định.
2. **Harjoitus 10 (Trang 230)**: Chia động từ phủ định ở thì Quá khứ (-nut/-nyt/-neet).
3. **Harjoitus 14 (Trang 231)**: Đặt câu với Hậu giới từ vị trí kết hợp cách Genetiivi (-n edessä, -n vieressä).`
  },
  {
    id: "w21_d5_kiemtra_tongket_kappale8",
    title: "Đề kiểm tra đánh giá năng lực toàn diện: Kappale 8 (Trang 233-235)",
    chapter: "Kappale 8",
    week: 21,
    description: "Đánh giá mức độ thành thạo về phương tiện giao thông, thì quá khứ đơn và hậu giới từ vị trí.",
    content: `# Đề kiểm tra tổng kết Chương 8

Bài kiểm tra này đánh giá toàn diện khả năng làm chủ thì quá khứ và giao tiếp đi lại giao thông theo chuẩn A1.3.

---

## Thực hiện bài kiểm tra tương tác:

[exercise:ex_w21_d5_kiemtra_kappale8]`
  },
  {
    id: "w21_d7_tongket_kappale8",
    title: "Tổng kết Hoàn thành Chương 8: Chinh phục mốc 87.5%!",
    chapter: "Kappale 8",
    week: 21,
    description: "Chúc mừng bạn đã hoàn thành xuất sắc 21 tuần học! Bạn đã có thể tự tin kể lại các câu chuyện trong quá khứ.",
    content: `# Chúc mừng bạn đã hoàn thành Chương 8! 🚀

Bạn đã vượt qua tuần thứ 21 và hoàn thành trọn vẹn nội dung của **Chương 8 (Kappale 8)**.

---

## Thành tựu nổi bật bạn đã sở hữu:

- Kể lại mạch lạc những việc đã làm ngày hôm qua, tuần trước bằng thì Quá khứ đơn (Imperfekti).
- Sử dụng chuẩn xác cấu trúc phủ định trong quá khứ với phân từ \`-nut / -nyt / -neet\`.
- Định vị không gian chính xác bằng các Hậu giới từ (auton edessä, talon takana).
- Tự tin đi lại trên toàn bộ mạng lưới giao thông HSL và tàu hỏa liên tỉnh VR.

Tiếp theo là **Chương 9 (Tuần 22 & 23)**: Chủ đề Sức khỏe, Khám chữa bệnh & Tân ngữ Objekti! Sau đó là Tuần 24 thi thử tốt nghiệp toàn khóa!`
  }
];

// ==========================================
// 3. STUDY PLAN WEEKS (20 & 21)
// ==========================================
const week20 = {
  title: "Tuần 20: Phương tiện Giao thông & Thì Quá khứ đơn (Imperfekti Khẳng định)",
  description: "Bắt đầu Chương 8 (Kappale 8): Từ vựng phương tiện di chuyển, mua vé xe và làm chủ thì quá khứ đơn khẳng định.",
  days: [
    {
      dayOfWeek: 1,
      theme: "Kappale 8: Phương tiện Giao thông & Đi lại",
      activities: [
        {
          activityId: "w20_d1_act1",
          type: "LESSON",
          title: "Bài học: Phương tiện Giao thông & Đi lại (Trang 209-213)",
          description: "Mở đầu Chương 8: Học tên gọi các phương tiện và cách dùng Adessiivi (-lla/-llä).",
          durationMinutes: 30,
          targetRefId: "w20_d1_tuvung_kulkuvalineet_liikenne",
          steps: [
            { stepNumber: 1, instruction: "Ghi nhớ bảng từ vựng phương tiện: bussi, juna, metro, ratikka, auto, pyörä." },
            { stepNumber: 2, instruction: "Thực hành cấu trúc: Menen töihin bussilla / pyörällä." }
          ]
        },
        {
          activityId: "w20_d1_act2",
          type: "EXERCISE",
          title: "Bài tập tương tác: Từ vựng phương tiện đi lại",
          description: "Luyện phản xạ cách dùng phương tiện giao thông.",
          durationMinutes: 15,
          targetRefId: "ex_w20_d1_kulkuvalineet",
          steps: [
            { stepNumber: 1, instruction: "Làm bài tập trắc nghiệm trên ứng dụng." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 2,
      theme: "Mua vé Phương tiện Công cộng & Xem Lịch trình",
      activities: [
        {
          activityId: "w20_d2_act1",
          type: "LESSON",
          title: "Bài học: Vé & Bảng giờ tàu xe (Trang 214-216)",
          description: "Học các thuật ngữ mua vé Kertalippu, Kausilippu và từ vựng sân ga bến tàu.",
          durationMinutes: 30,
          targetRefId: "w20_d2_tuvung_liput_ja_aikataulut",
          steps: [
            { stepNumber: 1, instruction: "Học cách đọc bảng giờ: Lähtee, Saapuu, Raide, Myöhässä." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 3,
      theme: "Ngữ pháp Trọng tâm: Thì Quá khứ đơn Imperfekti Khẳng định",
      activities: [
        {
          activityId: "w20_d3_act1",
          type: "LESSON",
          title: "Bài học: Thì Quá khứ đơn Imperfekti Khẳng định (Trang 217-220)",
          description: "Nắm vững nguyên lý chữ -i- của thì quá khứ và quy tắc biến đổi nguyên âm.",
          durationMinutes: 35,
          targetRefId: "w20_d3_nguphap_imperfekti_perusteet",
          steps: [
            { stepNumber: 1, instruction: "Học quy tắc nguyên âm đơn biến mất trước -i- (ostaa -> ostin)." },
            { stepNumber: 2, instruction: "Học quy tắc biến đổi nguyên âm đôi (syödä -> söin, juoda -> join)." }
          ]
        },
        {
          activityId: "w20_d3_act2",
          type: "EXERCISE",
          title: "Bài tập tương tác: Chia động từ khẳng định thì quá khứ",
          description: "Thực hành chia động từ quá khứ theo các ngôi nhân xưng.",
          durationMinutes: 15,
          targetRefId: "ex_w20_d3_imperfekti_positiivinen",
          steps: [
            { stepNumber: 1, instruction: "Hoàn thành bài tập trắc nghiệm trên ứng dụng." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 4,
      theme: "Immersion Đời sống: Hệ thống Vé Vùng HSL",
      activities: [
        {
          activityId: "w20_d4_act1",
          type: "SIGN",
          title: "Immersion: Phân vùng vé HSL ABCD & Ứng dụng di động",
          description: "Tìm hiểu cách chọn vùng vé chính xác khi đi lại tại khu vực thủ đô Helsinki.",
          durationMinutes: 25,
          targetRefId: "sign_hsl_lippu_vyohyke",
          steps: [
            { stepNumber: 1, instruction: "Hiểu quy tắc mua vé vùng kết hợp: AB, BC, ABC." },
            { stepNumber: 2, instruction: "Nắm rõ quy định kiểm tra vé và tránh bị phạt." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 5,
      theme: "Luyện Nghe & Phản xạ Kể chuyện Quá khứ",
      activities: [
        {
          activityId: "w20_d5_act1",
          type: "LESSON",
          title: "Luyện nghe đối thoại: Chuyến đi cuối tuần của Alex",
          description: "Nghe và đọc bài đối thoại kể về chuyến đi của Alex bằng thì quá khứ.",
          durationMinutes: 30,
          targetRefId: "w20_d1_tuvung_kulkuvalineet_liikenne",
          steps: [
            { stepNumber: 1, instruction: "Đọc to các câu văn kể chuyện thì quá khứ." },
            { stepNumber: 2, instruction: "Gạch chân tất cả các động từ chia ở thì quá khứ." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 6,
      theme: "Thực hành Viết: Nhật ký Ngày hôm qua (Eilen tein...)",
      activities: [
        {
          activityId: "w20_d6_act1",
          type: "LESSON",
          title: "Thực hành viết: Kirjoita mitä teit eilen (Bạn đã làm gì hôm qua)",
          description: "Tập viết 6-8 câu kể về các hoạt động của bản thân trong ngày hôm qua bằng thì quá khứ.",
          durationMinutes: 30,
          targetRefId: "w20_d3_nguphap_imperfekti_perusteet",
          steps: [
            { stepNumber: 1, instruction: "Sử dụng các động từ: heräsin, söin, menin, työskentelin, luin." },
            { stepNumber: 2, instruction: "Kiểm tra đúng đuôi ngôi nhân xưng -in." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 7,
      theme: "Tổng kết & Củng cố Tuần 20",
      activities: [
        {
          activityId: "w20_d7_act1",
          type: "LESSON",
          title: "Tổng kết & Củng cố Tuần 20 (Kappale 8)",
          description: "Ôn tập tổng kết toàn bộ từ vựng và thì quá khứ đơn khẳng định.",
          durationMinutes: 20,
          targetRefId: "w20_d7_tonghop_tuan20",
          steps: [
            { stepNumber: 1, instruction: "Đọc lại bảng tóm tắt kiến thức tuần 20." }
          ]
        }
      ]
    }
  ]
};

const week21 = {
  title: "Tuần 21: Phủ định Thì Quá khứ (-nut/-neet), Hậu giới từ Vị trí & Bài tập Chương 8",
  description: "Hoàn thiện Chương 8 (Kappale 8): Nắm vững cấu trúc phủ định quá khứ, các hậu giới từ vị trí và kiểm tra năng lực.",
  days: [
    {
      dayOfWeek: 1,
      theme: "Ngữ pháp: Phủ định Thì Quá khứ (Imperfektin kielto)",
      activities: [
        {
          activityId: "w21_d1_act1",
          type: "LESSON",
          title: "Bài học: Phủ định Thì Quá khứ (-nut / -nyt / -neet) (Trang 221-224)",
          description: "Học cách tạo câu phủ định quá khứ với trợ động từ en/et/ei... và phân từ quá khứ.",
          durationMinutes: 35,
          targetRefId: "w21_d1_nguphap_imperfekti_kielto_nut",
          steps: [
            { stepNumber: 1, instruction: "Nắm vững công thức: en/et/ei + -nut/-nyt (số ít) hoặc -neet (số nhiều)." },
            { stepNumber: 2, instruction: "Học các trường hợp biến âm theo nhóm động từ." }
          ]
        },
        {
          activityId: "w21_d1_act2",
          type: "EXERCISE",
          title: "Bài tập tương tác: Phủ định thì Quá khứ",
          description: "Thực hành chuyển câu khẳng định quá khứ sang phủ định.",
          durationMinutes: 15,
          targetRefId: "ex_w21_d1_imperfekti_kielto",
          steps: [
            { stepNumber: 1, instruction: "Làm bài tập trắc nghiệm trên ứng dụng." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 2,
      theme: "Immersion Thực tế: Trải nghiệm Tàu hỏa VR",
      activities: [
        {
          activityId: "w21_d2_act1",
          type: "SIGN",
          title: "Immersion: Đi tàu hỏa liên tỉnh Phần Lan (VR)",
          description: "Khám phá các tiện ích trên tàu VR: Toa nhà hàng, toa yên tĩnh, gửi xe đạp.",
          durationMinutes: 25,
          targetRefId: "sign_vr_juna_liput",
          steps: [
            { stepNumber: 1, instruction: "Học các thuật ngữ: Ravintolavaunu, Hiljainen vaunu, Pyöräpaikka." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 3,
      theme: "Ngữ pháp: Hậu giới từ Vị trí (Postpositiot)",
      activities: [
        {
          activityId: "w21_d3_act1",
          type: "LESSON",
          title: "Bài học: Hậu giới từ Vị trí kết hợp Genetiivi (Trang 225-227)",
          description: "Học các từ edessä, takana, vieressä, päällä, alla, välissä kết hợp danh từ sở hữu -n.",
          durationMinutes: 30,
          targetRefId: "w21_d3_nguphap_postpositiot_genetiivi",
          steps: [
            { stepNumber: 1, instruction: "Ghi nhớ quy tắc danh từ đi trước luôn phải ở cách Genetiivi (-n)." },
            { stepNumber: 2, instruction: "Học thuộc bảng 7 hậu giới từ thông dụng nhất." }
          ]
        },
        {
          activityId: "w21_d3_act2",
          type: "EXERCISE",
          title: "Bài tập tương tác: Hậu giới từ vị trí",
          description: "Luyện tập đặt câu với hậu giới từ chỉ vị trí đồ vật và địa điểm.",
          durationMinutes: 15,
          targetRefId: "ex_w21_d3_postpositiot",
          steps: [
            { stepNumber: 1, instruction: "Hoàn thành bài tập trên ứng dụng." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 4,
      theme: "Thực hành Giải Bài tập Giáo trình: Harjoitus 1 - 18",
      activities: [
        {
          activityId: "w21_d4_act1",
          type: "LESSON",
          title: "Bài tập thực hành: Harjoitus 1 - 18 Chương 8 (Trang 228-232)",
          description: "Giải bài tập tổng hợp về thì quá khứ khẳng định, phủ định và hậu giới từ.",
          durationMinutes: 35,
          targetRefId: "w21_d4_baitap_harjoitus1_18",
          steps: [
            { stepNumber: 1, instruction: "Làm bài tập chia động từ quá khứ trong câu chuyện ngắn." },
            { stepNumber: 2, instruction: "Đối chiếu và phân tích cấu trúc ngữ pháp." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 5,
      theme: "Đề Kiểm tra Toàn diện Đánh giá Năng lực: Kappale 8",
      activities: [
        {
          activityId: "w21_d5_act1",
          type: "LESSON",
          title: "Đề kiểm tra đánh giá năng lực: Kappale 8 (Trang 233-235)",
          description: "Thực hiện bài kiểm tra trắc nghiệm tổng hợp toàn bộ Chương 8.",
          durationMinutes: 30,
          targetRefId: "w21_d5_kiemtra_tongket_kappale8",
          steps: [
            { stepNumber: 1, instruction: "Làm bài kiểm tra tương tác bên dưới." }
          ]
        },
        {
          activityId: "w21_d5_act2",
          type: "EXERCISE",
          title: "Bài tập tương tác: Kiểm tra tổng kết Chương 8",
          description: "Hoàn thành các câu hỏi đánh giá chuẩn A1.3.",
          durationMinutes: 15,
          targetRefId: "ex_w21_d5_kiemtra_kappale8",
          steps: [
            { stepNumber: 1, instruction: "Chọn đáp án chính xác nhất." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 6,
      theme: "Kể chuyện Quá khứ: Kể về Kỳ nghỉ vừa qua của bạn",
      activities: [
        {
          activityId: "w21_d6_act1",
          type: "LESSON",
          title: "Thực hành viết: Viime loma (Kỳ nghỉ gần đây nhất)",
          description: "Viết đoạn văn ngắn 8-10 câu kể về kỳ nghỉ hoặc một chuyến đi bằng thì quá khứ.",
          durationMinutes: 30,
          targetRefId: "w20_d1_tuvung_kulkuvalineet_liikenne",
          steps: [
            { stepNumber: 1, instruction: "Sử dụng cả câu khẳng định (matkustin, kävin) và phủ định (en ajanut)." },
            { stepNumber: 2, instruction: "Áp dụng phương tiện giao thông (-lla) và hậu giới từ vị trí." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 7,
      theme: "Tổng kết Hoàn thành Chương 8: Chinh phục mốc 87.5%",
      activities: [
        {
          activityId: "w21_d7_act1",
          type: "LESSON",
          title: "Tổng kết Hoàn thành Chương 8: Chinh phục mốc 87.5%!",
          description: "Tự hào vinh danh nỗ lực vượt bậc của bạn trước khi bước vào chương cuối cùng của giáo trình!",
          durationMinutes: 20,
          targetRefId: "w21_d7_tongket_kappale8",
          steps: [
            { stepNumber: 1, instruction: "Nghỉ ngơi và chuẩn bị tinh thần bước vào chặng về đích!" }
          ]
        }
      ]
    }
  ]
};

// ==========================================
// 4. GENERATE FILES & SYNC TO FIRESTORE
// ==========================================
async function buildAndSyncPhase8() {
  console.log('🚀 === GENERATING AND SYNCING PHASE 8 (WEEKS 20 & 21 - CHAPTER 8) ===\n');

  const currDir = path.resolve(__dirname, '../../content/curriculum');
  const lessDir = path.resolve(__dirname, '../../content/lessons');

  // Save local files
  fs.writeFileSync(path.join(currDir, 'chapter_08_exercises.json'), JSON.stringify({ exercises }, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/chapter_08_exercises.json');

  fs.writeFileSync(path.join(lessDir, 'chapter_08_lessons.json'), JSON.stringify({ lessons }, null, 2), 'utf8');
  console.log('✅ Generated content/lessons/chapter_08_lessons.json');

  fs.writeFileSync(path.join(currDir, 'week_20.json'), JSON.stringify(week20, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/week_20.json');

  fs.writeFileSync(path.join(currDir, 'week_21.json'), JSON.stringify(week21, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/week_21.json');

  // Sync Exercises to Firestore
  console.log('\n📝 1. Synchronizing Phase 8 Interactive Exercises into Firestore `exercises`...');
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
  console.log('\n📚 2. Synchronizing Phase 8 Rich Interactive Lessons into Firestore `lessons`...');
  for (const rawLesson of lessons) {
    await db.collection('lessons').doc(rawLesson.id).set({
      id: rawLesson.id,
      title: rawLesson.title,
      chapter: rawLesson.chapter || 'Kappale 8',
      week: rawLesson.week || 20,
      description: rawLesson.description || '',
      audioUrls: [],
      content: rawLesson.content,
      updatedAt: admin.firestore.FieldValue.serverTimestamp()
    }, { merge: true });

    if (rawLesson.id.startsWith('sign_') || rawLesson.id.startsWith('song_') || rawLesson.id.startsWith('video_')) {
      await db.collection('immersion_resources').doc(rawLesson.id).set({
        id: rawLesson.id,
        title: rawLesson.title,
        chapter: rawLesson.chapter || 'Kappale 8',
        description: rawLesson.description || '',
        content: rawLesson.content,
        type: rawLesson.id.startsWith('sign_') ? 'sign' : (rawLesson.id.startsWith('song_') ? 'music' : 'video'),
        updatedAt: admin.firestore.FieldValue.serverTimestamp()
      }, { merge: true });
    }

    console.log(`   ✅ Synced Lesson: [${rawLesson.id}] ${rawLesson.title}`);
  }

  // Sync Weeks 20 & 21 to Firestore
  console.log('\n📅 3. Synchronizing Study Plan Weeks 20 & 21 into Firestore `study_plan_weeks`...');
  const planId = '6iWorOc6mZtnINIFBH8a';
  const week20DocId = '0UJQeXZ0f5fjnWF1nyRf';
  const week21DocId = 'ZDEqSmGaCdgHdWVdrEQi';

  await db.collection('study_plan_weeks').doc(week20DocId).set({
    planId: planId,
    weekNumber: 20,
    title: week20.title,
    description: week20.description,
    days: week20.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Week 20 (doc: ${week20DocId})`);

  await db.collection('study_plan_weeks').doc(week21DocId).set({
    planId: planId,
    weekNumber: 21,
    title: week21.title,
    description: week21.description,
    days: week21.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Week 21 (doc: ${week21DocId})`);

  console.log('\n🎉 ALL PHASE 8 (WEEKS 20 & 21) CONTENT SYNCED SUCCESSFULLY TO FIRESTORE PRODUCTION!');
}

buildAndSyncPhase8().catch(err => {
  console.error('❌ Phase 8 Build & Sync failed:', err);
  process.exit(1);
});
