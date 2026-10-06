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

// Audio URLs mapping
const audioUrls = JSON.parse(fs.readFileSync(path.resolve(__dirname, 'audio_urls_all.json'), 'utf8'));

function getAudioUrl(snippet) {
  if (!snippet) return '';
  for (const [key, url] of Object.entries(audioUrls)) {
    if (key.toLowerCase().includes(snippet.toLowerCase())) return url;
  }
  return '';
}

// ==========================================
// 1. EXERCISES (chapter_03_exercises.json)
// ==========================================
const exercises = [
  {
    id: "ex_w6_d1_pedro_soittaa",
    title: "Nghe hiểu: Pedro gọi điện cho Mikko (Kappale 3)",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Khi nghe điện thoại, người Phần Lan thường bắt đầu bằng:",
        type: "MULTIPLE_CHOICE",
        options: [
          "[Tên của mình] + puhelimessa! (hoặc chỉ xưng tên)",
          "Moi moi!",
          "Kuka sinä olet?"
        ],
        correctIndex: 0,
        explanation: "Thói quen nghe điện thoại lịch sự chuẩn Phần Lan là xưng tên: 'Mikko puhelimessa' (Mikko nghe máy đây)."
      },
      {
        prompt: "Cụm từ 'Mitä kuuluu?' có nghĩa là gì?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Dạo này bạn thế nào? (Hỏi thăm sức khỏe/cuộc sống)",
          "Bạn đang nghe gì đấy?",
          "Bạn ở đâu?"
        ],
        correctIndex: 0,
        explanation: "'Mitä kuuluu?' là câu hỏi thăm kinh điển. Đáp lại thường là 'Kiitos hyvää!' (Cảm ơn, tôi khỏe)."
      }
    ]
  },
  {
    id: "ex_w6_d2_adjektiivit",
    title: "Tính từ miêu tả trái nghĩa (Adjektiivit)",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Từ trái nghĩa với 'kuuma' (nóng) là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "kylmä (lạnh)",
          "lämmin (ấm)",
          "viileä (mát)"
        ],
        correctIndex: 0,
        explanation: "kuuma (nóng) đối lập với kylmä (lạnh)."
      },
      {
        prompt: "Từ trái nghĩa với 'kaunis' (đẹp) là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "ruma (xấu)",
          "hyvä (tốt)",
          "pieni (nhỏ)"
        ],
        correctIndex: 0,
        explanation: "kaunis (xinh đẹp) đối lập với ruma (xấu xí)."
      },
      {
        prompt: "Từ trái nghĩa với 'helppo' (dễ dàng) là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "vaikea (khó khăn)",
          "hauska (vui)",
          "uusi (mới)"
        ],
        correctIndex: 0,
        explanation: "helppo (dễ) đối lập với vaikea (khó)."
      }
    ]
  },
  {
    id: "ex_w6_d3_saa_vuodenajat",
    title: "Thời tiết & 4 Mùa (Sää ja vuodenajat)",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "'Sataa lunta' có nghĩa là thời tiết như thế nào?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Tuyết đang rơi",
          "Trời đang mưa",
          "Trời có gió"
        ],
        correctIndex: 0,
        explanation: "'Sataa lunta' = Tuyết rơi. 'Sataa vettä' = Mưa rơi."
      },
      {
        prompt: "Mùa hè trong tiếng Phần Lan là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "kesä",
          "talvi (mùa đông)",
          "syksy (mùa thu)"
        ],
        correctIndex: 0,
        explanation: "4 mùa: kevät (mùa xuân), kesä (mùa hè), syksy (mùa thu), talvi (mùa đông)."
      },
      {
        prompt: "Câu 'Aurinko paistaa' mô tả hiện tượng gì?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Mặt trời đang chiếu sáng (Trời có nắng)",
          "Trời nhiều mây",
          "Trời có bão"
        ],
        correctIndex: 0,
        explanation: "'Aurinko' = Mặt trời, 'paistaa' = chiếu sáng/tỏa nắng."
      }
    ]
  },
  {
    id: "ex_w7_d2_genetiivi",
    title: "Sở hữu cách Genetiivi (Đuôi -n)",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Dấu hiệu của Sở hữu cách Genetiivi số ít là thêm đuôi gì vào sau danh từ?",
        type: "MULTIPLE_CHOICE",
        options: [
          "-n",
          "-ssa",
          "-ta"
        ],
        correctIndex: 0,
        explanation: "Genetiivi có hậu tố là '-n': ví dụ Alex -> Alexin (của Alex), Pekka -> Pekan (của Pekka)."
      },
      {
        prompt: "Cụm từ 'Quyển sách của giáo viên' được viết là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "opettajan kirja",
          "opettaja kirja",
          "kirjan opettaja"
        ],
        correctIndex: 0,
        explanation: "Chủ sở hữu đứng trước gắn đuôi -n: opettaja -> opettajan + vật sở hữu: opettajan kirja."
      },
      {
        prompt: "LƯU Ý KPT: Danh từ 'Pekka' (có phụ âm đôi kk). Khi chuyển sang sở hữu cách 'của Pekka', kk biến thành:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Pekan (kk biến thành k ở cấp yếu)",
          "Pekkan",
          "Pekkaan"
        ],
        correctIndex: 0,
        explanation: "Đuôi -n tạo thành âm tiết đóng, kích hoạt quy tắc biến âm K-P-T cấp yếu: kk -> k."
      }
    ]
  },
  {
    id: "ex_w7_d3_t_monikko",
    title: "Danh từ số nhiều đuôi -t (T-monikko)",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Số nhiều cơ bản (Nominatiivi monikko) trong tiếng Phần Lan được tạo bằng cách thêm đuôi gì?",
        type: "MULTIPLE_CHOICE",
        options: [
          "-t",
          "-s",
          "-ja"
        ],
        correctIndex: 0,
        explanation: "Thêm đuôi '-t' vào sau thân từ: talo (1 ngôi nhà) -> talot (những ngôi nhà)."
      },
      {
        prompt: "'Các sinh viên / Những học viên' trong tiếng Phần là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "opiskelijat",
          "opiskelijas",
          "opiskelijan"
        ],
        correctIndex: 0,
        explanation: "opiskelija + t = opiskelijat."
      }
    ]
  },
  {
    id: "ex_w8_d6_kiemtra_kappale3",
    title: "Đề kiểm tra đánh giá năng lực Chương 3",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Chọn câu hỏi thăm thời tiết chính xác:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Millainen sää tänään on?",
          "Mikä sää tänään on?",
          "Kuka sää tänään on?"
        ],
        correctIndex: 0,
        explanation: "'Millainen sää tänään on?' = Thời tiết hôm nay thế nào? (Millainen = như thế nào)."
      },
      {
        prompt: "'Tänään on kaunis ja lämmin ilma' có nghĩa là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Hôm nay thời tiết đẹp và ấm áp",
          "Hôm nay trời mưa to và gió lạnh",
          "Hôm nay trời đầy tuyết"
        ],
        correctIndex: 0,
        explanation: "kaunis = đẹp, lämmin = ấm áp, ilma = thời tiết/không khí."
      },
      {
        prompt: "'Helsingin yliopisto' có nghĩa là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Đại học của Helsinki (Đại học Helsinki)",
          "Thành phố Helsinki",
          "Sinh viên Helsinki"
        ],
        correctIndex: 0,
        explanation: "Helsinki -> Helsingin (Genetiivi: k biến thành g) + yliopisto (trường đại học)."
      }
    ]
  }
];

// ==========================================
// 2. LESSONS (chapter_03_lessons.json)
// ==========================================
const lessons = [
  // TUẦN 6
  {
    id: "w6_d1_thoai_pedro_soittaa_mikolle",
    title: "Kappale 3: Hội thoại Pedro soittaa Mikolle (Trang 56-58)",
    chapter: "Kappale 3",
    week: 6,
    description: "Hội thoại gọi điện thoại hẹn gặp, hỏi thăm thời tiết và kế hoạch cuối tuần.",
    audioSnippet: "33 Pedro",
    audioSnippet2: "34 Pedro",
    content: `# 📞 Kappale 3: Pedro soittaa Mikolle (Pedro gọi điện cho Mikko)

Chào mừng bạn đến với **Chương 3 (Kappale 3)** của *Suomen Mestari 1*! Hôm nay chúng ta sẽ học kỹ năng giao tiếp qua điện thoại và cách nói về thời tiết, mùa màng.

---

### 🎧 1. Nghe đối thoại chuẩn văn viết (Track 33)
[audio:AUDIO_URL_1]

---

### 💬 2. Lời thoại song ngữ & Phân tích chi tiết

| Người nói | Lời thoại tiếng Phần Lan | Bản dịch tiếng Việt | Chú thích văn hóa & ngữ pháp |
| :--- | :--- | :--- | :--- |
| **Mikko** | Mikko Virtanen. | Mikko Virtanen nghe máy đây. | Thói quen xưng đầy đủ họ tên khi nhấc máy |
| **Pedro** | Hei Mikko, Pedro täällä! | Chào Mikko, Pedro đây! | *Pedro täällä* = Pedro ở đầu dây này |
| **Mikko** | No hei Pedro! Mitä kuuluu? | Ôi chào Pedro! Dạo này thế nào rồi? | *Mitä kuuluu?* = Bạn khỏe không? |
| **Pedro** | Kiitos hyvää. Entä sinulle? | Cảm ơn bạn, tôi khỏe. Còn bạn thì sao? | *Kiitos hyvää* = Cảm ơn, tốt lắm |
| **Mikko** | Ihan hyvää, kiitos. | Cũng khá tốt, cảm ơn bạn. | *Ihan hyvää* = Khá là ổn |
| **Pedro** | Millainen sää Helsingissä on? | Thời tiết ở Helsinki dạo này thế nào? | *Millainen sää* = Thời tiết ra sao |
| **Mikko** | Täällä on tosi kaunis ilma. Aurinko paistaa ja on lämmin. | Ở đây trời đẹp lắm. Nắng rực rỡ và rất ấm áp. | *Aurinko paistaa* = Nắng ấm |
| **Pedro** | Kuinka lämmin? | Ấm bao nhiêu độ? | |
| **Mikko** | Noin 20 astetta. | Khoảng 20 độ C. | *astetta* = độ C (Partitiivi) |
| **Pedro** | Hienoa! Mennäänkö viikonloppuna puistoon? | Tuyệt quá! Cuối tuần này chúng mình đi công viên nhé? | Cấu trúc rủ rê *-nko*: *Mennäänkö?* |
| **Mikko** | Joo, ilman muuta! | Ừ, chắc chắn rồi! | *Ilman muuta* = Đương nhiên rồi! |

---

### 🎙️ 3. Nghe văn nói đời thường qua điện thoại (Track 34)
[audio:AUDIO_URL_2]

> 💡 **Bí quyết giao tiếp:** Người Phần Lan không thích nói vòng vo. Khi gọi điện, hãy vào thẳng vấn đề ngay sau lời chào và hỏi thăm *Mitä kuuluu?*.

---

### 📝 4. Thử thách phản xạ tương tác
[exercise:ex_w6_d1_pedro_soittaa]`
  },
  {
    id: "w6_d2_tuvung_adjektiivit",
    title: "Từ vựng: Các cặp Tính từ miêu tả đối lập (Trang 59-60)",
    chapter: "Kappale 3",
    week: 6,
    description: "Làm chủ 20 tính từ miêu tả cảm xúc, thời tiết, tính chất và nghe Harjoitus 10 (Track 38).",
    audioSnippet: "38 Harjoitus 10",
    content: `# 🎨 Từ vựng: Các cặp Tính từ miêu tả đối lập (Adjektiivit)

Hôm nay bạn sẽ trang bị kho tính từ mô tả phong phú nhất để miêu tả mọi vật, con người và thời tiết.

---

### 🎧 1. Nghe Harjoitus 10: Viết các tính từ (Track 38)
[audio:AUDIO_URL_1]

---

### ⚖️ 2. Bảng các cặp tính từ trái nghĩa kinh điển

| Tính từ (A) | Nghĩa tiếng Việt | Tính từ đối lập (B) | Nghĩa tiếng Việt |
| :--- | :--- | :--- | :--- |
| **kuuma** | nóng bức | **kylmä** | lạnh cóng |
| **lämmin** | ấm áp | **viileä** | se se lạnh / mát mẻ |
| **kaunis** | đẹp đẽ, xinh đẹp | **ruma** | xấu xí |
| **hyvä** | tốt, ngon | **huono** | tồi tệ, dở |
| **iso / suuri** | to lớn | **pieni** | nhỏ bé |
| **uusi** | mới | **vanha** | cũ, già |
| **helppo** | dễ dàng | **vaikea** | khó khăn, phức tạp |
| **kallis** | đắt đỏ | **halpa** | rẻ tiền |
| **valoisa** | sáng sủa | **pimeä** | tối tăm |
| **hauska** | vui vẻ, thú vị | **tylsä** | buồn tẻ, nhàm chán |

---

### ✍️ 3. Bài tập tương tác tính từ
[exercise:ex_w6_d2_adjektiivit]`
  },
  {
    id: "w6_d3_tuvung_saa_vuodenajat",
    title: "Từ vựng: Thời tiết, 4 Mùa & 12 Tháng (Trang 61-62)",
    chapter: "Kappale 3",
    week: 6,
    description: "Nắm trọn vẹn cách dự báo thời tiết, 4 mùa trong năm và nghe Harjoitus 13 (Track 39).",
    audioSnippet: "39 Harjoitus 13",
    content: `# 🌦️ Từ vựng: Thời tiết (Sää), 4 Mùa (Vuodenajat) & 12 Tháng

Thời tiết là chủ đề nói chuyện số một của người Phần Lan quanh năm suốt tháng!

---

### 🎧 1. Nghe Harjoitus 13: Thời tiết các thành phố Phần Lan (Track 39)
[audio:AUDIO_URL_1]

---

### 🌸 2. 4 Mùa trong năm (Neljä vuodenaikaa)
* 🌷 **Kevät** (Mùa xuân - Tháng 3 đến Tháng 5): Tuyết tan (*lumi sulaa*), chim muông bay về.
* ☀️ **Kesä** (Mùa hè - Tháng 6 đến Tháng 8): Đêm trắng (*yötön yö*), tắm hồ, vào rừng hái dâu.
* 🍂 **Syksy** (Mùa thu - Tháng 9 đến Tháng 11): Rừng lá đổi màu vàng đỏ (*ruska*), trời mưa dầm.
* ❄️ **Talvi** (Mùa đông - Tháng 12 đến Tháng 2 năm sau): Tuyết phủ trắng xóa, Bắc cực quang (*revontulet*).

---

### ☀️ 3. Các hiện tượng thời tiết thường gặp
* **Aurinko paistaa** = Trời nắng.
* **Sataa vettä** = Trời mưa.
* **Sataa lunta** = Trời rơi tuyết.
* **Tuulee** = Trời có gió lớn.
* **On pilvistä** = Trời nhiều mây u ám.
* **On pakkasta** = Trời rét dưới 0 độ C (*Pakkasta on -10 astetta* = Âm 10 độ).

---

### 📝 4. Bài tập tương tác thời tiết
[exercise:ex_w6_d3_saa_vuodenajat]`
  },
  {
    id: "w6_d4_luyennghe_saakeskustelu",
    title: "Luyện nghe: 5 Đoạn hội thoại Thời tiết thực tế (Trang 72)",
    chapter: "Kappale 3",
    week: 6,
    description: "Thử thách thính giác với 5 cuộc trò chuyện ngắn về thời tiết từ Track 40 đến Track 44.",
    audioSnippet: "40 Harjoitus 15",
    audioSnippet2: "41 Harjoitus 15",
    content: `# 👂 Luyện nghe: Harjoitus 15 (Sääkeskustelut 1 - 5)

Hôm nay bạn sẽ luyện đôi tai nghe các cuộc trò chuyện ngắn của người dân Phần Lan khi bàn về thời tiết ngoài phố.

---

### 🎧 1. Đoạn hội thoại 1 (Track 40)
[audio:AUDIO_URL_1]
* *Hei, onpa tänään kylmä! - Niinpä on, vain 5 astetta.* (Hôm nay lạnh thật đấy! - Đúng vậy, chỉ có 5 độ thôi).

---

### 🎧 2. Đoạn hội thoại 2 (Track 41)
[audio:AUDIO_URL_2]
* *Sataako ulkona? - Ei sada enää, mutta tuulee kovasti.* (Ngoài trời còn mưa không? - Hết mưa rồi, nhưng gió thổi mạnh lắm).`
  },
  {
    id: "w6_d5_phatam_diftongit",
    title: "Phát âm: Nguyên âm ghép (Diftongit) (Trang 68)",
    chapter: "Kappale 3",
    week: 6,
    description: "Quy tắc trượt mượt mà giữa hai nguyên âm khác nhau qua Track 36 & 37.",
    audioSnippet: "36 Ääntäminen",
    audioSnippet2: "37 Harjoitus 1",
    content: `# 🎶 Phát âm: Nguyên âm ghép (Kaksi eri vokaalia - Diftongit)

Trong tiếng Phần Lan, khi 2 nguyên âm khác nhau đứng cạnh nhau trong cùng một âm tiết (như *uo, yö, ie, ai, oi, au, ou*), chúng tạo thành **Diftongi**.

---

### 🎧 1. Nghe hướng dẫn khẩu hình (Track 36)
[audio:AUDIO_URL_1]

---

### 🎧 2. Luyện tập Harjoitus 1 (Track 37)
[audio:AUDIO_URL_2]

> 📌 **Nguyên tắc vàng:** Bắt đầu phát âm rõ ràng ở nguyên âm thứ nhất, sau đó trượt nhẹ khẩu hình sang nguyên âm thứ hai mà không ngắt quãng hơi:
> * **uo**: *suo* (đầm lầy), *tuo* (cái kia)
> * **yö**: *yö* (ban đêm), *työ* (công việc)
> * **ie**: *tie* (con đường), *kieli* (ngôn ngữ)`
  },
  {
    id: "sign_yle_uutiset_selkosuomeksi",
    title: "Immersion Đời sống: Đọc bản tin thời tiết Selkosuomi",
    chapter: "Kappale 3",
    week: 6,
    description: "Làm quen với trang tin tức tiếng Phần giản lược Yle Uutiset selkosuomeksi.",
    content: `# 📰 Immersion Thực tế: Yle Uutiset selkosuomeksi

**Selkosuomi** là tiếng Phần Lan được đơn giản hóa từ vựng và ngữ pháp, được Đài truyền hình quốc gia Phần Lan (**Yle**) biên soạn đặc biệt cho người nước ngoài đang học tiếng Phần.

---

### 📻 Dự báo thời tiết mẫu trên đài Yle:
> *"Huomenna sää on poutainen koko maassa. Etelässä paistaa aurinko ja lämpötila on noin 18 astetta. Pohjoisessa Lapissa on viileää, vain 8 astetta, ja voi sataa vähän vettä."*

* **poutainen**: trời râm tạnh ráo, không mưa
* **koko maassa**: trên toàn quốc
* **etelässä**: ở miền Nam / **pohjoisessa**: ở miền Bắc
* **lämpötila**: nhiệt độ`
  },
  {
    id: "w6_d7_tonghop_tuan6",
    title: "Tổng kết & Củng cố Tuần 6 (Kappale 3)",
    chapter: "Kappale 3",
    week: 6,
    description: "Nhìn lại tuần đầu tiên của Chương 3: Điện thoại, thời tiết và tính từ.",
    content: `# 🏆 Tổng kết & Củng cố Tuần 6

* ✅ Đã biết cách nghe và gọi điện thoại chuẩn phong cách Phần Lan.
* ✅ Thuộc bảng 10 cặp tính từ miêu tả đối lập.
* ✅ Miêu tả được thời tiết 4 mùa và đọc nhiệt độ hàng ngày.
* ✅ Phân biệt và phát âm chuẩn các cặp nguyên âm ghép *uo, yö, ie*.`
  },

  // TUẦN 7
  {
    id: "w7_d1_giaotiep_dangky_khoahoc",
    title: "Giao tiếp: Pedro đăng ký khóa học tiếng Phần (Trang 63-65)",
    chapter: "Kappale 3",
    week: 7,
    description: "Tình huống giao tiếp thực tế điền phiếu đăng ký và hội thoại với nhân viên tuyển sinh.",
    audioSnippet: "35 Puhutaan",
    content: `# 📝 Giao tiếp: Pedro ilmoittautuu kurssille (Đăng ký khóa học)

Hôm nay Pedro đến trường cộng đồng (*työväenopisto*) để đăng ký khóa học tiếng Phần Lan tiếp theo.

---

### 🎧 1. Nghe đối thoại tại bàn tuyển sinh (Track 35)
[audio:AUDIO_URL_1]

---

### 💬 2. Lời thoại chính
* **Virkailija (Nhân viên):** *Hei! Miten voin auttaa?* (Xin chào! Tôi có thể giúp gì cho bạn?)
* **Pedro:** *Hei! Haluaisin ilmoittautua suomen kurssille.* (Chào cô! Tôi muốn đăng ký vào khóa học tiếng Phần).
* **Virkailija:** *Selvä juttu. Onko sinulla henkilötodistus mukana?* (Rõ rồi. Bạn có mang theo giấy tờ tùy thân không?)
* **Pedro:** *Joo, passi on tässä.* (Có, hộ chiếu của tôi ở đây).`
  },
  {
    id: "w7_d2_nguphap_genetiivi",
    title: "Ngữ pháp: Sở hữu cách Genetiivi (Đuôi -n) (Trang 66-67)",
    chapter: "Kappale 3",
    week: 7,
    description: "Khám phá cách sở hữu Genetiivi - chìa khóa để tạo cụm danh từ và giới từ tiếng Phần Lan.",
    content: `# 🗝️ Ngữ pháp: Sở hữu cách Genetiivi (Đuôi -n)

Sở hữu cách **Genetiivi** diễn tả quyền sở hữu (tương đương với chữ *"của"* trong tiếng Việt hoặc *'s / of* trong tiếng Anh).

---

### 🏷️ 1. Quy tắc tạo Genetiivi số ít
> 👉 **Thêm đuôi -N vào sau danh từ.**
* *Alex* -> **Alexin** (của Alex)
* *opettaja* (giáo viên) -> **opettajan** (của giáo viên)
* *Suomi* -> **Suomen** (của nước Phần Lan, ví dụ: *Suomen mestari*)

---

### 🚨 2. CẢNH BÁO K-P-T KHI THÊM ĐUÔI -N
Vì đuôi **-n** kết thúc bằng một phụ âm, nó biến âm tiết thành **âm tiết đóng**. Do đó, **nếu danh từ có K-P-T, từ PHẢI biến đổi sang cấp YẾU**!
* **kk -> k**: *Pekka* -> **Pekan** kirja (quyển sách của Pekka)
* **p -> v**: *Helsinki* -> **Helsingin** yliopisto (Đại học của Helsinki)
* **t -> d**: *äiti* (mẹ) -> **äidin** auto (ô tô của mẹ)

---

### 📝 3. Bài tập tương tác Genetiivi
[exercise:ex_w7_d2_genetiivi]`
  },
  {
    id: "w7_d3_nguphap_t_monikko",
    title: "Ngữ pháp: Danh từ số nhiều đuôi -t (T-monikko) (Trang 67)",
    chapter: "Kappale 3",
    week: 7,
    description: "Cách chuyển danh từ từ số ít sang số nhiều bằng hậu tố -t và áp dụng KPT cấp yếu.",
    content: `# 👥 Ngữ pháp: Danh từ số nhiều đuôi -t (T-monikko)

Khi muốn nói về nhiều đồ vật hay nhiều người làm chủ từ trong câu (ví dụ: *Những ngôi nhà thì đẹp, Các bạn sinh viên thì chăm chỉ*), ta dùng **T-monikko**.

---

### 🏗️ 1. Công thức
> 👉 **Thân từ cấp YẾU + T**
* *talo* -> **talot** (những ngôi nhà)
* *auto* -> **autot** (những chiếc ô tô)
* *kukka* (bông hoa - có kk) -> cấp yếu k -> **kukat** (những bông hoa)
* *pöytä* (cái bàn - có t) -> cấp yếu d -> **pöydät** (những cái bàn)

---

### 📝 2. Bài tập tương tác số nhiều
[exercise:ex_w7_d3_t_monikko]`
  },
  {
    id: "sign_opisto_kurssit",
    title: "Immersion Biển hiệu: Cung văn hóa & Trung tâm học tập (Opisto)",
    chapter: "Kappale 3",
    week: 7,
    description: "Tìm hiểu hệ thống trường Työväenopisto và Kansalaisopisto tại Phần Lan.",
    content: `# 🏛️ Immersion Thực tế: OPISTO & KANSALAISOPISTO

Ở Phần Lan, việc học tập suốt đời là một nét đẹp văn hóa quốc gia. Mọi thành phố đều có:

> # 🏫 HELSINGIN TYÖVÄENOPISTO / KANSALAISOPISTO

Tại đây, bất kỳ ai (dù là người bản xứ hay người nhập cư mới đến) đều có thể ghi danh học tiếng Phần Lan, làm gốm, khiêu vũ, nấu ăn, may vá với học phí cực kỳ rẻ (chỉ khoảng 30 - 50 € cho cả kỳ học)!`
  },
  {
    id: "w7_d5_baitap_harjoitus1_9",
    title: "Bài tập thực hành: Harjoitus 1 - 9 Chương 3 (Trang 68-70)",
    chapter: "Kappale 3",
    week: 7,
    description: "Luyện giải bài tập phát âm và chia sở hữu cách Genetiivi.",
    content: `# ✍️ Bài tập thực hành: Harjoitus 1 - 9 Chương 3

Hôm nay chúng ta rèn luyện phản xạ chia đuôi Genetiivi *-n* và số nhiều *-t* cho các danh từ trong sách giáo khoa.`
  },
  {
    id: "w7_d7_tonghop_tuan7",
    title: "Tổng kết & Củng cố Tuần 7 (Kappale 3)",
    chapter: "Kappale 3",
    week: 7,
    description: "Ôn tập Genetiivi, số nhiều đuôi -t và tình huống đăng ký khóa học.",
    content: `# 🏆 Tổng kết & Củng cố Tuần 7

* ✅ Đã biết cách đăng ký khóa học và nói chuyện với nhân viên tuyển sinh.
* ✅ Nắm vững Sở hữu cách Genetiivi *-n* và quy tắc KPT kèm theo (*Pekka* -> *Pekan*).
* ✅ Biết cách tạo danh từ số nhiều làm chủ ngữ (*talot, kukat, pöydät*).`
  },

  // TUẦN 8
  {
    id: "w8_d1_baitap_harjoitus16_20",
    title: "Bài tập thực hành: Harjoitus 16 - 20 (Trang 74-77)",
    chapter: "Kappale 3",
    week: 8,
    description: "Thực hành bài tập biến đổi KPT nâng cao với các danh từ có biến cách Genetiivi.",
    content: `# ✍️ Bài tập thực hành: Harjoitus 16 - 20 (Trang 74-77)

Tuần thứ 8 là tuần chạy nước rút để hoàn thiện 100% toàn bộ bài tập còn lại của Chương 3.`
  },
  {
    id: "w8_d3_giaotiep_lomake",
    title: "Giao tiếp: Điền mẫu đơn khóa học thực tế (Harjoitus 27 - Trang 84)",
    chapter: "Kappale 3",
    week: 8,
    description: "Luyện nghe bài đối thoại điền form mẫu phức tạp qua Track 45.",
    audioSnippet: "45 Harjoitus 27",
    content: `# 📋 Giao tiếp: Harjoitus 27 - Điền phiếu đăng ký (Track 45)

Nghe Track 45 để theo dõi cuộc đối thoại hướng dẫn điền đơn:

[audio:AUDIO_URL_1]

> 💡 **Mẹo:** Chú ý các con số điện thoại và địa chỉ email khi nghe người bản xứ đánh vần từng ký tự!`
  },
  {
    id: "sign_sauna_kulttuuri",
    title: "Immersion Văn hóa: Văn hóa Sauna & Mùa đông Phần Lan",
    chapter: "Kappale 3",
    week: 8,
    description: "Khám phá linh hồn của đời sống Phần Lan: Tắm hơi Sauna giữa mùa đông băng giá.",
    content: `# 🧖 Immersion Văn hóa: SAUNA - Trái tim của Phần Lan

Tại Phần Lan với dân số 5,5 triệu người, có tới hơn **3,3 triệu phòng xông hơi Sauna**! Hầu như mọi căn hộ chung cư đều có sauna riêng hoặc sauna chung cho tòa nhà.

---

### 🔥 1. Các thuật ngữ Sauna cần biết
* **Löyly**: Làn hơi nước nóng bốc lên khi bạn múc nước dội vào đống đá nóng trong lò sauna.
* **Vihta / Vasta**: Bó cành lá cây bạch dương tươi dùng để vỗ nhẹ lên người trong sauna để kích thích tuần hoàn máu và tạo mùi thơm tự nhiên ngào ngạt.
* **Avanto**: Hố băng khoét trên mặt hồ đóng băng giữa mùa đông. Người Phần Lan sau khi ngồi sauna 80-90°C sẽ chạy ra nhảy ùm xuống hố băng rồi quay lại sauna!`
  },
  {
    id: "w8_d6_kiemtra_tongket_kappale3",
    title: "Đề kiểm tra đánh giá năng lực toàn diện: Kappale 3 (Trang 84-85)",
    chapter: "Kappale 3",
    week: 8,
    description: "Bài kiểm tra chuẩn hóa tổng kết toàn diện kiến thức Chương 3.",
    content: `# 🎓 Đề kiểm tra năng lực toàn diện: Kappale 3

Kiểm tra tổng hợp 3 trụ cột:
1. Từ vựng thời tiết, 4 mùa và tính từ đối lập.
2. Sở hữu cách Genetiivi và biến đổi KPT.
3. Danh từ số nhiều T-monikko.

---

### ✍️ Bắt đầu làm bài kiểm tra tương tác
[exercise:ex_w8_d6_kiemtra_kappale3]`
  },
  {
    id: "w8_d7_tongket_kappale3",
    title: "Tổng kết Tháng thứ 2: Chinh phục trọn vẹn Chương 3",
    chapter: "Kappale 3",
    week: 8,
    description: "Khép lại 8 tuần học tập đầu tiên: Sẵn sàng bước sang Chương 4 (Gia đình & Cách Partitiivi).",
    content: `# 🏆 Chúc mừng bạn đã hoàn thành xuất sắc Chương 3!

Bạn đã đi được **1/3 chặng đường của toàn bộ giáo trình Suomen Mestari 1** (8 / 24 tuần)!
Toàn bộ 45 Audio Tracks của Đĩa 1 (Disc 1) đã được bạn nghe và làm chủ hoàn toàn!

Tuần tới, chúng ta sẽ bắt đầu **Chương 4 (Tuần 9 - 11): Bản thân, Gia đình, Ngoại hình, Mua sắm quần áo và Cách bổ ngữ Partitiivi**!`
  }
];

// ==========================================
// 3. CURRICULUM WEEKS 6, 7, 8
// ==========================================
const week06 = {
  id: "week_06",
  planId: "6iWorOc6mZtnINIFBH8a",
  weekNumber: 6,
  title: "Tháng 2 - Tuần 6: Khởi động Chương 3: Thời tiết, Gọi điện & Tính từ",
  description: "Bắt đầu Chương 3 (Kappale 3): Hội thoại gọi điện Pedro soittaa Mikolle (Track 33 & 34), Các cặp tính từ đối lập Adjektiivit (Track 38), Từ vựng Thời tiết Sää & 4 Mùa (Track 39), Nghe 5 đoạn hội thoại thời tiết (Track 40-44) và Phát âm nguyên âm kép Diftongit (Track 36, 37).",
  chapter: "Kappale 3",
  bookPages: "56-62, 68, 72",
  days: [
    {
      dayIndex: 1,
      dayName: "Thứ 2",
      actions: [
        {
          id: "w6_d1_act1",
          type: "lesson_full",
          title: "Kappale 3: Hội thoại Pedro soittaa Mikolle (Trang 56-58)",
          goal: "Học cách nghe gọi điện thoại và hỏi thăm thời tiết, lên lịch hẹn cuối tuần.",
          estimatedMinutes: 25,
          targetRefId: "w6_d1_thoai_pedro_soittaa_mikolle",
          notes: "Audio Track 33 & 34",
          steps: [
            { stepNumber: 1, instruction: "Nghe Track 33 (Kirjakieli) và Track 34 (Puhekieli)." },
            { stepNumber: 2, instruction: "Làm bài tập phản xạ hội thoại điện thoại." }
          ]
        }
      ]
    },
    {
      dayIndex: 2,
      dayName: "Thứ 3",
      actions: [
        {
          id: "w6_d2_act1",
          type: "vocabulary_set",
          title: "Từ vựng: Các cặp Tính từ miêu tả đối lập (Trang 59-60)",
          goal: "Nắm vững 10 cặp tính từ miêu tả đối lập quan trọng nhất.",
          estimatedMinutes: 20,
          targetRefId: "w6_d2_tuvung_adjektiivit",
          notes: "Audio Track 38",
          steps: [
            { stepNumber: 1, instruction: "Học các cặp kuuma/kylmä, kaunis/ruma, helppo/vaikea." },
            { stepNumber: 2, instruction: "Làm bài tập tương tác tính từ." }
          ]
        }
      ]
    },
    {
      dayIndex: 3,
      dayName: "Thứ 4",
      actions: [
        {
          id: "w6_d3_act1",
          type: "vocabulary_set",
          title: "Từ vựng: Thời tiết, 4 Mùa & 12 Tháng (Trang 61-62)",
          goal: "Học cách dự báo thời tiết và thuộc tên 4 mùa, 12 tháng.",
          estimatedMinutes: 20,
          targetRefId: "w6_d3_tuvung_saa_vuodenajat",
          notes: "Audio Track 39",
          steps: [
            { stepNumber: 1, instruction: "Nghe Track 39 về thời tiết các thành phố." },
            { stepNumber: 2, instruction: "Làm bài tập trắc nghiệm thời tiết." }
          ]
        },
        {
          id: "w6_d3_act2",
          type: "immersion_sign",
          title: "Immersion Đời sống: Đọc bản tin thời tiết Selkosuomi",
          goal: "Làm quen với tiếng Phần giản lược trên đài Yle.",
          estimatedMinutes: 10,
          targetRefId: "sign_yle_uutiset_selkosuomeksi",
          steps: [
            { stepNumber: 1, instruction: "Đọc bản tin thời tiết mẫu Yle Uutiset selkosuomeksi." }
          ]
        }
      ]
    },
    {
      dayIndex: 4,
      dayName: "Thứ 5",
      actions: [
        {
          id: "w6_d4_act1",
          type: "lesson_slice",
          title: "Luyện nghe: 5 Đoạn hội thoại Thời tiết thực tế (Trang 72)",
          goal: "Rèn luyện đôi tai qua 5 mẩu hội thoại ngắn Track 40-44.",
          estimatedMinutes: 25,
          targetRefId: "w6_d4_luyennghe_saakeskustelu",
          notes: "Audio Track 40-44",
          steps: [
            { stepNumber: 1, instruction: "Nghe từng đoạn đối thoại Track 40, 41, 42, 43, 44." }
          ]
        }
      ]
    },
    {
      dayIndex: 5,
      dayName: "Thứ 6",
      actions: [
        {
          id: "w6_d5_act1",
          type: "lesson_slice",
          title: "Phát âm: Nguyên âm ghép (Diftongit) (Trang 68)",
          goal: "Phát âm chuẩn xác các cặp nguyên âm uo, yö, ie qua Track 36 & 37.",
          estimatedMinutes: 20,
          targetRefId: "w6_d5_phatam_diftongit",
          notes: "Audio Track 36 & 37",
          steps: [
            { stepNumber: 1, instruction: "Nghe và phát âm theo Track 36 & Track 37." }
          ]
        }
      ]
    },
    {
      dayIndex: 6,
      dayName: "Thứ 7",
      actions: [
        {
          id: "w6_d6_act1",
          type: "custom",
          title: "Tổng kết & Củng cố Tuần 6 (Kappale 3)",
          goal: "Ôn tập toàn bộ kiến thức tuần 6.",
          estimatedMinutes: 15,
          targetRefId: "w6_d7_tonghop_tuan6",
          steps: [
            { stepNumber: 1, instruction: "Đọc tóm tắt tuần 6." }
          ]
        }
      ]
    },
    {
      dayIndex: 7,
      dayName: "Chủ Nhật",
      actions: [
        {
          id: "w6_d7_act1",
          type: "custom",
          title: "Ota rennosti: Nghỉ ngơi & Thư giãn cuối tuần",
          goal: "Nạp năng lượng cho tuần mới.",
          estimatedMinutes: 15,
          targetRefId: "w6_d7_tonghop_tuan6",
          steps: [
            { stepNumber: 1, instruction: "Nghỉ ngơi thư giãn." }
          ]
        }
      ]
    }
  ]
};

const week07 = {
  id: "week_07",
  planId: "6iWorOc6mZtnINIFBH8a",
  weekNumber: 7,
  title: "Tháng 2 - Tuần 7: Ngữ pháp Sở hữu cách Genetiivi & Số nhiều T-monikko",
  description: "Trọng tâm ngữ pháp Chương 3: Giao tiếp đăng ký khóa học Pedro ilmoittautuu kurssille (Track 35), Sở hữu cách Genetiivi đuôi -n và KPT, Danh từ số nhiều đuôi -t (T-monikko), và Giải bài tập Harjoitus 1 - 9.",
  chapter: "Kappale 3",
  bookPages: "63-67, 69-71",
  days: [
    {
      dayIndex: 1,
      dayName: "Thứ 2",
      actions: [
        {
          id: "w7_d1_act1",
          type: "lesson_slice",
          title: "Giao tiếp: Pedro đăng ký khóa học tiếng Phần (Trang 63-65)",
          goal: "Học cách giao tiếp tại bàn đăng ký học vụ và nộp giấy tờ tùy thân.",
          estimatedMinutes: 20,
          targetRefId: "w7_d1_giaotiep_dangky_khoahoc",
          notes: "Audio Track 35",
          steps: [
            { stepNumber: 1, instruction: "Nghe đối thoại mẫu Track 35." }
          ]
        }
      ]
    },
    {
      dayIndex: 2,
      dayName: "Thứ 3",
      actions: [
        {
          id: "w7_d2_act1",
          type: "grammar_point",
          title: "Ngữ pháp: Sở hữu cách Genetiivi (Đuôi -n) (Trang 66-67)",
          goal: "Làm chủ cách tạo sở hữu cách và biến đổi KPT cấp yếu.",
          estimatedMinutes: 30,
          targetRefId: "w7_d2_nguphap_genetiivi",
          steps: [
            { stepNumber: 1, instruction: "Học quy tắc thêm đuôi -n và KPT: Pekka -> Pekan." },
            { stepNumber: 2, instruction: "Làm bài tập tương tác Genetiivi." }
          ]
        }
      ]
    },
    {
      dayIndex: 3,
      dayName: "Thứ 4",
      actions: [
        {
          id: "w7_d3_act1",
          type: "grammar_point",
          title: "Ngữ pháp: Danh từ số nhiều đuôi -t (T-monikko) (Trang 67)",
          goal: "Biết cách tạo danh từ số nhiều làm chủ ngữ.",
          estimatedMinutes: 25,
          targetRefId: "w7_d3_nguphap_t_monikko",
          steps: [
            { stepNumber: 1, instruction: "Học công thức Thân từ cấp yếu + t: talot, pöydät." },
            { stepNumber: 2, instruction: "Làm bài tập tương tác số nhiều." }
          ]
        },
        {
          id: "w7_d3_act2",
          type: "immersion_sign",
          title: "Immersion Biển hiệu: Cung văn hóa & Trung tâm học tập (Opisto)",
          goal: "Hiểu hệ thống giáo dục người lớn Kansalaisopisto tại Phần Lan.",
          estimatedMinutes: 10,
          targetRefId: "sign_opisto_kurssit",
          steps: [
            { stepNumber: 1, instruction: "Đọc cẩm nang về trường cộng đồng Opisto." }
          ]
        }
      ]
    },
    {
      dayIndex: 4,
      dayName: "Thứ 5",
      actions: [
        {
          id: "w7_d4_act1",
          type: "exercise_set",
          title: "Bài tập thực hành: Harjoitus 1 - 9 Chương 3 (Trang 68-70)",
          goal: "Thực hành giải bài tập chia Genetiivi và T-monikko.",
          estimatedMinutes: 25,
          targetRefId: "w7_d5_baitap_harjoitus1_9",
          steps: [
            { stepNumber: 1, instruction: "Giải các bài tập chia đuôi danh từ." }
          ]
        }
      ]
    },
    {
      dayIndex: 5,
      dayName: "Thứ 6",
      actions: [
        {
          id: "w7_d5_act2",
          type: "exercise_set",
          title: "Bài tập thực hành: Harjoitus 10 - 15 Chương 3 (Trang 71-73)",
          goal: "Hoàn thiện các bài tập tính từ và thời tiết.",
          estimatedMinutes: 25,
          targetRefId: "w7_d5_baitap_harjoitus1_9",
          steps: [
            { stepNumber: 1, instruction: "Thực hành bài tập đọc hiểu và điền từ." }
          ]
        }
      ]
    },
    {
      dayIndex: 6,
      dayName: "Thứ 7",
      actions: [
        {
          id: "w7_d6_act1",
          type: "custom",
          title: "Tổng kết & Củng cố Tuần 7 (Kappale 3)",
          goal: "Ôn tập Genetiivi và T-monikko.",
          estimatedMinutes: 15,
          targetRefId: "w7_d7_tonghop_tuan7",
          steps: [
            { stepNumber: 1, instruction: "Đọc tóm tắt kiến thức tuần 7." }
          ]
        }
      ]
    },
    {
      dayIndex: 7,
      dayName: "Chủ Nhật",
      actions: [
        {
          id: "w7_d7_act1",
          type: "custom",
          title: "Nghỉ ngơi nạp năng lượng (Ota rennosti)",
          goal: "Thư giãn trước tuần hoàn thiện Chương 3.",
          estimatedMinutes: 15,
          targetRefId: "w7_d7_tonghop_tuan7",
          steps: [
            { stepNumber: 1, instruction: "Thư giãn cuối tuần." }
          ]
        }
      ]
    }
  ]
};

const week08 = {
  id: "week_08",
  planId: "6iWorOc6mZtnINIFBH8a",
  weekNumber: 8,
  title: "Tháng 2 - Tuần 8: Hoàn thiện Chương 3 & Đề kiểm tra đánh giá năng lực",
  description: "Tuần về đích Chương 3: Hoàn thiện toàn bộ bài tập Harjoitus 16 - 28, Luyện nghe điền đơn thực tế (Track 45), Văn hóa Sauna mùa đông Phần Lan, và Đề kiểm tra đánh giá năng lực hoàn tất Kappale 3 (Đạt mốc 1/3 giáo trình).",
  chapter: "Kappale 3",
  bookPages: "74-85",
  days: [
    {
      dayIndex: 1,
      dayName: "Thứ 2",
      actions: [
        {
          id: "w8_d1_act1",
          type: "exercise_set",
          title: "Bài tập thực hành: Harjoitus 16 - 20 (Trang 74-77)",
          goal: "Giải các bài tập biến đổi KPT nâng cao trong câu hoàn chỉnh.",
          estimatedMinutes: 25,
          targetRefId: "w8_d1_baitap_harjoitus16_20",
          steps: [
            { stepNumber: 1, instruction: "Làm bài tập chia động từ và danh từ." }
          ]
        }
      ]
    },
    {
      dayIndex: 2,
      dayName: "Thứ 3",
      actions: [
        {
          id: "w8_d2_act1",
          type: "lesson_slice",
          title: "Giao tiếp: Điền mẫu đơn khóa học thực tế (Harjoitus 27 - Trang 84)",
          goal: "Nghe hiểu cuộc trò chuyện điền form mẫu phức tạp qua Track 45.",
          estimatedMinutes: 25,
          targetRefId: "w8_d3_giaotiep_lomake",
          notes: "Audio Track 45",
          steps: [
            { stepNumber: 1, instruction: "Nghe Track 45 và đối chiếu các thông tin cá nhân." }
          ]
        }
      ]
    },
    {
      dayIndex: 3,
      dayName: "Thứ 4",
      actions: [
        {
          id: "w8_d3_act1",
          type: "immersion_sign",
          title: "Immersion Văn hóa: Văn hóa Sauna & Mùa đông Phần Lan",
          goal: "Tìm hiểu nét văn hóa đặc trưng nhất của đất nước Phần Lan.",
          estimatedMinutes: 15,
          targetRefId: "sign_sauna_kulttuuri",
          steps: [
            { stepNumber: 1, instruction: "Đọc bài viết về Löyly, Vihta và Avanto." }
          ]
        }
      ]
    },
    {
      dayIndex: 4,
      dayName: "Thứ 5",
      actions: [
        {
          id: "w8_d4_act1",
          type: "exercise_set",
          title: "Hoàn thiện toàn bộ bài tập còn lại: Harjoitus 21 - 28 (Trang 78-83)",
          goal: "Giải quyết 100% bài tập còn lại của Chương 3.",
          estimatedMinutes: 25,
          targetRefId: "w8_d1_baitap_harjoitus16_20",
          steps: [
            { stepNumber: 1, instruction: "Làm bài tập tổng hợp cuối chương." }
          ]
        }
      ]
    },
    {
      dayIndex: 5,
      dayName: "Thứ 6",
      actions: [
        {
          id: "w8_d5_act1",
          type: "lesson_full",
          title: "Đề kiểm tra đánh giá năng lực toàn diện: Kappale 3 (Trang 84-85)",
          goal: "Đánh giá toàn diện kiến thức Chương 3 trước khi bước sang Chương 4.",
          estimatedMinutes: 30,
          targetRefId: "w8_d6_kiemtra_tongket_kappale3",
          steps: [
            { stepNumber: 1, instruction: "Làm bài kiểm tra đánh giá năng lực tương tác." }
          ]
        }
      ]
    },
    {
      dayIndex: 6,
      dayName: "Thứ 7",
      actions: [
        {
          id: "w8_d6_act1",
          type: "custom",
          title: "Tổng kết Tháng thứ 2: Chinh phục trọn vẹn Chương 3",
          goal: "Đánh dấu mốc hoàn thành 1/3 giáo trình Suomen Mestari 1.",
          estimatedMinutes: 15,
          targetRefId: "w8_d7_tongket_kappale3",
          steps: [
            { stepNumber: 1, instruction: "Ăn mừng hoàn thành 8 tuần đầu tiên!" }
          ]
        }
      ]
    },
    {
      dayIndex: 7,
      dayName: "Chủ Nhật",
      actions: [
        {
          id: "w8_d7_act1",
          type: "custom",
          title: "Nghỉ ngơi thư giãn (Ota rennosti)",
          goal: "Chuẩn bị tinh thần đón nhận Chương 4: Gia đình & Cách Partitiivi.",
          estimatedMinutes: 15,
          targetRefId: "w8_d7_tongket_kappale3",
          steps: [
            { stepNumber: 1, instruction: "Thư giãn nạp năng lượng." }
          ]
        }
      ]
    }
  ]
};

// ==========================================
// 4. GENERATE FILES & SYNC TO FIRESTORE
// ==========================================
async function buildAndSyncPhase3() {
  console.log('🚀 === GENERATING AND SYNCING PHASE 3 (WEEKS 6, 7, 8 - CHAPTER 3) ===\n');

  const currDir = path.resolve(__dirname, '../../content/curriculum');
  const lessDir = path.resolve(__dirname, '../../content/lessons');

  // Save local files
  fs.writeFileSync(path.join(currDir, 'chapter_03_exercises.json'), JSON.stringify({ exercises }, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/chapter_03_exercises.json');

  fs.writeFileSync(path.join(lessDir, 'chapter_03_lessons.json'), JSON.stringify({ lessons }, null, 2), 'utf8');
  console.log('✅ Generated content/lessons/chapter_03_lessons.json');

  fs.writeFileSync(path.join(currDir, 'week_06.json'), JSON.stringify(week06, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/week_06.json');

  fs.writeFileSync(path.join(currDir, 'week_07.json'), JSON.stringify(week07, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/week_07.json');

  fs.writeFileSync(path.join(currDir, 'week_08.json'), JSON.stringify(week08, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/week_08.json');

  // Sync Exercises to Firestore
  console.log('\n📝 1. Synchronizing Phase 3 Interactive Exercises into Firestore `exercises`...');
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
  console.log('\n📚 2. Synchronizing Phase 3 Rich Interactive Lessons into Firestore `lessons`...');
  for (const rawLesson of lessons) {
    let content = rawLesson.content;
    const audioUrlsList = [];

    if (rawLesson.audioSnippet) {
      const u1 = getAudioUrl(rawLesson.audioSnippet);
      if (u1) {
        content = content.replace(/AUDIO_URL_1/g, u1);
        audioUrlsList.push(u1);
      }
    }

    if (rawLesson.audioSnippet2) {
      const u2 = getAudioUrl(rawLesson.audioSnippet2);
      if (u2) {
        content = content.replace(/AUDIO_URL_2/g, u2);
        audioUrlsList.push(u2);
      }
    }

    await db.collection('lessons').doc(rawLesson.id).set({
      id: rawLesson.id,
      title: rawLesson.title,
      chapter: rawLesson.chapter || 'Kappale 3',
      week: rawLesson.week || 6,
      description: rawLesson.description || '',
      audioUrls: audioUrlsList,
      content: content,
      updatedAt: admin.firestore.FieldValue.serverTimestamp()
    }, { merge: true });

    if (rawLesson.id.startsWith('sign_') || rawLesson.id.startsWith('song_') || rawLesson.id.startsWith('video_')) {
      await db.collection('immersion_resources').doc(rawLesson.id).set({
        id: rawLesson.id,
        title: rawLesson.title,
        chapter: rawLesson.chapter || 'Kappale 3',
        description: rawLesson.description || '',
        content: content,
        type: rawLesson.id.startsWith('sign_') ? 'sign' : (rawLesson.id.startsWith('song_') ? 'music' : 'video'),
        updatedAt: admin.firestore.FieldValue.serverTimestamp()
      }, { merge: true });
    }

    console.log(`   ✅ Synced Lesson: [${rawLesson.id}] ${rawLesson.title}`);
  }

  // Sync Weeks 6, 7, 8 to Firestore
  console.log('\n📅 3. Synchronizing Study Plan Weeks 6, 7, 8 into Firestore `study_plan_weeks`...');
  const planId = '6iWorOc6mZtnINIFBH8a';
  const week6DocId = 'iVQtUXQjufqR4nPozqvp';
  const week7DocId = 'e13V5toEo0Z6YVC2rLz8';
  const week8DocId = '8BxrxpUUaudwLy2gFhpr';

  await db.collection('study_plan_weeks').doc(week6DocId).set({
    planId: planId,
    weekNumber: 6,
    title: week06.title,
    description: week06.description,
    days: week06.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Week 6 (doc: ${week6DocId})`);

  await db.collection('study_plan_weeks').doc(week7DocId).set({
    planId: planId,
    weekNumber: 7,
    title: week07.title,
    description: week07.description,
    days: week07.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Week 7 (doc: ${week7DocId})`);

  await db.collection('study_plan_weeks').doc(week8DocId).set({
    planId: planId,
    weekNumber: 8,
    title: week08.title,
    description: week08.description,
    days: week08.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Week 8 (doc: ${week8DocId})`);

  console.log('\n🎉 ALL PHASE 3 (WEEKS 6, 7, 8) CONTENT SYNCED SUCCESSFULLY TO FIRESTORE PRODUCTION!');
}

buildAndSyncPhase3().catch(err => {
  console.error('❌ Phase 3 Build & Sync failed:', err);
  process.exit(1);
});
