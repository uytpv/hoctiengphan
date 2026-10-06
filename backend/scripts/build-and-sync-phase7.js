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
// 1. EXERCISES (chapter_07_exercises.json)
// ==========================================
const exercises = [
  {
    id: "ex_w18_d1_matkustussanasto",
    title: "Từ vựng: Du lịch, Khách sạn & Đi lại trong thành phố",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Khi đặt phòng tại khách sạn Phần Lan, 'yhden hengen huone' và 'kahden hengen huone' có nghĩa là gì?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Phòng đơn (1 người) và phòng đôi (2 người)",
          "Phòng tầng 1 và phòng tầng 2",
          "Phòng có bếp và phòng không có bếp"
        ],
        correctIndex: 0,
        explanation: "henki = người; yhden hengen huone = phòng cho 1 người (phòng đơn); kahden hengen huone = phòng đôi."
      },
      {
        prompt: "Cụm từ nào dùng để hỏi 'Bữa sáng có bao gồm trong giá phòng không?'",
        type: "MULTIPLE_CHOICE",
        options: [
          "Kuuluuko aamiainen hintaan?",
          "Missä aamiainen on?",
          "Paljonko huone maksaa?"
        ],
        correctIndex: 0,
        explanation: "Kuulua hintaan = bao gồm trong giá; aamiainen = bữa sáng."
      }
    ]
  },
  {
    id: "ex_w18_d3_sanatyypit_i_e_nen",
    title: "Ngữ pháp: Các nhóm biến cách danh từ đuôi -i, -e, -nen",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Danh từ kết thúc bằng đuôi '-nen' (ví dụ: 'nainen', 'suomalainen') biến đổi thân từ như thế nào khi chia cách (ở đâu / cho ai)?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Đuôi '-nen' biến đổi thành '-se-' (nainen -> naisella, suomalainen -> suomalaiselle)",
          "Đuôi '-nen' biến đổi thành '-te-'",
          "Giữ nguyên đuôi '-nen' rồi thêm hậu tố"
        ],
        correctIndex: 0,
        explanation: "Quy tắc sanatyypit -nen: đuôi -nen luôn chuyển thành -se- trước mọi hậu tố cách (nainen -> naisessa, suomalainen -> suomalaisesta)."
      },
      {
        prompt: "Từ cổ gốc Phần Lan 'kieli' (ngôn ngữ / cái lưỡi) khi chia 'bằng tiếng Phần Lan' (kielellä) hay 'trong ngôn ngữ' (kielessä) có thân từ là gì?",
        type: "MULTIPLE_CHOICE",
        options: [
          "kiele- (nguyên âm -i đổi thành -e-)",
          "kieli- (giữ nguyên)",
          "kielu-"
        ],
        correctIndex: 0,
        explanation: "Từ cổ gốc Phần Lan có tận cùng bằng -i đổi thành -e- khi gắn đuôi biến cách: kieli -> kiele-, nimi -> nime-, mäki -> mäe-."
      },
      {
        prompt: "Danh từ kết thúc bằng nguyên âm '-e' (ví dụ: 'huone', 'kirje', 'vaate') khi chia cách sẽ:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Nhân đôi nguyên âm -e thành '-ee-' (huoneessa, kirjeessä, vaatteessa)",
          "Bỏ nguyên âm -e đi",
          "Thêm phụ âm -s vào giữa"
        ],
        correctIndex: 0,
        explanation: "Quy tắc từ tận cùng bằng -e: thân từ luôn có -ee- kéo dài: huone -> huonee- -> huoneessa."
      }
    ]
  },
  {
    id: "ex_w19_d2_imperatiivi_monikko",
    title: "Ngữ pháp: Thể Mệnh lệnh Số ít và Số nhiều / Lịch sự",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Khi nói lịch sự hoặc ra lệnh cho nhiều người 'Xin mời vào!' (động từ 'tulla'), ta dùng hình thức nào?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Tulkaa sisään!",
          "Tule sisään!",
          "Tuletko sisään?"
        ],
        correctIndex: 0,
        explanation: "Thể mệnh lệnh số nhiều/lịch sự của tulla là 'Tulkaa!'. Số ít thân mật là 'Tule!'."
      },
      {
        prompt: "Dạng phủ định mệnh lệnh số nhiều 'Xin quý vị đừng hút thuốc ở đây!' (tupakoida) là:",
        type: "MULTIPLE_CHOICE",
        options: [
          "Älkää tupakoiko täällä!",
          "Älä tupakoi täällä!",
          "Ei tupakoi täällä!"
        ],
        correctIndex: 0,
        explanation: "Phủ định mệnh lệnh số nhiều dùng 'Älkää' + động từ ở dạng thân kết thúc bằng -ko/-kö: Älkää tupakoiko!"
      }
    ]
  },
  {
    id: "ex_w19_d5_kiemtra_kappale7",
    title: "Đề kiểm tra đánh giá năng lực toàn diện Chương 7",
    type: "MULTIPLE_CHOICE",
    questions: [
      {
        prompt: "Chọn câu viết đúng ngữ pháp biến cách nhóm từ: 'Tôi sống trong căn phòng mới của người phụ nữ Phần Lan':",
        type: "MULTIPLE_CHOICE",
        options: [
          "Asun suomalaisen naisen uudessa huoneessa.",
          "Asun suomalainen nainen uusi huone.",
          "Asun suomalaisessa naisessa huoneesta."
        ],
        correctIndex: 0,
        explanation: "suomalainen -> suomalaisen (sở hữu genetiivi), nainen -> naisen, uusi -> uudessa (tính từ chia cách theo danh từ huone -> huoneessa)."
      },
      {
        prompt: "'Kirpputori' (chợ trời Phần Lan) thường hoạt động theo mô hình nào đặc trưng?",
        type: "MULTIPLE_CHOICE",
        options: [
          "Người bán thuê bàn / ô kệ (itsepalvelukirpputori), dán mã giá và thu tiền tại quầy thu ngân chung",
          "Chỉ bán đồ điện tử mới",
          "Chỉ mở cửa vào ban đêm"
        ],
        correctIndex: 0,
        explanation: "Itsepalvelukirpputori là mô hình chợ trời tự phục vụ vô cùng đặc sắc của Phần Lan: người bán dán mã vạch lên từng món và hệ thống quầy thanh toán tự động gom tiền."
      }
    ]
  }
];

// ==========================================
// 2. LESSONS (chapter_07_lessons.json)
// ==========================================
const lessons = [
  // --- TUẦN 18 ---
  {
    id: "w18_d1_tuvung_matkustaminen_hotelli",
    title: "Kappale 7: Du lịch & Đặt phòng khách sạn (Trang 184-188)",
    chapter: "Kappale 7",
    week: 18,
    description: "Mở đầu Chương 7: Từ vựng du lịch, đặt khách sạn và đối thoại thực tế khi nhận phòng tại Phần Lan.",
    content: `# Kappale 7: Matkustaminen ja loma (Du lịch và Kỳ nghỉ)

Chào mừng bạn đến với **Chương 7 (Kappale 7)** của giáo trình *Suomen Mestari 1*! Đây là chương học mở ra khả năng giao tiếp du lịch, đặt khách sạn, khám phá đời sống thành phố và mua sắm thực tế.

---

## 1. Hội thoại mẫu: Pedro đặt phòng tại khách sạn (Hotellissa)

> **Pedro**: Hyvää päivää! Minulla on huonevaraus nimellä Pedro Gomez.  
> **Virkailija (Nhân viên lễ tân)**: Päivää! Hetkinen, tarkistan... Kyllä, yhden hengen huone kahdeksi yöksi.  
> **Pedro**: Juuri niin. Kuuluuko aamiainen hintaan?  
> **Virkailija**: Kyllä, aamiainen on arkisin kello 7-10 ja viikonloppuna 8-11 ravintolassa pohjakerroksessa.  
> **Pedro**: Entä sauna? Onko täällä asiakassauna?  
> **Virkailija**: On, sauna on lämmin joka ilta kello 18-21. Tässä on avainkorttinne, huone 412, neljäs kerros. Hissi on tuolla oikealla.  
> **Pedro**: Kiitos paljon!  
> **Virkailija**: Olkaa hyvä ja mukavaa lomaa!

---

## 2. Từ vựng cốt lõi về Khách sạn & Du lịch (Hotellisanasto)

| Từ tiếng Phần | Phiên âm / Loại từ | Nghĩa tiếng Việt |
| :--- | :--- | :--- |
| **matkustaa** | Động từ nhóm 1 | du lịch, đi lại |
| **loma** | Danh từ | kỳ nghỉ, ngày phép |
| **varata** | Động từ nhóm 4 | đặt trước (reserve, book) |
| **huonevaraus** | Danh từ ghép | sự đặt phòng khách sạn |
| **yhden hengen huone** | Cụm danh từ | phòng đơn (1 người) |
| **kahden hengen huone** | Cụm danh từ | phòng đôi (2 người) |
| **aamiainen** | Danh từ (nhóm -nen) | bữa sáng |
| **avain / avainkortti** | Danh từ | chìa khóa / thẻ từ mở phòng |
| **kerros** | Danh từ | tầng lầu |
| **hissi** | Danh từ | thang máy |
| **asiakas** | Danh từ | khách hàng, quý khách |
| **kuulua hintaan** | Cụm động từ | bao gồm trong giá tiền |

---

## 3. Luyện tập tương tác ngay

[exercise:ex_w18_d1_matkustussanasto]`
  },
  {
    id: "w18_d2_tuvung_kaupungilla_palvelut",
    title: "Từ vựng: Địa điểm & Tiện ích trong Đô thị (Trang 189-191)",
    chapter: "Kappale 7",
    week: 18,
    description: "Nắm vững tên gọi các địa điểm hành chính, dịch vụ công cộng và văn hóa giải trí trong thành phố.",
    content: `# Kaupungilla: Paikat ja palvelut (Trong thành phố: Địa điểm & Tiện ích)

Khi sống hoặc du lịch tại Phần Lan, bạn sẽ thường xuyên cần tìm kiếm các địa điểm công cộng tiện ích.

---

## 1. Bảng từ vựng các địa điểm công cộng đô thị

| Tiếng Phần Lan | Nghĩa tiếng Việt | Ví dụ thực tế |
| :--- | :--- | :--- |
| **rautatieasema** | ga xe lửa trung tâm | Helsingin päärautatieasema |
| **bussipysäkki** | trạm dừng xe buýt | Missä on lähin pysäkki? |
| **kirjasto** | thư viện công cộng | Oodi-kirjasto on upea! |
| **museo** | bảo tàng | Ateneumin taidemuseo |
| **posti** | bưu điện | Paketti on postissa. |
| **pankki** | ngân hàng | Pankkiautomaatti (Otto) |
| **apteekki** | hiệu thuốc tây | Yliopiston Apteekki |
| **tori / kauppatori** | quảng trường chợ trời ven cảng | Ostamme mansikoita torilta. |
| **kirpputori (kirppis)** | chợ đồ cũ, chợ trời | Löysin takin kirpputorilta! |
| **kirkko / tuomiokirkko** | nhà thờ / nhà thờ chính tòa | Helsingin tuomiokirkko |
| **satama** | bến cảng, cảng biển | Laiva lähtee satamasta. |

---

## 2. Mẫu câu hỏi địa điểm thường gặp

1. **Anteeksi, missä on lähin apteekki?** (Xin lỗi, hiệu thuốc gần nhất ở đâu?)
2. **Miten pääsen rautatieasemalle?** (Làm thế nào tôi đến được ga tàu hỏa?)
3. **Onko täällä lähellä pankkiautomaattia?** (Ở gần đây có cây rút tiền ATM nào không?)`
  },
  {
    id: "w18_d3_nguphap_sanatyypit_i_e_nen",
    title: "Ngữ pháp: Ba nhóm Biến cách Danh từ Đặc biệt: -i, -e, -nen (Trang 192-194)",
    chapter: "Kappale 7",
    week: 18,
    description: "Phân loại quy luật biến cách khoa học cho danh từ kết thúc bằng đuôi -i, -e và -nen.",
    content: `# Ngữ pháp: Sanatyypit (-i, -e, -nen)

Trong tiếng Phần Lan, hình thức nguyên mẫu (Nominatiivi) của danh từ quyết định cách biến đổi thân từ khi gắn hậu tố cách. Chương 7 hệ thống hóa **3 nhóm từ cực kỳ quan trọng**:

---

## Nhóm 1: Từ kết thúc bằng '-i' (Sanat, jotka päättyvät -i)

Có sự phân biệt rõ ràng giữa **Từ mới vay mượn** và **Từ cổ gốc Phần Lan**:

### A. Từ mới vay mượn quốc tế: Giữ nguyên '-i'
- **pankki** ➔ pankissa (trong ngân hàng)
- **turisti** ➔ turistille (cho khách du lịch)
- **baari** ➔ baarissa (trong quán bar)
- **posti** ➔ postista (từ bưu điện)

### B. Từ cổ gốc Phần Lan: Đổi '-i' thành '-e-'
- **kieli** (ngôn ngữ) ➔ **kiele-** ➔ kielessä, kielellä
- **nimi** (tên) ➔ **nime-** ➔ nimessä, nimeni
- **lehti** (tờ báo/lá cây) ➔ **lehde-** ➔ lehdessä (kèm KPT: ht -> hd)
- **mäki** (ngọn đồi) ➔ **mäe-** ➔ mäellä (kèm KPT: k -> mất)

---

## Nhóm 2: Từ kết thúc bằng '-e' (Sanat, jotka päättyvät -e)

Quy tắc bất biến: **Nguyên âm -e nhân đôi thành '-ee-' trong thân từ!**
*(Lưu ý: Nguyên mẫu ở cấp độ YẾU, khi thêm -ee- thân từ chuyển sang cấp độ MẠNH).*

- **huone** (căn phòng) ➔ **huonee-** ➔ huoneessa, huoneesta, huoneeseen
- **perhe** (gia đình) ➔ **perhee-** ➔ perheessä, perheelle
- **kirje** (bức thư) ➔ **kirjee-** ➔ kirjeessä
- **vaate** (quần áo - KPT t -> tt) ➔ **vaattee-** ➔ vaatteessa

---

## Nhóm 3: Từ kết thúc bằng '-nen' (Sanat, jotka päättyvät -nen)

Quy tắc vàng: **Đuôi '-nen' biến đổi hoàn toàn thành '-se-'!**

- **nainen** (phụ nữ) ➔ **naise-** ➔ naisella, naiselle, naisessa
- **suomalainen** (người Phần Lan) ➔ **suomalaise-** ➔ suomalaiselle
- **ihminen** (con người) ➔ **ihmise-** ➔ ihmiset (những con người)
- **punainen** (màu đỏ) ➔ **punaise-** ➔ punaisessa talossa

---

## Luyện tập củng cố tương tác

[exercise:ex_w18_d3_sanatyypit_i_e_nen]`
  },
  {
    id: "sign_kirpputori_kierratyskeskus",
    title: "Immersion Đời sống: Văn hóa Chợ Trời Kirpputori & Kierrätyskeskus",
    chapter: "Kappale 7",
    week: 18,
    description: "Khám phá nét văn hóa độc đáo bền vững của người Phần Lan qua việc mua sắm đồ cũ.",
    content: `# Immersion Đời sống Phần Lan: Kirpputori ja Kierto-talous

Ở Phần Lan, đi **kirpputori (chợ đồ cũ / kirppis)** là một thói quen văn hóa được yêu thích ở mọi tầng lớp xã hội, từ sinh viên, nhân viên văn phòng cho đến các chuyên gia kinh tế.

---

## 1. Mô hình 'Itsepalvelukirpputori' (Chợ trời tự phục vụ)

Khác với chợ trời truyền thống ở nhiều nước:
- Người muốn thanh lý đồ đạc thuê một gian kệ (pöytä / loosi) trong 1-2 tuần.
- Tự định giá và dán tem nhãn có mã vạch riêng của mình lên từng sản phẩm.
- Người mua vào chọn đồ, sau đó thanh toán tất cả tại quầy thu ngân trung tâm bằng thẻ ngân hàng. Tiền bán được hệ thống chuyển khoản trực tiếp cho chủ sạp.

---

## 2. Các thuật ngữ mua sắm đồ cũ cần biết

| Tiếng Phần | Ý nghĩa đời sống |
| :--- | :--- |
| **Uudenveroinen** | Gần như mới tinh (like new) |
| **Käytetty** | Đã qua sử dụng (second-hand) |
| **Koko (S / M / L / XL)** | Kích cỡ trang phục |
| **Sovituskoppi** | Phòng thử đồ |
| **Ei vaihto- tai palautusoikeutta** | Hàng miễn đổi trả |
| **Kelpaako kortti?** | Có quẹt thẻ được không? |

---

## 3. Trung tâm tái chế công cộng Kierrätyskeskus

Kierrätyskeskus là tổ chức phi lợi nhuận lớn chuyên nhận quyên góp và bán lại đồ nội thất, quần áo, sách vở, xe đạp và đồ điện tử đã qua kiểm định an toàn kỹ thuật với giá rất rẻ.`
  },
  {
    id: "w18_d7_tonghop_tuan18",
    title: "Tổng kết & Củng cố Tuần 18 (Kappale 7)",
    chapter: "Kappale 7",
    week: 18,
    description: "Hệ thống hóa toàn bộ kiến thức tuần 18: Từ vựng khách sạn, thành phố và quy luật biến cách -i, -e, -nen.",
    content: `# Tổng kết & Củng cố Tuần 18

Chúc mừng bạn đã hoàn thành tuần học đầu tiên của Chương 7!

---

## Tóm tắt nội dung trọng tâm

1. **Khách sạn**: Đặt phòng, nhận phòng, hỏi tiện ích (aamiainen, sauna, hissi, avainkortti).
2. **Thành phố**: Tìm kiếm địa điểm công cộng (asema, kirjasto, apteekki, tori, kirpputori).
3. **Quy tắc biến cách 3 nhóm danh từ**:
   - Từ vay mượn đuôi \`-i\` giữ nguyên, từ cổ \`-i\` chuyển thành \`-e-\`.
   - Danh từ đuôi \`-e\` nhân đôi thành \`-ee-\`.
   - Danh từ đuôi \`-nen\` chuyển thành \`-se-\`.`
  },

  // --- TUẦN 19 ---
  {
    id: "w19_d1_nguphap_imperatiivi_yksikko_monikko",
    title: "Ngữ pháp: Thể Mệnh lệnh Số ít & Số nhiều / Lịch sự (Trang 195-197)",
    chapter: "Kappale 7",
    week: 19,
    description: "Cách cấu tạo câu mệnh lệnh, yêu cầu hướng dẫn và lời mời lịch sự trong tiếng Phần Lan.",
    content: `# Ngữ pháp: Thể Mệnh lệnh (Imperatiivi)

Thể mệnh lệnh dùng để đưa ra hướng dẫn, chỉ đường, yêu cầu hoặc lời mời.

---

## 1. Mệnh lệnh số ít thân mật (Yksikön imperatiivi)

Được tạo thành bằng cách lấy **thân từ minä và bỏ đuôi -n**:

| Động từ nguyên mẫu | Ngôi minä | Mệnh lệnh khẳng định | Mệnh lệnh phủ định (Älä + ...) |
| :--- | :--- | :--- | :--- |
| **ottaa** (lấy, nhận) | ota**n** | **Ota!** | **Älä ota!** |
| **mennä** (đi) | mene**n** | **Mene!** | **Älä mene!** |
| **tulla** (đến) | tule**n** | **Tule!** | **Älä tule!** |
| **avata** (mở) | avaa**n** | **Avaa!** | **Älä avaa!** |

---

## 2. Mệnh lệnh số nhiều & Lịch sự trang trọng (Monikon imperatiivi)

Dùng khi nói với nhiều người hoặc thể hiện sự trang trọng, lịch thiệp (kính cẩn) với khách hàng, người lớn tuổi.  
Quy tắc: Lấy thân nguyên mẫu (infinitive stem) + **-kaa / -kää**:

| Động từ nguyên mẫu | Mệnh lệnh khẳng định (quý vị/các bạn) | Mệnh lệnh phủ định (Älkää + ...-ko/-kö) |
| :--- | :--- | :--- |
| **ottaa** | **Ottakaa!** | **Älkää ottako!** |
| **tulla** | **Tulkaa!** | **Älkää tulko!** |
| **mennä** | **Menkää!** | **Älkää menkö!** |
| **odottaa** | **Odottakaa!** | **Älkää odottako!** |
| **istua** | **Istukaa!** | **Älkää istuko!** |

> **Ví dụ giao tiếp lịch sự**:
> - *Olkaa hyvä ja istukaa!* (Xin mời quý vị ngồi!)
> - *Ottakaa kuitti, olkaa hyvä!* (Xin mời quý khách lấy biên lai hóa đơn!)

---

## Luyện tập tương tác ngay

[exercise:ex_w19_d2_imperatiivi_monikko]`
  },
  {
    id: "sign_hotelli_varaus",
    title: "Immersion Thực tế: Biển báo & Hướng dẫn trong Khách sạn Phần Lan",
    chapter: "Kappale 7",
    week: 19,
    description: "Đọc hiểu bảng chỉ dẫn khách sạn: Giờ ăn sáng, hướng dẫn dùng phòng tắm hơi Sauna và nội quy phòng.",
    content: `# Immersion Đời sống: Hướng dẫn & Biển báo Khách sạn

Khi lưu trú tại khách sạn Phần Lan, bạn sẽ bắt gặp các biển báo và tờ hướng dẫn tiêu chuẩn sau:

---

## 1. Biển báo giờ giấc & Dịch vụ

- **Aamiainen (Bữa sáng)**:  
  *Ma–Pe 06:30–09:30 | La–Su 07:30–10:30*
- **Huoneiden luovutus (Check-out)**:  
  *Klo 12:00 mennessä (Trước 12 giờ trưa)*
- **Asiakassauna (Phòng xông hơi)**:  
  *Naiset (Phụ nữ): 17:00–19:00*  
  *Miehet (Nam giới): 19:15–21:15*
- **Tupakointi kielletty (Cấm hút thuốc)**:  
  *Kaikki huoneet ovat savuttomia. Sakko 200€.* (Tất cả các phòng đều không hút thuốc. Phạt 200€ nếu vi phạm).

---

## 2. Biển treo tay nắm cửa phòng (Ovikyltti)

- **Ei saa häiritä! / Älä häiritse!**: Xin đừng làm phiền!
- **Pyydämme siivoamaan huoneen**: Xin vui lòng dọn phòng giúp.`
  },
  {
    id: "w19_d4_baitap_harjoitus1_15",
    title: "Bài tập thực hành: Harjoitus 1 - 15 Chương 7 (Trang 198-204)",
    chapter: "Kappale 7",
    week: 19,
    description: "Luyện giải bài tập tổng hợp về biến cách danh từ và thể mệnh lệnh theo chuẩn sách Suomen Mestari 1.",
    content: `# Bài tập thực hành: Harjoitus Chương 7

Chào mừng bạn đến với buổi thực hành giải bài tập tổng hợp Chương 7.

---

## Harjoitus trọng tâm cần giải:

1. **Harjoitus 4 & 5 (Trang 200)**: Chia động từ ở thể Mệnh lệnh số ít và số nhiều (Imperatiivi).
2. **Harjoitus 8 & 9 (Trang 201)**: Biến cách danh từ đuôi \`-i\`, \`-e\`, \`-nen\` vào câu hoàn chỉnh.
3. **Harjoitus 12 (Trang 203)**: Điền giới từ vị trí và phương hướng du lịch trong thành phố.

Hãy vận dụng kiến thức lý thuyết đã học để hoàn thành tốt bài tập kiểm tra bên dưới!`
  },
  {
    id: "w19_d5_kiemtra_tongket_kappale7",
    title: "Đề kiểm tra đánh giá năng lực toàn diện: Kappale 7 (Trang 206-208)",
    chapter: "Kappale 7",
    week: 19,
    description: "Đánh giá mức độ thành thạo về từ vựng du lịch, quy tắc biến cách danh từ và thể mệnh lệnh.",
    content: `# Đề kiểm tra tổng kết Chương 7

Bài kiểm tra này đánh giá toàn diện năng lực tiếp thu kiến thức Chương 7 (Kappale 7) theo chuẩn A1.2.

---

## Thực hiện bài kiểm tra tương tác:

[exercise:ex_w19_d5_kiemtra_kappale7]`
  },
  {
    id: "w19_d7_tongket_kappale7",
    title: "Tổng kết Hoàn thành Chương 7: Chinh phục mốc 79.2%!",
    chapter: "Kappale 7",
    week: 19,
    description: "Chúc mừng bạn đã hoàn thành xuất sắc 19 tuần học! Bạn đã sẵn sàng bước sang 2 chương cuối cùng của giáo trình.",
    content: `# Chúc mừng bạn đã hoàn thành Chương 7! 🎓

Bạn đã hoàn thành tuần thứ 19 và toàn bộ nội dung của **Chương 7 (Kappale 7)** trong giáo trình *Suomen Mestari 1*.

---

## Thành tựu bạn đã đạt được:

- Tự tin đặt phòng khách sạn, hỏi giờ bữa sáng, phòng xông hơi và chỉ đường trong thành phố.
- Nắm vững bí quyết chia 3 nhóm từ biến cách danh từ khó nhất ở trình độ sơ cấp: \`-i\`, \`-e\`, \`-nen\`.
- Sử dụng thành thạo thể mệnh lệnh số ít (Ota!) và số nhiều lịch sự (Ottakaa!).
- Hiểu rõ văn hóa chợ trời Kirpputori và lối sống xanh tái chế của Phần Lan.

Chỉ còn 2 chương lớn (Chương 8 - Giao thông & Quá khứ Imperfekti, Chương 9 - Y tế & Sức khỏe) trước khi bước vào kỳ thi thử toàn diện cuối khóa!`
  }
];

// ==========================================
// 3. STUDY PLAN WEEKS (18 & 19)
// ==========================================
const week18 = {
  title: "Tuần 18: Du lịch, Khách sạn & Quy luật Biến cách Danh từ (-i, -e, -nen)",
  description: "Bắt đầu Chương 7 (Kappale 7): Giao tiếp đặt phòng khách sạn, tiện ích đô thị và bí quyết chia 3 nhóm danh từ trọng tâm.",
  days: [
    {
      dayOfWeek: 1,
      theme: "Kappale 7: Du lịch & Đặt phòng Khách sạn",
      activities: [
        {
          activityId: "w18_d1_act1",
          type: "LESSON",
          title: "Bài học: Du lịch & Đặt phòng khách sạn (Trang 184-188)",
          description: "Mở đầu Chương 7: Hội thoại nhận phòng khách sạn và từ vựng du lịch.",
          durationMinutes: 30,
          targetRefId: "w18_d1_tuvung_matkustaminen_hotelli",
          steps: [
            { stepNumber: 1, instruction: "Đọc kỹ hội thoại đặt phòng của Pedro tại khách sạn." },
            { stepNumber: 2, instruction: "Học các cụm từ: yhden hengen huone, aamiainen, kuulua hintaan." }
          ]
        },
        {
          activityId: "w18_d1_act2",
          type: "EXERCISE",
          title: "Bài tập tương tác: Từ vựng du lịch & khách sạn",
          description: "Kiểm tra khả năng ghi nhớ từ vựng khách sạn.",
          durationMinutes: 15,
          targetRefId: "ex_w18_d1_matkustussanasto",
          steps: [
            { stepNumber: 1, instruction: "Trả lời các câu hỏi trắc nghiệm tương tác." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 2,
      theme: "Khám phá Tiện ích Đô thị & Địa điểm Công cộng",
      activities: [
        {
          activityId: "w18_d2_act1",
          type: "LESSON",
          title: "Bài học: Địa điểm & Tiện ích trong Đô thị (Trang 189-191)",
          description: "Học tên gọi các địa điểm: rautatieasema, kirjasto, apteekki, satama, kirpputori.",
          durationMinutes: 30,
          targetRefId: "w18_d2_tuvung_kaupungilla_palvelut",
          steps: [
            { stepNumber: 1, instruction: "Ghi nhớ bảng từ vựng các địa điểm công cộng." },
            { stepNumber: 2, instruction: "Thực hành mẫu câu hỏi đường: Missä on lähin apteekki?" }
          ]
        }
      ]
    },
    {
      dayOfWeek: 3,
      theme: "Ngữ pháp Trọng tâm: Nhóm Biến cách Danh từ -i, -e, -nen",
      activities: [
        {
          activityId: "w18_d3_act1",
          type: "LESSON",
          title: "Bài học: Phân loại 3 nhóm Biến cách Danh từ Đặc biệt",
          description: "Nắm vững quy tắc biến đổi thân từ cho -i (từ mới vs từ cổ), -e nhân đôi và -nen biến thành -se-.",
          durationMinutes: 35,
          targetRefId: "w18_d3_nguphap_sanatyypit_i_e_nen",
          steps: [
            { stepNumber: 1, instruction: "Phân biệt từ mới vay mượn giữ -i và từ cổ đổi -i thành -e-." },
            { stepNumber: 2, instruction: "Ghi nhớ quy tắc nhân đôi -ee- và đuôi -nen thành -se-." }
          ]
        },
        {
          activityId: "w18_d3_act2",
          type: "EXERCISE",
          title: "Bài tập tương tác: Biến cách danh từ -i, -e, -nen",
          description: "Thực hành nhận diện và chia dạng đúng của từ.",
          durationMinutes: 15,
          targetRefId: "ex_w18_d3_sanatyypit_i_e_nen",
          steps: [
            { stepNumber: 1, instruction: "Làm bài tập tương tác trên ứng dụng." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 4,
      theme: "Immersion Đời sống: Văn hóa Chợ Trời Kirpputori",
      activities: [
        {
          activityId: "w18_d4_act1",
          type: "SIGN",
          title: "Immersion: Khám phá Văn hóa Chợ Trời & Kierrätyskeskus",
          description: "Tìm hiểu thói quen mua sắm đồ cũ và lối sống bền vững của người Phần.",
          durationMinutes: 25,
          targetRefId: "sign_kirpputori_kierratyskeskus",
          steps: [
            { stepNumber: 1, instruction: "Đọc bài viết về mô hình Itsepalvelukirpputori." },
            { stepNumber: 2, instruction: "Học các cụm từ thông dụng: Uudenveroinen, Käytetty, Kelpaako kortti?" }
          ]
        }
      ]
    },
    {
      dayOfWeek: 5,
      theme: "Luyện Nghe & Phản xạ Hội thoại Du lịch",
      activities: [
        {
          activityId: "w18_d5_act1",
          type: "LESSON",
          title: "Luyện phát âm & Nghe đối thoại tại Khách sạn",
          description: "Rèn luyện ngữ điệu tự nhiên khi giao tiếp với nhân viên lễ tân.",
          durationMinutes: 30,
          targetRefId: "w18_d1_tuvung_matkustaminen_hotelli",
          steps: [
            { stepNumber: 1, instruction: "Đọc to từng câu thoại theo cặp Pedro và Lễ tân." },
            { stepNumber: 2, instruction: "Tự đóng vai lễ tân trả lời khách du lịch." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 6,
      theme: "Thực hành Viết: Đoạn văn Giới thiệu Chuyến du lịch",
      activities: [
        {
          activityId: "w18_d6_act1",
          type: "LESSON",
          title: "Thực hành viết: Kirjoita matkasta (Viết về kỳ nghỉ)",
          description: "Viết đoạn văn ngắn 5-8 câu mô tả chuyến du lịch của bạn đến một thành phố ở Phần Lan.",
          durationMinutes: 30,
          targetRefId: "w18_d2_tuvung_kaupungilla_palvelut",
          steps: [
            { stepNumber: 1, instruction: "Sử dụng các từ vựng: matkustaa, hotelli, juna, museo, tori." },
            { stepNumber: 2, instruction: "Áp dụng cấu trúc vị trí nơi chốn -ssa / -lla." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 7,
      theme: "Tổng kết & Củng cố Tuần 18",
      activities: [
        {
          activityId: "w18_d7_act1",
          type: "LESSON",
          title: "Tổng kết & Củng cố Tuần 18 (Kappale 7)",
          description: "Hệ thống hóa toàn bộ từ vựng và ngữ pháp tuần 18.",
          durationMinutes: 20,
          targetRefId: "w18_d7_tonghop_tuan18",
          steps: [
            { stepNumber: 1, instruction: "Ôn lại bảng tóm tắt kiến thức." }
          ]
        }
      ]
    }
  ]
};

const week19 = {
  title: "Tuần 19: Thể Mệnh Lệnh (Imperatiivi), Biển báo Khách sạn & Bài tập Tổng hợp Chương 7",
  description: "Hoàn thiện Chương 7 (Kappale 7): Thành thạo thể mệnh lệnh số ít và số nhiều lịch sự, giải bài tập và làm bài kiểm tra năng lực.",
  days: [
    {
      dayOfWeek: 1,
      theme: "Ngữ pháp: Thể Mệnh lệnh Số ít & Số nhiều Lịch sự",
      activities: [
        {
          activityId: "w19_d1_act1",
          type: "LESSON",
          title: "Bài học: Thể Mệnh lệnh Imperatiivi (Trang 195-197)",
          description: "Học cách tạo câu mệnh lệnh số ít (Ota!), số nhiều lịch sự (Ottakaa!) và dạng phủ định (Älä / Älkää).",
          durationMinutes: 35,
          targetRefId: "w19_d1_nguphap_imperatiivi_yksikko_monikko",
          steps: [
            { stepNumber: 1, instruction: "Học cách lấy thân từ minä cho mệnh lệnh số ít." },
            { stepNumber: 2, instruction: "Học cách thêm -kaa/-kää cho mệnh lệnh số nhiều/lịch sự." }
          ]
        },
        {
          activityId: "w19_d1_act2",
          type: "EXERCISE",
          title: "Bài tập tương tác: Thể mệnh lệnh số ít & số nhiều",
          description: "Luyện tập chuyển đổi câu sang thể mệnh lệnh lịch sự.",
          durationMinutes: 15,
          targetRefId: "ex_w19_d2_imperatiivi_monikko",
          steps: [
            { stepNumber: 1, instruction: "Chọn đáp án mệnh lệnh đúng trên ứng dụng." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 2,
      theme: "Immersion Thực tế: Biển báo & Hướng dẫn Khách sạn",
      activities: [
        {
          activityId: "w19_d2_act1",
          type: "SIGN",
          title: "Immersion: Đọc hiểu Biển báo Khách sạn Phần Lan",
          description: "Học cách đọc giờ bữa sáng, giờ phòng xông hơi Sauna và các quy định chung.",
          durationMinutes: 25,
          targetRefId: "sign_hotelli_varaus",
          steps: [
            { stepNumber: 1, instruction: "Ghi nhớ các thuật ngữ: Huoneiden luovutus, Asiakassauna, Savuton." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 3,
      theme: "Luyện Nghe & Nói Phản xạ: Giao tiếp tại Lễ tân & Cửa hàng",
      activities: [
        {
          activityId: "w19_d3_act1",
          type: "LESSON",
          title: "Hội thoại thực hành: Mua sắm & Hỏi dịch vụ du lịch",
          description: "Rèn luyện phản xạ tình huống khi mua hàng tại chợ trời hoặc hỏi nhân viên khách sạn.",
          durationMinutes: 30,
          targetRefId: "w19_d1_nguphap_imperatiivi_yksikko_monikko",
          steps: [
            { stepNumber: 1, instruction: "Thực hành câu: 'Olkaa hyvä ja kirjoittakaa tähän' (Xin vui lòng viết vào đây)." },
            { stepNumber: 2, instruction: "Thực hành trả giá và hỏi phương thức thanh toán tại chợ trời." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 4,
      theme: "Thực hành Giải Bài tập Sách Giáo trình: Harjoitus 1 - 15",
      activities: [
        {
          activityId: "w19_d4_act1",
          type: "LESSON",
          title: "Bài tập thực hành: Harjoitus 1 - 15 Chương 7 (Trang 198-204)",
          description: "Luyện giải bài tập tổng hợp về biến cách danh từ và thể mệnh lệnh.",
          durationMinutes: 35,
          targetRefId: "w19_d4_baitap_harjoitus1_15",
          steps: [
            { stepNumber: 1, instruction: "Làm bài tập điền từ và chia đuôi biến cách." },
            { stepNumber: 2, instruction: "Kiểm tra lại đáp án và phân tích lỗi sai nếu có." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 5,
      theme: "Đề Kiểm tra Toàn diện Đánh giá Năng lực: Kappale 7",
      activities: [
        {
          activityId: "w19_d5_act1",
          type: "LESSON",
          title: "Đề kiểm tra đánh giá năng lực: Kappale 7 (Trang 206-208)",
          description: "Thực hiện bài kiểm tra trắc nghiệm tổng hợp toàn bộ Chương 7.",
          durationMinutes: 30,
          targetRefId: "w19_d5_kiemtra_tongket_kappale7",
          steps: [
            { stepNumber: 1, instruction: "Làm bài kiểm tra tương tác bên dưới." }
          ]
        },
        {
          activityId: "w19_d5_act2",
          type: "EXERCISE",
          title: "Bài tập tương tác: Kiểm tra tổng kết Chương 7",
          description: "Hoàn thành các câu hỏi đánh giá chuẩn A1.2.",
          durationMinutes: 15,
          targetRefId: "ex_w19_d5_kiemtra_kappale7",
          steps: [
            { stepNumber: 1, instruction: "Chọn đáp án chính xác nhất." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 6,
      theme: "Dự án Thực tế: Lên Kế hoạch Du lịch Helsinki",
      activities: [
        {
          activityId: "w19_d6_act1",
          type: "LESSON",
          title: "Dự án: Thiết kế Lịch trình Khám phá Thủ đô Helsinki",
          description: "Tự tạo lịch trình 2 ngày 1 đêm tại Helsinki: Khách sạn, phương tiện, địa điểm tham quan.",
          durationMinutes: 30,
          targetRefId: "w18_d2_tuvung_kaupungilla_palvelut",
          steps: [
            { stepNumber: 1, instruction: "Chọn 1 khách sạn và mô tả loại phòng đặt." },
            { stepNumber: 2, instruction: "Liệt kê 3 địa điểm sẽ ghé thăm (Oodi, Tuomiokirkko, Kauppatori)." }
          ]
        }
      ]
    },
    {
      dayOfWeek: 7,
      theme: "Tổng kết Hoàn thành Chương 7: Cán mốc 79.2%",
      activities: [
        {
          activityId: "w19_d7_act1",
          type: "LESSON",
          title: "Tổng kết Hoàn thành Chương 7: Chinh phục mốc 79.2%!",
          description: "Vinh danh chặng đường nỗ lực và chuẩn bị bước sang 2 chương cuối.",
          durationMinutes: 20,
          targetRefId: "w19_d7_tongket_kappale7",
          steps: [
            { stepNumber: 1, instruction: "Nghỉ ngơi và chúc mừng thành tựu đạt được!" }
          ]
        }
      ]
    }
  ]
};

// ==========================================
// 4. GENERATE FILES & SYNC TO FIRESTORE
// ==========================================
async function buildAndSyncPhase7() {
  console.log('🚀 === GENERATING AND SYNCING PHASE 7 (WEEKS 18 & 19 - CHAPTER 7) ===\n');

  const currDir = path.resolve(__dirname, '../../content/curriculum');
  const lessDir = path.resolve(__dirname, '../../content/lessons');

  // Save local files
  fs.writeFileSync(path.join(currDir, 'chapter_07_exercises.json'), JSON.stringify({ exercises }, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/chapter_07_exercises.json');

  fs.writeFileSync(path.join(lessDir, 'chapter_07_lessons.json'), JSON.stringify({ lessons }, null, 2), 'utf8');
  console.log('✅ Generated content/lessons/chapter_07_lessons.json');

  fs.writeFileSync(path.join(currDir, 'week_18.json'), JSON.stringify(week18, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/week_18.json');

  fs.writeFileSync(path.join(currDir, 'week_19.json'), JSON.stringify(week19, null, 2), 'utf8');
  console.log('✅ Generated content/curriculum/week_19.json');

  // Sync Exercises to Firestore
  console.log('\n📝 1. Synchronizing Phase 7 Interactive Exercises into Firestore `exercises`...');
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
  console.log('\n📚 2. Synchronizing Phase 7 Rich Interactive Lessons into Firestore `lessons`...');
  for (const rawLesson of lessons) {
    await db.collection('lessons').doc(rawLesson.id).set({
      id: rawLesson.id,
      title: rawLesson.title,
      chapter: rawLesson.chapter || 'Kappale 7',
      week: rawLesson.week || 18,
      description: rawLesson.description || '',
      audioUrls: [],
      content: rawLesson.content,
      updatedAt: admin.firestore.FieldValue.serverTimestamp()
    }, { merge: true });

    if (rawLesson.id.startsWith('sign_') || rawLesson.id.startsWith('song_') || rawLesson.id.startsWith('video_')) {
      await db.collection('immersion_resources').doc(rawLesson.id).set({
        id: rawLesson.id,
        title: rawLesson.title,
        chapter: rawLesson.chapter || 'Kappale 7',
        description: rawLesson.description || '',
        content: rawLesson.content,
        type: rawLesson.id.startsWith('sign_') ? 'sign' : (rawLesson.id.startsWith('song_') ? 'music' : 'video'),
        updatedAt: admin.firestore.FieldValue.serverTimestamp()
      }, { merge: true });
    }

    console.log(`   ✅ Synced Lesson: [${rawLesson.id}] ${rawLesson.title}`);
  }

  // Sync Weeks 18 & 19 to Firestore
  console.log('\n📅 3. Synchronizing Study Plan Weeks 18 & 19 into Firestore `study_plan_weeks`...');
  const planId = '6iWorOc6mZtnINIFBH8a';
  const week18DocId = '4qh21yfHweLotLdDVhMd';
  const week19DocId = 'xCGqhpUQxffiTBG0OX2Q';

  await db.collection('study_plan_weeks').doc(week18DocId).set({
    planId: planId,
    weekNumber: 18,
    title: week18.title,
    description: week18.description,
    days: week18.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Week 18 (doc: ${week18DocId})`);

  await db.collection('study_plan_weeks').doc(week19DocId).set({
    planId: planId,
    weekNumber: 19,
    title: week19.title,
    description: week19.description,
    days: week19.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Week 19 (doc: ${week19DocId})`);

  console.log('\n🎉 ALL PHASE 7 (WEEKS 18 & 19) CONTENT SYNCED SUCCESSFULLY TO FIRESTORE PRODUCTION!');
}

buildAndSyncPhase7().catch(err => {
  console.error('❌ Phase 7 Build & Sync failed:', err);
  process.exit(1);
});
