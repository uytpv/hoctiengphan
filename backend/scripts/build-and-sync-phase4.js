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
// 1. EXERCISES (chapter_04_exercises.json)
// ==========================================
const exercises = [
  {
    id: "ex_w9_d1_mina_itse",
    title: "Giới thiệu bản thân & Ngoại hình (Kappale 4)",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Để nói 'Tôi có mái tóc màu nâu và đôi mắt xanh lam', câu chuẩn tiếng Phần là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Minulla on ruskeat hiukset ja siniset silmät.",
          "Minulla on ruskea hius ja sininen silmä.",
          "Minä olen ruskeat hiukset."
        ],
        correctIndex: 0,
        explanation: "Hiukset (tóc) và silmät (đôi mắt) luôn dùng ở dạng số nhiều: ruskeat hiukset, siniset silmät."
      },
      {
        prompt: "Từ nào sau đây có nghĩa là 'cao lớn'?",
        type: "MULTIPLE_CHOICE",
        options: [
          "pitkä",
          "lyhyt (thấp)",
          "hoikka (thanh mảnh)"
        ],
        correctIndex: 0,
        explanation: "pitkä = dài, cao; lyhyt = ngắn, thấp."
      }
    ]
  },
  {
    id: "ex_w9_d2_perhesanasto",
    title: "Từ vựng: Cây phả hệ Gia đình (Perhe)",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "'Anh/Em trai' và 'Chị/Em gái' trong tiếng Phần Lan lần lượt là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "veli ja sisko",
          "isä ja äiti",
          "poika ja tytär"
        ],
        correctIndex: 0,
        explanation: "veli = anh/em trai; sisko = chị/em gái."
      },
      {
        prompt: "'Bố mẹ' (cha mẹ) trong tiếng Phần là danh từ số nhiều:",
        type: "MULTIPLE_CHOICE",
        options: [
          "vanhemmat",
          "isovanhemmat (ông bà)",
          "lapset (con cái)"
        ],
        correctIndex: 0,
        explanation: "vanhemmat = bố mẹ; isovanhemmat = ông bà."
      }
    ]
  },
  {
    id: "ex_w9_d3_vaatteet_varit",
    title: "Từ vựng: Quần áo (Vaatteet) & Màu sắc (Värit)",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Màu 'musta' và 'valkoinen' lần lượt là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "đen và trắng",
          "đỏ và xanh lá",
          "vàng và xanh dương"
        ],
        correctIndex: 0,
        explanation: "musta = màu đen, valkoinen = màu trắng."
      },
      {
        prompt: "Món đồ mặc vào mùa đông ấm áp 'takki' là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "áo khoác",
          "quần bò (farkut)",
          "giày (kengät)"
        ],
        correctIndex: 0,
        explanation: "takki = áo khoác; talvitakki = áo khoác mùa đông."
      }
    ]
  },
  {
    id: "ex_w10_d1_partitiivi_saannot",
    title: "Ngữ pháp: Quy tắc chia đuôi Partitiivi",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Từ 'talo' kết thúc bằng 1 nguyên âm đơn (o). Đuôi Partitiivi là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "taloa (thêm -a)",
          "talota",
          "talotta"
        ],
        correctIndex: 0,
        explanation: "Luật 1 Partitiivi: Tận cùng bằng 1 nguyên âm đơn -> thêm -a/-ä: talo -> taloa."
      },
      {
        prompt: "Từ 'maa' kết thúc bằng 2 nguyên âm (aa). Đuôi Partitiivi là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "maata (thêm -ta)",
          "maaa",
          "maassa"
        ],
        correctIndex: 0,
        explanation: "Luật 2 Partitiivi: Tận cùng bằng 2 nguyên âm hoặc 1 phụ âm -> thêm -ta/-tä: maa -> maata."
      },
      {
        prompt: "Động từ 'rakastaa' (yêu thương) bắt buộc đi với cách gì?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Partitiivi (Minä rakastan sinua)",
          "Genetiivi (Minä rakastan sinun)",
          "Nominatiivi (Minä rakastan sinä)"
        ],
        correctIndex: 0,
        explanation: "Động từ cảm xúc 'rakastaa' luôn đòi hỏi tân ngữ ở thể Partitiivi: sinä -> sinua."
      }
    ]
  },
  {
    id: "ex_w10_d3_minulla_on",
    title: "Cấu trúc sở hữu: Minulla on... / Minulla ei ole...",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Để nói 'Tôi có một chiếc xe đạp', câu chuẩn là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Minulla on polkupyörä.",
          "Minä on polkupyörä.",
          "Minulla olen polkupyörä."
        ],
        correctIndex: 0,
        explanation: "Cấu trúc sở hữu: [Người ở dạng -lla/-llä] + on + [vật sở hữu]: Minulla on..."
      },
      {
        prompt: "Khi nói 'Tôi KHÔNG có ô tô', từ 'auto' bắt buộc phải chuyển sang cách gì?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Partitiivi: Minulla ei ole autoa.",
          "Giữ nguyên: Minulla ei ole auto.",
          "Genetiivi: Minulla ei ole auton."
        ],
        correctIndex: 0,
        explanation: "NGUYÊN TẮC VÀNG: Trong câu phủ định sở hữu 'ei ole', vật sở hữu LUÔN LUÔN ở thể Partitiivi: auto -> autoa!"
      }
    ]
  },
  {
    id: "ex_w11_d6_kiemtra_kappale4",
    title: "Đề kiểm tra đánh giá năng lực toàn diện Chương 4",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Dịch câu 'Chúng tôi có hai người con':",
        type: "MULTIPLE_CHOICE",
        options: [
          "Meillä on kaksi lasta.",
          "Meillä on kaksi lapsi.",
          "Me olemme kaksi lasta."
        ],
        correctIndex: 0,
        explanation: "Sau số đếm lớn hơn 1 (kaksi), danh từ chia ở thể Partitiivi: lapsi -> lasta."
      },
      {
        prompt: "'Pedro asuu vaimon kanssa' có nghĩa là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Pedro sống cùng với vợ",
          "Pedro sống một mình",
          "Pedro tìm kiếm vợ"
        ],
        correctIndex: 0,
        explanation: "Giới từ 'kanssa' (cùng với) luôn đi sau danh từ ở thể Genetiivi: vaimo -> vaimon kanssa."
      }
    ]
  }
];

// ==========================================
// 2. LESSONS (chapter_04_lessons.json)
// ==========================================
const lessons = [
  // TUẦN 9
  {
    id: "w9_d1_thoai_mina",
    title: "Kappale 4: Hội thoại Minä - Giới thiệu bản thân & Ngoại hình (Trang 86-88)",
    chapter: "Kappale 4",
    week: 9,
    description: "Học cách miêu tả chi tiết ngoại hình, chiều cao, màu tóc, màu mắt và tính cách.",
    content: `# 👤 Kappale 4: Minä (Bản thân tôi)

Chào mừng bạn đến với **Chương 4 (Kappale 4)** của *Suomen Mestari 1*! Hôm nay chúng ta sẽ học cách phác họa chân dung bản thân và người thân.

---

### 💬 1. Bài đọc mẫu: Alex ja Pedro esittäytyvät (Alex và Pedro tự giới thiệu)

| Tiếng Phần Lan (Suomi) | Tiếng Việt (Vietnam) | Chú giải từ vựng |
| :--- | :--- | :--- |
| *Minä olen Alex. Olen 28 vuotta vanha.* | Tôi là Alex. Tôi 28 tuổi. | *vuotta vanha* = tuổi đời |
| *Olen pitkä ja hoikka.* | Tôi cao và thanh mảnh. | *pitkä* = cao, *hoikka* = mảnh khảnh |
| *Minulla on lyhyet, ruskeat hiukset ja siniset silmät.* | Tôi có mái tóc ngắn màu nâu và đôi mắt xanh lam. | *hiukset* (tóc), *silmät* (mắt) |
| *Olen naimisissa. Vaimon nimi on Hanna.* | Tôi đã kết hôn. Tên của vợ tôi là Hanna. | *naimisissa* = đã kết hôn |
| *Meillä on kissa. Sen nimi on Kisu.* | Chúng tôi có một chú mèo. Tên nó là Kisu. | *Meillä on* = Chúng tôi có |

---

### 🎨 2. Bảng từ vựng miêu tả ngoại hình (Ulkonäkö)

| Từ vựng | Nghĩa | Từ trái nghĩa | Nghĩa |
| :--- | :--- | :--- | :--- |
| **pitkä** | cao lớn / dài | **lyhyt** | thấp bé / ngắn |
| **hoikka** | thon thả, gầy | **tukeva / lihava** | đậm đà, mập |
| **nuori** | trẻ tuổi | **vanha** | già dặn |
| **tumma** | ngăm đen, tóc sẫm | **vaalea** | da trắng, tóc vàng hoe |

---

### 📝 3. Thử thách tương tác
[exercise:ex_w9_d1_mina_itse]`
  },
  {
    id: "w9_d2_tuvung_perhe",
    title: "Từ vựng: Cây phả hệ Gia đình (Perhe) (Trang 89-91)",
    chapter: "Kappale 4",
    week: 9,
    description: "Làm chủ toàn bộ các danh xưng thành viên trong gia đình Phần Lan.",
    content: `# 👨‍👩‍👧‍👦 Từ vựng: Gia đình (Perhe) & Họ hàng (Sukulaiset)

Gia đình là điểm tựa ấm áp nhất trong mùa đông Phần Lan tuyết trắng.

---

### 🌳 Bảng danh xưng các thành viên

| Tiếng Phần Lan | Tiếng Việt | Ví dụ câu |
| :--- | :--- | :--- |
| **isä / isi** | bố, cha | *Minun isä on mukava.* |
| **äiti / äippä** | mẹ, má | *Äiti tekee ruokaa.* |
| **vanhemmat** | bố mẹ, phụ huynh | *Vanhemmat asuvat Vietnamissa.* |
| **lapsi (monikko: lapset)**| con, đứa trẻ (các con) | *Heillä on kaksi lasta.* |
| **poika** | con trai, bé trai | *Heidän poika on koulussa.* |
| **tytär** | con gái | *Tytär on 5 vuotta vanha.* |
| **veli** | anh trai, em trai | *Minulla on yksi veli.* |
| **sisko / sisar** | chị gái, em gái | *Minulla ei ole siskoa.* |
| **isovanhemmat** | ông bà | *Isovanhemmat ovat eläkkeellä.* |
| **isoisa / vaari / ukki** | ông nội, ông ngoại | *Vaari kalastaa.* |
| **isoäiti / mummo / mummi**| bà nội, bà ngoại | *Mummo leipoo pullaa.* |
| **mies / aviomies** | người chồng | *Minun mies on suomalainen.* |
| **vaimo** | người vợ | *Hänen vaimo on opettaja.* |

---

### ✍️ Bài tập tương tác gia đình
[exercise:ex_w9_d2_perhesanasto]`
  },
  {
    id: "w9_d3_tuvung_vaatteet_varit",
    title: "Từ vựng: Quần áo (Vaatteet) & Màu sắc (Värit) (Trang 92-94)",
    chapter: "Kappale 4",
    week: 9,
    description: "Bộ sưu tập thời trang thường nhật và bảng màu sắc rực rỡ.",
    content: `# 👗 Từ vựng: Quần áo (Vaatteet) & Màu sắc (Värit)

---

### 🎨 1. Bảng 10 màu sắc căn bản (Värit)
* 🔴 **punainen**: đỏ
* 🔵 **sininen**: xanh lam
* 🟡 **keltainen**: vàng
* 🟢 **vihreä**: xanh lá
* ⚫ **musta**: đen
* ⚪ **valkoinen**: trắng
* 🟤 **ruskea**: nâu
* 🟠 **oranssi**: cam
* 🟣 **violetti**: tím
* 🔘 **harmaa**: xám

---

### 🧥 2. Quần áo thường ngày (Vaatteet)
* **paita**: áo sơ mi, áo phông
* **t-paita**: áo thun cộc tay
* **takki**: áo khoác (*talvitakki* = áo khoác mùa đông)
* **housut** (số nhiều): quần dài
* **farkut** (số nhiều): quần bò jean
* **hame**: chân váy
* **mekko**: váy liền thân
* **kengät** (số nhiều): đôi giày
* **pipo**: mũ len mùa đông (vật bất ly thân ở Phần Lan!)
* **kaulaliina**: khăn quàng cổ
* **hanskat / kintaat**: găng tay len / găng tay da

---

### 📝 3. Bài tập tương tác
[exercise:ex_w9_d3_vaatteet_varit]`
  },
  {
    id: "sign_vaatekauppa_hm",
    title: "Immersion Biển hiệu: Cửa hàng thời trang & Bảng size Phần Lan",
    chapter: "Kappale 4",
    week: 9,
    description: "Khám phá cách mua sắm quần áo ấm mùa đông tại Prisma, Stadium và H&M.",
    content: `# 🏷️ Immersion Thực tế: VAATEKAUPPA (Cửa hàng quần áo)

Khi mùa thu sang và mùa đông tới ở Bắc Âu, cụm từ bạn sẽ tìm kiếm tại các trung tâm thương mại chính là:

> # 🧥 TALVIVAATTEET & ALE!
> *(Quần áo mùa đông & Giảm giá)*

---

### 🛍️ Các biển chỉ dẫn trong tiệm quần áo
* **Sovituskoppi**: Phòng thử đồ.
* **Koot / Koko**: Kích cỡ (*S, M, L, XL* hoặc số *36, 38, 40*).
* **Naisten osasto**: Gian hàng đồ nữ.
* **Miesten osasto**: Gian hàng đồ nam.
* **Lasten osasto**: Gian hàng trẻ em.`
  },
  {
    id: "w9_d7_tonghop_tuan9",
    title: "Tổng kết & Củng cố Tuần 9 (Kappale 4)",
    chapter: "Kappale 4",
    week: 9,
    description: "Ôn tập chân dung bản thân, các thành viên gia đình, quần áo và màu sắc.",
    content: `# 🏆 Tổng kết & Củng cố Tuần 9

* ✅ Tự tin miêu tả ngoại hình, chiều cao, màu mắt, mái tóc.
* ✅ Thuộc trọn vẹn gia phả từ ông bà, bố mẹ đến con cái.
* ✅ Làm chủ 10 màu sắc và tên các trang phục mùa đông Phần Lan.`
  },

  // TUẦN 10
  {
    id: "w10_d1_nguphap_partitiivi",
    title: "Ngữ pháp: Cách bổ ngữ Partitiivi (Trang 95-96)",
    chapter: "Kappale 4",
    week: 10,
    description: "Khám phá cách ngữ pháp vĩ đại và độc đáo nhất của tiếng Phần Lan: Bổ ngữ Partitiivi.",
    content: `# 🧩 Ngữ pháp: Cách bổ ngữ Partitiivi (Osa-sijamuoto)

Nếu có một cách ngữ pháp xuất hiện nhiều nhất trong câu văn tiếng Phần Lan, đó chính là **PARTITIIVI**. Partitiivi diễn tả một phần, sự không trọn vẹn, tính chất liên tục chưa dứt điểm, hoặc đi sau số đếm.

---

### 📐 3 QUY TẮC CẤU TẠO ĐUÔI PARTITIIVI SỐ ÍT

#### 1. Quy tắc 1: Từ tận cùng bằng 1 NGUYÊN ÂM ĐƠN (trừ đuôi -e) -> Thêm **-A / -Ä**
* *talo* -> **taloa**
* *kirja* -> **kirjaa**
* *kahvi* -> **kahvia**
* *auto* -> **autoa**
* *päivä* -> **päivää**

#### 2. Quy tắc 2: Từ tận cùng bằng 2 NGUYÊN ÂM hoặc 1 PHỤ ÂM -> Thêm **-TA / -TÄ**
* *maa* (đất nước) -> **maata**
* *tee* (trà) -> **teetä**
* *puu* (cái cây) -> **puuta**
* *kieli* (thân từ *kiel-*) -> **kieltä**
* *olut* (bia) -> **olutta**

#### 3. Quy tắc 3: Từ tận cùng bằng chữ cái **-E** -> Nhân đôi thành **-TTA / -TTÄ**
* *kirje* (bức thư) -> **kirjettä**
* *perhe* (gia đình) -> **perhettä**
* *huone* (căn phòng) -> **huonetta**

> 📌 **LƯU Ý ĐẶC BIỆT VỀ K-P-T:** Khi thêm đuôi Partitiivi số ít, từ **LUÔN GIỮ CẤP MẠNH (Vahva aste)**, không bị biến âm!
> * *Pekka* -> **Pekkaa** (vẫn giữ kk).
> * *tyttö* -> **tyttöä** (vẫn giữ tt).

---

### 📝 4. Bài tập tương tác Partitiivi
[exercise:ex_w10_d1_partitiivi_saannot]`
  },
  {
    id: "w10_d2_dongtu_partitiivi",
    title: "Ngữ pháp: Các Động từ bắt buộc đi với Partitiivi (Trang 96)",
    chapter: "Kappale 4",
    week: 10,
    description: "Nhận diện danh sách các động từ đòi hỏi tân ngữ Partitiivi (Partitiiviverbit).",
    content: `# ❤️ Ngữ pháp: Các Động từ luôn đòi hỏi Partitiivi (Partitiiviverbit)

Trong tiếng Phần Lan, nhiều động từ cảm xúc, nhận thức hoặc hành vi tiếp diễn **bắt buộc tân ngữ đứng sau nó phải ở dạng Partitiivi**:

---

### 📋 Danh sách động từ Partitiivi thường gặp nhất
1. **rakastaa** (yêu): *Minä rakastan **sinua**.* (Tôi yêu bạn).
2. **puhua** (nói ngôn ngữ): *Hän puhuu **suomea**.* (Anh ấy nói tiếng Phần).
3. **auttaa** (giúp đỡ): *Voitko auttaa **minua**?* (Bạn có thể giúp tôi được không?).
4. **odottaa** (chờ đợi): *Minä odotan **bussia**.* (Tôi đang đợi xe buýt).
5. **ymmärtää** (thấu hiểu): *En ymmärrä **tätä sanaa**.* (Tôi không hiểu từ này).
6. **opiskella** (học): *Me opiskelemme **suomen kieltä**.* (Chúng tôi học tiếng Phần).`
  },
  {
    id: "w10_d3_nguphap_minulla_on",
    title: "Ngữ pháp: Cấu trúc sở hữu Minulla on... / Minulla ei ole... (Trang 97-98)",
    chapter: "Kappale 4",
    week: 10,
    description: "Diễn tả sự sở hữu 'Tôi có...' và 'Tôi không có...' chuẩn mực ngữ pháp.",
    content: `# 🤝 Ngữ pháp: Cấu trúc sở hữu (Omistusrakenne)

Tiếng Phần Lan **không có động từ 'to have'** như tiếng Anh. Thay vào đó, tiếng Phần Lan dùng cấu trúc:
> 👉 **[Chủ sở hữu + -LLA / -LLÄ] + ON + [Vật sở hữu]**

---

### 👤 1. Bảng đại từ sở hữu
* minä -> **Minulla on** (Tôi có...)
* sinä -> **Sinulla on** (Bạn có...)
* hän -> **Hänellä on** (Anh ấy/cô ấy có...)
* me -> **Meillä on** (Chúng tôi có...)
* te -> **Teillä on** (Các bạn có...)
* he -> **Heillä on** (Họ có...)

---

### 🚨 2. CÂU PHỦ ĐỊNH: MINULLA EI OLE + PARTITIIVI
Khi nói *"Tôi không có..."*, vật sở hữu **BẮT BUỘC PHẢI CHUYỂN SANG PARTITIIVI**:
* *Minulla on auto.* (Tôi có ô tô) -> *Minulla **ei ole autoa**.* (Tôi không có ô tô).
* *Minulla on aikaa.* (Tôi có thời gian) -> *Minulla **ei ole aikaa**.* (Tôi không có thời gian).
* *Meillä on lapsi.* (Chúng tôi có con) -> *Meillä **ei ole lasta**.* (Chúng tôi chưa có con).

---

### 📝 3. Bài tập tương tác sở hữu
[exercise:ex_w10_d3_minulla_on]`
  },
  {
    id: "song_mina_rakastan_sinua",
    title: "Immersion Âm nhạc: Bài hát Minä rakastan sinua",
    chapter: "Kappale 4",
    week: 10,
    description: "Cảm nhận cách dùng Partitiivi đầy xúc cảm qua bản tình ca Phần Lan nổi tiếng.",
    content: `# 🎵 Immersion Âm nhạc: Minä rakastan sinua (Anh yêu em / Em yêu anh)

Bản tình ca bất hủ của Matti ja Teppo mang tựa đề chính là câu nói kinh điển của ngữ pháp Partitiivi:

> # 💖 Minä rakastan sinua!
> *(sinä -> sinua)*

| Lời tiếng Phần | Lời dịch tiếng Việt |
| :--- | :--- |
| *Minä rakastan sinua,* | *Anh yêu em,* |
| *enemmän kuin mitään muuta.* | *nhiều hơn bất kỳ điều gì khác trên đời.* |
| *Sinä olet minun elämä,* | *Em chính là cuộc sống của anh,* |
| *kaunis kuin kesäinen päivä.* | *đẹp rạng ngời như một ngày nắng mùa hè.* |`
  },
  {
    id: "w10_d7_tonghop_tuan10",
    title: "Tổng kết & Củng cố Tuần 10 (Kappale 4)",
    chapter: "Kappale 4",
    week: 10,
    description: "Ôn tập 3 quy tắc Partitiivi và cấu trúc Minulla on / Minulla ei ole.",
    content: `# 🏆 Tổng kết & Củng cố Tuần 10

* ✅ Thuộc làu 3 quy tắc chia đuôi Partitiivi (-a/-ä, -ta/-tä, -tta/-ttä).
* ✅ Ghi nhớ các động từ luôn đi với Partitiivi (*rakastaa, puhua, auttaa, odottaa*).
* ✅ Nắm vững cấu trúc khẳng định và phủ định sở hữu (*Minulla on auto* vs *Minulla ei ole autoa*).`
  },

  // TUẦN 11
  {
    id: "w11_d1_baitap_harjoitus19_27",
    title: "Bài tập thực hành: Harjoitus 19 - 27 (Trang 108-113)",
    chapter: "Kappale 4",
    week: 11,
    description: "Giải bài tập tổng hợp cấu trúc Minulla on và cách Partitiivi.",
    content: `# ✍️ Bài tập thực hành: Harjoitus 19 - 27 (Trang 108-113)

Tuần thứ 11 là tuần hoàn tất toàn bộ bài tập của Chương 4 và chuẩn bị bước sang Chương 5.`
  },
  {
    id: "w11_d3_khoidong_kappale5",
    title: "Khởi động Chương 5: Hội thoại Meidän tavallinen päivä (Trang 114-116)",
    chapter: "Kappale 5",
    week: 11,
    description: "Làm quen với một ngày sinh hoạt thường nhật của gia đình Phần Lan.",
    content: `# ⏰ Mở đầu Kappale 5: Meidän tavallinen päivä (Ngày bình thường của chúng tôi)

Hãy cùng Alex và Hanna bước vào nhịp sống thường nhật của một gia đình tại Helsinki:
* *Herään aamulla kello 7.00.* = Tôi thức dậy lúc 7 giờ sáng.
* *Keitän kahvia ja syön aamiaista.* = Tôi pha cà phê và ăn sáng.
* *Lähden töihin kello 8.00.* = Tôi đi làm lúc 8 giờ sáng.`
  },
  {
    id: "sign_k_plussa_s_etukortti",
    title: "Immersion Đời sống: Thẻ tích điểm S-Etukortti & K-Plussa",
    chapter: "Kappale 4",
    week: 11,
    description: "Văn hóa dùng thẻ thành viên siêu thị của mọi người dân Phần Lan.",
    content: `# 💳 Immersion Đời sống: S-ETUKORTTI & K-PLUSSA

Khi thanh toán tại bất kỳ quầy thu ngân siêu thị nào ở Phần Lan, câu hỏi đầu tiên của nhân viên luôn là:

> # ❓ "Onko S-etukorttia?" / "Onko Plussa-korttia?"
> *(Bạn có thẻ thành viên S-Group / K-Group không?)*

Người Phần Lan rất chuộng dùng thẻ này vì mỗi tháng họ được hoàn tiền mặt (**Bonus**) trực tiếp vào tài khoản ngân hàng lên đến 5% tổng chi tiêu mua sắm!`
  },
  {
    id: "w11_d6_kiemtra_tongket_kappale4",
    title: "Đề kiểm tra đánh giá năng lực toàn diện: Kappale 4 (Trang 112-113)",
    chapter: "Kappale 4",
    week: 11,
    description: "Đề kiểm tra chuẩn hóa tổng kết toàn diện kiến thức Chương 4.",
    content: `# 🎓 Đề kiểm tra năng lực toàn diện: Kappale 4

Kiểm tra 3 trụ cột:
1. Từ vựng Gia đình, Ngoại hình, Quần áo và Màu sắc.
2. Cách chia và ứng dụng bổ ngữ Partitiivi.
3. Cấu trúc sở hữu *Minulla on... / Minulla ei ole...*.

---

### ✍️ Bắt đầu làm bài kiểm tra tương tác
[exercise:ex_w11_d6_kiemtra_kappale4]`
  },
  {
    id: "w11_d7_tongket_kappale4",
    title: "Tổng kết Tháng thứ 3: Chạm mốc gần 50% chặng đường!",
    chapter: "Kappale 4",
    week: 11,
    description: "Khép lại 11 tuần học tập: Nắm chắc ngữ pháp nền tảng vững vàng.",
    content: `# 🏆 Chúc mừng bạn đã hoàn thành xuất sắc Chương 4!

Bạn đã hoàn thành **11 / 24 tuần (Gần 50% giáo trình Suomen Mestari 1)**!
Vốn từ vựng và ngữ pháp của bạn giờ đây đã đủ để:
* Giới thiệu đầy đủ về bản thân, nghề nghiệp, gia đình và ngoại hình.
* Sử dụng thành thạo cách Partitiivi và cấu trúc sở hữu.

Tuần tới, chúng ta bước sang **Chương 5 (Tuần 12 - 14): Sinh hoạt thường ngày, Xem giờ đồng hồ và Toàn bộ 5 Nhóm động từ (Verbityypit 1 - 5)**!`
  }
];

// ==========================================
// 3. CURRICULUM WEEKS 9, 10, 11
// ==========================================
const week09 = {
  id: "week_09",
  planId: "6iWorOc6mZtnINIFBH8a",
  weekNumber: 9,
  title: "Tháng 3 - Tuần 9: Khởi động Chương 4: Bản thân, Gia đình & Quần áo",
  description: "Bắt đầu Chương 4 (Kappale 4): Hội thoại Minä (Trang 86-88), Cây phả hệ Gia đình Perhe (Trang 89-91), Quần áo Vaatteet & Màu sắc Värit (Trang 92-94), Cửa hàng thời trang mùa đông Phần Lan.",
  chapter: "Kappale 4",
  bookPages: "86-94, 100-102",
  days: [
    {
      dayIndex: 1,
      dayName: "Thứ 2",
      actions: [
        {
          id: "w9_d1_act1",
          type: "lesson_full",
          title: "Kappale 4: Hội thoại Minä - Giới thiệu bản thân & Ngoại hình (Trang 86-88)",
          goal: "Học cách miêu tả chiều cao, vóc dáng, màu tóc, màu mắt.",
          estimatedMinutes: 25,
          targetRefId: "w9_d1_thoai_mina",
          steps: [
            { stepNumber: 1, instruction: "Đọc bài giới thiệu của Alex và Pedro." },
            { stepNumber: 2, instruction: "Làm bài tập tương tác miêu tả ngoại hình." }
          ]
        }
      ]
    },
    {
      dayIndex: 2,
      dayName: "Thứ 3",
      actions: [
        {
          id: "w9_d2_act1",
          type: "vocabulary_set",
          title: "Từ vựng: Cây phả hệ Gia đình (Perhe) (Trang 89-91)",
          goal: "Nắm vững danh xưng bố mẹ, con cái, anh chị em, ông bà.",
          estimatedMinutes: 20,
          targetRefId: "w9_d2_tuvung_perhe",
          steps: [
            { stepNumber: 1, instruction: "Học bảng phả hệ gia đình." },
            { stepNumber: 2, instruction: "Làm bài tập trắc nghiệm gia đình." }
          ]
        }
      ]
    },
    {
      dayIndex: 3,
      dayName: "Thứ 4",
      actions: [
        {
          id: "w9_d3_act1",
          type: "vocabulary_set",
          title: "Từ vựng: Quần áo (Vaatteet) & Màu sắc (Värit) (Trang 92-94)",
          goal: "Thuộc 10 màu sắc và tên các trang phục mùa đông.",
          estimatedMinutes: 20,
          targetRefId: "w9_d3_tuvung_vaatteet_varit",
          steps: [
            { stepNumber: 1, instruction: "Học bảng màu sắc và quần áo thường ngày." }
          ]
        },
        {
          id: "w9_d3_act2",
          type: "immersion_sign",
          title: "Immersion Biển hiệu: Cửa hàng thời trang & Bảng size Phần Lan",
          goal: "Biết cách mua sắm quần áo ấm tại Phần Lan.",
          estimatedMinutes: 10,
          targetRefId: "sign_vaatekauppa_hm",
          steps: [
            { stepNumber: 1, instruction: "Đọc cẩm nang mua sắm quần áo mùa đông." }
          ]
        }
      ]
    },
    {
      dayIndex: 4,
      dayName: "Thứ 5",
      actions: [
        {
          id: "w9_d4_act1",
          type: "exercise_set",
          title: "Bài tập thực hành: Harjoitus 1 - 8 Chương 4 (Trang 100-102)",
          goal: "Làm bài tập từ vựng gia đình và màu sắc.",
          estimatedMinutes: 25,
          targetRefId: "w9_d1_thoai_mina",
          steps: [
            { stepNumber: 1, instruction: "Thực hành giải các bài tập trong sách." }
          ]
        }
      ]
    },
    {
      dayIndex: 5,
      dayName: "Thứ 6",
      actions: [
        {
          id: "w9_d5_act1",
          type: "lesson_slice",
          title: "Thực hành: Viết 5 câu giới thiệu bản thân và người thân",
          goal: "Tự viết đoạn văn ngắn về gia đình mình.",
          estimatedMinutes: 20,
          targetRefId: "w9_d1_thoai_mina",
          steps: [
            { stepNumber: 1, instruction: "Tập viết các câu miêu tả tên, tuổi, ngoại hình." }
          ]
        }
      ]
    },
    {
      dayIndex: 6,
      dayName: "Thứ 7",
      actions: [
        {
          id: "w9_d6_act1",
          type: "custom",
          title: "Tổng kết & Củng cố Tuần 9 (Kappale 4)",
          goal: "Ôn tập toàn bộ kiến thức tuần 9.",
          estimatedMinutes: 15,
          targetRefId: "w9_d7_tonghop_tuan9",
          steps: [
            { stepNumber: 1, instruction: "Đọc tóm tắt tuần 9." }
          ]
        }
      ]
    },
    {
      dayIndex: 7,
      dayName: "Chủ Nhật",
      actions: [
        {
          id: "w9_d7_act1",
          type: "custom",
          title: "Nghỉ ngơi nạp năng lượng (Ota rennosti)",
          goal: "Thư giãn cuối tuần.",
          estimatedMinutes: 15,
          targetRefId: "w9_d7_tonghop_tuan9",
          steps: [
            { stepNumber: 1, instruction: "Nghỉ ngơi thư giãn." }
          ]
        }
      ]
    }
  ]
};

const week10 = {
  id: "week_10",
  planId: "6iWorOc6mZtnINIFBH8a",
  weekNumber: 10,
  title: "Tháng 3 - Tuần 10: Ngữ pháp Cách Partitiivi & Cấu trúc Minulla on",
  description: "Trọng tâm ngữ pháp Chương 4: 3 Quy tắc cốt lõi của Cách Partitiivi, Các động từ Partitiiviverbit, Cấu trúc sở hữu Minulla on... / Minulla ei ole... + Partitiivi, và Bài hát Minä rakastan sinua.",
  chapter: "Kappale 4",
  bookPages: "95-99, 103-107",
  days: [
    {
      dayIndex: 1,
      dayName: "Thứ 2",
      actions: [
        {
          id: "w10_d1_act1",
          type: "grammar_point",
          title: "Ngữ pháp: Cách bổ ngữ Partitiivi (Trang 95-96)",
          goal: "Nắm vững 3 quy tắc chia đuôi Partitiivi số ít (-a/-ä, -ta/-tä, -tta/-ttä).",
          estimatedMinutes: 30,
          targetRefId: "w10_d1_nguphap_partitiivi",
          steps: [
            { stepNumber: 1, instruction: "Học 3 quy tắc biến đổi đuôi Partitiivi." },
            { stepNumber: 2, instruction: "Làm bài tập tương tác chia đuôi danh từ." }
          ]
        }
      ]
    },
    {
      dayIndex: 2,
      dayName: "Thứ 3",
      actions: [
        {
          id: "w10_d2_act1",
          type: "grammar_point",
          title: "Ngữ pháp: Các Động từ bắt buộc đi với Partitiivi (Trang 96)",
          goal: "Ghi nhớ các động từ rakastaa, puhua, auttaa, odottaa, ymmärtää.",
          estimatedMinutes: 20,
          targetRefId: "w10_d2_dongtu_partitiivi",
          steps: [
            { stepNumber: 1, instruction: "Học danh sách các động từ Partitiiviverbit." }
          ]
        }
      ]
    },
    {
      dayIndex: 3,
      dayName: "Thứ 4",
      actions: [
        {
          id: "w10_d3_act1",
          type: "grammar_point",
          title: "Ngữ pháp: Cấu trúc sở hữu Minulla on... / Minulla ei ole... (Trang 97-98)",
          goal: "Thành thạo nói về những thứ mình có và không có.",
          estimatedMinutes: 25,
          targetRefId: "w10_d3_nguphap_minulla_on",
          steps: [
            { stepNumber: 1, instruction: "Học bảng đại từ Minulla, Sinulla, Hänellä, Meillä, Teillä, Heillä." },
            { stepNumber: 2, instruction: "Ghi nhớ: Trong câu phủ định 'ei ole', vật sở hữu luôn ở Partitiivi!" },
            { stepNumber: 3, instruction: "Làm bài tập tương tác sở hữu." }
          ]
        }
      ]
    },
    {
      dayIndex: 4,
      dayName: "Thứ 5",
      actions: [
        {
          id: "w10_d4_act1",
          type: "exercise_set",
          title: "Bài tập thực hành: Harjoitus 9 - 18 Chương 4 (Trang 103-107)",
          goal: "Rèn luyện chia đuôi Partitiivi trong câu hoàn chỉnh.",
          estimatedMinutes: 25,
          targetRefId: "w10_d1_nguphap_partitiivi",
          steps: [
            { stepNumber: 1, instruction: "Làm bài tập điền đuôi Partitiivi." }
          ]
        }
      ]
    },
    {
      dayIndex: 5,
      dayName: "Thứ 6",
      actions: [
        {
          id: "w10_d5_act1",
          type: "immersion_music",
          title: "Immersion Âm nhạc: Bài hát Minä rakastan sinua",
          goal: "Thư giãn nghe nhạc và cảm nhận vẻ đẹp của Partitiivi.",
          estimatedMinutes: 15,
          targetRefId: "song_mina_rakastan_sinua",
          steps: [
            { stepNumber: 1, instruction: "Nghe bài hát và đọc lời dịch song ngữ." }
          ]
        }
      ]
    },
    {
      dayIndex: 6,
      dayName: "Thứ 7",
      actions: [
        {
          id: "w10_d6_act1",
          type: "custom",
          title: "Tổng kết & Củng cố Tuần 10 (Kappale 4)",
          goal: "Ôn tập Partitiivi và cấu trúc sở hữu.",
          estimatedMinutes: 15,
          targetRefId: "w10_d7_tonghop_tuan10",
          steps: [
            { stepNumber: 1, instruction: "Đọc tóm tắt tuần 10." }
          ]
        }
      ]
    },
    {
      dayIndex: 7,
      dayName: "Chủ Nhật",
      actions: [
        {
          id: "w10_d7_act1",
          type: "custom",
          title: "Nghỉ ngơi thư giãn (Ota rennosti)",
          goal: "Nạp năng lượng cho tuần hoàn tất Chương 4.",
          estimatedMinutes: 15,
          targetRefId: "w10_d7_tonghop_tuan10",
          steps: [
            { stepNumber: 1, instruction: "Nghỉ ngơi cuối tuần." }
          ]
        }
      ]
    }
  ]
};

const week11 = {
  id: "week_11",
  planId: "6iWorOc6mZtnINIFBH8a",
  weekNumber: 11,
  title: "Tháng 3 - Tuần 11: Hoàn thiện Chương 4 & Khởi động Chương 5",
  description: "Hoàn thiện 100% bài tập Chương 4 (Harjoitus 19 - 27), Đọc hiểu văn bản dài, Khởi động Chương 5 (Meidän tavallinen päivä), Thẻ thành viên siêu thị Phần Lan S-Etukortti & K-Plussa, và Đề kiểm tra đánh giá năng lực Kappale 4 (Gần 50% chặng đường).",
  chapter: "Kappale 4",
  bookPages: "108-116",
  days: [
    {
      dayIndex: 1,
      dayName: "Thứ 2",
      actions: [
        {
          id: "w11_d1_act1",
          type: "exercise_set",
          title: "Bài tập thực hành: Harjoitus 19 - 27 (Trang 108-113)",
          goal: "Giải quyết toàn bộ bài tập còn lại của Chương 4.",
          estimatedMinutes: 25,
          targetRefId: "w11_d1_baitap_harjoitus19_27",
          steps: [
            { stepNumber: 1, instruction: "Làm bài tập tổng hợp cấu trúc Minulla on và Partitiivi." }
          ]
        }
      ]
    },
    {
      dayIndex: 2,
      dayName: "Thứ 3",
      actions: [
        {
          id: "w11_d2_act1",
          type: "lesson_slice",
          title: "Khởi động Chương 5: Hội thoại Meidän tavallinen päivä (Trang 114-116)",
          goal: "Làm quen với các mốc thời gian và hoạt động sinh hoạt trong ngày.",
          estimatedMinutes: 20,
          targetRefId: "w11_d3_khoidong_kappale5",
          steps: [
            { stepNumber: 1, instruction: "Đọc hội thoại về lịch trình một ngày của gia đình Phần Lan." }
          ]
        }
      ]
    },
    {
      dayIndex: 3,
      dayName: "Thứ 4",
      actions: [
        {
          id: "w11_d3_act1",
          type: "immersion_sign",
          title: "Immersion Đời sống: Thẻ tích điểm S-Etukortti & K-Plussa",
          goal: "Hiểu nét văn hóa tích điểm tiêu dùng của người Phần.",
          estimatedMinutes: 15,
          targetRefId: "sign_k_plussa_s_etukortti",
          steps: [
            { stepNumber: 1, instruction: "Đọc cẩm nang về thẻ S-Etukortti và K-Plussa." }
          ]
        }
      ]
    },
    {
      dayIndex: 4,
      dayName: "Thứ 5",
      actions: [
        {
          id: "w11_d4_act1",
          type: "exercise_set",
          title: "Thực hành viết đoạn văn: Gia đình và bạn bè tôi",
          goal: "Ứng dụng tổng hợp từ vựng và ngữ pháp Chương 4 vào bài viết thực tế.",
          estimatedMinutes: 25,
          targetRefId: "w11_d1_baitap_harjoitus19_27",
          steps: [
            { stepNumber: 1, instruction: "Viết đoạn văn 6 câu tự giới thiệu gia đình bằng tiếng Phần." }
          ]
        }
      ]
    },
    {
      dayIndex: 5,
      dayName: "Thứ 6",
      actions: [
        {
          id: "w11_d5_act1",
          type: "lesson_full",
          title: "Đề kiểm tra đánh giá năng lực toàn diện: Kappale 4 (Trang 112-113)",
          goal: "Đánh giá toàn diện 4 kỹ năng trước khi sang Chương 5.",
          estimatedMinutes: 30,
          targetRefId: "w11_d6_kiemtra_tongket_kappale4",
          steps: [
            { stepNumber: 1, instruction: "Làm bài kiểm tra tương tác tổng kết Chương 4." }
          ]
        }
      ]
    },
    {
      dayIndex: 6,
      dayName: "Thứ 7",
      actions: [
        {
          id: "w11_d6_act1",
          type: "custom",
          title: "Tổng kết Tháng thứ 3: Chạm mốc gần 50% chặng đường!",
          goal: "Tự hào nhìn lại chặng đường 11 tuần đã chinh phục.",
          estimatedMinutes: 15,
          targetRefId: "w11_d7_tongket_kappale4",
          steps: [
            { stepNumber: 1, instruction: "Đọc bản tổng kết và tự thưởng cho mình một buổi tối thư giãn!" }
          ]
        }
      ]
    },
    {
      dayIndex: 7,
      dayName: "Chủ Nhật",
      actions: [
        {
          id: "w11_d7_act1",
          type: "custom",
          title: "Nghỉ ngơi thư giãn (Ota rennosti)",
          goal: "Chuẩn bị bước sang Chương 5: Sinh hoạt & 5 Nhóm động từ.",
          estimatedMinutes: 15,
          targetRefId: "w11_d7_tonghop_tuan11",
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
async function buildAndSyncPhase4() {
  console.log('🚀 === GENERATING AND SYNCING PHASE 4 (WEEKS 9, 10, 11 - CHAPTER 4) ===\n');

  const currDir = path.resolve(__dirname, '../../content/curriculum');
  const lessDir = path.resolve(__dirname, '../../content/lessons');

  // Save local files
  fs.writeFileSync(path.join(currDir, 'chapter_04_exercises.json'), JSON.stringify({ exercises }, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/chapter_04_exercises.json');

  fs.writeFileSync(path.join(lessDir, 'chapter_04_lessons.json'), JSON.stringify({ lessons }, null, 2), 'utf8');
  console.log('✅ Generated content/lessons/chapter_04_lessons.json');

  fs.writeFileSync(path.join(currDir, 'week_09.json'), JSON.stringify(week09, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/week_09.json');

  fs.writeFileSync(path.join(currDir, 'week_10.json'), JSON.stringify(week10, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/week_10.json');

  fs.writeFileSync(path.join(currDir, 'week_11.json'), JSON.stringify(week11, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/week_11.json');

  // Sync Exercises to Firestore
  console.log('\n📝 1. Synchronizing Phase 4 Interactive Exercises into Firestore `exercises`...');
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
  console.log('\n📚 2. Synchronizing Phase 4 Rich Interactive Lessons into Firestore `lessons`...');
  for (const rawLesson of lessons) {
    await db.collection('lessons').doc(rawLesson.id).set({
      id: rawLesson.id,
      title: rawLesson.title,
      chapter: rawLesson.chapter || 'Kappale 4',
      week: rawLesson.week || 9,
      description: rawLesson.description || '',
      audioUrls: [],
      content: rawLesson.content,
      updatedAt: admin.firestore.FieldValue.serverTimestamp()
    }, { merge: true });

    if (rawLesson.id.startsWith('sign_') || rawLesson.id.startsWith('song_') || rawLesson.id.startsWith('video_')) {
      await db.collection('immersion_resources').doc(rawLesson.id).set({
        id: rawLesson.id,
        title: rawLesson.title,
        chapter: rawLesson.chapter || 'Kappale 4',
        description: rawLesson.description || '',
        content: rawLesson.content,
        type: rawLesson.id.startsWith('sign_') ? 'sign' : (rawLesson.id.startsWith('song_') ? 'music' : 'video'),
        updatedAt: admin.firestore.FieldValue.serverTimestamp()
      }, { merge: true });
    }

    console.log(`   ✅ Synced Lesson: [${rawLesson.id}] ${rawLesson.title}`);
  }

  // Sync Weeks 9, 10, 11 to Firestore
  console.log('\n📅 3. Synchronizing Study Plan Weeks 9, 10, 11 into Firestore `study_plan_weeks`...');
  const planId = '6iWorOc6mZtnINIFBH8a';
  const week9DocId = 'v1jILeUCkuzi7fNaVhw7';
  const week10DocId = 'o7JKgEaWPtDsnF4XvbRH';
  const week11DocId = 'mvMpSWE4Ob0SoKx9A661';

  await db.collection('study_plan_weeks').doc(week9DocId).set({
    planId: planId,
    weekNumber: 9,
    title: week09.title,
    description: week09.description,
    days: week09.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Week 9 (doc: ${week9DocId})`);

  await db.collection('study_plan_weeks').doc(week10DocId).set({
    planId: planId,
    weekNumber: 10,
    title: week10.title,
    description: week10.description,
    days: week10.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Week 10 (doc: ${week10DocId})`);

  await db.collection('study_plan_weeks').doc(week11DocId).set({
    planId: planId,
    weekNumber: 11,
    title: week11.title,
    description: week11.description,
    days: week11.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Week 11 (doc: ${week11DocId})`);

  console.log('\n🎉 ALL PHASE 4 (WEEKS 9, 10, 11) CONTENT SYNCED SUCCESSFULLY TO FIRESTORE PRODUCTION!');
}

buildAndSyncPhase4().catch(err => {
  console.error('❌ Phase 4 Build & Sync failed:', err);
  process.exit(1);
});
