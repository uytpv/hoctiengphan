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
// 1. EXERCISES (chapter_09_exercises.json)
// ==========================================
const exercises = [
  {
    id: "ex_w22_d1_ruumiinosat_oireet",
    title: "Từ vựng: Bộ phận Cơ thể & Triệu chứng Bệnh",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Trong tiếng Phần Lan, 'päänsärky' và 'vatsakipu' lần lượt có nghĩa là gì?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Đau đầu và đau bụng",
          "Đau họng và đau lưng",
          "Sổ mũi và sốt cao"
        ],
        correctIndex: 0,
        explanation: "pää = đầu, särky = cơn nhức buốt -> päänsärky = đau đầu; vatsa = bụng, kipu = cơn đau -> vatsakipu = đau bụng."
      },
      {
        prompt: "Khi nói 'Tôi bị sốt 38.5 độ', ta nói bằng tiếng Phần Lan như thế nào?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Minulla on kuumetta 38,5 astetta.",
          "Minulla on pää kipeä.",
          "Minä olen sairaala."
        ],
        correctIndex: 0,
        explanation: "kuume = cơn sốt; kuumetta = dạng Partitiivi thường đi cùng số độ sốt."
      }
    ]
  },
  {
    id: "ex_w22_d3_objekti_perusteet",
    title: "Ngữ pháp: Quy tắc Tân ngữ Objekti (Koko-objekti vs Osa-objekti)",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Trong câu phủ định, tân ngữ (Objekti) LUÔN LUÔN phải ở cách ngữ pháp nào?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Cách Partitiivi (-a / -ä / -ta / -tä)",
          "Cách Genetiivi (-n)",
          "Cách Nominatiivi (nguyên mẫu)"
        ],
        correctIndex: 0,
        explanation: "Quy tắc vàng của ngữ pháp Phần Lan: Trong câu phủ định (kieltolause), tân ngữ luôn luôn ở cách Partitiivi (ví dụ: En osta kirjaa, En syö omenaa)."
      },
      {
        prompt: "So sánh 2 câu: 'Minä luen kirjaa' và 'Minä luen kirjan'. Sự khác biệt về mặt ý nghĩa là gì?",
        type: "MULTIPLE_CHOICE",
        options: [
          "'luen kirjaa' = đang đọc (chưa xong, hành động dang dở); 'luen kirjan' = sẽ đọc xong trọn vẹn cả cuốn sách",
          "'luen kirjaa' = đọc xong rồi; 'luen kirjan' = không đọc",
          "Hai câu hoàn toàn đồng nghĩa 100%"
        ],
        correctIndex: 0,
        explanation: "Partitiivi (kirjaa) chỉ hành động đang diễn ra chưa hoàn thành (process/incomplete). Genetiivi (kirjan) chỉ hành động hoàn tất trọn vẹn (result/complete)."
      }
    ]
  },
  {
    id: "ex_w23_d1_terveyskeskus_laakarissa",
    title: "Giao tiếp: Đi khám bác sĩ & Mua thuốc theo đơn",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Số điện thoại tư vấn y tế khẩn cấp phi cấp cứu (Päivystysapu) trên toàn Phần Lan là bao nhiêu?",
        type: "MULTIPLE_CHOICE",
        options: [
          "116 117 (hoặc gọi 112 khi nguy kịch tính mạng)",
          "911",
          "114"
        ],
        correctIndex: 0,
        explanation: "116 117 là tổng đài y tế trực tuyến toàn quốc của Phần Lan; 112 là số cấp cứu khẩn cấp nguy hiểm tính mạng."
      },
      {
        prompt: "Thuật ngữ 'Resepti' và 'Sairasloma' có nghĩa là gì?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Đơn thuốc bác sĩ kê và Giấy nghỉ phép ốm",
          "Hóa đơn viện phí và Thẻ bảo hiểm",
          "Phòng cấp cứu và Thuốc kháng sinh"
        ],
        correctIndex: 0,
        explanation: "resepti = toa thuốc; sairasloma = thời gian nghỉ bệnh có hưởng lương/trợ cấp."
      }
    ]
  },
  {
    id: "ex_w23_d5_kiemtra_kappale9",
    title: "Đề kiểm tra đánh giá năng lực toàn diện Chương 9",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Điền dạng đúng của từ vào chỗ trống: 'Lääkäri kirjoitti minulle _____ (resepti) ja minä hain _____ (lääke) apteekista.'",
        type: "MULTIPLE_CHOICE",
        options: [
          "reseptin (Genetiivi tân ngữ kết quả) / lääkkeet (số nhiều hoàn tất)",
          "reseptiä / lääkettä",
          "reseptissä / lääkkeestä"
        ],
        correctIndex: 0,
        explanation: "Hành động đã hoàn thành: viết xong 1 đơn thuốc (reseptin) và lấy thuốc xong (lääkkeet / lääkkeen)."
      },
      {
        prompt: "Khi đến hiệu thuốc (Apteekki) ở Phần Lan lấy thuốc theo đơn, bạn chỉ cần xuất trình giấy tờ gì?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Thẻ Kela-kortti hoặc Hộ chiếu/Căn cước Henkilökortti (dược sĩ sẽ tra cứu e-resepti trực tuyến)",
          "Đơn thuốc giấy viết tay có mộc đỏ",
          "Giấy xác nhận công ty"
        ],
        correctIndex: 0,
        explanation: "Phần Lan sử dụng 100% hệ thống toa thuốc điện tử quốc gia (Kanta e-resepti); chỉ cần quẹt thẻ căn cước hoặc thẻ Kela là nhà thuốc có ngay đơn thuốc."
      }
    ]
  }
];

// ==========================================
// 2. LESSONS (chapter_09_lessons.json)
// ==========================================
const lessons = [
  // --- TUẦN 22 ---
  {
    id: "w22_d1_tuvung_ruumiinosat_terveys",
    title: "Kappale 9: Bộ phận Cơ thể & Sức khỏe (Trang 236-240)",
    chapter: "Kappale 9",
    week: 22,
    description: "Mở đầu Chương 9: Tên gọi các bộ phận cơ thể người, triệu chứng bệnh tật thông thường và cách diễn đạt khi ốm.",
    content: `# Kappale 9: Terveys ja sairaus (Sức khỏe và Bệnh tật)

Chào mừng bạn đến với **Chương 9 (Kappale 9)** - Chương kiến thức trọng điểm cuối cùng của giáo trình *Suomen Mestari 1*! Chương này trang bị cho bạn đầy đủ vốn từ vựng và ngữ pháp để tự tin chăm sóc sức khỏe, đi khám bác sĩ và sử dụng hệ thống y tế Phần Lan.

---

## 1. Bảng từ vựng Bộ phận Cơ thể (Ruumiinosat)

| Tiếng Phần Lan | Nghĩa tiếng Việt | Tiếng Phần Lan | Nghĩa tiếng Việt |
| :--- | :--- | :--- | :--- |
| **pää** | đầu | **silmä** | mắt |
| **korva** | tai | **nenä** | mũi |
| **suu** | miệng | **hammas** | răng |
| **kurkku** | cổ họng | **kaula** | cổ |
| **selkä** | lưng | **vatsa / maha** | bụng |
| **käsi** | cánh tay / bàn tay | **sormi** | ngón tay |
| **jalka** | cẳng chân / bàn chân | **varvas** | ngón chân |
| **sydän** | trái tim | **iho** | da thịt |

---

## 2. Diễn đạt Triệu chứng Bệnh (Oireet)

- **Minulla on pää kipeä / Päätäni särkee**: Tôi bị đau đầu nhức óc.
- **Minulla on kurkkukipu**: Tôi bị đau rát cổ họng.
- **Minulla on vatsa kipeä**: Tôi bị đau bụng.
- **Minulla on kuumetta (38 astetta)**: Tôi bị sốt (38 độ).
- **Minulla on yskä ja nuha**: Tôi bị ho và sổ mũi cảm lạnh.
- **Minua huimaa**: Tôi bị chóng mặt hoa mắt.
- **Olen sairas / Olen kipeä**: Tôi bị ốm.

---

## 3. Luyện tập tương tác ngay

[exercise:ex_w22_d1_ruumiinosat_oireet]`
  },
  {
    id: "w22_d2_tuvung_laakkeet_ja_hoito",
    title: "Từ vựng: Thuốc & Chăm sóc Y tế (Trang 241-243)",
    chapter: "Kappale 9",
    week: 22,
    description: "Học tên các loại thuốc thông dụng, thuốc giảm đau, hạ sốt, băng gạc và cách dùng thuốc đúng chỉ định.",
    content: `# Lääkkeet ja hoito (Thuốc men và Chăm sóc y tế)

Tại Phần Lan, thuốc giảm đau nhẹ và vitamin được bán tự do, trong khi thuốc đặc trị và kháng sinh bắt buộc phải có đơn của bác sĩ.

---

## 1. Từ vựng các loại thuốc thông dụng

| Tiếng Phần Lan | Nghĩa tiếng Việt |
| :--- | :--- |
| **lääke** | thuốc điều trị (chung) |
| **särkylääke / kipulääke** | thuốc giảm đau (parasetamoli, ibuprofeeni) |
| **kuumelääke** | thuốc hạ sốt |
| **yskänsiirappi / yskänlääke** | siro ho / thuốc ho |
| **nenäsumute** | xịt mũi thông mũi |
| **laastari** | băng cá nhân dán vết thương |
| **sideharso** | băng gạc tiệt trùng |
| **antibiootti** | thuốc kháng sinh (chỉ bán theo đơn) |
| **vitamiini (D-vitamiini)** | vitamin (đặc biệt D-vitamin mùa đông) |

---

## 2. Hướng dẫn sử dụng thuốc (Käyttöohje)

- **Yksi tabletti kolme kertaa päivässä**: 1 viên, 3 lần mỗi ngày.
- **Ruoan jälkeen**: Sau bữa ăn.
- **Runsaan veden kera**: Uống với nhiều nước.`
  },
  {
    id: "w22_d3_nguphap_objekti_saannot",
    title: "Ngữ pháp: Quy luật Tân ngữ Objekti (Toàn thể vs Bộ phận) (Trang 244-247)",
    chapter: "Kappale 9",
    week: 22,
    description: "Hệ thống hóa bản chất của Tân ngữ (Objekti): Tân ngữ phủ định, Tân ngữ kết quả (Genetiivi) và Tân ngữ dang dở (Partitiivi).",
    content: `# Ngữ pháp Trọng tâm: Tân ngữ Objekti

Tân ngữ (Objekti) là đối tượng chịu tác động của hành động do động từ gây ra. Trong tiếng Phần Lan, hình thức ngữ pháp của tân ngữ quyết định **ý nghĩa trọn vẹn hay dang dở** của câu.

---

## 1. QUY TẮC SỐ 1: Tân ngữ trong Câu Phủ định LUÔN LÀ PARTITIIVI
Bất kể danh từ là gì, nếu câu có từ phủ định (*en, et, ei, emme, ette, eivät*), tân ngữ bắt buộc phải ở cách **Partitiivi**:
- *En osta **kirjaa**.* (Tôi không mua cuốn sách.)
- *Hän ei ota **lääkettä**.* (Anh ấy không uống thuốc.)
- *Emme syöneet **omenaa**.* (Chúng tôi đã không ăn quả táo.)

---

## 2. QUY TẮC SỐ 2: Trong câu khẳng định - Lựa chọn giữa Partitiivi và Genetiivi

### A. Dùng Partitiivi (Osa-objekti - Tân ngữ bộ phận):
1. **Chất liệu không đếm được**: *Juon **kahvia**.* (Tôi uống cà phê).
2. **Hành động đang tiếp diễn chưa xong**: *Luen **kirjaa**.* (Tôi đang đọc cuốn sách).
3. **Động từ chỉ cảm xúc, tư duy** (rakastaa, pelätä, auttaa...): *Rakastan **sinua**.*

### B. Dùng Genetiivi (-n) (Koko-objekti - Tân ngữ toàn thể / kết quả):
Dùng khi danh từ đếm được và hành động được thực hiện **trọn vẹn hoàn tất đến cùng**:
- *Ostan **kirjan**.* (Tôi sẽ mua cuốn sách đó - mua đứt).
- *Luin **kirjan**.* (Tôi đã đọc xong toàn bộ cuốn sách).
- *Otan **yhden tabletin**.* (Tôi uống 1 viên thuốc).

---

## Luyện tập tương tác ngay

[exercise:ex_w22_d3_objekti_perusteet]`
  },
  {
    id: "sign_terveyskeskus_kela",
    title: "Immersion Đời sống: Hệ thống Y tế Terveysasema & Thẻ Kela-kortti",
    chapter: "Kappale 9",
    week: 22,
    description: "Cách tiếp cận dịch vụ y tế công cộng Phần Lan, gọi tổng đài 116 117 và quyền lợi bảo hiểm Kela.",
    content: `# Immersion Đời sống: Dịch vụ Y tế Công cộng Phần Lan

Hệ thống y tế công cộng Phần Lan (Julkinen terveydenhuolto) nổi tiếng thế giới về tính bình đẳng, chất lượng cao và chi phí rất thấp.

---

## 1. Trạm Y tế cơ sở (Terveysasema / Terveyskeskus)

- Khi bị ốm thông thường (cảm sốt, đau họng, bong gân), bạn liên hệ với **Terveysasema** tại khu vực bạn cư trú.
- Bạn sẽ nói chuyện với y tá điều phối (Triage hoitaja) qua điện thoại để được đánh giá mức độ cấp bách và nhận lịch hẹn khám.

---

## 2. Tổng đài khẩn cấp & Ngoài giờ

- **116 117 (Päivystysapu)**: Gọi số này khi trạm y tế đóng cửa (buổi tối, cuối tuần) trước khi đến phòng cấp cứu (Päivystys).
- **112 (Hätänumero)**: Chỉ gọi khi có tai nạn đe dọa trực tiếp tính mạng (bất tỉnh, đột quỵ, tai nạn giao thông nghiêm trọng).

---

## 3. Thẻ Bảo hiểm Y tế Quốc gia Kela-kortti

Mọi cư dân đăng ký thường trú tại Phần Lan đều nhận được thẻ Kela có gắn mã số cá nhân (Henkilötunnus). Thẻ này giúp bạn được hỗ trợ chi phí khám bệnh công và được trợ cấp tiền mua thuốc tại hiệu thuốc.`
  },
  {
    id: "w22_d7_tonghop_tuan22",
    title: "Tổng kết & Củng cố Tuần 22 (Kappale 9)",
    chapter: "Kappale 9",
    week: 22,
    description: "Hệ thống hóa kiến thức tuần 22: Bộ phận cơ thể, thuốc men và quy tắc tân ngữ Partitiivi vs Genetiivi.",
    content: `# Tổng kết & Củng cố Tuần 22

Chúc mừng bạn đã hoàn thành tuần thứ 22!

---

## Tóm tắt nội dung trọng tâm:

1. **Bộ phận cơ thể**: pää, silmä, korva, kurkku, selkä, vatsa, käsi, jalka.
2. **Triệu chứng & Thuốc**: päänsärky, kuume, särkylääke, yskänsiirappi.
3. **Bản chất Tân ngữ (Objekti)**:
   - Câu phủ định: 100% Partitiivi (*En osta leipää*).
   - Câu khẳng định: Hoàn tất dùng Genetiivi (*Ostan leivän*), dang dở dùng Partitiivi (*Syön leipää*).`
  },

  // --- TUẦN 23 ---
  {
    id: "w23_d1_giaotiep_laakarissa_terveyskeskus",
    title: "Giao tiếp Thực tế: Đi Khám Bác sĩ (Lääkärissä) (Trang 248-251)",
    chapter: "Kappale 9",
    week: 23,
    description: "Mẫu câu đối thoại chuẩn với bác sĩ, giải thích triệu chứng, nhận chẩn đoán và xin giấy nghỉ ốm.",
    content: `# Giao tiếp Thực tế: Lääkärissä (Tại phòng khám Bác sĩ)

Đối thoại thực tế giữa bệnh nhân (potilas) và bác sĩ (lääkäri):

---

## 1. Hội thoại mẫu tại phòng khám

> **Lääkäri**: Päivää! Mikä teitä vaivaa? / Mikä hätänä?  
> **Potilas**: Päivää. Olen ollut kipeänä kolme päivää. Minulla on kova kurkkukipu, yskä ja kuumetta 38,5 astetta.  
> **Lääkäri**: Selvä. Katsotaanpa kurkkuun. Avatkaa suu ja sanokaa 'Aaa'... Kurkku on melko punainen. Kuuntelen vielä keuhkot. Hengittäkää syvään... ja ulos.  
> **Potilas**: Onko se jotain vakavaa?  
> **Lääkäri**: Ei hätää, kyseessä on tavallinen flunssa. Kirjoitan teille reseptin tehokkaaseen särkylääkkeeseen ja tarvitsetteko sairaslomatodistuksen töihin?  
> **Potilas**: Kyllä kiitos, kaksi päivää olisi hyvä.  
> **Lääkäri**: Kirjoitan todistuksen perjantaihin asti. Lepäilkää ja juokaa paljon lämmintä mehua! Parantukaa pian!  
> **Potilas**: Paljon kiitoksia, näkemiin!

---

## 2. Luyện tập tương tác ngay

[exercise:ex_w23_d1_terveyskeskus_laakarissa]`
  },
  {
    id: "sign_apteekki_resepti",
    title: "Immersion Thực tế: Lấy thuốc Toa Điện tử tại Hiệu thuốc Apteekki",
    chapter: "Kappale 9",
    week: 23,
    description: "Trải nghiệm lấy thuốc bằng hệ thống toa điện tử Kanta.fi tại hiệu thuốc Phần Lan.",
    content: `# Immersion Đời sống: Apteekki ja sähköinen resepti

Hiệu thuốc tại Phần Lan (Apteekki) được nhận biết bằng logo chữ thập xanh lá cây (vihreä risti).

---

## 1. Quy trình mua thuốc kê đơn (Reseptilääkkeet)

1. **Lấy số thứ tự**: Chọn nút "Reseptintoimitus" (Phục vụ thuốc kê đơn).
2. **Gặp Dược sĩ (Farmaseutti)**: Đến quầy riêng tư khi số của bạn hiện lên.
3. **Xuất trình căn cước**: Đưa thẻ Kela-kortti hoặc Hộ chiếu. Dược sĩ mở hồ sơ Kanta.fi trên màn hình để kiểm tra đơn bác sĩ vừa kê.
4. **Tư vấn thuốc**: Dược sĩ sẽ hỏi bạn có muốn đổi sang loại thuốc gốc (geneerinen lääke) tương đương có giá rẻ hơn được bảo hiểm chi trả nhiều hơn hay không (Lääkevaihto).
5. **Thanh toán**: Quẹt thẻ ngân hàng tại quầy và nhận thuốc kèm tờ hướng dẫn.`
  },
  {
    id: "w23_d4_baitap_harjoitus1_20",
    title: "Bài tập thực hành: Harjoitus 1 - 20 Chương 9 (Trang 252-257)",
    chapter: "Kappale 9",
    week: 23,
    description: "Thực hành giải bài tập tổng hợp về tân ngữ Objekti, từ vựng sức khỏe và biến cách từ loại -us/-ys.",
    content: `# Bài tập thực hành: Harjoitus Chương 9

Chào mừng bạn đến với buổi thực hành bài tập Chương 9.

---

## Các bài tập trọng điểm:

1. **Harjoitus 6 & 7 (Trang 254)**: Phân biệt và điền tân ngữ Partitiivi vs Genetiivi.
2. **Harjoitus 11 (Trang 255)**: Đặt câu diễn đạt triệu chứng với cơ thể (Minulla on... / Päätäni särkee).
3. **Harjoitus 15 (Trang 256)**: Chia dạng biến cách của các từ tận cùng bằng \`-us / -ys\` (kysymys -> kysymyksen, vastaus -> vastauksen).`
  },
  {
    id: "w23_d5_kiemtra_tongket_kappale9",
    title: "Đề kiểm tra đánh giá năng lực toàn diện: Kappale 9 (Trang 258-260)",
    chapter: "Kappale 9",
    week: 23,
    description: "Đánh giá mức độ làm chủ toàn bộ nội dung Chương 9: Sức khỏe, hội thoại bác sĩ và ngữ pháp tân ngữ.",
    content: `# Đề kiểm tra tổng kết Chương 9

Bài kiểm tra này đánh giá toàn diện năng lực của bạn sau khi hoàn thành toàn bộ 9 chương của giáo trình *Suomen Mestari 1*.

---

## Thực hiện bài kiểm tra tương tác:

[exercise:ex_w23_d5_kiemtra_kappale9]`
  },
  {
    id: "w23_d7_tongket_kappale9",
    title: "Tổng kết Hoàn thành Toàn bộ 9 Chương Giáo trình: Cán mốc 95.8%!",
    chapter: "Kappale 9",
    week: 23,
    description: "Chúc mừng bạn đã hoàn thành toàn bộ 9 chương sách giáo trình Suomen Mestari 1! Bạn đã sẵn sàng cho kỳ thi tổng kết cuối cùng.",
    content: `# CHÚC MỪNG BẠN ĐÃ HOÀN THÀNH 9 CHƯƠNG GIÁO TRÌNH! 🎉🎓

Một kỳ tích học tập đáng kinh ngạc! Bạn đã đi qua 23 tuần học miệt mài và hoàn thành toàn bộ khối lượng kiến thức khổng lồ của cuốn sách **Suomen Mestari 1**.

---

## Tổng kết hành trình 9 chương đã chinh phục:

1. **Kappale 1**: Chào hỏi, Phát âm, Bảng chữ cái, Số đếm.
2. **Kappale 2**: Quốc tịch, Ngôn ngữ, Động từ Olla, Giới thiệu bản thân.
3. **Kappale 3**: Gia đình, Thời tiết, Màu sắc, 4 Nhóm động từ cơ bản.
4. **Kappale 4**: Thời gian, Ngày giờ, Biến âm KPT, Sinh hoạt hàng ngày.
5. **Kappale 5**: Ẩm thực, Mua sắm, Cách bộ phận Partitiivi, Động từ nhóm 5-6.
6. **Kappale 6**: Nhà ở, Phòng ốc, 6 Cách vị trí Paikansijat, Huoneessa on.
7. **Kappale 7**: Du lịch, Khách sạn, Thể mệnh lệnh, Biến cách -i/-e/-nen.
8. **Kappale 8**: Giao thông HSL/VR, Thì quá khứ đơn Imperfekti (-i- / -nut).
9. **Kappale 9**: Sức khỏe, Khám bệnh, Toa thuốc Kanta, Tân ngữ Objekti.

🎯 **Tuần 24 (Tuần cuối cùng)**: Kỳ thi Thử Tốt nghiệp Toàn diện 4 Kỹ năng Nghe - Đọc - Viết - Nói chuẩn quốc tế A1.3 / A2.1!`
  }
];

// ==========================================
// 3. STUDY PLAN WEEKS (22 & 23)
// ==========================================
const week22 = {
  title: "Tuần 22: Sức khỏe, Bộ phận Cơ thể & Ngữ pháp Tân ngữ Objekti",
  description: "Bắt đầu Chương 9 (Kappale 9): Từ vựng bộ phận cơ thể, triệu chứng ốm đau và bản chất tân ngữ Partitiivi vs Genetiivi.",
  days: [
    {
      dayOfWeek: 1,
      theme: "Kappale 9: Bộ phận Cơ thể & Triệu chứng Bệnh",
      activities: [
        {
          activityId: "w22_d1_act1",
          type: "LESSON",
          title: "Bài học: Bộ phận Cơ thể & Sức khỏe (Trang 236-240)",
          description: "Học tên gọi các bộ phận cơ thể và cách diễn đạt khi bị đau ốm.",
          durationMinutes: 30,
          targetRefId: "w22_d1_tuvung_ruumiinosat_terveys",
          steps: [
            { stepNumber: 1, instruction: "Ghi nhớ bảng từ vựng các bộ phận: pää, silmä, korva, kurkku, vatsa, selkä." },
            { stepNumber: 2, instruction: "Học mẫu câu diễn đạt: Minulla on päänsärky / Minua huimaa." }
          ]
        },
        {
          activityId: "w22_d1_act2",
          type: "EXERCISE",
          title: "Bài tập tương tác: Bộ phận cơ thể & triệu chứng",
          description: "Luyện phản xạ nhận diện các triệu chứng sức khỏe.",
          durationMinutes: 15,
          targetRefId: "ex_w22_d1_ruumiinosat_oireet",
          steps: [
            { stepNumber: 1, instruction: "Làm bài tập trắc nghiệm trên ứng dụng." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 2,
      theme: "Thuốc men & Hướng dẫn Sử dụng Thuốc",
      activities: [
        {
          activityId: "w22_d2_act1",
          type: "LESSON",
          title: "Bài học: Thuốc & Chăm sóc Y tế (Trang 241-243)",
          description: "Học tên các loại thuốc thông dụng và cách đọc liều lượng sử dụng.",
          durationMinutes: 30,
          targetRefId: "w22_d2_tuvung_laakkeet_ja_hoito",
          steps: [
            { stepNumber: 1, instruction: "Ghi nhớ các từ: särkylääke, kuumelääke, yskänsiirappi, laastari." },
            { stepNumber: 2, instruction: "Học hiểu câu hướng dẫn: Yksi tabletti päivässä ruoan jälkeen." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 3,
      theme: "Ngữ pháp Trọng tâm: Quy tắc Tân ngữ Objekti",
      activities: [
        {
          activityId: "w22_d3_act1",
          type: "LESSON",
          title: "Bài học: Quy luật Tân ngữ Objekti Toàn thể vs Bộ phận (Trang 244-247)",
          description: "Nắm vững nguyên lý: Câu phủ định 100% Partitiivi, hành động hoàn tất dùng Genetiivi.",
          durationMinutes: 35,
          targetRefId: "w22_d3_nguphap_objekti_saannot",
          steps: [
            { stepNumber: 1, instruction: "Khắc sâu quy tắc tân ngữ trong câu phủ định." },
            { stepNumber: 2, instruction: "Phân biệt câu dang dở (luen kirjaa) và hoàn thành (luen kirjan)." }
          ]
        },
        {
          activityId: "w22_d3_act2",
          type: "EXERCISE",
          title: "Bài tập tương tác: Phân biệt Tân ngữ Objekti",
          description: "Thực hành chọn dạng đúng của tân ngữ trong câu.",
          durationMinutes: 15,
          targetRefId: "ex_w22_d3_objekti_perusteet",
          steps: [
            { stepNumber: 1, instruction: "Làm bài tập trắc nghiệm tương tác." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 4,
      theme: "Immersion Đời sống: Dịch vụ Y tế Công cộng Terveysasema",
      activities: [
        {
          activityId: "w22_d4_act1",
          type: "SIGN",
          title: "Immersion: Trạm Y tế Terveysasema & Bảo hiểm Kela",
          description: "Khám phá quy trình khám bệnh công cộng và các đầu số tổng đài khẩn cấp.",
          durationMinutes: 25,
          targetRefId: "sign_terveyskeskus_kela",
          steps: [
            { stepNumber: 1, instruction: "Hiểu vai trò của tổng đài 116 117 và số cấp cứu 112." },
            { stepNumber: 2, instruction: "Biết cách sử dụng thẻ Kela-kortti khi đi khám bệnh." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 5,
      theme: "Luyện Nghe & Nói Phản xạ: Miêu tả Tình trạng Sức khỏe",
      activities: [
        {
          activityId: "w22_d5_act1",
          type: "LESSON",
          title: "Luyện nói phản xạ: Diễn đạt tình trạng ốm cho người khác",
          description: "Thực hành báo ốm xin nghỉ làm với đồng nghiệp hoặc quản lý.",
          durationMinutes: 30,
          targetRefId: "w22_d1_tuvung_ruumiinosat_terveys",
          steps: [
            { stepNumber: 1, instruction: "Thực hành câu: 'Hei, olen valitettavasti tänään sairas...'" },
            { stepNumber: 2, instruction: "Nêu lý do: 'Minulla on kuumetta enkä pääse töihin.'" }
          ]
        }
      ]
    },
    {
      dayOfWeek: 6,
      theme: "Thực hành Viết: Tin nhắn Xin nghỉ Ốm (Poissaoloviesti)",
      activities: [
        {
          activityId: "w22_d6_act1",
          type: "LESSON",
          title: "Thực hành viết: Viết email xin nghỉ ốm bằng tiếng Phần",
          description: "Soạn thảo email hoặc tin nhắn chuẩn mực gửi nơi làm việc / trường học thông báo nghỉ bệnh.",
          durationMinutes: 30,
          targetRefId: "w22_d1_tuvung_ruumiinosat_terveys",
          steps: [
            { stepNumber: 1, instruction: "Sử dụng các từ vựng: sairasloma, lääkäri, toipua." },
            { stepNumber: 2, instruction: "Ghi rõ ngày dự kiến đi làm/học trở lại." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 7,
      theme: "Tổng kết & Củng cố Tuần 22",
      activities: [
        {
          activityId: "w22_d7_act1",
          type: "LESSON",
          title: "Tổng kết & Củng cố Tuần 22 (Kappale 9)",
          description: "Hệ thống hóa toàn bộ kiến thức tuần 22.",
          durationMinutes: 20,
          targetRefId: "w22_d7_tonghop_tuan22",
          steps: [
            { stepNumber: 1, instruction: "Đọc lại bảng tóm tắt kiến thức tuần 22." }
          ]
        }
      ]
    }
  ]
};

const week23 = {
  title: "Tuần 23: Đi Khám Bác sĩ, Toa thuốc Điện tử & Hoàn thành Chương 9",
  description: "Hoàn tất Chương 9 (Kappale 9): Hội thoại phòng khám bác sĩ, lấy thuốc tại hiệu thuốc và bài kiểm tra tổng kết 9 chương.",
  days: [
    {
      dayOfWeek: 1,
      theme: "Giao tiếp Thực tế: Đi Khám Bác sĩ (Lääkärissä)",
      activities: [
        {
          activityId: "w23_d1_act1",
          type: "LESSON",
          title: "Bài học: Đối thoại tại Phòng khám Bác sĩ (Trang 248-251)",
          description: "Học các câu hỏi của bác sĩ và cách trả lời mô tả cơn đau.",
          durationMinutes: 35,
          targetRefId: "w23_d1_giaotiep_laakarissa_terveyskeskus",
          steps: [
            { stepNumber: 1, instruction: "Đọc hội thoại giữa Bác sĩ và Bệnh nhân." },
            { stepNumber: 2, instruction: "Ghi nhớ các câu chỉ dẫn: 'Avatkaa suu', 'Hengittäkää syvään'." }
          ]
        },
        {
          activityId: "w23_d1_act2",
          type: "EXERCISE",
          title: "Bài tập tương tác: Giao tiếp tại phòng khám & nhà thuốc",
          description: "Luyện phản xạ các tình huống khám chữa bệnh.",
          durationMinutes: 15,
          targetRefId: "ex_w23_d1_terveyskeskus_laakarissa",
          steps: [
            { stepNumber: 1, instruction: "Chọn đáp án xử lý tình huống chính xác trên ứng dụng." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 2,
      theme: "Immersion Thực tế: Mua thuốc Toa Điện tử tại Apteekki",
      activities: [
        {
          activityId: "w23_d2_act1",
          type: "SIGN",
          title: "Immersion: Hệ thống Toa thuốc Điện tử Kanta & Hiệu thuốc",
          description: "Tìm hiểu cách lấy thuốc theo đơn trực tuyến và chính sách đổi thuốc tương đương (Lääkevaihto).",
          durationMinutes: 25,
          targetRefId: "sign_apteekki_resepti",
          steps: [
            { stepNumber: 1, instruction: "Học các thuật ngữ: Resepti, Kanta.fi, Farmaseutti." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 3,
      theme: "Luyện Nghe & Nói Phản xạ: Mô tả Bệnh lý Toàn diện",
      activities: [
        {
          activityId: "w23_d3_act1",
          type: "LESSON",
          title: "Luyện nói phản xạ: Tự mô tả triệu chứng và yêu cầu giúp đỡ",
          description: "Rèn luyện khả năng nói lưu loát khi cần miêu tả bệnh lý cá nhân.",
          durationMinutes: 30,
          targetRefId: "w23_d1_giaotiep_laakarissa_terveyskeskus",
          steps: [
            { stepNumber: 1, instruction: "Tập nói các câu mô tả triệu chứng kéo dài bao lâu." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 4,
      theme: "Thực hành Giải Bài tập Giáo trình: Harjoitus 1 - 20",
      activities: [
        {
          activityId: "w23_d4_act1",
          type: "LESSON",
          title: "Bài tập thực hành: Harjoitus 1 - 20 Chương 9 (Trang 252-257)",
          description: "Giải bài tập tổng hợp về tân ngữ Objekti và từ vựng y tế.",
          durationMinutes: 35,
          targetRefId: "w23_d4_baitap_harjoitus1_20",
          steps: [
            { stepNumber: 1, instruction: "Làm bài tập điền tân ngữ đúng dạng." },
            { stepNumber: 2, instruction: "Kiểm tra và củng cố ngữ pháp." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 5,
      theme: "Đề Kiểm tra Toàn diện Đánh giá Năng lực: Kappale 9",
      activities: [
        {
          activityId: "w23_d5_act1",
          type: "LESSON",
          title: "Đề kiểm tra đánh giá năng lực: Kappale 9 (Trang 258-260)",
          description: "Thực hiện bài kiểm tra trắc nghiệm tổng hợp toàn bộ Chương 9.",
          durationMinutes: 30,
          targetRefId: "w23_d5_kiemtra_tongket_kappale9",
          steps: [
            { stepNumber: 1, instruction: "Làm bài kiểm tra tương tác bên dưới." }
          ]
        },
        {
          activityId: "w23_d5_act2",
          type: "EXERCISE",
          title: "Bài tập tương tác: Kiểm tra tổng kết Chương 9",
          description: "Hoàn thành các câu hỏi đánh giá chuẩn A1.3.",
          durationMinutes: 15,
          targetRefId: "ex_w23_d5_kiemtra_kappale9",
          steps: [
            { stepNumber: 1, instruction: "Chọn đáp án chính xác nhất." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 6,
      theme: "Ôn tập Tổng hợp Toàn bộ 9 Chương Giáo trình",
      activities: [
        {
          activityId: "w23_d6_act1",
          type: "LESSON",
          title: "Đại ôn tập: Tổng hợp Hệ thống Ngữ pháp 9 Chương Suomen Mestari 1",
          description: "Hệ thống hóa toàn bộ các điểm ngữ pháp nền tảng từ Chương 1 đến Chương 9.",
          durationMinutes: 40,
          targetRefId: "w22_d3_nguphap_objekti_saannot",
          steps: [
            { stepNumber: 1, instruction: "Xem lại bảng KPT, 6 nhóm động từ, 6 cách vị trí và thì quá khứ đơn." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 7,
      theme: "Tổng kết Hoàn thành Toàn bộ 9 Chương Sách: Cán mốc 95.8%",
      activities: [
        {
          activityId: "w23_d7_act1",
          type: "LESSON",
          title: "Tổng kết Hoàn thành 9 Chương Giáo trình: Sẵn sàng cho Tuần Thi thử Cuối cùng!",
          description: "Tự hào vinh danh nỗ lực vượt bậc của bạn trước khi bước vào kỳ thi thử tốt nghiệp toàn diện!",
          durationMinutes: 20,
          targetRefId: "w23_d7_tongket_kappale9",
          steps: [
            { stepNumber: 1, instruction: "Chúc mừng bạn đã chinh phục trọn vẹn 9 chương sách!" }
          ]
        }
      ]
    }
  ]
};

// ==========================================
// 4. GENERATE FILES & SYNC TO FIRESTORE
// ==========================================
async function buildAndSyncPhase9() {
  console.log('🚀 === GENERATING AND SYNCING PHASE 9 (WEEKS 22 & 23 - CHAPTER 9) ===\n');

  const currDir = path.resolve(__dirname, '../../content/curriculum');
  const lessDir = path.resolve(__dirname, '../../content/lessons');

  // Save local files
  fs.writeFileSync(path.join(currDir, 'chapter_09_exercises.json'), JSON.stringify({ exercises }, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/chapter_09_exercises.json');

  fs.writeFileSync(path.join(lessDir, 'chapter_09_lessons.json'), JSON.stringify({ lessons }, null, 2), 'utf8');
  console.log('✅ Generated content/lessons/chapter_09_lessons.json');

  fs.writeFileSync(path.join(currDir, 'week_22.json'), JSON.stringify(week22, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/week_22.json');

  fs.writeFileSync(path.join(currDir, 'week_23.json'), JSON.stringify(week23, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/week_23.json');

  // Sync Exercises to Firestore
  console.log('\n📝 1. Synchronizing Phase 9 Interactive Exercises into Firestore `exercises`...');
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
  console.log('\n📚 2. Synchronizing Phase 9 Rich Interactive Lessons into Firestore `lessons`...');
  for (const rawLesson of lessons) {
    await db.collection('lessons').doc(rawLesson.id).set({
      id: rawLesson.id,
      title: rawLesson.title,
      chapter: rawLesson.chapter || 'Kappale 9',
      week: rawLesson.week || 22,
      description: rawLesson.description || '',
      audioUrls: [],
      content: rawLesson.content,
      updatedAt: admin.firestore.FieldValue.serverTimestamp()
    }, { merge: true });

    if (rawLesson.id.startsWith('sign_') || rawLesson.id.startsWith('song_') || rawLesson.id.startsWith('video_')) {
      await db.collection('immersion_resources').doc(rawLesson.id).set({
        id: rawLesson.id,
        title: rawLesson.title,
        chapter: rawLesson.chapter || 'Kappale 9',
        description: rawLesson.description || '',
        content: rawLesson.content,
        type: rawLesson.id.startsWith('sign_') ? 'sign' : (rawLesson.id.startsWith('song_') ? 'music' : 'video'),
        updatedAt: admin.firestore.FieldValue.serverTimestamp()
      }, { merge: true });
    }

    console.log(`   ✅ Synced Lesson: [${rawLesson.id}] ${rawLesson.title}`);
  }

  // Sync Weeks 22 & 23 to Firestore
  console.log('\n📅 3. Synchronizing Study Plan Weeks 22 & 23 into Firestore `study_plan_weeks`...');
  const planId = '6iWorOc6mZtnINIFBH8a';
  const week22DocId = 'DeD1nIsmpTIExZ05lPcN';
  const week23DocId = 'jbcBA4wjAsdAgZU3ws64';

  await db.collection('study_plan_weeks').doc(week22DocId).set({
    planId: planId,
    weekNumber: 22,
    title: week22.title,
    description: week22.description,
    days: week22.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Week 22 (doc: ${week22DocId})`);

  await db.collection('study_plan_weeks').doc(week23DocId).set({
    planId: planId,
    weekNumber: 23,
    title: week23.title,
    description: week23.description,
    days: week23.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Week 23 (doc: ${week23DocId})`);

  console.log('\n🎉 ALL PHASE 9 (WEEKS 22 & 23) CONTENT SYNCED SUCCESSFULLY TO FIRESTORE PRODUCTION!');
}

buildAndSyncPhase9().catch(err => {
  console.error('❌ Phase 9 Build & Sync failed:', err);
  process.exit(1);
});
