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
// 1. EXERCISES (chapter_06_exercises.json)
// ==========================================
const exercises = [
  {
    id: "ex_w15_d1_asumissanasto",
    title: "Từ vựng: Các loại nhà ở & Các phòng trong nhà",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "'Kerrostalo' là loại nhà ở nào rất phổ biến tại các đô thị Phần Lan?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Tòa nhà chung cư nhiều tầng",
          "Nhà liền kề (rivitalo)",
          "Nhà biệt lập một gia đình (omakotitalo)"
        ],
        correctIndex: 0,
        explanation: "kerrostalo = chung cư (kerros = tầng lầu); rivitalo = nhà dãy liền kề; omakotitalo = nhà riêng biệt lập."
      },
      {
        prompt: "Phòng khách và phòng ngủ trong tiếng Phần Lan lần lượt là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "olohuone ja makuuhuone",
          "keittiö ja kylpyhuone",
          "eteinen ja parveke"
        ],
        correctIndex: 0,
        explanation: "olohuone = phòng sinh hoạt/khách; makuuhuone = phòng ngủ; keittiö = bếp; kylpyhuone = phòng tắm."
      }
    ]
  },
  {
    id: "ex_w16_d1_paikansijat_6",
    title: "Ngữ pháp: Các cách chỉ Vị trí Nơi chốn (Paikansijat)",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Ba câu hỏi phương hướng vị trí bên trong 'Mihin? - Missä? - Mistä?' có nghĩa là gì?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Đi vào đâu? - Ở trong đâu? - Từ trong đâu ra?",
          "Ở đâu? - Khi nào? - Tại sao?",
          "Ai? - Cái gì? - Bao nhiêu?"
        ],
        correctIndex: 0,
        explanation: "Hệ thống vị trí 3 hướng: Mihin (Đến đâu - Illatiivi), Missä (Ở đâu - Inessiivi -ssa), Mistä (Từ đâu - Elatiivi -sta)."
      },
      {
        prompt: "'Pedro asuu Helsingissä, mutta hän on kotoisin Brasiliasta' diễn tả điều gì?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Pedro sống ở Helsinki (-ssä), nhưng anh ấy đến từ Brazil (-sta)",
          "Pedro đi tới Helsinki, rồi bay sang Brazil",
          "Pedro sinh ra ở Helsinki"
        ],
        correctIndex: 0,
        explanation: "Helsingissä = ở tại Helsinki (Missä); Brasiliasta = từ Brazil đến (Mistä)."
      },
      {
        prompt: "Từ 'talo' (ngôi nhà) khi chuyển sang câu trả lời 'Đi vào trong nhà' (Mihin?) là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "taloon (nhân đôi nguyên âm cuối + n)",
          "talossa",
          "talosta"
        ],
        correctIndex: 0,
        explanation: "Quy tắc Illatiivi (Mihin): Nhân đôi nguyên âm cuối và thêm n: talo -> taloon."
      }
    ]
  },
  {
    id: "ex_w16_d4_imperatiivi_ohjeet",
    title: "Ngữ pháp: Thể Mệnh lệnh & Chỉ đường",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Khi chỉ đường 'Mene suoraan ja käänny oikealle', câu đó có nghĩa là gì?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Hãy đi thẳng và rẽ sang bên phải",
          "Hãy dừng lại và rẽ trái",
          "Hãy đi lùi lại phía sau"
        ],
        correctIndex: 0,
        explanation: "Mene suoraan = Đi thẳng; käänny oikealle = rẽ phải; käänny vasemmalle = rẽ trái."
      },
      {
        prompt: "Thể mệnh lệnh ngôi 'sinä' (bạn hãy làm gì) được tạo bằng cách:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Dùng thân từ động từ cấp Yếu (Heikko vartalo) và KHÔNG thêm đuôi cá nhân",
          "Thêm đuôi -t",
          "Thêm đuôi -kaa"
        ],
        correctIndex: 0,
        explanation: "Mệnh lệnh ngôi sinä: Tule! (Hãy đến!), Syö! (Hãy ăn đi!), Katso! (Hãy nhìn kìa!)."
      }
    ]
  },
  {
    id: "ex_w17_d5_kiemtra_kappale6",
    title: "Đề kiểm tra đánh giá năng lực toàn diện Chương 6",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Ký hiệu '2h + k + kph + p, 52 m²' trong mẩu tin thuê nhà Phần Lan có nghĩa là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "2 phòng + bếp + phòng tắm + ban công, diện tích 52 mét vuông",
          "2 tầng + nhà kho + bãi đỗ xe",
          "2 người ở + bao tiền nước"
        ],
        correctIndex: 0,
        explanation: "h = huone (phòng), k = keittiö (bếp), kph = kylpyhuone (phòng tắm), p = parveke (ban công)."
      },
      {
        prompt: "'Kirja on pöydällä' có nghĩa là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Quyển sách đang ở TRÊN mặt bàn (đuôi -lla: vị trí bên trên mặt phẳng)",
          "Quyển sách ở trong ngăn kéo",
          "Quyển sách rơi xuống gầm bàn"
        ],
        correctIndex: 0,
        explanation: "Đuôi Adessiivi (-lla/-llä) chỉ vị trí bên trên bề mặt mở: pöydällä = trên bàn."
      }
    ]
  }
];

// ==========================================
// 2. LESSONS (chapter_06_lessons.json)
// ==========================================
const lessons = [
  // TUẦN 15
  {
    id: "w15_d1_tuvung_talotyypit_huoneet",
    title: "Kappale 6: Các loại nhà ở & Các phòng trong căn hộ (Trang 149-152)",
    chapter: "Kappale 6",
    week: 15,
    description: "Khám phá kiến trúc nhà ở Phần Lan và các phòng chức năng trong căn nhà.",
    content: `# 🏡 Kappale 6: Asuminen ja koti (Nhà ở và tổ ấm)

Chào mừng bạn đến với **Chương 6 (Kappale 6)** của *Suomen Mestari 1*! Hôm nay chúng ta sẽ tìm hiểu về không gian sống và các tiện ích nhà ở tại Phần Lan.

---

### 🏢 1. 4 Loại hình nhà ở phổ biến tại Phần Lan
1. 🏬 **Kerrostalo**: Chung cư cao tầng (phổ biến nhất tại các trung tâm thành phố).
2. 🏘️ **Rivitalo**: Nhà liền kề (mỗi căn hộ có cửa đi riêng và một mảnh sân vườn nhỏ xinh xắn *takapiha*).
3. 🏡 **Omakotitalo**: Nhà biệt lập riêng biệt (thường có sân vườn rộng, garage riêng và phòng sauna củi).
4. 🏡 **Paritalo**: Nhà song lập (2 gia đình chung một vách ngăn đôi).

---

### 🚪 2. Các phòng trong nhà (Huoneet)
* **Eteinen**: Tiền sảnh lối vào nhà (nơi cởi áo khoác ấm và tháo giày dép - văn hóa Phần Lan tuyệt đối không mang giày dép vào trong nhà!).
* **Keittiö**: Phòng bếp (*Keittokomero* = góc bếp nhỏ).
* **Olohuone**: Phòng khách / phòng sinh hoạt chung.
* **Makuuhuone**: Phòng ngủ.
* **Kylpyhuone (KPH)**: Phòng tắm.
* **Sauna**: Phòng tắm hơi sauna.
* **Parveke**: Ban công kính đón nắng.

---

### 📝 3. Thử thách tương tác
[exercise:ex_w15_d1_asumissanasto]`
  },
  {
    id: "w15_d2_tuvung_huonekalut",
    title: "Từ vựng: Đồ nội thất & Thiết bị gia dụng (Trang 153-154)",
    chapter: "Kappale 6",
    week: 15,
    description: "Bộ từ vựng trang bị trọn vẹn cho một căn hộ mới chuyển đến.",
    content: `# 🛋️ Từ vựng: Đồ nội thất (Huonekalut) & Thiết bị gia dụng (Kodinkoneet)

---

### 🪑 1. Đồ nội thất căn bản
* **sohva**: ghế sofa êm ái
* **nojatuoli**: ghế bành tựa lưng
* **pöytä**: cái bàn (*ruokapöytä* = bàn ăn, *kirjoituspöytä* = bàn học/viết)
* **tuoli**: cái ghế
* **sänky**: chiếc giường ngủ
* **kirjahylly**: kệ sách
* **vaatekaappi**: tủ đựng quần áo
* **matto**: tấm thảm trải sàn
* **verhot**: rèm cửa sổ
* **lamppu**: đèn chiếu sáng

---

### ⚡ 2. Thiết bị gia dụng hiện đại
* **jääkaappi**: tủ lạnh (*pakastin* = tủ đông)
* **hella / liesi**: bếp nấu điện/từ
* **uuni**: lò nướng
* **mikroaaltouuni (mikro)**: lò vi sóng
* **tiskikone / astianpesukone**: máy rửa chén bát
* **pesukone / pyykinpesukone**: máy giặt quần áo`
  },
  {
    id: "sign_huoltoyhtio_isannoitsija",
    title: "Immersion Thực tế: Ban quản lý tòa nhà (Huoltoyhtiö & Isännöitsijä)",
    chapter: "Kappale 6",
    week: 15,
    description: "Ai là người sửa ống nước, mở khóa cửa khi bạn quên chìa tại chung cư Phần Lan?",
    content: `# 🔧 Immersion Đời sống: HUOLTOYHTIÖ & ISÄNNÖITSIJÄ

Tại mọi chung cư Phần Lan, ngay lối vào tầng 1 luôn dán một bảng thông tin quan trọng nhất:

> # 🏢 HUOLTOYHTIÖ (Công ty bảo trì kỹ thuật)
> # 👨‍💼 ISÄNNÖITSIJÄ (Ban quản lý vận hành tòa nhà)

---

### 📞 Khi nào bạn cần gọi Huoltoyhtiö?
* 🔑 **Ovenavaus**: Bạn lỡ quên chìa khóa trong nhà và bị khóa ngoài cửa (gọi thợ huolto đến mở cửa cứu viện, phí khoảng 30 - 50 €).
* 🚰 **Hana vuotaa**: Vòi nước bồn rửa mặt bị rò rỉ.
* ❄️ **Patteri on kylmä**: Lò sưởi ấm trong phòng mùa đông không nóng.`
  },
  {
    id: "sign_vuokraovi_oikotie",
    title: "Immersion Đời sống: Giải mã tin đăng thuê nhà Oikotie / Vuokraovi",
    chapter: "Kappale 6",
    week: 15,
    description: "Bí quyết đọc hiểu hợp đồng thuê nhà và các chi phí điện, nước, internet tại Phần Lan.",
    content: `# 🔑 Immersion Thực tế: Đọc tin thuê nhà Phần Lan

Khi thuê nhà trên *Oikotie.fi* hoặc *Lumo.fi*, bạn sẽ thấy các thông số:

* 🏠 **Vuokra**: Tiền thuê nhà hàng tháng (ví dụ: *750 €/kk*).
* 💧 **Vesimaksu**: Tiền nước (thường là *20 - 25 € / người / tháng*).
* 🛡️ **Vakuus / Takuuvuokra**: Tiền đặt cọc nhà (thường bằng 1 - 2 tháng tiền thuê).
* 🔌 **Sähkösopimus**: Hợp đồng tiền điện (người thuê tự ký trực tiếp với công ty điện lực như Helen, Fortum).
* 📜 **Kotivakuutus**: Bảo hiểm nhà ở (bắt buộc 100% chủ nhà Phần Lan đều yêu cầu người thuê phải mua trước khi nhận chìa khóa).`
  },
  {
    id: "w15_d7_tonghop_tuan15",
    title: "Tổng kết & Củng cố Tuần 15 (Kappale 6)",
    chapter: "Kappale 6",
    week: 15,
    description: "Ôn tập các loại nhà, các phòng, đồ nội thất và thủ tục thuê nhà.",
    content: `# 🏆 Tổng kết & Củng cố Tuần 15

* ✅ Phân biệt rõ ràng *kerrostalo, rivitalo, omakotitalo*.
* ✅ Thuộc toàn bộ tên các phòng trong nhà và đồ gia dụng thiết yếu.
* ✅ Đọc hiểu thông số tin rao nhà đất và biết cách liên hệ ban quản lý *huoltoyhtiö*.`
  },

  // TUẦN 16
  {
    id: "w16_d1_nguphap_paikansijat_6",
    title: "Ngữ pháp: Hệ thống 6 Cách chỉ Vị trí Nơi chốn (Paikansijat) (Trang 155-156)",
    chapter: "Kappale 6",
    week: 16,
    description: "Giải mã hệ thống hậu tố vị trí không gian 3 chiều hoàn hảo của tiếng Phần Lan.",
    content: `# 🧭 Ngữ pháp: 6 Cách chỉ Vị trí Nơi chốn (Paikansijat)

Trong tiếng Phần Lan, thay vì dùng các giới từ rời (*in, from, to, on*) như tiếng Anh, ngôn ngữ này gắn trực tiếp các hậu tố biểu đạt không gian vào sau danh từ!

---

### 📦 1. Nhóm vị trí BÊN TRONG (Sisäpaikansijat)

| Hướng chuyển động | Tên cách ngữ pháp | Hậu tố | Ví dụ câu | Dịch nghĩa |
| :--- | :--- | :--- | :--- | :--- |
| **Mihin?** (Đi vào trong) | **Illatiivi** | **-Vn / -hVn / -seen** | *Menen **taloon**.* | Tôi đi **vào trong nhà**. |
| **Missä?** (Ở bên trong) | **Inessiivi** | **-ssa / -ssä** | *Olen **talossa**.* | Tôi đang **ở trong nhà**. |
| **Mistä?** (Từ trong ra) | **Elatiivi** | **-sta / -stä** | *Tulen **talosta**.* | Tôi đi **từ trong nhà ra**. |

---

### 🏞️ 2. Nhóm vị trí BÊN NGOÀI / BỀ MẶT (Ulkopaikansijat)

| Hướng chuyển động | Tên cách ngữ pháp | Hậu tố | Ví dụ câu | Dịch nghĩa |
| :--- | :--- | :--- | :--- | :--- |
| **Mille?** (Đi lên bề mặt/tới) | **Allatiivi** | **-lle** | *Menen **torille**.* | Tôi đi **ra quảng trường chợ**. |
| **Millä?** (Ở trên bề mặt) | **Adessiivi** | **-lla / -llä** | *Olen **torilla**.* | Tôi đang **ở ngoài chợ**. |
| **Miltä?** (Từ bề mặt rời đi)| **Ablatiivi** | **-lta / -ltä** | *Tulen **torilta**.* | Tôi đi **từ chợ về**. |

---

### 📝 3. Bài tập tương tác vị trí nơi chốn
[exercise:ex_w16_d1_paikansijat_6]`
  },
  {
    id: "w16_d2_nguphap_huoneessa_on",
    title: "Ngữ pháp: Cấu trúc tồn tại vị trí 'Huoneessa on...' (Trang 156)",
    chapter: "Kappale 6",
    week: 16,
    description: "Cách miêu tả đồ đạc trong một không gian: 'Ở trong... có một...'",
    content: `# 📍 Ngữ pháp: Cấu trúc tồn tại nơi chốn (Eksistentiaalilause)

Khi muốn miêu tả trong một căn phòng hay một địa điểm có cái gì (tương đương với *There is / There are*):
> 👉 **[Địa điểm ở dạng -ssa / -lla] + ON + [Đồ vật tồn tại]**

---

### 💡 Các câu ví dụ sinh động
* *Keittiössä on jääkaappi ja pöytä.* (Trong bếp có một chiếc tủ lạnh và một cái bàn).
* *Olohuoneessa on mukava sohva.* (Trong phòng khách có một bộ sofa êm ái).
* *Pöydällä on tietokone ja kirja.* (Trên bàn có máy tính và quyển sách).
* *Pihalla on kaksi autoa.* (Ngoài sân có 2 chiếc ô tô).`
  },
  {
    id: "w16_d4_nguphap_imperatiivi",
    title: "Ngữ pháp: Thể Mệnh lệnh cơ bản & Chỉ đường (Trang 157)",
    chapter: "Kappale 6",
    week: 16,
    description: "Cách ra mệnh lệnh lịch sự và chỉ dẫn đường đi trong thành phố.",
    content: `# 🚶 Ngữ pháp: Thể Mệnh lệnh (Imperatiivi) & Chỉ đường

---

### 🗣️ 1. Thể mệnh lệnh ngôi Sinä (Bạn hãy...)
Lấy **Thân từ cấp YẾU** của động từ:
* *tulla* -> **Tule!** (Hãy đến đây!)
* *mennä* -> **Mene!** (Hãy đi đi!)
* *ottaa* -> **Ota!** (Hãy lấy đi!)
* *katsoa* -> **Katso!** (Hãy nhìn kìa!)
* *odottaa* -> **Odota!** (Hãy đợi một chút!)

---

### 🗺️ 2. Mẫu câu chỉ đường
* **Mene suoraan eteenpäin.** = Hãy đi thẳng về phía trước.
* **Käänny oikealle.** = Hãy rẽ sang phải.
* **Käänny vasemmalle.** = Hãy rẽ sang trái.
* **Se on kadun toisella puolella.** = Nó nằm ở phía bên kia đường.

---

### 📝 3. Bài tập tương tác
[exercise:ex_w16_d4_imperatiivi_ohjeet]`
  },
  {
    id: "sign_jarjestyssaannot_kierratys",
    title: "Immersion Đời sống: Nội quy chung cư & Phân loại rác (Kierrätys)",
    chapter: "Kappale 6",
    week: 16,
    description: "Hiểu quy định giờ yên tĩnh Hiljaisuus 22-07 và cách bảo vệ môi trường chuẩn Phần Lan.",
    content: `# ♻️ Immersion Thực tế: NỘI QUY CHUNG CƯ & PHÂN LOẠI RÁC

Ở Phần Lan, hai điều tuyệt đối phải tuân thủ khi sống tại chung cư:

---

### 🤫 1. Giờ yên tĩnh (Hiljaisuus / Yörauha)
Từ **22:00 đêm đến 07:00 sáng hôm sau**, tòa nhà bước vào giờ yên tĩnh tuyệt đối: không mở nhạc lớn, không bật máy giặt, không khoan đục tường.

---

### 🗑️ 2. Nhà rác chung cư (Jätekatos / Kierrätys)
Phần Lan là một trong những quốc gia tái chế rác hàng đầu thế giới:
* 🔵 **Paperi**: Báo, tạp chí, giấy in.
* 📦 **Kartonki**: Thùng carton, vỏ hộp sữa giấy (phải gấp dẹp trước khi bỏ vào thùng).
* 🍾 **Lasi**: Chai lọ thủy tinh trong suốt và có màu.
* 🥫 **Metalli**: Vỏ lon nhôm, đồ kim loại nhỏ.
* 🟡 **Muovi**: Bao bì nhựa thực phẩm.
* 🍏 **Biojäte**: Rác hữu cơ, vỏ rau củ, thức ăn thừa (bỏ vào túi giấy phân hủy sinh học).
* ⚫ **Sekajäte**: Rác thải sinh hoạt vô cơ còn lại.`
  },
  {
    id: "w16_d7_tonghop_tuan16",
    title: "Tổng kết & Củng cố Tuần 16 (Kappale 6)",
    chapter: "Kappale 6",
    week: 16,
    description: "Ôn tập 6 cách vị trí nơi chốn, cấu trúc Huoneessa on và thể mệnh lệnh chỉ đường.",
    content: `# 🏆 Tổng kết & Củng cố Tuần 16

* ✅ Nắm chắc bộ 6 cách vị trí nơi chốn (*Missä, Mistä, Mihin, Millä, Miltä, Mille*).
* ✅ Biết cách miêu tả đồ vật trong phòng bằng cấu trúc *Huoneessa on...*.
* ✅ Biết cách chỉ đường và dùng thể mệnh lệnh *Mene suoraan, Käänny oikealle*.
* ✅ Hiểu nội quy chung cư và văn hóa phân loại rác bảo vệ môi trường.`
  },

  // TUẦN 17
  {
    id: "w17_d1_baitap_harjoitus19_25",
    title: "Bài tập thực hành: Harjoitus 19 - 25 Chương 6 (Trang 168-175)",
    chapter: "Kappale 6",
    week: 17,
    description: "Thực hành giải bài tập hình ảnh vị trí đồ vật và chia đuôi nơi chốn.",
    content: `# ✍️ Bài tập thực hành: Harjoitus 19 - 25 (Trang 168-175)

Tuần thứ 17 là tuần tổng lực rèn luyện chia các cách vị trí nơi chốn trong mọi ngữ cảnh đời thực.`
  },
  {
    id: "w17_d5_kiemtra_tongket_kappale6",
    title: "Đề kiểm tra đánh giá năng lực toàn diện: Kappale 6 (Trang 182-183)",
    chapter: "Kappale 6",
    week: 17,
    description: "Đề kiểm tra chuẩn hóa tổng kết toàn diện kiến thức Chương 6.",
    content: `# 🎓 Đề kiểm tra năng lực toàn diện: Kappale 6

Kiểm tra 3 trụ cột:
1. Từ vựng Nhà cửa, Đồ đạc và Tiện nghi căn hộ.
2. Hệ thống 6 cách vị trí nơi chốn Paikansijat.
3. Kỹ năng chỉ đường và thể mệnh lệnh Imperatiivi.

---

### ✍️ Bắt đầu làm bài kiểm tra tương tác
[exercise:ex_w17_d5_kiemtra_kappale6]`
  },
  {
    id: "w17_d7_tongket_kappale6",
    title: "Tổng kết Tháng thứ 4: Vượt mốc 70% toàn bộ giáo trình!",
    chapter: "Kappale 6",
    week: 17,
    description: "Hoàn tất trọn vẹn Chương 6: Sẵn sàng bước sang Chương 7 (Du lịch & Quá khứ đơn).",
    content: `# 🏆 Chúc mừng bạn đã hoàn thành xuất sắc Chương 6!

Bạn đã đi qua **17 / 24 tuần (Hơn 70% toàn bộ giáo trình Suomen Mestari 1)**!
Hệ thống biến cách nơi chốn - viên ngọc quý của ngữ pháp Phần Lan - đã nằm trọn vẹn trong tay bạn.

Tuần tới, chúng ta sẽ bước sang **Chương 7 (Tuần 18 - 19): Thành phố, Du lịch, Thể mệnh lệnh mở rộng và Thì quá khứ đơn giản (Imperfekti)**!`
  }
];

// ==========================================
// 3. CURRICULUM WEEKS 15, 16, 17
// ==========================================
const week15 = {
  id: "week_15",
  planId: "6iWorOc6mZtnINIFBH8a",
  weekNumber: 15,
  title: "Tháng 4 - Tuần 15: Khởi động Chương 6: Nhà cửa & Đồ nội thất",
  description: "Bắt đầu Chương 6 (Kappale 6): Các loại hình nhà ở Phần Lan (Trang 149-150), Các phòng trong căn hộ Huoneet (Trang 151-152), Đồ nội thất & Thiết bị gia dụng Kodinkoneet, Ban quản lý tòa nhà Huoltoyhtiö và Giải mã tin đăng thuê nhà Oikotie.",
  chapter: "Kappale 6",
  bookPages: "149-154, 158-161",
  days: [
    {
      dayIndex: 1,
      dayName: "Thứ 2",
      actions: [
        {
          id: "w15_d1_act1",
          type: "lesson_full",
          title: "Kappale 6: Các loại nhà ở & Các phòng trong căn hộ (Trang 149-152)",
          goal: "Phân biệt kerrostalo, rivitalo, omakotitalo và tên các phòng chức năng.",
          estimatedMinutes: 25,
          targetRefId: "w15_d1_tuvung_talotyypit_huoneet",
          steps: [
            { stepNumber: 1, instruction: "Học từ vựng 4 loại hình nhà ở và các phòng." },
            { stepNumber: 2, instruction: "Làm bài tập tương tác nhà ở." }
          ]
        }
      ]
    },
    {
      dayIndex: 2,
      dayName: "Thứ 3",
      actions: [
        {
          id: "w15_d2_act1",
          type: "vocabulary_set",
          title: "Từ vựng: Đồ nội thất & Thiết bị gia dụng (Trang 153-154)",
          goal: "Làm chủ từ vựng bàn, ghế, tủ, giường, máy giặt, tủ lạnh.",
          estimatedMinutes: 20,
          targetRefId: "w15_d2_tuvung_huonekalut",
          steps: [
            { stepNumber: 1, instruction: "Học bảng đồ đạc nội thất và thiết bị gia dụng." }
          ]
        }
      ]
    },
    {
      dayIndex: 3,
      dayName: "Thứ 4",
      actions: [
        {
          id: "w15_d3_act1",
          type: "immersion_sign",
          title: "Immersion Thực tế: Ban quản lý tòa nhà (Huoltoyhtiö & Isännöitsijä)",
          goal: "Hiểu vai trò của công ty bảo trì và ban quản trị chung cư.",
          estimatedMinutes: 10,
          targetRefId: "sign_huoltoyhtio_isannoitsija",
          steps: [
            { stepNumber: 1, instruction: "Đọc cẩm nang về các tình huống gọi huoltoyhtiö." }
          ]
        },
        {
          id: "w15_d3_act2",
          type: "immersion_sign",
          title: "Immersion Đời sống: Giải mã tin đăng thuê nhà Oikotie / Vuokraovi",
          goal: "Học cách đọc hiểu mẩu tin tìm nhà thuê thực tế.",
          estimatedMinutes: 10,
          targetRefId: "sign_vuokraovi_oikotie",
          steps: [
            { stepNumber: 1, instruction: "Đọc cẩm nang thuê nhà tại Phần Lan." }
          ]
        }
      ]
    },
    {
      dayIndex: 4,
      dayName: "Thứ 5",
      actions: [
        {
          id: "w15_d4_act1",
          type: "exercise_set",
          title: "Bài tập thực hành: Harjoitus 3 - 10 Chương 6 (Trang 158-161)",
          goal: "Rèn luyện giải các bài tập từ vựng nhà ở và đồ đạc.",
          estimatedMinutes: 25,
          targetRefId: "w15_d1_tuvung_talotyypit_huoneet",
          steps: [
            { stepNumber: 1, instruction: "Làm bài tập điền từ trong sách giáo khoa." }
          ]
        }
      ]
    },
    {
      dayIndex: 5,
      dayName: "Thứ 6",
      actions: [
        {
          id: "w15_d5_act1",
          type: "lesson_slice",
          title: "Thực hành: Miêu tả căn phòng lý tưởng của bạn",
          goal: "Tập viết 5 câu giới thiệu căn hộ hoặc phòng ngủ của mình.",
          estimatedMinutes: 20,
          targetRefId: "w15_d1_tuvung_talotyypit_huoneet",
          steps: [
            { stepNumber: 1, instruction: "Viết đoạn văn ngắn miêu tả đồ đạc trong phòng." }
          ]
        }
      ]
    },
    {
      dayIndex: 6,
      dayName: "Thứ 7",
      actions: [
        {
          id: "w15_d6_act1",
          type: "custom",
          title: "Tổng kết & Củng cố Tuần 15 (Kappale 6)",
          goal: "Ôn tập toàn bộ kiến thức tuần 15.",
          estimatedMinutes: 15,
          targetRefId: "w15_d7_tonghop_tuan15",
          steps: [
            { stepNumber: 1, instruction: "Đọc tóm tắt tuần 15." }
          ]
        }
      ]
    },
    {
      dayIndex: 7,
      dayName: "Chủ Nhật",
      actions: [
        {
          id: "w15_d7_act1",
          type: "custom",
          title: "Nghỉ ngơi nạp năng lượng (Ota rennosti)",
          goal: "Thư giãn cuối tuần.",
          estimatedMinutes: 15,
          targetRefId: "w15_d7_tonghop_tuan15",
          steps: [
            { stepNumber: 1, instruction: "Nghỉ ngơi thư giãn." }
          ]
        }
      ]
    }
  ]
};

const week16 = {
  id: "week_16",
  planId: "6iWorOc6mZtnINIFBH8a",
  weekNumber: 16,
  title: "Tháng 4 - Tuần 16: Ngữ pháp 6 Cách Vị trí Nơi chốn (Paikansijat) & Chỉ đường",
  description: "Trọng tâm ngữ pháp Chương 6: Hệ thống 6 cách vị trí nơi chốn Missä/Mistä/Mihin (-ssa, -sta, -on) và Millä/Miltä/Mille (-lla, -lta, -lle), Cấu trúc Huoneessa on..., Thể mệnh lệnh Imperatiivi và Văn hóa phân loại rác Kierrätys.",
  chapter: "Kappale 6",
  bookPages: "155-157, 162-167",
  days: [
    {
      dayIndex: 1,
      dayName: "Thứ 2",
      actions: [
        {
          id: "w16_d1_act1",
          type: "grammar_point",
          title: "Ngữ pháp: Hệ thống 6 Cách chỉ Vị trí Nơi chốn (Paikansijat) (Trang 155-156)",
          goal: "Làm chủ bản đồ 3 hướng bên trong (-ssa/-sta/-on) và bên ngoài (-lla/-lta/-lle).",
          estimatedMinutes: 30,
          targetRefId: "w16_d1_nguphap_paikansijat_6",
          steps: [
            { stepNumber: 1, instruction: "Học bảng so sánh 6 cách vị trí." },
            { stepNumber: 2, instruction: "Làm bài tập tương tác chia đuôi vị trí." }
          ]
        }
      ]
    },
    {
      dayIndex: 2,
      dayName: "Thứ 3",
      actions: [
        {
          id: "w16_d2_act1",
          type: "grammar_point",
          title: "Ngữ pháp: Cấu trúc tồn tại vị trí 'Huoneessa on...' (Trang 156)",
          goal: "Thành thạo miêu tả đồ vật có ở trong phòng hoặc trên bàn.",
          estimatedMinutes: 25,
          targetRefId: "w16_d2_nguphap_huoneessa_on",
          steps: [
            { stepNumber: 1, instruction: "Học công thức [Địa điểm] + on + [Vật]." }
          ]
        }
      ]
    },
    {
      dayIndex: 3,
      dayName: "Thứ 4",
      actions: [
        {
          id: "w16_d3_act1",
          type: "grammar_point",
          title: "Ngữ pháp: Thể Mệnh lệnh cơ bản & Chỉ đường (Trang 157)",
          goal: "Biết cách chỉ đường: Mene suoraan, Käänny oikealle/vasemmalle.",
          estimatedMinutes: 25,
          targetRefId: "w16_d4_nguphap_imperatiivi",
          steps: [
            { stepNumber: 1, instruction: "Học thể mệnh lệnh ngôi sinä và các cụm từ chỉ hướng." },
            { stepNumber: 2, instruction: "Làm bài tập tương tác chỉ đường." }
          ]
        },
        {
          id: "w16_d3_act2",
          type: "immersion_sign",
          title: "Immersion Đời sống: Nội quy chung cư & Phân loại rác (Kierrätys)",
          goal: "Hiểu quy định giờ yên tĩnh và cách phân loại 7 thùng rác chuẩn Phần Lan.",
          estimatedMinutes: 15,
          targetRefId: "sign_jarjestyssaannot_kierratys",
          steps: [
            { stepNumber: 1, instruction: "Đọc cẩm nang văn hóa chung cư Phần Lan." }
          ]
        }
      ]
    },
    {
      dayIndex: 4,
      dayName: "Thứ 5",
      actions: [
        {
          id: "w16_d4_act1",
          type: "exercise_set",
          title: "Bài tập thực hành: Harjoitus 11 - 18 Chương 6 (Trang 162-167)",
          goal: "Rèn luyện giải các bài tập chia đuôi nơi chốn trong câu.",
          estimatedMinutes: 25,
          targetRefId: "w16_d1_nguphap_paikansijat_6",
          steps: [
            { stepNumber: 1, instruction: "Làm bài tập điền đuôi -ssa, -sta, -on." }
          ]
        }
      ]
    },
    {
      dayIndex: 5,
      dayName: "Thứ 6",
      actions: [
        {
          id: "w16_d5_act1",
          type: "lesson_slice",
          title: "Luyện tập: Hỏi và chỉ đường đến nhà ga hoặc siêu thị",
          goal: "Thực hành hội thoại hỏi đường ngoài phố.",
          estimatedMinutes: 20,
          targetRefId: "w16_d4_nguphap_imperatiivi",
          steps: [
            { stepNumber: 1, instruction: "Thực hành câu hỏi Anteeksi, miten pääsen asemalle?" }
          ]
        }
      ]
    },
    {
      dayIndex: 6,
      dayName: "Thứ 7",
      actions: [
        {
          id: "w16_d6_act1",
          type: "custom",
          title: "Tổng kết & Củng cố Tuần 16 (Kappale 6)",
          goal: "Ôn tập 6 cách vị trí và chỉ đường.",
          estimatedMinutes: 15,
          targetRefId: "w16_d7_tonghop_tuan16",
          steps: [
            { stepNumber: 1, instruction: "Đọc tóm tắt tuần 16." }
          ]
        }
      ]
    },
    {
      dayIndex: 7,
      dayName: "Chủ Nhật",
      actions: [
        {
          id: "w16_d7_act1",
          type: "custom",
          title: "Nghỉ ngơi nạp năng lượng (Ota rennosti)",
          goal: "Thư giãn cuối tuần.",
          estimatedMinutes: 15,
          targetRefId: "w16_d7_tonghop_tuan16",
          steps: [
            { stepNumber: 1, instruction: "Nghỉ ngơi thư giãn." }
          ]
        }
      ]
    }
  ]
};

const week17 = {
  id: "week_17",
  planId: "6iWorOc6mZtnINIFBH8a",
  weekNumber: 17,
  title: "Tháng 5 - Tuần 17: Hoàn thiện Bài tập Chương 6 & Đề kiểm tra đánh giá",
  description: "Hoàn thiện 100% bài tập Chương 6 (Harjoitus 19 - 30), Thực hành tranh ảnh vị trí đồ đạc, Đề kiểm tra đánh giá năng lực toàn diện Kappale 6 (Chinh phục mốc hơn 70% giáo trình).",
  chapter: "Kappale 6",
  bookPages: "168-183",
  days: [
    {
      dayIndex: 1,
      dayName: "Thứ 2",
      actions: [
        {
          id: "w17_d1_act1",
          type: "exercise_set",
          title: "Bài tập thực hành: Harjoitus 19 - 25 Chương 6 (Trang 168-175)",
          goal: "Giải các bài tập biến cách nơi chốn theo tranh vẽ sinh động.",
          estimatedMinutes: 25,
          targetRefId: "w17_d1_baitap_harjoitus19_25",
          steps: [
            { stepNumber: 1, instruction: "Làm bài tập điền đuôi vị trí." }
          ]
        }
      ]
    },
    {
      dayIndex: 2,
      dayName: "Thứ 3",
      actions: [
        {
          id: "w17_d2_act1",
          type: "exercise_set",
          title: "Hoàn thiện toàn bộ bài tập còn lại: Harjoitus 26 - 30 (Trang 176-181)",
          goal: "Giải quyết 100% bài tập còn lại của Chương 6.",
          estimatedMinutes: 25,
          targetRefId: "w17_d1_baitap_harjoitus19_25",
          steps: [
            { stepNumber: 1, instruction: "Làm bài tập đọc hiểu và tổng kết." }
          ]
        }
      ]
    },
    {
      dayIndex: 3,
      dayName: "Thứ 4",
      actions: [
        {
          id: "w17_d3_act1",
          type: "lesson_slice",
          title: "Đọc hiểu: Chuyến tham quan căn hộ mới của bạn bè",
          goal: "Đọc hiểu đoạn văn tổng hợp về nhà ở và đồ đạc.",
          estimatedMinutes: 20,
          targetRefId: "w17_d1_baitap_harjoitus19_25",
          steps: [
            { stepNumber: 1, instruction: "Đọc bài và trả lời câu hỏi." }
          ]
        }
      ]
    },
    {
      dayIndex: 4,
      dayName: "Thứ 5",
      actions: [
        {
          id: "w17_d4_act1",
          type: "lesson_full",
          title: "Đề kiểm tra đánh giá năng lực toàn diện: Kappale 6 (Trang 182-183)",
          goal: "Kiểm tra toàn diện trước khi bước sang Chương 7.",
          estimatedMinutes: 30,
          targetRefId: "w17_d5_kiemtra_tongket_kappale6",
          steps: [
            { stepNumber: 1, instruction: "Làm bài kiểm tra tương tác tổng kết Chương 6." }
          ]
        }
      ]
    },
    {
      dayIndex: 5,
      dayName: "Thứ 6",
      actions: [
        {
          id: "w17_d5_act2",
          type: "custom",
          title: "Tổng kết Tháng thứ 4: Vượt mốc 70% toàn bộ giáo trình!",
          goal: "Tự hào nhìn lại chặng đường 17 tuần đã chinh phục.",
          estimatedMinutes: 15,
          targetRefId: "w17_d7_tongket_kappale6",
          steps: [
            { stepNumber: 1, instruction: "Đọc bản tổng kết tuần 17." }
          ]
        }
      ]
    },
    {
      dayIndex: 6,
      dayName: "Thứ 7",
      actions: [
        {
          id: "w17_d6_act1",
          type: "custom",
          title: "Nghỉ ngơi thư giãn (Ota rennosti)",
          goal: "Chuẩn bị bước sang Chương 7: Thành phố, Du lịch & Thời quá khứ.",
          estimatedMinutes: 15,
          targetRefId: "w17_d7_tongket_kappale6",
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
          id: "w17_d7_act1",
          type: "custom",
          title: "Nghỉ ngơi nạp năng lượng",
          goal: "Sẵn sàng cho chặng đường tiếp theo.",
          estimatedMinutes: 15,
          targetRefId: "w17_d7_tongket_kappale6",
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
async function buildAndSyncPhase6() {
  console.log('🚀 === GENERATING AND SYNCING PHASE 6 (WEEKS 15, 16, 17 - CHAPTER 6) ===\n');

  const currDir = path.resolve(__dirname, '../../content/curriculum');
  const lessDir = path.resolve(__dirname, '../../content/lessons');

  // Save local files
  fs.writeFileSync(path.join(currDir, 'chapter_06_exercises.json'), JSON.stringify({ exercises }, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/chapter_06_exercises.json');

  fs.writeFileSync(path.join(lessDir, 'chapter_06_lessons.json'), JSON.stringify({ lessons }, null, 2), 'utf8');
  console.log('✅ Generated content/lessons/chapter_06_lessons.json');

  fs.writeFileSync(path.join(currDir, 'week_15.json'), JSON.stringify(week15, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/week_15.json');

  fs.writeFileSync(path.join(currDir, 'week_16.json'), JSON.stringify(week16, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/week_16.json');

  fs.writeFileSync(path.join(currDir, 'week_17.json'), JSON.stringify(week17, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/week_17.json');

  // Sync Exercises to Firestore
  console.log('\n📝 1. Synchronizing Phase 6 Interactive Exercises into Firestore `exercises`...');
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
  console.log('\n📚 2. Synchronizing Phase 6 Rich Interactive Lessons into Firestore `lessons`...');
  for (const rawLesson of lessons) {
    await db.collection('lessons').doc(rawLesson.id).set({
      id: rawLesson.id,
      title: rawLesson.title,
      chapter: rawLesson.chapter || 'Kappale 6',
      week: rawLesson.week || 15,
      description: rawLesson.description || '',
      audioUrls: [],
      content: rawLesson.content,
      updatedAt: admin.firestore.FieldValue.serverTimestamp()
    }, { merge: true });

    if (rawLesson.id.startsWith('sign_') || rawLesson.id.startsWith('song_') || rawLesson.id.startsWith('video_')) {
      await db.collection('immersion_resources').doc(rawLesson.id).set({
        id: rawLesson.id,
        title: rawLesson.title,
        chapter: rawLesson.chapter || 'Kappale 6',
        description: rawLesson.description || '',
        content: rawLesson.content,
        type: rawLesson.id.startsWith('sign_') ? 'sign' : (rawLesson.id.startsWith('song_') ? 'music' : 'video'),
        updatedAt: admin.firestore.FieldValue.serverTimestamp()
      }, { merge: true });
    }

    console.log(`   ✅ Synced Lesson: [${rawLesson.id}] ${rawLesson.title}`);
  }

  // Sync Weeks 15, 16, 17 to Firestore
  console.log('\n📅 3. Synchronizing Study Plan Weeks 15, 16, 17 into Firestore `study_plan_weeks`...');
  const planId = '6iWorOc6mZtnINIFBH8a';
  const week15DocId = 'aYOPdAUFz1vTQSzDLPhw';
  const week16DocId = 'ViYEAo0ZX6Ht5WsAydmj';
  const week17DocId = 'BP5d8wSt8wZCNXnBZDVp';

  await db.collection('study_plan_weeks').doc(week15DocId).set({
    planId: planId,
    weekNumber: 15,
    title: week15.title,
    description: week15.description,
    days: week15.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Week 15 (doc: ${week15DocId})`);

  await db.collection('study_plan_weeks').doc(week16DocId).set({
    planId: planId,
    weekNumber: 16,
    title: week16.title,
    description: week16.description,
    days: week16.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Week 16 (doc: ${week16DocId})`);

  await db.collection('study_plan_weeks').doc(week17DocId).set({
    planId: planId,
    weekNumber: 17,
    title: week17.title,
    description: week17.description,
    days: week17.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Week 17 (doc: ${week17DocId})`);

  console.log('\n🎉 ALL PHASE 6 (WEEKS 15, 16, 17) CONTENT SYNCED SUCCESSFULLY TO FIRESTORE PRODUCTION!');
}

buildAndSyncPhase6().catch(err => {
  console.error('❌ Phase 6 Build & Sync failed:', err);
  process.exit(1);
});
