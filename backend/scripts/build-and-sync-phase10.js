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
// 1. EXERCISES (week_24_exercises.json)
// ==========================================
const exercises = [
  {
    id: "ex_w24_d1_ontap_ch1_3",
    title: "Đại ôn tập Cụm 1: Nền tảng Chương 1 - 3",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Phân biệt nguyên âm ngắn và dài: 'tuli', 'tuuli', 'tulli' lần lượt có nghĩa là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "ngọn lửa - ngọn gió - trạm hải quan",
          "cái bàn - cái ghế - cái giường",
          "đi đến - đi về - ở lại"
        ],
        correctIndex: 0,
        explanation: "Chương 1: tuli = lửa, tuuli = gió, tulli = hải quan. Độ dài nguyên âm/phụ âm thay đổi hoàn toàn nghĩa của từ."
      },
      {
        prompt: "Động từ 'puhua' (nói) và 'ymmärtää' (hiểu) thuộc nhóm động từ nào?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Cả hai đều thuộc Động từ Nhóm 1 (kết thúc bằng 2 nguyên âm: -aa / -ää)",
          "Nhóm 2",
          "Nhóm 3"
        ],
        correctIndex: 0,
        explanation: "Chương 3: Động từ nhóm 1 có tận cùng là 2 nguyên âm (-aa, -ää, -ea, -eä, -oa, -ua...)."
      }
    ]
  },
  {
    id: "ex_w24_d2_ontap_ch4_6",
    title: "Đại ôn tập Cụm 2: Biến âm KPT, Giờ giấc, Partitiivi & Vị trí nơi chốn",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Cặp biến âm KPT nào sau đây là chính xác?",
        type: "MULTIPLE_CHOICE",
        options: [
          "kk -> k, pp -> p, tt -> t, k -> mất, p -> v, t -> d",
          "k -> s, p -> m, t -> n",
          "kk -> t, pp -> k"
        ],
        correctIndex: 0,
        explanation: "Chương 4: Quy luật KPT cấp độ mạnh (vahva aste) sang cấp độ yếu (heikko aste)."
      },
      {
        prompt: "Cụm 3 hướng vị trí bên trong (Sisäpaikansijat) của từ 'talo' (nhà) lần lượt là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "taloon (vào trong) - talossa (ở trong) - talosta (từ trong ra)",
          "talolle - talolla - talolta",
          "talon - taloa - taloksi"
        ],
        correctIndex: 0,
        explanation: "Chương 6: Hệ thống 3 câu hỏi phương hướng Mihin? (Illatiivi: taloon) - Missä? (Inessiivi: talossa) - Mistä? (Elatiivi: talosta)."
      }
    ]
  },
  {
    id: "ex_w24_d3_ontap_ch7_9",
    title: "Đại ôn tập Cụm 3: Biến cách -i/-e/-nen, Thì Quá khứ & Tân ngữ Objekti",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Câu nào sau đây chia đúng thì Quá khứ đơn (Imperfekti)?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Eilen me söimme pizzaa ja katsoimme elokuvaa kotona.",
          "Eilen me syömme pizzaa ja katsomme elokuvaa kotona.",
          "Eilen me syöneet pizzaa ja katsoneet elokuvaa kotona."
        ],
        correctIndex: 0,
        explanation: "Chương 8: syödä -> söimme; katsoa -> katsoimme (thì quá khứ có dấu hiệu chữ -i-)."
      },
      {
        prompt: "Tân ngữ trong câu 'En osta uutta puhelinta' ở cách ngữ pháp nào và tại sao?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Partitiivi (puhelinta), vì đây là câu phủ định (En osta)",
          "Genetiivi (puhelimen), vì mua trọn vẹn 1 chiếc điện thoại",
          "Nominatiivi (puhelin)"
        ],
        correctIndex: 0,
        explanation: "Chương 9: Quy tắc bất biến - Tân ngữ trong câu phủ định (kieltolause) luôn luôn ở cách Partitiivi."
      }
    ]
  },
  {
    id: "ex_w24_d5_thitotnghiep_yki",
    title: "Đề Thi Tốt Nghiệp Toàn Khóa: Chuẩn YKI A1.3 / A2.1",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Đọc hiểu: 'Hei Pedro! Anteeksi, en pääse tänään kurssille, koska minulla on kova kuume ja kurkkukipu. Lääkäri määräsi sairaslomaa perjantaihin saakka. Nähdään ensi viikolla! Terveisin, Alex.' — Alex vắng mặt vì lý do gì?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Alex bị ốm sốt cao và đau họng, bác sĩ cho nghỉ ốm đến thứ Sáu",
          "Alex phải đi công tác ở Tampere",
          "Alex bận đi mua đồ ở chợ trời Kirpputori"
        ],
        correctIndex: 0,
        explanation: "Đọc hiểu: kova kuume = sốt cao; kurkkukipu = đau họng; sairaslomaa perjantaihin saakka = nghỉ ốm đến thứ Sáu."
      },
      {
        prompt: "Ngữ pháp tổng hợp: Chọn câu đúng hoàn toàn về KPT, Quá khứ và Phương tiện:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Viime viikolla Hanna matkusti junalla Helsinkiin ja tapasi ystävänsä uudessa kahvilassa.",
          "Viime viikolla Hanna matkustaa junassa Helsinkiin ja tapaa ystävänsä uusi kahvilassa.",
          "Viime viikolla Hanna matkustanut junalle Helsinkiin ja tavannut ystävää uudessa kahvilasta."
        ],
        correctIndex: 0,
        explanation: "matkustaa -> matkusti; junalla (Adessiivi phương tiện); Helsinkiin (Illatiivi mihin); tavata -> tapasi (KPT v -> p); uudessa kahvilassa (Inessiivi tính từ + danh từ)."
      },
      {
        prompt: "Trong cuộc sống hàng ngày tại Phần Lan, câu nào sau đây thể hiện sự lịch sự nhất khi nhờ giúp đỡ?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Voisitteko auttaa minua, olkaa hyvä?",
          "Auta minua!",
          "Miksi et auta?"
        ],
        correctIndex: 0,
        explanation: "Thể điều kiện lịch sự Konditionaali / Imperatiivi trang trọng kết hợp 'olkaa hyvä'."
      }
    ]
  }
];

// ==========================================
// 2. LESSONS (week_24_lessons.json)
// ==========================================
const lessons = [
  {
    id: "w24_d1_ontap_ch1_3",
    title: "Đại Ôn Tập Cụm 1: Nền tảng Nhập môn (Chương 1 - 3)",
    chapter: "Kappale 1-3",
    week: 24,
    description: "Hệ thống hóa phát âm nguyên âm/phụ âm ngắn dài, hài hòa nguyên âm, 4 nhóm động từ cơ bản và hội thoại làm quen.",
    content: `# Đại Ôn Tập Cụm 1: Nền tảng Nhập môn (Chương 1 - 3)

Chào mừng bạn đến với **Tuần 24 - Tuần Tốt Nghiệp** của toàn bộ khóa học *Suomen Mestari 1*! Hôm nay chúng ta cùng nhìn lại nền móng vững chắc đầu tiên.

---

## 1. Phát âm & Ngữ âm học tiếng Phần Lan
- **Trọng âm luôn rơi vào âm tiết đầu tiên** của từ.
- **Quy luật Hài hòa Nguyên âm (Vokaalisointu)**:
  - Nhóm nguyên âm sau: **A, O, U** đi với đuôi mang hậu tố -a/-o/-u (ví dụ: taloss**a**, autoll**a**).
  - Nhóm nguyên âm trước: **Ä, Ö, Y** đi với đuôi mang hậu tố -ä/-ö/-y (ví dụ: kylpyhuoneess**ä**, pyöräll**ä**).
  - Nguyên âm trung tính: **E, I** có thể đi với cả hai nhóm.
- **Độ dài âm thanh quyết định ý nghĩa**:
  - *tuli* (lửa) $\\neq$ *tuuli* (gió) $\\neq$ *tulli* (hải quan).
  - *muta* (bùn) $\\neq$ *mutta* (nhưng).

---

## 2. Động từ Olla & 4 Nhóm Động từ Cơ bản
- **Động từ To Be 'Olla'**: *olen, olet, on, olemme, olette, ovat* | Phủ định: *en ole, et ole, ei ole, emme ole, ette ole, eivät ole*.
- **Cấu trúc sở hữu**: *Minulla on... / Minulla ei ole...*
- **4 Nhóm động từ cơ bản**:
  - Nhóm 1 (-aa/-ää): *puhua ➔ puhun*
  - Nhóm 2 (-da/-dä): *syödä ➔ syön*
  - Nhóm 3 (-la/-lä, -ra/-rä, -na/-nä, -sta/-stä): *tulla ➔ tulen, opiskella ➔ opiskelen*
  - Nhóm 4 (-ata/-ätä, -ota/-ötä, -uta/-ytä): *haluta ➔ haluan, herätä ➔ herään*

---

## Luyện tập tương tác ngay

[exercise:ex_w24_d1_ontap_ch1_3]`
  },
  {
    id: "w24_d2_ontap_ch4_6",
    title: "Đại Ôn Tập Cụm 2: KPT, Thời gian, Partitiivi & Không gian Nhà ở (Chương 4 - 6)",
    chapter: "Kappale 4-6",
    week: 24,
    description: "Hệ thống hóa biến âm KPT cấp độ mạnh - yếu, cách nói giờ giấc, cách bộ phận Partitiivi và 6 cách chỉ vị trí nơi chốn.",
    content: `# Đại Ôn Tập Cụm 2: KPT, Partitiivi & Vị trí Nơi chốn (Chương 4 - 6)

Đây là giai đoạn bạn bắt đầu làm quen với những nét ngữ pháp đặc sắc nhất của ngữ hệ Finno-Ugric.

---

## 1. Biến âm phụ âm KPT (Konsonanttien astevaihtelu)
Xảy ra với các phụ âm **K, P, T** khi chuyển giữa âm tiết mở (cấp độ Mạnh) và âm tiết đóng (cấp độ Yếu):
- **Đôi thành đơn**: *kk ➔ k* (pankki ➔ pankissa), *pp ➔ p* (oppia ➔ opin), *tt ➔ t* (tyttö ➔ tytön).
- **Đơn biến đổi/mất đi**: *k ➔ mất* (lukea ➔ luen), *p ➔ v* (tapaa ➔ tavan), *t ➔ d* (koti ➔ kodissa).
- **Tổ hợp phụ âm**: *nt ➔ nn* (Helsinki ➔ Helsingissä), *mp ➔ mm* (kampa ➔ kamman), *lt ➔ ll* (ilta ➔ illalla), *rt ➔ rr* (parta ➔ parran).

---

## 2. Cách bộ phận Partitiivi (-a / -ä / -ta / -tä)
- Dùng sau **Số từ từ 2 trở lên**: *kaksi euroa, viisi omenaa*.
- Dùng với **Chất liệu không đếm được**: *kahvia, teetä, maitoa, leipää*.
- Dùng trong **Câu phủ định**: *Minulla ei ole autoa*.
- Dùng với **Cụm chào hỏi quen thuộc**: *Mitä kuuluu? Hyvää päivää! Huomenta!*

---

## 3. Hệ thống 6 Cách chỉ Vị trí Nơi chốn (Paikansijat)

| Hướng câu hỏi | Vị trí bên trong (Sisäpaikansijat) | Vị trí bên ngoài / Bề mặt (Ulkopaikansijat) |
| :--- | :--- | :--- |
| **Mihin? (Đến đâu?)** | **Illatiivi** (-hVn / nhân đôi + n): *taloon, kotiin* | **Allatiivi** (-lle): *pöydälle, torille, asemalle* |
| **Missä? (Ở đâu?)** | **Inessiivi** (-ssa / -ssä): *talossa, Helsingissä* | **Adessiivi** (-lla / -llä): *pöydällä, torilla, asemalla* |
| **Mistä? (Từ đâu?)** | **Elatiivi** (-sta / -stä): *talosta, Suomesta* | **Ablatiivi** (-lta / -ltä): *pöydältä, torilta, asemalta* |

---

## Luyện tập tương tác ngay

[exercise:ex_w24_d2_ontap_ch4_6]`
  },
  {
    id: "w24_d3_ontap_ch7_9",
    title: "Đại Ôn Tập Cụm 3: Biến cách -i/-e/-nen, Thì Quá khứ & Tân ngữ Objekti (Chương 7 - 9)",
    chapter: "Kappale 7-9",
    week: 24,
    description: "Hệ thống hóa thể mệnh lệnh Imperatiivi, các nhóm biến cách danh từ, thì Quá khứ đơn Imperfekti và bản chất tân ngữ Objekti.",
    content: `# Đại Ôn Tập Cụm 3: Biến cách -i/-e/-nen, Quá khứ & Objekti (Chương 7 - 9)

Giai đoạn hoàn thiện ngữ pháp A1/A2 giúp bạn diễn đạt những ý tưởng phức tạp, biểu đạt thời gian và tương tác xã hội.

---

## 1. Ba nhóm biến cách Danh từ đặc biệt (Chương 7)
- **Đuôi -i**:
  - Từ vay mượn mới giữ nguyên -i: *posti ➔ postissa, turisti ➔ turistille*.
  - Từ cổ đổi -i thành -e-: *kieli ➔ kielellä, nimi ➔ nimessä*.
- **Đuôi -e**: Nhân đôi thành -ee- (*huone ➔ huoneessa, perhe ➔ perheelle*).
- **Đuôi -nen**: Chuyển thành -se- (*nainen ➔ naisella, suomalainen ➔ suomalaiselle*).

---

## 2. Thể Mệnh lệnh (Imperatiivi)
- Thân mật số ít: *Tule! Mene! Avaa! Älä mene!*
- Trang trọng số nhiều: *Tulkaa! Menkää! Avatkaa! Älkää menkö!*

---

## 3. Thì Quá khứ đơn (Imperfekti) (Chương 8)
- Dấu hiệu: **-i-** chèn trước đuôi ngôi (*ostin, puhuin, asuin*).
- Động từ nguyên âm đôi biến đổi: *syödä ➔ söin, juoda ➔ join*.
- **Phủ định quá khứ**: *en/et/ei... + -nut / -nyt (số ít) hoặc -neet (số nhiều)* (*En ostanut, Emme menneet*).

---

## 4. Bản chất Tân ngữ (Objekti) (Chương 9)
- Phủ định: **100% Partitiivi** (*En osta leipää*).
- Khẳng định:
  - Hoàn thành trọn vẹn: **Genetiivi -n** (*Ostan leivän, Luin kirjan*).
  - Đang diễn ra dang dở: **Partitiivi** (*Syön leipää, Luen kirjaa*).

---

## Luyện tập tương tác ngay

[exercise:ex_w24_d3_ontap_ch7_9]`
  },
  {
    id: "sign_yki_testi_info",
    title: "Immersion Đời sống: Cẩm nang Kỳ thi Quốc tịch Tiếng Phần Lan (YKI-testi)",
    chapter: "YKI Testi",
    week: 24,
    description: "Tìm hiểu toàn bộ cấu trúc kỳ thi chứng chỉ ngôn ngữ quốc gia YKI (Yleiset kielitutkinnot), bí quyết đạt A2/B1 xin quốc tịch.",
    content: `# Immersion Đời sống: Kỳ thi Chứng chỉ Quốc gia YKI (Yleiset kielitutkinnot)

Để xin quốc tịch Phần Lan (Suomen kansalaisuus) hoặc học đại học/nghề bằng tiếng Phần, bạn cần đạt chứng chỉ năng lực ngôn ngữ **YKI trình độ trung cấp (Keskitaso - B1/B2)**. Toàn bộ kiến thức của *Suomen Mestari 1* là nền tảng tối quan trọng giúp bạn đạt mốc A2.

---

## 1. Cấu trúc 4 kỹ năng trong đề thi YKI

1. **Tekstin ymmärtäminen (Đọc hiểu)**: Đọc tin nhắn, email đời sống, tin tức ngắn và trả lời câu hỏi trắc nghiệm / điền từ.
2. **Kirjoittaminen (Viết)**: Viết 3 bài: 1 tin nhắn ngắn thân mật, 1 thư phàn nàn/hỏi thông tin trang trọng và 1 đoạn văn nêu quan điểm cá nhân.
3. **Puheen ymmärtäminen (Nghe hiểu)**: Nghe các đoạn thông báo sân ga, bản tin radio, mẩu đối thoại ngắn tại cửa hàng/bệnh viện.
4. **Puhuminen (Nói)**: Ghi âm giọng nói trong phòng lab xử lý các tình huống giao tiếp đời sống (phản xạ nhanh, tranh luận ngắn, kể chuyện tranh).

---

## 2. Bí quyết thành công từ Suomen Mestari 1
- **Không dịch từng từ một**: Tập nắm ý chính dựa trên gốc từ và hậu tố cách.
- **Nắm chắc từ vựng tình huống**: Khách sạn, bác sĩ, siêu thị, giao thông HSL là 90% các tình huống xuất hiện trong bài thi.
- **Viết đúng ngữ pháp KPT và chia đuôi ngôi**: Người chấm thi đánh giá rất cao sự chuẩn mực trong câu khẳng định, phủ định và chia thì.`
  },
  {
    id: "w24_d5_thitotnghiep_yki_simulation",
    title: "Đề Thi Tốt Nghiệp Toàn Khóa: Mô phỏng YKI Toàn diện (Chương 1 - 9)",
    chapter: "Tốt nghiệp",
    week: 24,
    description: "Thực hiện bài thi tổng hợp đánh giá 4 kỹ năng kiến thức xuyên suốt 24 tuần của giáo trình Suomen Mestari 1.",
    content: `# Đề Thi Tốt Nghiệp Toàn Khóa: Chuẩn YKI Simulation A1.3 / A2.1

Chào mừng bạn đến với bài thi tốt nghiệp chính thức của Khóa học *Suomen Mestari 1*!

---

## Hướng dẫn làm bài thi:
- Đọc kỹ từng câu hỏi tình huống thực tế đời sống.
- Vận dụng toàn bộ kiến thức 9 chương sách: Ngữ âm, Từ vựng, 6 Nhóm Động từ, Biến âm KPT, 6 Cách Vị trí, Biến cách -i/-e/-nen, Thì Quá khứ đơn Imperfekti và Tân ngữ Objekti.

---

## Thực hiện bài thi tương tác ngay:

[exercise:ex_w24_d5_thitotnghiep_yki]`
  },
  {
    id: "w24_d7_le_tot_nghiep_khoa_hoc",
    title: "🎓 LỄ TỐT NGHIỆP: Vinh Danh Hoàn Thành Xuất Sắc Lộ Trình 24 Tuần Suomen Mestari 1!",
    chapter: "Tốt nghiệp",
    week: 24,
    description: "Chúc mừng bạn đã hoàn thành trọn vẹn 100% lộ trình 24 tuần giáo trình Suomen Mestari 1! Nhận chứng chỉ hoàn thành khóa học.",
    content: `# 🎓 LỄ TỐT NGHIỆP & VINH DANH HOÀN THÀNH LỘ TRÌNH 24 TUẦN! 🇫🇮

**ONNEKSI OLKOON! (XIN NHIỆT LIỆT CHÚC MỪNG BẠN!)**

Bạn đã chính thức hoàn thành xuất sắc toàn bộ **24 Tuần học** và **9 Chương sách** của giáo trình tiếng Phần Lan kinh điển thế giới: **Suomen Mestari 1**.

---

## 🌟 Hành trình phi thường bạn đã chinh phục:

- **24 Tuần học** với 168 ngày học tập đều đặn và khoa học.
- **Hơn 1.200 Từ vựng** bao quát mọi khía cạnh đời sống: Làm quen, Gia đình, Thời tiết, Mua sắm ăn uống, Nhà ở, Du lịch, Giao thông HSL/VR và Chăm sóc sức khỏe y tế.
- **Làm chủ Hệ thống Ngữ pháp Toàn diện**:
  - Hài hòa nguyên âm & Phát âm chuẩn xác.
  - Bảng chia 6 Nhóm Động từ tiếng Phần Lan.
  - Biến âm phụ âm KPT cấp độ mạnh - yếu.
  - Hệ thống 6 Cách chỉ Vị trí Nơi chốn (Paikansijat).
  - Cách bộ phận Partitiivi & Cách sở hữu Genetiivi.
  - 3 Nhóm biến cách danh từ đặc biệt (-i, -e, -nen).
  - Thể Mệnh lệnh số ít & số nhiều lịch sự (Imperatiivi).
  - Thì Quá khứ đơn khẳng định và phủ định (Imperfekti -i- / -nut / -neet).
  - Quy tắc Tân ngữ trực tiếp (Objekti).
- **Hàng chục bài tập trắc nghiệm tương tác & đề thi chuẩn hóa**.
- **Kho tàng Immersion Văn hóa - Đời sống thực tế**: Thẻ Kela, vé tàu VR, vé vùng HSL, toa thuốc Kanta, chợ trời Kirpputori, nội quy chung cư và kỳ thi quốc tịch YKI.

---

## 🚀 Bước tiếp theo trên con đường chinh phục tiếng Phần Lan:
Bạn đã xây dựng được nền tảng A1.3 - A2.1 vững như bàn thạch. Giờ đây, bạn hoàn toàn tự tin bước sang giáo trình **Suomen Mestari 2** để chinh phục ngưỡng B1 và hiện thực hóa ước mơ định cư, học tập và làm việc lâu dài tại Phần Lan!

*Kiitos paljon ja onnea tuleviin opintoihin! (Cảm ơn bạn rất nhiều và chúc bạn luôn thành công trên con đường học tập phía trước!)*`
  }
];

// ==========================================
// 3. STUDY PLAN WEEK 24
// ==========================================
const week24 = {
  title: "Tuần 24: Đại Ôn Tập Toàn Diện 9 Chương & Kỳ Thi Tốt Nghiệp Chuẩn A1.3 / A2.1",
  description: "Tuần về đích vinh quang của lộ trình 24 tuần Suomen Mestari 1: Tổng kết toàn bộ 9 chương sách, làm bài thi chuẩn YKI và nhận bằng tốt nghiệp.",
  days: [
    {
      dayOfWeek: 1,
      theme: "Đại Ôn Tập Cụm 1: Nền tảng Nhập môn (Chương 1 - 3)",
      activities: [
        {
          activityId: "w24_d1_act1",
          type: "LESSON",
          title: "Bài học: Đại Ôn Tập Cụm 1 (Chương 1 - 3)",
          description: "Hệ thống hóa phát âm nguyên âm/phụ âm, 4 nhóm động từ và hội thoại làm quen.",
          durationMinutes: 35,
          targetRefId: "w24_d1_ontap_ch1_3",
          steps: [
            { stepNumber: 1, instruction: "Ôn lại quy luật hài hòa nguyên âm và động từ Olla." },
            { stepNumber: 2, instruction: "Làm bài tập ôn tập Cụm 1 bên dưới." }
          ]
        },
        {
          activityId: "w24_d1_act2",
          type: "EXERCISE",
          title: "Bài tập tương tác: Ôn tập Cụm 1 (Chương 1 - 3)",
          description: "Kiểm tra kiến thức nền tảng nhập môn.",
          durationMinutes: 15,
          targetRefId: "ex_w24_d1_ontap_ch1_3",
          steps: [
            { stepNumber: 1, instruction: "Làm bài tập trắc nghiệm trên ứng dụng." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 2,
      theme: "Đại Ôn Tập Cụm 2: KPT, Giờ giấc, Partitiivi & Nhà ở (Chương 4 - 6)",
      activities: [
        {
          activityId: "w24_d2_act1",
          type: "LESSON",
          title: "Bài học: Đại Ôn Tập Cụm 2 (Chương 4 - 6)",
          description: "Ôn tập biến âm KPT, cách bộ phận Partitiivi và 6 cách chỉ vị trí nơi chốn.",
          durationMinutes: 35,
          targetRefId: "w24_d2_ontap_ch4_6",
          steps: [
            { stepNumber: 1, instruction: "Xem lại bảng KPT và quy tắc 3 câu hỏi Mihin? Missä? Mistä?" },
            { stepNumber: 2, instruction: "Làm bài tập củng cố Cụm 2." }
          ]
        },
        {
          activityId: "w24_d2_act2",
          type: "EXERCISE",
          title: "Bài tập tương tác: Ôn tập Cụm 2 (Chương 4 - 6)",
          description: "Luyện tập nhận diện KPT và vị trí nơi chốn.",
          durationMinutes: 15,
          targetRefId: "ex_w24_d2_ontap_ch4_6",
          steps: [
            { stepNumber: 1, instruction: "Hoàn thành bài tập trên ứng dụng." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 3,
      theme: "Đại Ôn Tập Cụm 3: Biến cách -i/-e/-nen, Quá khứ & Objekti (Chương 7 - 9)",
      activities: [
        {
          activityId: "w24_d3_act1",
          type: "LESSON",
          title: "Bài học: Đại Ôn Tập Cụm 3 (Chương 7 - 9)",
          description: "Ôn tập thể mệnh lệnh, thì Quá khứ đơn Imperfekti và bản chất tân ngữ Objekti.",
          durationMinutes: 35,
          targetRefId: "w24_d3_ontap_ch7_9",
          steps: [
            { stepNumber: 1, instruction: "Nắm chắc công thức thì quá khứ khẳng định và phủ định." },
            { stepNumber: 2, instruction: "Phân biệt tân ngữ hoàn tất (Genetiivi) và dang dở (Partitiivi)." }
          ]
        },
        {
          activityId: "w24_d3_act2",
          type: "EXERCISE",
          title: "Bài tập tương tác: Ôn tập Cụm 3 (Chương 7 - 9)",
          description: "Thực hành chia thì quá khứ và tân ngữ câu.",
          durationMinutes: 15,
          targetRefId: "ex_w24_d3_ontap_ch7_9",
          steps: [
            { stepNumber: 1, instruction: "Làm bài tập trắc nghiệm trên ứng dụng." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 4,
      theme: "Immersion Đời sống: Cẩm nang Kỳ thi Quốc tịch YKI",
      activities: [
        {
          activityId: "w24_d4_act1",
          type: "SIGN",
          title: "Immersion: Cẩm nang Kỳ thi Chứng chỉ Quốc gia YKI",
          description: "Hiểu rõ cấu trúc 4 phần thi Đọc - Viết - Nghe - Nói và chiến thuật làm bài thi YKI.",
          durationMinutes: 25,
          targetRefId: "sign_yki_testi_info",
          steps: [
            { stepNumber: 1, instruction: "Đọc cấu trúc bài thi YKI và thang điểm A1-B2." },
            { stepNumber: 2, instruction: "Ghi nhớ các mẹo làm bài thực chiến." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 5,
      theme: "Đề Thi Tốt Nghiệp Toàn Khóa: Chuẩn YKI Toàn diện",
      activities: [
        {
          activityId: "w24_d5_act1",
          type: "LESSON",
          title: "Đề Thi Tốt Nghiệp Toàn Khóa: Mô phỏng YKI Toàn diện",
          description: "Thực hiện bài thi tổng hợp đánh giá năng lực toàn diện sau 24 tuần học.",
          durationMinutes: 40,
          targetRefId: "w24_d5_thitotnghiep_yki_simulation",
          steps: [
            { stepNumber: 1, instruction: "Làm bài thi trắc nghiệm tốt nghiệp bên dưới." }
          ]
        },
        {
          activityId: "w24_d5_act2",
          type: "EXERCISE",
          title: "Bài tập tương tác: Đề thi Tốt nghiệp Toàn khóa Chuẩn YKI",
          description: "Hoàn thành các câu hỏi đánh giá tổng hợp chuẩn A1.3 / A2.1.",
          durationMinutes: 20,
          targetRefId: "ex_w24_d5_thitotnghiep_yki",
          steps: [
            { stepNumber: 1, instruction: "Chọn đáp án chính xác nhất." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 6,
      theme: "Thực hành Viết Tốt Nghiệp: Bức thư Giới thiệu Toàn diện Bản thân",
      activities: [
        {
          activityId: "w24_d6_act1",
          type: "LESSON",
          title: "Thực hành viết tốt nghiệp: Bức thư Giới thiệu Toàn diện (Kirje ystävälle)",
          description: "Tự viết một bức thư dài 15-20 câu kể về bản thân, gia đình, công việc, nơi ở và chuyến du lịch vừa qua.",
          durationMinutes: 35,
          targetRefId: "w24_d3_ontap_ch7_9",
          steps: [
            { stepNumber: 1, instruction: "Sử dụng đầy đủ thì Hiện tại và Quá khứ." },
            { stepNumber: 2, instruction: "Áp dụng các cách vị trí nơi chốn, KPT và tân ngữ." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 7,
      theme: "LỄ TỐT NGHIỆP: Vinh Danh Hoàn Thành Xuất Sắc Lộ Trình 24 Tuần!",
      activities: [
        {
          activityId: "w24_d7_act1",
          type: "LESSON",
          title: "LỄ TỐT NGHIỆP: Vinh Danh Hoàn Thành Lộ Trình 24 Tuần Suomen Mestari 1!",
          description: "Nhận chứng nhận hoàn thành lộ trình và sẵn sàng bước tiếp sang Suomen Mestari 2!",
          durationMinutes: 30,
          targetRefId: "w24_d7_le_tot_nghiep_khoa_hoc",
          steps: [
            { stepNumber: 1, instruction: "Tự hào nhìn lại chặng đường 24 tuần tuyệt vời!" },
            { stepNumber: 2, instruction: "Chúc mừng bạn đã chính thức tốt nghiệp!" }
          ]
        }
      ]
    }
  ]
};

// ==========================================
// 4. GENERATE FILES & SYNC TO FIRESTORE
// ==========================================
async function buildAndSyncPhase10() {
  console.log('🚀 === GENERATING AND SYNCING PHASE 10 (WEEK 24 - CAPSTONE & GRADUATION) ===\n');

  const currDir = path.resolve(__dirname, '../../content/curriculum');
  const lessDir = path.resolve(__dirname, '../../content/lessons');

  // Save local files
  fs.writeFileSync(path.join(currDir, 'week_24_exercises.json'), JSON.stringify({ exercises }, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/week_24_exercises.json');

  fs.writeFileSync(path.join(lessDir, 'week_24_lessons.json'), JSON.stringify({ lessons }, null, 2), 'utf8');
  console.log('✅ Generated content/lessons/week_24_lessons.json');

  fs.writeFileSync(path.join(currDir, 'week_24.json'), JSON.stringify(week24, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/week_24.json');

  // Sync Exercises to Firestore
  console.log('\n📝 1. Synchronizing Phase 10 Interactive Exercises into Firestore `exercises`...');
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
  console.log('\n📚 2. Synchronizing Phase 10 Rich Interactive Lessons into Firestore `lessons`...');
  for (const rawLesson of lessons) {
    await db.collection('lessons').doc(rawLesson.id).set({
      id: rawLesson.id,
      title: rawLesson.title,
      chapter: rawLesson.chapter || 'Tốt nghiệp',
      week: rawLesson.week || 24,
      description: rawLesson.description || '',
      audioUrls: [],
      content: rawLesson.content,
      updatedAt: admin.firestore.FieldValue.serverTimestamp()
    }, { merge: true });

    if (rawLesson.id.startsWith('sign_') || rawLesson.id.startsWith('song_') || rawLesson.id.startsWith('video_')) {
      await db.collection('immersion_resources').doc(rawLesson.id).set({
        id: rawLesson.id,
        title: rawLesson.title,
        chapter: rawLesson.chapter || 'Tốt nghiệp',
        description: rawLesson.description || '',
        content: rawLesson.content,
        type: rawLesson.id.startsWith('sign_') ? 'sign' : (rawLesson.id.startsWith('song_') ? 'music' : 'video'),
        updatedAt: admin.firestore.FieldValue.serverTimestamp()
      }, { merge: true });
    }

    console.log(`   ✅ Synced Lesson: [${rawLesson.id}] ${rawLesson.title}`);
  }

  // Sync Week 24 to Firestore
  console.log('\n📅 3. Synchronizing Study Plan Week 24 into Firestore `study_plan_weeks`...');
  const planId = '6iWorOc6mZtnINIFBH8a';
  const week24DocId = 'rZ8GWhdMtdGVN5qcfF2m';

  await db.collection('study_plan_weeks').doc(week24DocId).set({
    planId: planId,
    weekNumber: 24,
    title: week24.title,
    description: week24.description,
    days: week24.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Week 24 (doc: ${week24DocId})`);

  console.log('\n🎉 ALL PHASE 10 (WEEK 24 - CAPSTONE & GRADUATION) CONTENT SYNCED SUCCESSFULLY TO FIRESTORE PRODUCTION!');
  console.log('🏆 CONGRATULATIONS! 100% OF THE 24-WEEK MASTER CURRICULUM IS NOW LIVE ON FIRESTORE PRODUCTION!');
}

buildAndSyncPhase10().catch(err => {
  console.error('❌ Phase 10 Build & Sync failed:', err);
  process.exit(1);
});
