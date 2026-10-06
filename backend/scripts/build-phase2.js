const fs = require('fs');
const path = require('path');

// ==========================================
// 1. DATA DEFINITIONS FOR PHASE 2 (WEEKS 3, 4, 5 - CHAPTER 2)
// ==========================================

const audioUrls = JSON.parse(fs.readFileSync(path.resolve(__dirname, 'audio_urls_all.json'), 'utf8'));

function getAudioUrl(snippet) {
  if (!snippet) return '';
  for (const [key, url] of Object.entries(audioUrls)) {
    if (key.toLowerCase().includes(snippet.toLowerCase())) return url;
  }
  return '';
}

// ------------------------------------------
// EXERCISES (chapter_02_exercises.json)
// ------------------------------------------
const exercises = [
  {
    id: "ex_w3_d1_minkamaalainen",
    title: "Quốc gia, Quốc tịch & Ngôn ngữ (Kappale 2)",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Câu hỏi 'Minkämaalainen sinä olet?' có nghĩa là gì?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Bạn là người nước nào? (Quốc tịch gì?)",
          "Bạn sống ở đâu?",
          "Bạn nói tiếng gì?"
        ],
        correctIndex: 0,
        explanation: "'Minkämaalainen' hỏi về quốc tịch/nguồn gốc xuất xứ. 'Minkä' (gì) + 'maa' (đất nước) + '-lainen' (hậu tố người)."
      },
      {
        prompt: "Người Việt Nam trong tiếng Phần Lan là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "vietnamilainen",
          "vietnam",
          "vietnamia"
        ],
        correctIndex: 0,
        explanation: "Thêm đuôi '-lainen/-läinen' vào tên nước để tạo quốc tịch: Vietnam -> vietnamilainen."
      },
      {
        prompt: "Để nói 'Tôi nói tiếng Phần Lan', câu chuẩn là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Minä puhun suomea.",
          "Minä puhun suomalainen.",
          "Minä puhun Suomi."
        ],
        correctIndex: 0,
        explanation: "Động từ 'puhua' (nói) luôn đi với tân ngữ ở dạng Partitiivi: suomi -> suomea."
      }
    ]
  },
  {
    id: "ex_w3_d2_kielet_maat",
    title: "Nối Quốc gia & Ngôn ngữ (Harjoitus 12)",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Đất nước 'Ranska' (Nước Pháp) nói tiếng gì?",
        type: "MULTIPLE_CHOICE",
        options: [
          "ranskaa (tiếng Pháp)",
          "saksaa (tiếng Đức)",
          "espanjaa (tiếng Tây Ban Nha)"
        ],
        correctIndex: 0,
        explanation: "Ranska -> ranska / ranskaa."
      },
      {
        prompt: "Đất nước 'Saksa' (Nước Đức) nói tiếng gì?",
        type: "MULTIPLE_CHOICE",
        options: [
          "saksaa (tiếng Đức)",
          "venäjää (tiếng Nga)",
          "englantia (tiếng Anh)"
        ],
        correctIndex: 0,
        explanation: "Saksa -> saksa / saksaa."
      },
      {
        prompt: "Đất nước 'Venäjä' (Nước Nga) người dân là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "venäläinen",
          "venäjäläinen",
          "venäjäinen"
        ],
        correctIndex: 0,
        explanation: "Venäjä -> venäläinen (quy tắc biến đổi đuôi -läinen)."
      }
    ]
  },
  {
    id: "ex_w3_d3_jatskikiskalla",
    title: "Giao tiếp mua kem tại quầy Jätskikiskalla",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Trong văn nói đời thường, 'jäätelökioski' (quầy kem) được người Phần gọi tắt là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "jätskikispa / jätskikiska",
          "kioski jäätelö",
          "jäätelökauppa"
        ],
        correctIndex: 0,
        explanation: "'Jätski' là tiếng lóng rất phổ biến của 'jäätelö' (kem), 'kiska' là từ lóng của 'kioski'."
      },
      {
        prompt: "Khi mua hàng, mẫu câu lịch sự 'Cho tôi xin một cây kem vani' là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Yksi vaniljajäätelö, kiitos!",
          "Minä haluan vaniljajäätelö!",
          "Anna minulle jäätelö!"
        ],
        correctIndex: 0,
        explanation: "Trong văn hóa Phần Lan, chỉ cần nói '[Món đồ] + kiitos!' là cách gọi món tự nhiên và chuẩn mực nhất."
      }
    ]
  },
  {
    id: "ex_w3_d4_dongtunhom1",
    title: "Chia động từ nhóm 1 (Verbityyppi 1)",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Động từ 'puhua' (nói) chia cho ngôi 'hän' (anh ấy/cô ấy) là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "hän puhuu",
          "hän puhu",
          "hän puhuvat"
        ],
        correctIndex: 0,
        explanation: "Quy tắc ngôi thứ 3 số ít (hän) của nhóm 1: Bỏ đuôi -a/-ä, nhân đôi nguyên âm cuối cùng: puhu- -> puhuu."
      },
      {
        prompt: "Động từ 'asua' (sống/cư trú) chia cho ngôi 'me' (chúng tôi) là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "me asumme",
          "me asutte",
          "me asuvat"
        ],
        correctIndex: 0,
        explanation: "Đuôi của ngôi 'me' là '-mme': asu- + mme = asumme."
      },
      {
        prompt: "Động từ 'kysyä' (hỏi) chia cho ngôi 'he' (họ) là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "he kysyvät",
          "he kysyvat",
          "he kysyy"
        ],
        correctIndex: 0,
        explanation: "Do 'kysyä' chứa nguyên âm 'y' (nguyên âm trước), đuôi ngôi 'he' phải chọn '-vät' theo luật hài hòa nguyên âm."
      }
    ]
  },
  {
    id: "ex_w3_d5_phudinh_nhom1",
    title: "Thể phủ định của động từ nhóm 1",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "'Tôi không nói tiếng Nga' được dịch sang tiếng Phần là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "En puhu venäjää.",
          "Ei puhu venäjää.",
          "En puhun venäjää."
        ],
        correctIndex: 0,
        explanation: "Động từ phủ định chia theo ngôi 'minä' là 'en', động từ chính giữ nguyên thân từ cấp yếu không chia đuôi cá nhân: en puhu."
      },
      {
        prompt: "'Họ không sống ở Helsinki' là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "He eivät asu Helsingissä.",
          "He ei asu Helsingissä.",
          "He eivät asuvat Helsingissä."
        ],
        correctIndex: 0,
        explanation: "Ngôi 'he' đi với động từ phủ định 'eivät' + thân từ 'asu'."
      }
    ]
  },
  {
    id: "ex_w4_d1_kpt_astevaihtelu",
    title: "Hiện tượng biến âm K-P-T (Astevaihtelu)",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Cặp biến âm nào sau đây là biến âm K-P-T định lượng (Quantitative)?",
        type: "MULTIPLE_CHOICE",
        options: [
          "kk -> k, tt -> t, pp -> p",
          "k -> -, p -> v, t -> d",
          "nt -> nn, lt -> ll, rt -> rr"
        ],
        correctIndex: 0,
        explanation: "Biến âm định lượng là giảm từ 2 phụ âm giống nhau (âm đôi mạnh) xuống còn 1 phụ âm (âm đơn yếu): kk->k, tt->t, pp->p."
      },
      {
        prompt: "Động từ 'nukkua' (ngủ) có 'kk'. Khi chia ở ngôi 'minä' (âm tiết đóng), từ sẽ biến thành:",
        type: "MULTIPLE_CHOICE",
        options: [
          "nukun",
          "nukkuun",
          "nukkun"
        ],
        correctIndex: 0,
        explanation: "kk biến thành k ở ngôi minä (cấp yếu): minä nukun."
      },
      {
        prompt: "Động từ 'kirjoittaa' (viết) chia ở ngôi 'hän' (âm tiết mở) là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "hän kirjoittaa",
          "hän kirjoitaa",
          "hän kirjoitan"
        ],
        correctIndex: 0,
        explanation: "Ngôi hän giữ nguyên cấp MẠNH (vahva aste): tt giữ nguyên là tt -> hän kirjoittaa."
      }
    ]
  },
  {
    id: "ex_w4_d2_phatam_phuamdoi",
    title: "Luyện phát âm phụ âm đơn vs phụ âm đôi",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Từ 'tapaa' (gặp gỡ) và 'tappaa' (giết) khác nhau ở:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Độ dài của phụ âm p: 'tapaa' p ngắn nhẹ, 'tappaa' giữ hơi môi p lâu gấp đôi",
          "Khác nhau ở nguyên âm a",
          "Phát âm hoàn toàn giống nhau"
        ],
        correctIndex: 0,
        explanation: "Phụ âm đôi trong tiếng Phần Lan đòi hỏi người nói phải giữ chặt vị trí cấu âm (ngậm môi/giữ lưỡi) lâu gấp đôi trước khi nhả âm."
      },
      {
        prompt: "Từ nào sau đây có nghĩa là 'con mèo'?",
        type: "MULTIPLE_CHOICE",
        options: [
          "kissa (phụ âm đôi ss)",
          "kisa (cuộc thi - s đơn)",
          "kassi (cái túi)"
        ],
        correctIndex: 0,
        explanation: "'kissa' = con mèo. Nếu phát âm nhầm s đơn 'kisa' sẽ thành cuộc thi!"
      }
    ]
  },
  {
    id: "ex_w4_d3_cauhoi_koko_tudehoi",
    title: "Câu hỏi nghi vấn -ko/-kö & Từ để hỏi",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Để biến câu 'Sinä puhut suomea' thành câu hỏi 'Bạn có nói tiếng Phần Lan không?', ta nói:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Puhutko sinä suomea?",
          "Sinä puhutko suomea?",
          "Onko sinä puhut suomea?"
        ],
        correctIndex: 0,
        explanation: "Đưa động từ lên đầu câu và gắn hậu tố -ko/-kö: Puhut + ko = Puhutko sinä suomea?"
      },
      {
        prompt: "Từ để hỏi 'Missä' có nghĩa là gì?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Ở đâu?",
          "Từ đâu đến?",
          "Đi đâu?"
        ],
        correctIndex: 0,
        explanation: "'Missä' = Ở đâu (vị trí tĩnh). 'Mistä' = Từ đâu đến. 'Mihin' = Đi tới đâu."
      }
    ]
  },
  {
    id: "ex_w4_d4_sodem_hinnat",
    title: "Số đếm mở rộng & Giá cả (Hinnat)",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Số 25 trong tiếng Phần Lan viết là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "kaksikymmentäviisi",
          "viisikymmentäkaksi",
          "kaksikymmentä"
        ],
        correctIndex: 0,
        explanation: "kaksi (2) + kymmentä (mươi/chục) + viisi (5) = kaksikymmentäviisi."
      },
      {
        prompt: "Giá tiền '3,50 €' đọc chuẩn là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "kolme euroa viisikymmentä senttiä",
          "kolme viisikymmentä euro",
          "viisi euroa kolmekymmentä"
        ],
        correctIndex: 0,
        explanation: "Sau số đếm lớn hơn 1, euro ở dạng partitiivi: 'kolme euroa' + số xu 'viisikymmentä senttiä'."
      }
    ]
  },
  {
    id: "ex_w5_d1_harjoitus16_22",
    title: "Thực hành chia động từ KPT tổng hợp",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Động từ 'lukea' (đọc): k biến mất (-) ở cấp yếu. 'Tôi đọc sách' là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Minä luen kirjaa.",
          "Minä luken kirjaa.",
          "Minä lukeen kirjaa."
        ],
        correctIndex: 0,
        explanation: "lukea -> thân từ cấp yếu: lue- -> minä luen."
      },
      {
        prompt: "Động từ 'tietää' (biết): t biến thành d ở cấp yếu. 'Tôi không biết' là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "En tiedä.",
          "En tietää.",
          "En tietä."
        ],
        correctIndex: 0,
        explanation: "Cụm từ cửa miệng kinh điển: 'En tiedä' (Tôi không biết)."
      }
    ]
  },
  {
    id: "ex_w5_d5_kiemtra_kappale2",
    title: "Đề kiểm tra đánh giá năng lực Chương 2",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Chọn câu viết đúng ngữ pháp hoàn chỉnh:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Pedro asuu Suomessa ja puhuu portugalia.",
          "Pedro asu Suomessa ja puhu portugali.",
          "Pedro asuvat Suomessa ja puhuvat portugalia."
        ],
        correctIndex: 0,
        explanation: "Pedro (hän) đi với động từ nhân đôi nguyên âm cuối: asuu, puhuu; tiếng nói ở dạng partitiivi: portugalia."
      },
      {
        prompt: "Khi muốn hỏi 'Quyển sách này giá bao nhiêu?', ta hỏi:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Paljonko tämä kirja maksaa?",
          "Mikä tämä kirja maksaa?",
          "Kuka tämä kirja on?"
        ],
        correctIndex: 0,
        explanation: "'Paljonko [món đồ] maksaa?' là câu hỏi giá phổ biến và chính xác nhất."
      },
      {
        prompt: "Quy tắc K-P-T áp dụng khi nào?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Ở ngôi minä, sinä, me, te (âm tiết đóng) chia ở cấp YẾU; ngôi hän, he (âm tiết mở) giữ cấp MẠNH",
          "Áp dụng cho tất cả các ngôi như nhau",
          "Chỉ áp dụng cho câu phủ định"
        ],
        correctIndex: 0,
        explanation: "Đây là nguyên lý cốt lõi của Astevaihtelu trong động từ nhóm 1."
      }
    ]
  }
];

// ------------------------------------------
// LESSONS (chapter_02_lessons.json)
// ------------------------------------------
const lessons = [
  // TUẦN 3
  {
    id: "w3_d1_thoai_minkamaalainen",
    title: "Kappale 2: Hội thoại Minkämaalainen sinä olet? (Trang 28-30)",
    chapter: "Kappale 2",
    week: 3,
    description: "Học cách hỏi và trả lời về quốc tịch, quê hương, nơi sinh sống và ngôn ngữ giao tiếp.",
    audioSnippet: "15 Minkämaalainen",
    audioSnippet2: "16 Minkämaalainen",
    content: `# 🌍 Kappale 2: Minkämaalainen sinä olet? (Bạn là người nước nào?)

Chào mừng bạn đến với **Chương 2 (Kappale 2)** của *Suomen Mestari 1*! Trong chương này, các nhân vật **Alex**, **Pedro**, và **Olga** sẽ cùng nhau trò chuyện về quê hương, quốc tịch, nơi ở và ngôn ngữ mà họ có thể nói.

---

### 🎧 1. Nghe đoạn hội thoại chuẩn văn viết (Kirjakieli)
Bấm nút bên dưới để nghe Track 15:

[audio:AUDIO_URL_1]

---

### 💬 2. Lời thoại song ngữ & Phân tích chi tiết

| Người nói | Tiếng Phần Lan (Suomi) | Tiếng Việt (Vietnam) | Giải thích ngữ pháp |
| :--- | :--- | :--- | :--- |
| **Pedro** | Hei Alex! Minkämaalainen sinä olet? | Chào Alex! Bạn là người nước nào? | *minkämaalainen* = quốc tịch gì |
| **Alex** | Minä olen englantilainen. Mistä sinä olet kotoisin? | Tôi là người Anh. Bạn đến từ đâu? | *kotoisin* = xuất xứ từ quê nào |
| **Pedro** | Minä olen kotoisin Brasiliasta. Olen brasilialainen. | Tôi đến từ Brazil. Tôi là người Brazil. | *Brasiliasta* (đuôi -sta = từ nước Brazil) |
| **Alex** | Asutko sinä Helsingissä? | Bạn có sống ở Helsinki không? | Câu hỏi *-ko*: *Asutko* |
| **Pedro** | Joo, asun. Minä asun Vallilassa. Entä sinä? | Vâng, tôi sống ở Vallila (Helsinki). Còn bạn? | *Entä sinä?* = Còn bạn thì sao? |
| **Alex** | Minä asun Espoossa. | Tôi sống ở Espoo. | *Espoossa* (đuôi -ssa = ở trong) |
| **Pedro** | Puhutko sinä suomea? | Bạn có nói tiếng Phần Lan không? | *suomi* -> *suomea* (Partitiivi) |
| **Alex** | Puhun vähän suomea ja englantia. Entä sinä? | Tôi nói một chút tiếng Phần và tiếng Anh. Còn bạn? | *vähän* = một chút, ít |
| **Pedro** | Minä puhun portugalia, englantia ja vähän suomea. | Tôi nói tiếng Bồ Đào Nha, tiếng Anh và một chút tiếng Phần. | |

---

### 🎙️ 3. Nghe phiên bản văn nói đời thường (Puhekieli)
Trong đời sống thực tế ngoài ga tàu hay quán cà phê, người Phần Lan sẽ nói như Track 16:

[audio:AUDIO_URL_2]

> 💡 **Bảng so sánh Văn nói vs Văn viết:**
> * Văn viết: **Minkämaalainen sinä olet?** -> Văn nói: **Minkämaalainen sä oot?**
> * Văn viết: **Mistä sinä olet kotoisin?** -> Văn nói: **Mistä sä oot kotoisin?**
> * Văn viết: **Asutko sinä Helsingissä?** -> Văn nói: **Asutsä Helsingissä?**

---

### 📝 4. Thử thách phản xạ tương tác
Học viên hãy kiểm tra khả năng tiếp thu qua bài trắc nghiệm sau:

[exercise:ex_w3_d1_minkamaalainen]`
  },
  {
    id: "w3_d2_tuvung_quocgia_ngonngu",
    title: "Từ vựng: Quốc gia, Quốc tịch & Ngôn ngữ (Trang 31-32)",
    chapter: "Kappale 2",
    week: 3,
    description: "Nắm vững bảng quy đổi Tên nước -> Người nước đó -> Tiếng nói theo chuẩn Suomen Mestari 1.",
    audioSnippet: "17 Pedro",
    audioSnippet2: "29 Harjoitus 12",
    content: `# 🗺️ Từ vựng: Quốc gia (Maa), Quốc tịch (Kansallisuus) & Ngôn ngữ (Kieli)

Hôm nay chúng ta sẽ học bảng phân loại cốt lõi để giới thiệu xuất thân của bản thân và bạn bè quốc tế.

---

### 🎧 1. Nghe đọc nhân vật Pedro, Olga và Alex (Trang 31)
Bấm nút bên dưới để nghe Track 17:

[audio:AUDIO_URL_1]

---

### 📊 2. Bảng đối chiếu Quốc gia - Quốc tịch - Ngôn ngữ

| Đất nước (Maa) | Quốc tịch (Kansallisuus) | Ngôn ngữ nói (Puhua + kieltä) | Tiếng Việt |
| :--- | :--- | :--- | :--- |
| **Suomi** | suomalainen | suomea | Nước Phần Lan |
| **Vietnam** | vietnamilainen | vietnamia | Nước Việt Nam |
| **Englanti** | englantilainen | englantia | Nước Anh |
| **Brasilia** | brasilialainen | portugalia | Nước Brazil |
| **Venäjä** | venäläinen | venäjää | Nước Nga |
| **Ranska** | ranskalainen | ranskaa | Nước Pháp |
| **Saksa** | saksalainen | saksaa | Nước Đức |
| **Ruotsi** | ruotsalainen | ruotsia | Nước Thụy Điển |
| **Espanja** | espanjalainen | espanjaa | Nước Tây Ban Nha |
| **Italia** | italialainen | italiaa | Nước Ý |
| **Kiina** | kiinalainen | kiinaa | Nước Trung Quốc |
| **Japani** | japanilainen | japania | Nước Nhật Bản |

> 📌 **3 Nguyên tắc vàng cần ghi nhớ:**
> 1. **Tên nước (Maa):** Luôn viết hoa chữ cái đầu (*Suomi, Vietnam, Ranska*).
> 2. **Quốc tịch (Kansallisuus):** Viết chữ thường, thêm đuôi **-lainen / -läinen** (*suomalainen, vietnamilainen*).
> 3. **Ngôn ngữ (Kieli):** Viết chữ thường. Khi đi sau động từ *puhua* (nói), thêm đuôi đối cách **-a / -ä** (*suomea, englantia, venäjää*).

---

### 🎧 3. Harjoitus 12: Luyện nghe Quốc gia & Ngôn ngữ
Bấm Track 29 để nghe bài tập nhận diện quốc gia:

[audio:AUDIO_URL_2]

---

### ✍️ 4. Bài tập tương tác
[exercise:ex_w3_d2_kielet_maat]`
  },
  {
    id: "w3_d3_giaotiep_jatskikiskalla",
    title: "Giao tiếp: Mua kem tại quầy Jätskikiskalla (Trang 33-34)",
    chapter: "Kappale 2",
    week: 3,
    description: "Tình huống thực tế gọi món kem tại quầy Kioski mùa hè Phần Lan.",
    audioSnippet: "18 Puhutaan",
    audioSnippet2: "19 Puhekielen",
    content: `# 🍦 Giao tiếp thực tế: Puhutaan! Jätskikiskalla (Tại quầy kem)

Mùa hè ở Phần Lan là mùa của những quầy bán kem ngoài trời (**jäätelökioski**, hay giới trẻ gọi thân mật là **jätskikiska**).

---

### 🎧 1. Nghe đoạn hội thoại mua kem mẫu
Bấm Track 18 để nghe:

[audio:AUDIO_URL_1]

---

### 💬 2. Lời thoại tại quầy kem

| Người nói | Câu thoại | Dịch nghĩa |
| :--- | :--- | :--- |
| **Người bán** | Hei! Mitä saisi olla? | Xin chào! Bạn muốn dùng gì ạ? |
| **Pedro** | Yksi suklaajäätelö, kiitos. | Cho tôi một kem sô-cô-la nhé. |
| **Người bán** | Tötterö vai kuppi? | Ốc quế hay ly giấy ạ? |
| **Pedro** | Tötterö, kiitos. | Cho vào ốc quế nhé, cảm ơn. |
| **Người bán** | Entä sinulle? | Còn bạn thì sao? |
| **Olga** | Yksi vaniljajäätelö kupissa, kiitos. | Một kem vani trong ly giấy ạ. |
| **Người bán** | Tuleeko muuta? | Có thêm gì nữa không ạ? |
| **Olga** | Ei kiitos, siinä kaikki. | Dạ không, thế là đủ rồi ạ. |
| **Người bán** | Se tekee 6 euroa. | Tổng cộng hết 6 euro. |
| **Pedro** | Ole hyvä. | Xin gửi bạn tiền. |
| **Người bán** | Kiitos, ja ole hyvä! | Cảm ơn bạn và mời bạn nhận kem! |

---

### 🔢 3. Số đếm trong văn nói đời thường (Puhekielen numerot)
Nghe Track 19 để nắm cách người Phần đọc tắt số tiền khi thanh toán:

[audio:AUDIO_URL_2]

* 1 = **yks** (thay vì *yksi*)
* 2 = **kaks** (thay vì *kaksi*)
* 5 = **viis** (thay vì *viisi*)
* 6 = **kuus** (thay vì *kuusi*)
* 10 = **kymppi** (thay vì *kymmenen*)

---

### 📝 4. Bài tập tương tác
[exercise:ex_w3_d3_jatskikiskalla]`
  },
  {
    id: "sign_kioski_grilli",
    title: "Immersion Biển hiệu: KIOSKI & GRILLI",
    chapter: "Kappale 2",
    week: 3,
    description: "Khám phá nét văn hóa ẩm thực đường phố độc đáo tại các Kioski và Grilli Phần Lan.",
    content: `# 🌭 Immersion Biển hiệu đời thực: KIOSKI & GRILLI

Nếu bạn đi dạo quanh các góc phố ở Helsinki, Tampere hay Turku, bạn sẽ luôn bắt gặp những quầy ki-ốt nhỏ màu vàng hoặc đỏ mang biển hiệu:

> # 🏪 KIOSKI / R-KIOSKI & GRILLI

---

### 🍟 1. Văn hóa 'Grilli' của người Phần
**Grilli** (hay *Lippakioski*) là quầy thức ăn nhanh truyền thống mở cửa cả đêm tại Phần Lan. Sau khi đi chơi hoặc tan ca khuya, người dân địa phương thường xếp hàng tại Grilli để gọi:
* 🌭 **Makkaraperunat**: Xúc xích chiên cắt khúc ăn cùng khoai tây chiên giòn, xốt mù tạt Phần Lan (*sinappi*), xốt cà chua và hành tây ngâm.
* 🍔 **Lihapiirakka**: Bánh bao vỏ chiên nhân thịt xay và gạo, kẹp thêm xúc xích nackki bên trong.

---

### 🗣️ 2. Mẫu câu gọi món tại biển hiệu Grilli
* **Yksi lihapiirakka kahdella nakilla, kiitos!** = Cho tôi một bánh nhân thịt kẹp 2 xúc xích!
* **Kaikilla mausteilla!** = Cho đủ mọi loại xốt gia vị nhé! (Mù tạt, ketchup, dưa chuột chua).
* **Maksukortilla, kiitos.** = Tôi xin thanh toán bằng thẻ ngân hàng.`
  },
  {
    id: "w3_d4_nguphap_dongtunhom1",
    title: "Ngữ pháp: Chia Động từ nhóm 1 (Verbityyppi 1) (Trang 37-38)",
    chapter: "Kappale 2",
    week: 3,
    description: "Quy tắc cốt lõi tìm thân từ và gắn đuôi 6 ngôi của nhóm động từ lớn nhất tiếng Phần Lan.",
    content: `# ⚙️ Ngữ pháp: Động từ nhóm 1 (Verbityyppi 1)

Trong tiếng Phần Lan có **5 nhóm động từ chính**. Nhóm 1 là nhóm đông đảo và phổ biến nhất, chiếm hơn 60% tổng số động từ thường dùng.

---

### 🔍 1. Dấu hiệu nhận biết Nhóm 1
Động từ nguyên thể (Infinitive) kết thúc bằng **2 nguyên âm**, trong đó chữ cái tận cùng là **-A** hoặc **-Ä**.
* Ví dụ: *puh-**ua*** (nói), *as-**ua*** (sống), *kys-**yä*** (hỏi), *ets-**iä*** (tìm kiếm), *ost-**aa*** (mua).

---

### ✂️ 2. Cách tìm thân từ (Vartalo)
> 👉 **QUY TẮC:** Bỏ chữ **-a** hoặc **-ä** tận cùng của động từ nguyên thể.
* *puhua* -> bỏ -a -> Thân từ: **puhu-**
* *asua* -> bỏ -a -> Thân từ: **asu-**
* *kysyä* -> bỏ -ä -> Thân từ: **kysy-**

---

### 🏷️ 3. Bảng đuôi chia 6 ngôi cá nhân

| Ngôi | Đuôi cá nhân | Ví dụ: puhua (nói) | Ví dụ: asua (sống) |
| :--- | :--- | :--- | :--- |
| **minä** (tôi) | **-n** | minä puhu**n** | minä asu**n** |
| **sinä** (bạn) | **-t** | sinä puhu**t** | sinä asu**t** |
| **hän** (anh ấy/cô ấy) | **Nhân đôi nguyên âm cuối** | hän puhu**u** | hän asu**u** |
| **me** (chúng tôi) | **-mme** | me puhu**mme** | me asu**mme** |
| **te** (các bạn) | **-tte** | te puhu**tte** | te asu**tte** |
| **he** (họ) | **-vat / -vät** | he puhu**vat** | he asu**vat** |

> ⚠️ **Chú ý đặc biệt ở ngôi 'hän':** Không thêm chữ cái mới, mà nhân đôi nguyên âm cuối cùng của thân từ:
> * *puhu-* -> tận cùng là u -> nhân đôi thành *puhu**u***.
> * *kysy-* -> tận cùng là y -> nhân đôi thành *kysy**y***.

---

### 📝 4. Thử thách chia động từ
[exercise:ex_w3_d4_dongtunhom1]`
  },
  {
    id: "w3_d5_nguphap_phudinh_nhom1",
    title: "Ngữ pháp: Thể phủ định của Động từ nhóm 1 (Trang 38)",
    chapter: "Kappale 2",
    week: 3,
    description: "Cách cấu tạo câu phủ định bằng trợ động từ phủ định ei kết hợp thân từ.",
    content: `# 🚫 Ngữ pháp: Câu phủ định (Kieltolause)

Trong tiếng Phần Lan, **không có từ 'not' đơn lẻ** như tiếng Anh. Thay vào đó, tiếng Phần Lan dùng một **động từ phủ định đặc biệt** được chia theo từng ngôi!

---

### 🧩 1. Động từ phủ định biến đổi theo ngôi

* minä -> **en** (tôi không...)
* sinä -> **et** (bạn không...)
* hän -> **ei** (anh ấy/cô ấy không...)
* me -> **emme** (chúng tôi không...)
* te -> **ette** (các bạn không...)
* he -> **eivät** (họ không...)

---

### 🏗️ 2. Công thức cấu tạo câu phủ định
> 👉 **[Đại từ] + [en / et / ei / emme / ette / eivät] + [Thân từ động từ - KHÔNG CHIA ĐUÔI]**

Hãy xem ví dụ với động từ *puhua* (thân từ *puhu-*):
* Minä **en puhu** englantia. (Tôi không nói tiếng Anh).
* Sinä **et puhu** suomea. (Bạn không nói tiếng Phần).
* Hän **ei puhu** venäjää. (Cô ấy không nói tiếng Nga).
* Me **emme puhu** ranskaa. (Chúng tôi không nói tiếng Pháp).
* Te **ette puhu** saksaa. (Các bạn không nói tiếng Đức).
* He **eivät puhu** vietnamia. (Họ không nói tiếng Việt).

---

### 📝 3. Bài tập tương tác thể phủ định
[exercise:ex_w3_d5_phudinh_nhom1]`
  },
  {
    id: "song_lastenlaulu_kappale2",
    title: "Immersion Âm nhạc: Bài hát thiếu nhi Ihme ja kumma",
    chapter: "Kappale 2",
    week: 3,
    description: "Thư giãn cuối tuần cùng bài hát thiếu nhi kinh điển Phần Lan để rèn luyện thính xạ.",
    content: `# 🎵 Immersion Âm nhạc: Ihme ja kumma (Kỳ diệu và lạ lùng)

Một trong những cách thẩm thấu ngữ điệu và phản xạ tiếng Phần Lan nhanh nhất là nghe các bài hát thiếu nhi (*lastenlaulu*) với ca từ rõ ràng, giai điệu vui tươi.

---

### 🎶 Lời bài hát & Bản dịch

| Lời tiếng Phần | Lời dịch tiếng Việt |
| :--- | :--- |
| *Pieni tytön tylleröinen,* | *Một cô bé nhỏ nhắn xinh xắn,* |
| *tietä pitkin asteli.* | *bước từng bước trên con đường nhỏ.* |
| *Metsähiiri pikkarainen,* | *Một chú chuột rừng bé xíu,* |
| *kolostansa katseli.* | *từ trong hang ngó mắt nhìn ra.* |
| *Ihmeellinen suuri maailma,* | *Một thế giới to lớn và kỳ diệu,* |
| *kaunis, ihana ja avara.* | *thật đẹp đẽ, tuyệt vời và bao la.* |

> 💡 **Bài học ngôn ngữ:** Để ý các tính từ mô tả trong bài: *pieni* (nhỏ), *kaunis* (đẹp), *suuri* (to lớn). Hãy nghe và hát nhẩm theo nhịp điệu nhé!`
  },
  {
    id: "w3_d7_tonghop_tuan3",
    title: "Tổng kết & Củng cố Tuần 3 (Kappale 2)",
    chapter: "Kappale 2",
    week: 3,
    description: "Ôn tập toàn bộ kiến thức tuần 3: Quốc gia, ngôn ngữ, động từ nhóm 1 và giao tiếp mua sắm.",
    content: `# 🏆 Tổng kết & Củng cố Tuần 3

Chúc mừng bạn đã hoàn thành tuần đầu tiên của Chương 2! Hãy cùng nhìn lại các viên gạch nền tảng bạn đã tích lũy:

* ✅ Đã biết hỏi và trả lời tự tin: *Minkämaalainen sinä olet? - Minä olen vietnamilainen.*
* ✅ Nắm vững bảng 12 quốc gia, quốc tịch và ngôn ngữ phổ biến nhất.
* ✅ Thuộc lòng cấu trúc chia 6 ngôi khẳng định và phủ định của Động từ nhóm 1.
* ✅ Tự tin vào quầy kem hoặc ki-ốt gọi món bằng tiếng Phần Lan: *Yksi jäätelö, kiitos!*`
  },

  // TUẦN 4
  {
    id: "w4_d1_nguphap_kpt_astevaihtelu",
    title: "Ngữ pháp: Hiện tượng biến âm K-P-T (Astevaihtelu) (Trang 35-36)",
    chapter: "Kappale 2",
    week: 4,
    description: "Giải mã hiện tượng ngữ pháp then chốt nhất của ngôn ngữ Phần Lan: Biến âm phụ âm K-P-T.",
    audioSnippet: "20 Ääntäminen",
    audioSnippet2: "21 Ääntäminen",
    content: `# ⚡ Ngữ pháp: Hiện tượng biến âm phụ âm K-P-T (Astevaihtelu - Consonant Gradation)

Trong tiếng Phần Lan, khi chia động từ hoặc biến cách danh từ, các phụ âm **K, P, T** ở âm tiết cuối của thân từ sẽ bị thay đổi độ mạnh yếu. Hiện tượng này gọi là **ASTEVAIHTELU**.

---

### 🎧 1. Nghe phát âm phụ âm và ngữ điệu (Trang 35)
Bấm Track 20 và Track 21 để nghe hướng dẫn:

[audio:AUDIO_URL_1]

[audio:AUDIO_URL_2]

---

### 🛡️ 2. Hai cấp độ âm thanh: Cấp Mạnh (Vahva) và Cấp Yếu (Heikko)

#### A. Biến âm định lượng (Quantitative): Phụ âm đôi -> Phụ âm đơn
* **kk -> k**: *nukkua* (ngủ) -> minä *nu**k**un*
* **pp -> p**: *oppia* (học hỏi) -> minä *o**p**in*
* **tt -> t**: *odottaa* (chờ đợi) -> minä *odo**t**an*

#### B. Biến âm định tính (Qualitative): Phụ âm đơn biến thành âm khác hoặc biến mất
* **k -> biến mất (-)**: *lukea* (đọc) -> minä *lu**e**n*
* **p -> v**: *tapaa* -> *tavata* (gặp gỡ)
* **t -> d**: *tietää* (biết) -> minä *tie**d**än*

---

### ⚖️ 3. Quy luật áp dụng trong Động từ nhóm 1

| Cấp | Các ngôi áp dụng | Ví dụ: nukkua (kk -> k) | Ví dụ: lukea (k -> -) |
| :--- | :--- | :--- | :--- |
| **Cấp YẾU (Heikko)** | **minä, sinä, me, te** | minä nu**k**un, sinä nu**k**ut, me nu**k**umme, te nu**k**utte | minä lu**e**n, sinä lu**e**t, me lu**e**mme, te lu**e**tte |
| **Cấp MẠNH (Vahva)** | **hän, he** + **Nguyên thể** | hän nu**kk**uu, he nu**kk**uvat | hän lu**k**ee, he lu**k**evat |

> 💡 **Mẹo vàng người bản xứ:** Chỉ cần nhớ: **4 ngôi đầu (tôi, bạn, chúng tôi, các bạn) dùng cấp YẾU**; còn **anh ấy (hän), họ (he) và từ nguyên thể dùng cấp MẠNH**!

---

### 📝 4. Bài tập tương tác K-P-T
[exercise:ex_w4_d1_kpt_astevaihtelu]`
  },
  {
    id: "w4_d2_luyenphatam_phuamdoi",
    title: "Luyện phát âm: Phụ âm đơn vs Phụ âm đôi (Harjoitus 1-3 - Trang 39-40)",
    chapter: "Kappale 2",
    week: 4,
    description: "Luyện đôi tai phân biệt phụ âm ngắn và phụ âm dài qua Harjoitus 1, 2, 3.",
    audioSnippet: "22 Harjoitus 1",
    audioSnippet2: "23 Harjoitus 2",
    content: `# 🗣️ Luyện phát âm: Phụ âm đơn vs Phụ âm đôi (Harjoitus 1, 2, 3)

Tương tự như nguyên âm ngắn và dài, **phụ âm đơn (ngắn) và phụ âm đôi (dài) trong tiếng Phần Lan làm biến đổi hoàn toàn nghĩa của từ**!

---

### 🎧 1. Nghe Harjoitus 1 & 2 (Track 22 & Track 23)
Bấm nút bên dưới để nghe bài tập phát âm:

[audio:AUDIO_URL_1]

[audio:AUDIO_URL_2]

---

### ⚖️ 2. Bảng các cặp từ đối lập nguy hiểm

| Cặp phụ âm | Phụ âm đơn (Ngắn) | Nghĩa | Phụ âm đôi (Dài) | Nghĩa |
| :--- | :--- | :--- | :--- | :--- |
| **k / kk** | *kuka* | ai (người nào) | *kukka* | bông hoa |
| **t / tt** | *katua* | hối hận | *kattoa* | trần nhà / mái |
| **p / pp** | *tapaa* | gặp mặt | *tappaa* | giết chết |
| **s / ss** | *kisa* | cuộc thi | *kissa* | con mèo |
| **l / ll** | *tuli* | ngọn lửa | *tulli* | hải quan |
| **m / mm** | *uuma* | eo thon | *kumma* | kỳ lạ |

---

### 🎯 3. Thử thách phân biệt phát âm
[exercise:ex_w4_d2_phatam_phuamdoi]`
  },
  {
    id: "w4_d3_cauhoi_koko_tudehoi",
    title: "Ngữ pháp: Câu hỏi nghi vấn -ko/-kö & Từ để hỏi (Trang 38-39)",
    chapter: "Kappale 2",
    week: 4,
    description: "Học cách đặt mọi loại câu hỏi trong tiếng Phần Lan: Câu hỏi Yes/No và Câu hỏi có từ để hỏi.",
    content: `# ❓ Ngữ pháp: Câu hỏi nghi vấn -ko/-kö & Các từ để hỏi

Hôm nay bạn sẽ trang bị bộ công cụ hỏi đáp toàn diện để chủ động bắt chuyện trong mọi tình huống.

---

### 🔘 1. Câu hỏi Yes/No với tiếp vĩ ngữ -ko / -kö
Để hỏi câu hỏi Có/Không:
1. Đưa động từ lên đầu câu.
2. Gắn đuôi **-ko** (nếu từ chứa nguyên âm sau A/O/U) hoặc **-kö** (nếu chỉ chứa nguyên âm trước Ä/Ö/Y hoặc E/I).
* *Puhutko suomea?* (Bạn có nói tiếng Phần không?) -> *Joo, puhun. / En puhu.*
* *Asutko sinä täällä?* (Bạn sống ở đây à?) -> *Joo, asun.*
* *Ymmärrätkö?* (Bạn có hiểu không?) -> *Joo, ymmärrän.*

---

### 🔍 2. 7 Từ để hỏi quan trọng nhất tiếng Phần Lan

| Từ để hỏi | Nghĩa tiếng Việt | Câu ví dụ |
| :--- | :--- | :--- |
| **Kuka?** | Ai? | *Kuka tuo mies on?* (Người đàn ông kia là ai?) |
| **Mikä?** | Cái gì? | *Mikä sinun puhelinnumero on?* (Số điện thoại bạn là gì?) |
| **Mitä?** | Cái gì? (dùng với Partitiivi) | *Mitä sinä teet?* (Bạn đang làm gì đấy?) |
| **Missä?** | Ở đâu? (vị trí tĩnh) | *Missä sinä asut?* (Bạn sống ở đâu?) |
| **Mistä?** | Từ đâu đến? | *Mistä sinä olet kotoisin?* (Bạn từ đâu đến?) |
| **Mihin? / Minne?** | Đi đâu? | *Mihin sinä menet?* (Bạn đi đâu đấy?) |
| **Miksi?** | Tại sao? | *Miksi sinä opiskelet suomea?* (Tại sao bạn học tiếng Phần?) |
| **Miten? / Kuinka?** | Như thế nào? Bằng cách nào? | *Miten sinä sanot tämän?* (Bạn nói câu này thế nào?) |

---

### 📝 3. Bài tập tương tác câu hỏi
[exercise:ex_w4_d3_cauhoi_koko_tudehoi]`
  },
  {
    id: "sign_kielletty_ohjeet",
    title: "Immersion Biển báo: Biển cấm & Chỉ dẫn (Kielletty & Ohjeet)",
    chapter: "Kappale 2",
    week: 4,
    description: "Nhận biết các biển báo cấm và chỉ dẫn an toàn thường thấy trên đường phố và xe buýt Phần Lan.",
    content: `# 🚷 Immersion Biển báo đời thực: KIELLETTY & OHJEET

Tại Phần Lan, văn hóa tuân thủ trật tự công cộng rất cao. Bạn sẽ thường xuyên thấy các biển báo mang từ khóa:

> # 🚫 KIELLETTY!
> *(Bị nghiêm cấm / Forbidden!)*

---

### 🚭 1. Các biển cấm phổ biến nhất
* 🚭 **Tupakointi kielletty!**: Cấm hút thuốc! (Tại các trạm xe buýt, trước cửa ga tàu, trong chung cư).
* 🐕 **Koirien ulkoiluttaminen kielletty**: Cấm dắt chó đi dạo trong khu vực này.
* 🅿️ **Pysäköinti kielletty**: Cấm đỗ xe.
* 🚯 **Roskaaminen kielletty**: Cấm vứt rác bừa bãi.

---

### ℹ️ 2. Biển chỉ dẫn hữu ích
* 🚪 **Hätäuloskäynti**: Lối thoát hiểm khẩn cấp.
* 🛗 **Hissi**: Thang máy.
* 🚻 **WC / Vessa**: Nhà vệ sinh (*Naiset* = Nữ, *Miehet* = Nam).`
  },
  {
    id: "w4_d5_sodem_gia_hinnat",
    title: "Số đếm mở rộng & Hỏi giá cả (Hinnat) (Trang 34, 45)",
    chapter: "Kappale 2",
    week: 4,
    description: "Luyện nghe số đếm tiền bạc từ Track 25 đến Track 28 và thực hành hỏi giá hàng hóa.",
    audioSnippet: "25 Harjoitus 8",
    audioSnippet2: "28 Harjoitus 8",
    content: `# 💶 Số đếm mở rộng & Hỏi giá cả (Hinnat)

Hôm nay chúng ta sẽ bước vào siêu thị hoặc chợ để hỏi giá và nghe thanh toán tiền tệ bằng Euro (€).

---

### 🎧 1. Nghe Harjoitus 8: Luyện nghe số đếm giá tiền (Track 25-28)
Bấm nút bên dưới để nghe đọc các con số thực tế:

[audio:AUDIO_URL_1]

[audio:AUDIO_URL_2]

---

### 💰 2. Mẫu câu hỏi giá kinh điển
* ❓ **Paljonko tämä maksaa?** = Cái này giá bao nhiêu?
* ❓ **Mitä tämä maksaa?** = Cái này bao nhiêu tiền?
* 💬 **Se maksaa kaksi euroa.** = Nó giá 2 euro.
* 💬 **Yhteensä 15 euroa.** = Tổng cộng 15 euro.

---

### 📝 3. Bài tập tương tác số tiền
[exercise:ex_w4_d4_sodem_hinnat]`
  },
  {
    id: "w4_d6_dienform_henkilotiedot",
    title: "Thực hành: Điền mẫu đơn thông tin cá nhân (Henkilötiedot) (Trang 48)",
    chapter: "Kappale 2",
    week: 4,
    description: "Thực hành nghe và điền form mẫu hành chính tại Phần Lan (Harjoitus 14 - Track 30).",
    audioSnippet: "30 Harjoitus 14",
    content: `# 📋 Thực hành: Điền mẫu đơn thông tin cá nhân (Henkilötiedot)

Khi mới sang Phần Lan làm thủ tục cư trú tại DVV, đăng ký khóa học tiếng Phần hay mở tài khoản ngân hàng, bạn luôn phải điền tờ khai **Henkilötiedot**.

---

### 🎧 1. Nghe Track 30: Harjoitus 14
Bấm nút bên dưới để nghe người bản xứ đọc thông tin điền form:

[audio:AUDIO_URL_1]

---

### 📑 2. Các mục từ vựng hành chính bắt buộc phải hiểu

| Từ vựng trong form | Nghĩa tiếng Việt | Ví dụ điền |
| :--- | :--- | :--- |
| **Sukunimi** | Họ | *Nguyen* |
| **Etunimi** | Tên đệm & Tên chính | *Van Linh* |
| **Syntymäaika** | Ngày tháng năm sinh | *15.08.1995* |
| **Henkilötunnus (HETU)** | Mã số định danh cá nhân Phần Lan | *150895-XXXX* |
| **Kansalaisuus** | Quốc tịch | *Vietnam* |
| **Äidinkieli** | Tiếng mẹ đẻ | *vietnamin kieli* |
| **Osoite** | Địa chỉ nhà | *Mannerheimintie 10 A 4* |
| **Postinumero ja -toimipaikka** | Mã bưu điện & Thành phố | *00100 Helsinki* |
| **Puhelinnumero** | Số điện thoại | *040 123 4567* |
| **Sähköposti** | Email | *linh.nguyen@gmail.com* |`
  },
  {
    id: "w4_d7_tonghop_tuan4",
    title: "Tổng kết & Củng cố Tuần 4 (Kappale 2)",
    chapter: "Kappale 2",
    week: 4,
    description: "Ôn tập hiện tượng K-P-T, phát âm phụ âm đôi, cách đặt câu hỏi và điền tờ khai cá nhân.",
    content: `# 🏆 Tổng kết & Củng cố Tuần 4

Bạn đã chinh phục thành công ải ngữ pháp lớn nhất của giai đoạn mở đầu: **Quy tắc K-P-T**!

* ✅ Hiểu rõ vì sao *nukkua* -> *minä nukun*, *lukea* -> *minä luen*.
* ✅ Phân biệt được sự nguy hiểm của phụ âm đơn và phụ âm đôi (*kuka* vs *kukka*, *tapaa* vs *tappaa*).
* ✅ Thuộc nằm lòng 7 từ để hỏi: *Kuka, Mikä, Mitä, Missä, Mistä, Mihin, Miksi*.
* ✅ Điền được tờ khai thông tin cá nhân *Henkilötiedot*.`
  },

  // TUẦN 5
  {
    id: "w5_d1_baitap_harjoitus16_22",
    title: "Bài tập thực hành: Harjoitus 16 - 22 (Trang 49-51)",
    chapter: "Kappale 2",
    week: 5,
    description: "Luyện giải các bài tập chia động từ, điền từ và hoàn thiện câu của Chương 2.",
    content: `# ✍️ Bài tập thực hành: Harjoitus 16 - 22 (Trang 49-51)

Tuần thứ 5 dành riêng để tôi luyện phản xạ giải bài tập và đọc hiểu thông thạo toàn bộ nội dung Chương 2.

---

### 📝 1. Bài tập chia động từ K-P-T
Hãy làm các câu trắc nghiệm tương tác dưới đây để kiểm tra mức độ thuần thục của bạn:

[exercise:ex_w5_d1_harjoitus16_22]`
  },
  {
    id: "w5_d3_giaotiep_hinnat_puhekieli",
    title: "Giao tiếp: Mua sắm giá cả văn nói vs văn viết (Harjoitus 30 - Trang 55)",
    chapter: "Kappale 2",
    week: 5,
    description: "Luyện nghe đối thoại mua hàng thực tế qua Track 31 (Puhekieli) và Track 32 (Kirjakieli).",
    audioSnippet: "31 Harjoitus 30",
    audioSnippet2: "32 Harjoitus 30",
    content: `# 🛍️ Giao tiếp: Puhutaan! Hinnat (Giá cả trong văn nói và văn viết)

Khi đi mua sắm tại chợ trời (*kirpputori*) hoặc siêu thị ở Phần Lan, cách người bán nói giá tiền thường rất nhanh và rút gọn.

---

### 🎧 1. Nghe Harjoitus 30
Bấm nghe Track 31 (Văn nói đời thường) và Track 32 (Chuẩn văn viết):

[audio:AUDIO_URL_1]

[audio:AUDIO_URL_2]

---

### 💬 2. Các cụm từ mua bán thường gặp
* **Mitä omenat maksavat?** = Táo này giá bao nhiêu?
* **Kaksi euroa kilo.** = 2 euro một cân.
* **Otan kaksi kiloa.** = Tôi lấy 2 cân nhé.
* **Onko teillä käteistä vai kortti?** = Bạn trả tiền mặt hay quẹt thẻ?
* **Maksan kortilla.** = Tôi trả bằng thẻ.`
  },
  {
    id: "sign_alennus_tarjous",
    title: "Immersion Biển hiệu: ALENNUS & TARJOUS (Giảm giá & Khuyến mãi)",
    chapter: "Kappale 2",
    week: 5,
    description: "Bí quyết săn đồ giảm giá và nhận diện các biển quảng cáo siêu thị Phần Lan.",
    content: `# 🏷️ Immersion Biển hiệu siêu thị: ALENNUS & TARJOUS

Khi đi siêu thị Phần Lan (Prisma, K-Citymarket, Lidl), đây là những từ vựng sẽ giúp bạn tiết kiệm hàng trăm euro mỗi tháng:

> # 💥 ALENNUS! / ALE!
> *(Giảm giá / Sale off!)*

---

### 🛒 1. Các thuật ngữ mua sắm thần thánh
* 🔴 **Tarjous**: Hàng khuyến mãi theo tuần.
* 🏷️ **Osta 2, maksa 1!**: Mua 2 tính tiền 1!
* 📉 **-30% / -60%**: Nhãn dán màu cam/vàng dán lên thực phẩm sắp hết hạn trong ngày (vào lúc 20:00 tối tại Prisma, các mặt hàng -30% sẽ được giảm sâu thành **-60%**!).
* 🧾 **Kuitti**: Hóa đơn mua hàng (*Haluatko kuitin?* = Bạn có lấy hóa đơn không?).`
  },
  {
    id: "w5_d6_kiemtra_tongket_kappale2",
    title: "Đề kiểm tra đánh giá năng lực toàn diện: Kappale 2 (Trang 54-55)",
    chapter: "Kappale 2",
    week: 5,
    description: "Bài kiểm tra chuẩn hóa tổng hợp toàn bộ ngữ pháp, từ vựng và phản xạ của Chương 2.",
    content: `# 🎓 Đề kiểm tra năng lực toàn diện: Kappale 2

Hôm nay là bài thi tổng kết Chương 2! Đề thi bao gồm các phần:
1. Quốc tịch, ngôn ngữ và nơi cư trú.
2. Chia động từ nhóm 1 khẳng định và phủ định.
3. Ứng dụng chuẩn xác quy tắc biến âm K-P-T.
4. Kỹ năng hỏi giá và mua sắm cơ bản.

---

### ✍️ Bắt đầu làm bài kiểm tra tương tác
[exercise:ex_w5_d5_kiemtra_kappale2]`
  },
  {
    id: "w5_d7_tongket_thang12",
    title: "Tổng kết Tháng 1 & 2: Chinh phục trọn vẹn Chương 1 & Chương 2",
    chapter: "Kappale 2",
    week: 5,
    description: "Nhìn lại hành trình 5 tuần đầu tiên: Từ con số 0 đến nền tảng giao tiếp sơ cấp vững chắc.",
    content: `# 🏆 Chúc mừng bạn đã hoàn thành xuất sắc Giai đoạn 1 (Chương 1 & 2)!

Chỉ sau 5 tuần học tập bền bỉ mỗi ngày 20 phút, bạn đã đạt được những bước tiến vượt bậc:
* 🌟 **2 Chương sách giáo khoa trọn vẹn (Trang 10 - 55).**
* 🎧 **Nghe và làm chủ 32 Audio Tracks gốc của Disc 1.**
* 📝 **Giải quyết 100% 52 bài tập Harjoitus trong sách.**
* 🪧 **Hiểu và nhận diện 5 loại biển báo thực tế trên đường phố Phần Lan.**

Tuần tới, chúng ta sẽ bước sang **Chương 3 (Tuần 6 - 8): Thời tiết, Mùa, Sở hữu cách Genetiivi và Đăng ký khóa học**!`
  }
];

// ------------------------------------------
// CURRICULUM WEEKS 3, 4, 5
// ------------------------------------------
const week03 = {
  id: "week_03",
  planId: "6iWorOc6mZtnINIFBH8a",
  weekNumber: 3,
  title: "Tháng 1 - Tuần 3: Quốc gia, Ngôn ngữ, Quầy kem & Động từ nhóm 1",
  description: "Bắt đầu Chương 2 (Kappale 2): Hội thoại Minkämaalainen sinä olet?, Quốc tịch, Ngôn ngữ, Giao tiếp quầy kem Jätskikiskalla, Biển hiệu Kioski & Grilli, Chia động từ nhóm 1 khẳng định và phủ định.",
  chapter: "Kappale 2",
  bookPages: "28-34, 37-38",
  days: [
    {
      dayIndex: 1,
      dayName: "Thứ 2",
      actions: [
        {
          id: "w3_d1_act1",
          type: "lesson_full",
          title: "Kappale 2: Hội thoại Minkämaalainen sinä olet? (Trang 28-30)",
          goal: "Nghe hiểu đoạn hội thoại giới thiệu quốc tịch, nơi ở và ngôn ngữ; phân biệt văn nói Puhekieli.",
          estimatedMinutes: 25,
          targetRefId: "w3_d1_thoai_minkamaalainen",
          notes: "Audio Track 15 & Track 16",
          steps: [
            { stepNumber: 1, instruction: "Nghe Track 15 (Kirjakieli) và đọc theo lời thoại của Pedro và Alex." },
            { stepNumber: 2, instruction: "Nghe Track 16 (Puhekieli) để so sánh cách người Phần rút gọn câu thoại." },
            { stepNumber: 3, instruction: "Làm bài tập phản xạ tương tác cuối bài." }
          ]
        }
      ]
    },
    {
      dayIndex: 2,
      dayName: "Thứ 3",
      actions: [
        {
          id: "w3_d2_act1",
          type: "vocabulary_set",
          title: "Từ vựng: Quốc gia, Quốc tịch & Ngôn ngữ (Trang 31-32)",
          goal: "Thuộc bảng quy đổi 12 quốc gia, quốc tịch và ngôn ngữ phổ biến.",
          estimatedMinutes: 20,
          targetRefId: "w3_d2_tuvung_quocgia_ngonngu",
          notes: "Audio Track 17 & Track 29",
          steps: [
            { stepNumber: 1, instruction: "Nghe Track 17 đọc tiểu sử các nhân vật." },
            { stepNumber: 2, instruction: "Ghi nhớ 3 nguyên tắc viết hoa tên nước, viết thường quốc tịch (-lainen) và ngôn ngữ (-a/-ä)." },
            { stepNumber: 3, instruction: "Làm bài tập nghe nối Harjoitus 12 (Track 29)." }
          ]
        }
      ]
    },
    {
      dayIndex: 3,
      dayName: "Thứ 4",
      actions: [
        {
          id: "w3_d3_act1",
          type: "lesson_slice",
          title: "Giao tiếp: Mua kem tại quầy Jätskikiskalla (Trang 33-34)",
          goal: "Thực hành phản xạ gọi món tại quầy kem và nghe số đếm văn nói.",
          estimatedMinutes: 20,
          targetRefId: "w3_d3_giaotiep_jatskikiskalla",
          notes: "Audio Track 18 & Track 19",
          steps: [
            { stepNumber: 1, instruction: "Nghe đoạn hội thoại mua kem mẫu Track 18." },
            { stepNumber: 2, instruction: "Luyện nghe số đếm văn nói Track 19 (yks, kaks, viis, kymppi)." }
          ]
        },
        {
          id: "w3_d3_act2",
          type: "immersion_sign",
          title: "Immersion Biển hiệu: KIOSKI & GRILLI",
          goal: "Hiểu nét văn hóa ki-ốt và đồ ăn nhanh đường phố Phần Lan.",
          estimatedMinutes: 10,
          targetRefId: "sign_kioski_grilli",
          steps: [
            { stepNumber: 1, instruction: "Đọc bài viết về văn hóa Grilli và món Makkaraperunat." }
          ]
        }
      ]
    },
    {
      dayIndex: 4,
      dayName: "Thứ 5",
      actions: [
        {
          id: "w3_d4_act1",
          type: "grammar_point",
          title: "Ngữ pháp: Chia Động từ nhóm 1 (Verbityyppi 1) (Trang 37-38)",
          goal: "Nắm vững công thức tìm thân từ và gắn đuôi 6 ngôi của động từ nhóm 1.",
          estimatedMinutes: 25,
          targetRefId: "w3_d4_nguphap_dongtunhom1",
          steps: [
            { stepNumber: 1, instruction: "Học cách nhận biết động từ đuôi -a/-ä và quy tắc tìm thân từ." },
            { stepNumber: 2, instruction: "Ghi nhớ bảng đuôi 6 ngôi (-n, -t, nhân đôi nguyên âm, -mme, -tte, -vat/-vät)." },
            { stepNumber: 3, instruction: "Hoàn thành bài tập chia động từ mẫu." }
          ]
        }
      ]
    },
    {
      dayIndex: 5,
      dayName: "Thứ 6",
      actions: [
        {
          id: "w3_d5_act1",
          type: "grammar_point",
          title: "Ngữ pháp: Thể phủ định của Động từ nhóm 1 (Trang 38)",
          goal: "Làm chủ cấu trúc câu phủ định en/et/ei/emme/ette/eivät + thân từ.",
          estimatedMinutes: 20,
          targetRefId: "w3_d5_nguphap_phudinh_nhom1",
          steps: [
            { stepNumber: 1, instruction: "Học 6 dạng của trợ động từ phủ định ei." },
            { stepNumber: 2, instruction: "Làm bài tập chuyển câu khẳng định sang phủ định." }
          ]
        }
      ]
    },
    {
      dayIndex: 6,
      dayName: "Thứ 7",
      actions: [
        {
          id: "w3_d6_act1",
          type: "immersion_music",
          title: "Immersion Âm nhạc: Bài hát thiếu nhi Ihme ja kumma",
          goal: "Thư giãn nghe nhạc và luyện thính xạ từ vựng tiếng Phần.",
          estimatedMinutes: 15,
          targetRefId: "song_lastenlaulu_kappale2",
          steps: [
            { stepNumber: 1, instruction: "Nghe bài hát và đọc lời dịch song ngữ." }
          ]
        }
      ]
    },
    {
      dayIndex: 7,
      dayName: "Chủ Nhật",
      actions: [
        {
          id: "w3_d7_act1",
          type: "custom",
          title: "Tổng kết & Củng cố Tuần 3 (Kappale 2)",
          goal: "Ôn lại các điểm kiến thức trọng tâm đã học trong tuần 3.",
          estimatedMinutes: 15,
          targetRefId: "w3_d7_tonghop_tuan3",
          steps: [
            { stepNumber: 1, instruction: "Đọc lại bản tóm tắt kiến thức tuần." }
          ]
        }
      ]
    }
  ]
};

const week04 = {
  id: "week_04",
  planId: "6iWorOc6mZtnINIFBH8a",
  weekNumber: 4,
  title: "Tháng 1 - Tuần 4: Biến âm K-P-T, Câu hỏi -ko/-kö & Giá cả",
  description: "Trọng tâm ngữ pháp cốt lõi của Chương 2: Hiện tượng biến âm K-P-T (Astevaihtelu), Luyện phát âm phụ âm đôi (Track 20-24), Câu hỏi đảo ngữ -ko/-kö, 7 Từ để hỏi, Số đếm giá tiền và Điền mẫu đơn thông tin cá nhân Henkilötiedot.",
  chapter: "Kappale 2",
  bookPages: "35-36, 38-41, 45-48",
  days: [
    {
      dayIndex: 1,
      dayName: "Thứ 2",
      actions: [
        {
          id: "w4_d1_act1",
          type: "grammar_point",
          title: "Ngữ pháp: Hiện tượng biến âm K-P-T (Astevaihtelu) (Trang 35-36)",
          goal: "Hiểu sâu bản chất cấp mạnh (Vahva) và cấp yếu (Heikko) khi chia động từ.",
          estimatedMinutes: 30,
          targetRefId: "w4_d1_nguphap_kpt_astevaihtelu",
          notes: "Audio Track 20 & Track 21",
          steps: [
            { stepNumber: 1, instruction: "Nghe Track 20 & 21 về phát âm phụ âm." },
            { stepNumber: 2, instruction: "Học bảng biến đổi KPT định lượng (kk->k, tt->t, pp->p) và định tính (k->-, t->d, p->v)." },
            { stepNumber: 3, instruction: "Làm bài tập tương tác K-P-T." }
          ]
        }
      ]
    },
    {
      dayIndex: 2,
      dayName: "Thứ 3",
      actions: [
        {
          id: "w4_d2_act1",
          type: "lesson_slice",
          title: "Luyện phát âm: Phụ âm đơn vs Phụ âm đôi (Harjoitus 1-3 - Trang 39-40)",
          goal: "Phân biệt trường độ phát âm giữa phụ âm đơn và phụ âm đôi qua bài nghe gốc.",
          estimatedMinutes: 20,
          targetRefId: "w4_d2_luyenphatam_phuamdoi",
          notes: "Audio Track 22, 23, 24",
          steps: [
            { stepNumber: 1, instruction: "Nghe Track 22, 23 và 24 lặp lại theo người bản xứ." },
            { stepNumber: 2, instruction: "Làm bài tập phân biệt cặp từ kuka/kukka, tapaa/tappaa." }
          ]
        }
      ]
    },
    {
      dayIndex: 3,
      dayName: "Thứ 4",
      actions: [
        {
          id: "w4_d3_act1",
          type: "grammar_point",
          title: "Ngữ pháp: Câu hỏi nghi vấn -ko/-kö & Từ để hỏi (Trang 38-39)",
          goal: "Thành thạo cấu tạo câu hỏi Yes/No và 7 từ để hỏi Kuka, Mikä, Mitä, Missä, Mistä, Mihin, Miksi.",
          estimatedMinutes: 25,
          targetRefId: "w4_d3_cauhoi_koko_tudehoi",
          steps: [
            { stepNumber: 1, instruction: "Học quy tắc đảo động từ và gắn đuôi -ko/-kö." },
            { stepNumber: 2, instruction: "Học 7 từ để hỏi thông dụng." },
            { stepNumber: 3, instruction: "Làm bài tập đặt câu hỏi." }
          ]
        },
        {
          id: "w4_d3_act2",
          type: "immersion_sign",
          title: "Immersion Biển báo: Biển cấm & Chỉ dẫn (Kielletty & Ohjeet)",
          goal: "Nhận biết các biển hiệu cấm hút thuốc, cấm đỗ xe, lối thoát hiểm.",
          estimatedMinutes: 10,
          targetRefId: "sign_kielletty_ohjeet",
          steps: [
            { stepNumber: 1, instruction: "Đọc các biển báo đời thực tại Phần Lan." }
          ]
        }
      ]
    },
    {
      dayIndex: 4,
      dayName: "Thứ 5",
      actions: [
        {
          id: "w4_d4_act1",
          type: "lesson_slice",
          title: "Số đếm mở rộng & Hỏi giá cả (Hinnat) (Trang 34, 45)",
          goal: "Luyện nghe số tiền và hỏi giá hàng hóa (Paljonko tämä maksaa?).",
          estimatedMinutes: 20,
          targetRefId: "w4_d5_sodem_gia_hinnat",
          notes: "Audio Track 25, 26, 27, 28",
          steps: [
            { stepNumber: 1, instruction: "Nghe các con số giá tiền Track 25-28." },
            { stepNumber: 2, instruction: "Làm bài tập trắc nghiệm số tiền." }
          ]
        }
      ]
    },
    {
      dayIndex: 5,
      dayName: "Thứ 6",
      actions: [
        {
          id: "w4_d5_act1",
          type: "lesson_slice",
          title: "Thực hành: Điền mẫu đơn thông tin cá nhân (Henkilötiedot) (Trang 48)",
          goal: "Nghe và điền form hành chính thực tế (Harjoitus 14 - Track 30).",
          estimatedMinutes: 25,
          targetRefId: "w4_d6_dienform_henkilotiedot",
          notes: "Audio Track 30",
          steps: [
            { stepNumber: 1, instruction: "Nghe Track 30 và theo dõi mẫu đơn thông tin cá nhân." },
            { stepNumber: 2, instruction: "Nắm vững các thuật ngữ Sukunimi, Etunimi, Syntymäaika, HETU, Osoite." }
          ]
        }
      ]
    },
    {
      dayIndex: 6,
      dayName: "Thứ 7",
      actions: [
        {
          id: "w4_d6_act1",
          type: "custom",
          title: "Tổng kết & Củng cố Tuần 4 (Kappale 2)",
          goal: "Ôn tập tổng thể KPT, câu hỏi và thông tin cá nhân.",
          estimatedMinutes: 15,
          targetRefId: "w4_d7_tonghop_tuan4",
          steps: [
            { stepNumber: 1, instruction: "Đọc lại tóm tắt tuần 4." }
          ]
        }
      ]
    },
    {
      dayIndex: 7,
      dayName: "Chủ Nhật",
      actions: [
        {
          id: "w4_d7_act1",
          type: "custom",
          title: "Ota rennosti: Nghỉ ngơi & Xem phóng sự ngắn đời sống Phần Lan",
          goal: "Thư giãn nạp năng lượng chuẩn bị cho tuần hoàn tất Chương 2.",
          estimatedMinutes: 15,
          targetRefId: "w4_d7_tonghop_tuan4",
          steps: [
            { stepNumber: 1, instruction: "Nghỉ ngơi và thư giãn." }
          ]
        }
      ]
    }
  ]
};

const week05 = {
  id: "week_05",
  planId: "6iWorOc6mZtnINIFBH8a",
  weekNumber: 5,
  title: "Tháng 2 - Tuần 5: Hoàn thiện Bài tập & Kiểm tra Chương 2",
  description: "Tuần tổng lực giải quyết toàn bộ bài tập còn lại của Chương 2 (Harjoitus 16 - 30), Luyện nghe mua sắm giá cả văn nói vs văn viết (Track 31 & 32), Biển báo giảm giá siêu thị ALENNUS/TARJOUS, và Đề kiểm tra đánh giá năng lực hoàn tất Kappale 2.",
  chapter: "Kappale 2",
  bookPages: "49-55",
  days: [
    {
      dayIndex: 1,
      dayName: "Thứ 2",
      actions: [
        {
          id: "w5_d1_act1",
          type: "exercise_set",
          title: "Bài tập thực hành: Harjoitus 16 - 22 (Trang 49-51)",
          goal: "Thực hành giải các bài tập chia động từ có biến âm KPT.",
          estimatedMinutes: 25,
          targetRefId: "w5_d1_baitap_harjoitus16_22",
          steps: [
            { stepNumber: 1, instruction: "Làm bài tập chia động từ tương tác Harjoitus 16-22." }
          ]
        }
      ]
    },
    {
      dayIndex: 2,
      dayName: "Thứ 3",
      actions: [
        {
          id: "w5_d2_act1",
          type: "lesson_slice",
          title: "Giao tiếp: Mua sắm giá cả văn nói vs văn viết (Harjoitus 30 - Trang 55)",
          goal: "Nghe hiểu đối thoại mua bán tại chợ Track 31 (Puhekieli) và Track 32 (Kirjakieli).",
          estimatedMinutes: 25,
          targetRefId: "w5_d3_giaotiep_hinnat_puhekieli",
          notes: "Audio Track 31 & Track 32",
          steps: [
            { stepNumber: 1, instruction: "Nghe Track 31 và Track 32." },
            { stepNumber: 2, instruction: "Ghi nhớ các câu hỏi giá và cách trả lời cân nặng (kilo, litra)." }
          ]
        }
      ]
    },
    {
      dayIndex: 3,
      dayName: "Thứ 4",
      actions: [
        {
          id: "w5_d3_act1",
          type: "immersion_sign",
          title: "Immersion Biển hiệu: ALENNUS & TARJOUS (Giảm giá & Khuyến mãi)",
          goal: "Bí quyết nhận diện biển báo giảm giá tại siêu thị Prisma, Lidl.",
          estimatedMinutes: 15,
          targetRefId: "sign_alennus_tarjous",
          steps: [
            { stepNumber: 1, instruction: "Đọc cẩm nang mua sắm tiết kiệm tại Phần Lan." }
          ]
        }
      ]
    },
    {
      dayIndex: 4,
      dayName: "Thứ 5",
      actions: [
        {
          id: "w5_d4_act1",
          type: "exercise_set",
          title: "Hoàn thiện bài tập: Harjoitus 23 - 29 (Trang 52-54)",
          goal: "Giải quyết toàn bộ các bài tập đọc hiểu và phản xạ câu hỏi.",
          estimatedMinutes: 25,
          targetRefId: "w5_d1_baitap_harjoitus16_22",
          steps: [
            { stepNumber: 1, instruction: "Thực hành bài tập đọc hiểu và trả lời câu hỏi." }
          ]
        }
      ]
    },
    {
      dayIndex: 5,
      dayName: "Thứ 6",
      actions: [
        {
          id: "w5_d5_act1",
          type: "lesson_full",
          title: "Đề kiểm tra đánh giá năng lực toàn diện: Kappale 2 (Trang 54-55)",
          goal: "Kiểm tra toàn diện 4 trụ cột kiến thức Chương 2 trước khi sang Chương 3.",
          estimatedMinutes: 30,
          targetRefId: "w5_d6_kiemtra_tongket_kappale2",
          steps: [
            { stepNumber: 1, instruction: "Hoàn thành bài kiểm tra 10 câu trắc nghiệm tổng hợp." }
          ]
        }
      ]
    },
    {
      dayIndex: 6,
      dayName: "Thứ 7",
      actions: [
        {
          id: "w5_d6_act1",
          type: "custom",
          title: "Tổng kết Tháng 1 & 2: Chinh phục trọn vẹn Chương 1 & Chương 2",
          goal: "Đánh giá lại toàn bộ chặng đường 5 tuần đã qua.",
          estimatedMinutes: 15,
          targetRefId: "w5_d7_tongket_thang12",
          steps: [
            { stepNumber: 1, instruction: "Đọc tổng kết và tự hào với kết quả đạt được!" }
          ]
        }
      ]
    },
    {
      dayIndex: 7,
      dayName: "Chủ Nhật",
      actions: [
        {
          id: "w5_d7_act1",
          type: "custom",
          title: "Nghỉ ngơi thư giãn (Ota rennosti)",
          goal: "Chuẩn bị tinh thần đón nhận Chương 3: Thời tiết & Sở hữu cách.",
          estimatedMinutes: 15,
          targetRefId: "w5_d7_tongket_thang12",
          steps: [
            { stepNumber: 1, instruction: "Thư giãn cùng một tách cà phê Phần Lan (kahvi)!" }
          ]
        }
      ]
    }
  ]
};

// ==========================================
// WRITE OUTPUT JSON FILES
// ==========================================
const currDir = path.resolve(__dirname, '../../content/curriculum');
const lessDir = path.resolve(__dirname, '../../content/lessons');

fs.writeFileSync(path.join(currDir, 'chapter_02_exercises.json'), JSON.stringify({ exercises }, null, 2), 'utf8');
console.log('✅ Generated content/curriculum/chapter_02_exercises.json');

fs.writeFileSync(path.join(lessDir, 'chapter_02_lessons.json'), JSON.stringify({ lessons }, null, 2), 'utf8');
console.log('✅ Generated content/lessons/chapter_02_lessons.json');

fs.writeFileSync(path.join(currDir, 'week_03.json'), JSON.stringify(week03, null, 2), 'utf8');
console.log('✅ Generated content/curriculum/week_03.json');

fs.writeFileSync(path.join(currDir, 'week_04.json'), JSON.stringify(week04, null, 2), 'utf8');
console.log('✅ Generated content/curriculum/week_04.json');

fs.writeFileSync(path.join(currDir, 'week_05.json'), JSON.stringify(week05, null, 2), 'utf8');
console.log('✅ Generated content/curriculum/week_05.json');

console.log('\n🎉 PHASE 2 LOCAL JSON FILES GENERATED SUCCESSFULLY!');
