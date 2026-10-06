const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');
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

// -------------------------------------------------------------
// STANDARDIZED LESSON DEFINITIONS (100% VERBATIM FROM TEXTBOOK)
// -------------------------------------------------------------

// 1. CHAPTER 2: w5_d3_giaotiep_hinnat_puhekieli (Sivu 54-55)
const ch2_w5_d3_content = `# 🛍️ Giao tiếp: Puhutaan! Hinnat (Hỏi giá & Mua sắm thực tế - Trang 55)

Chào mừng bạn đến với bài học giao tiếp mua sắm của **Chương 2 (Harjoitus 30 - Trang 55)** trong giáo trình chuẩn **Suomen Mestari 1**! 

Hôm nay chúng ta sẽ luyện phản xạ hỏi giá và trả lời giá tiền bằng cả hai hình thức: **Chuẩn văn bản (Kirjakieli)** và **Văn nói đời thường (Puhekieli)** với đầy đủ các món đồ xuất hiện trong sách giáo trình.

---

### 🎧 1. Nghe mẫu phát âm chuẩn Harjoitus 30

Bấm Track 32 để nghe chuẩn văn bản (Kirjakieli):
[audio:AUDIO_URL_1]

Bấm Track 31 để nghe cách người Phần đọc lướt trong đời sống (Puhekieli):
[audio:AUDIO_URL_2]

---

### 💬 2. Lời thoại hỏi giá 9 món đồ trong sách (Nghe & Đọc theo sách)

[dialogue_toggle:Bật/tắt tất cả bản dịch tiếng Việt]

[dialogue:Ostaja|Mitä jäätelö maksaa?|Kem này giá bao nhiêu vậy bạn?|Mitä maksaa = Có giá bao nhiêu (văn nói: Mitä jätski maksaa?)]
[dialogue:Myyjä|Se maksaa neljä euroa viisikymmentä senttiä.|Kem giá 4 euro 50 cent.|Kirjakieli: neljä euroa viisikymmentä senttiä. Puhekieli: neljä viiskyt]
[dialogue:Ostaja|Paljonko televisio maksaa?|Chiếc tivi kia giá bao nhiêu vậy ạ?|Paljonko maksaa = Giá bao nhiêu]
[dialogue:Myyjä|Televisio maksaa neljäsataa euroa.|Tivi có giá 400 euro.|neljäsataa = 400]
[dialogue:Ostaja|Mitä hampurilainen maksaa?|Bánh burger này giá bao nhiêu?|hampurilainen = bánh burger / bánh kẹp]
[dialogue:Myyjä|Se maksaa kuusi euroa.|Nó có giá 6 euro.|kuusi euroa = 6 euro (văn nói: kuus euroo)]
[dialogue:Ostaja|Paljonko bussilippu maksaa?|Vé xe buýt giá bao nhiêu vậy bác tài?|bussilippu = vé xe buýt]
[dialogue:Kuski|Se maksaa kaksi euroa.|Vé giá 2 euro nhé bạn.|kaksi euroa = 2 euro (văn nói: kaks euroo)]
[dialogue:Ostaja|Mitä pizza maksaa?|Bánh pizza giá bao nhiêu ạ?|pizza = bánh pizza]
[dialogue:Myyjä|Pizza maksaa kahdeksan euroa viisikymmentä senttiä.|Pizza giá 8 euro 50 cent.|văn nói: kaheksan viiskyt]
[dialogue:Ostaja|Paljonko tuo auto maksaa?|Chiếc ô tô kia giá bao nhiêu vậy anh?|tuo auto = chiếc ô tô đằng kia]
[dialogue:Myyjä|Se maksaa viisitoistatuhatta euroa.|Chiếc đó giá 15.000 euro.|viisitoistatuhatta = 15 nghìn]
[dialogue:Ostaja|Mitä kahvi maksaa?|Một tách cà phê giá bao nhiêu?|kahvi = cà phê]
[dialogue:Myyjä|Kahvikuppi maksaa kaksi euroa viisikymmentä senttiä.|Tách cà phê giá 2 euro 50 cent.|văn nói: kaks puol / kaks viiskyt]
[dialogue:Ostaja|Paljonko kamera maksaa?|Chiếc máy ảnh này giá bao nhiêu?|kamera = máy ảnh]
[dialogue:Myyjä|Se maksaa kolmesataa euroa.|Máy ảnh giá 300 euro.|kolmesataa = 300]
[dialogue:Ostaja|Mitä sanakirja maksaa?|Quyển từ điển Suomi-Englanti giá bao nhiêu ạ?|sanakirja = từ điển]
[dialogue:Myyjä|Se maksaa kaksikymmentä euroa.|Quyển từ điển giá 20 euro.|kaksikymmentä = 20 (văn nói: kakskyt)]

---

### 💡 3. Bảng đối chiếu Giá tiền: Kirjakieli vs Puhekieli

| Mức giá | Chuẩn văn bản (Kirjakieli) | Văn nói người bản xứ (Puhekieli) |
| :--- | :--- | :--- |
| **0,50 €** | viisikymmentä senttiä | *viiskyt senttii* |
| **1,00 €** | yksi euro | *yks euro* |
| **2,00 €** | kaksi euroa | *kaks euroo* |
| **4,50 €** | neljä euroa viisikymmentä senttiä | *neljä viiskyt* |
| **8,50 €** | kahdeksan euroa viisikymmentä senttiä | *kaheksan viiskyt* |
| **10,00 €** | kymmenen euroa | *kymppi / kymmenen euroo* |
| **20,00 €** | kaksikymmentä euroa | *kakskyt euroo* |

---

### 📝 4. Thử thách phản xạ hỏi giá

[exercise:ex_w5_h30_hinnat]`;

// 2. CHAPTER 3: w6_d1_thoai_pedro_soittaa_mikolle (Sivu 56-57)
const ch3_w6_d1_content = `# 📞 Kappale 3: Pedro soittaa Mikolle (Pedro gọi điện cho Mikko - Trang 57)

Chào mừng bạn đến với **Chương 3 (Kappale 3)** của giáo trình chuẩn **Suomen Mestari 1** (Trang 56-57)! 

Sau khi ổn định cuộc sống tại Phần Lan, **Pedro** gọi điện thoại video cho người bạn thân **Mikko** (đang làm việc tại São Paulo, Brazil) để hỏi thăm tình hình, trò chuyện về thời tiết Phần Lan và chia sẻ việc anh chuẩn bị chuyển về tổ ấm mới tại Helsinki.

Toàn bộ lời dẫn truyện và hội thoại dưới đây được giữ **chính xác 100% nguyên văn từ sách giáo trình Suomen Mestari 1 (Trang 57)**, đồng bộ chuẩn từng câu với Audio Track 33 & 34!

---

### 🎧 1. Nghe cuộc gọi thoại gốc (Kirjakieli - Chuẩn văn bản)
Bấm nút bên dưới để nghe Track 33:

[audio:AUDIO_URL_1]

---

### 📖 2. Phần dẫn truyện mở đầu (Kappaleen teksti)

[dialogue_toggle:Bật/tắt tất cả bản dịch tiếng Việt]

[reader:Mikko on Pedron hyvä ystävä. Mikko on suomalainen, mutta hän asuu nyt São Paolossa, Brasiliassa.|Mikko là bạn thân của Pedro. Mikko là người Phần Lan, nhưng hiện anh ấy đang sống ở São Paulo, Brazil. (hyvä ystävä = bạn thân; mutta = nhưng; asuu nyt = hiện đang sống)]
[reader:Tänään Pedro soittaa Mikolle videopuhelun.|Hôm nay Pedro gọi một cuộc gọi video cho Mikko. (tänään = hôm nay; soittaa + lle = gọi điện cho ai; videopuhelu = cuộc gọi video)]

---

### 💬 3. Lời thoại nguyên văn cuộc trò chuyện (Nghe & Đọc theo sách)

[dialogue:Pedro|Moi Mikko! Oletko jo töissä?|Chào Mikko! Bạn đã ở chỗ làm chưa?|Oletko jo töissä? = Bạn đã đến chỗ làm chưa? (töissä = đang ở nơi làm việc)]
[dialogue:Mikko|No moi! En vielä. Kello on täällä vasta puoli kahdeksan.|Ồ chào bạn! Tôi vẫn chưa. Ở bên này đồng hồ mới chỉ bảy giờ rưỡi sáng thôi.|En vielä = Tôi chưa; vasta = mới chỉ; puoli kahdeksan = 7 giờ 30 (nửa của tiếng thứ tám)]
[dialogue:Pedro|Ai niin, totta. No, mitä kuuluu?|À ừ nhỉ, đúng rồi. Thế dạo này bạn thế nào?|Ai niin, totta = À đúng rồi; Mitä kuuluu? = Dạo này bạn khỏe không / thế nào?]
[dialogue:Mikko|Ihan hyvää, mutta sää on nyt huono. Tänäänkin sataa kaatamalla ja on tuulista.|Khá ổn, nhưng thời tiết bây giờ chán lắm. Hôm nay trời cũng mưa như trút nước và nhiều gió.|sää on huono = thời tiết xấu; sataa kaatamalla = mưa như trút nước; tuulista = trời nhiều gió giật]
[dialogue:Pedro|Aijaa! Täällä aurinko paistaa ja on tosi lämmin, +25 astetta. Yöllä on niin valoisaa, että on vaikea nukkua.|Ồ vậy sao! Ở bên này mặt trời tỏa nắng rực rỡ và rất ấm áp, dương 25 độ C. Ban đêm trời sáng đến mức khó mà ngủ được.|aurinko paistaa = mặt trời chiếu sáng; tosi lämmin = rất ấm; astetta = độ C; valoisaa = sáng sủa; vaikea nukkua = khó ngủ]
[dialogue:Mikko|Heh heh, Suomen valoisat kesäyöt! Nauti nyt, marraskuussa on sitten pimeää.|Ha ha, những đêm hè sáng trắng đặc trưng của Phần Lan đó! Giờ hãy tận hưởng đi, sang tháng 11 là trời sẽ tối mịt mù rồi đấy.|valoisat kesäyöt = những đêm hè sáng trắng; nauti nyt = hãy tận hưởng đi; marraskuussa = vào tháng 11; pimeää = tối tăm]
[dialogue:Pedro|No joo, niin kuulemma!|Ừ thì, tôi cũng nghe mọi người bảo vậy!|niin kuulemma = nghe đồn/nghe người ta nói là như vậy]
[dialogue:Mikko|Mitä muuta kuuluu? Onko sinulla jo työpaikka?|Thế còn tin tức gì khác không? Bạn đã tìm được việc làm chưa?|Mitä muuta kuuluu? = Còn gì mới không?; työpaikka = công việc, chỗ làm việc]
[dialogue:Pedro|Ei vielä. Minä etsin töitä, mutta se ei ole helppoa. Olen nyt suomen kurssilla.|Vẫn chưa. Tôi đang tìm việc, nhưng điều đó không hề dễ dàng chút nào. Bây giờ tôi đang theo học khóa tiếng Phần Lan.|etsin töitä = tôi đang tìm việc; helppoa = dễ dàng; suomen kurssilla = ở khóa học tiếng Phần]
[dialogue:Mikko|Hieno juttu! Millainen kurssi on?|Tuyệt vời đấy! Khóa học như thế nào?|Hieno juttu = Điều tuyệt vời; Millainen kurssi on? = Khóa học ra sao?]
[dialogue:Pedro|Se on tosi hyvä! Opettaja on mukava ja minun ystävät Olga ja Alex ovat samalla kurssilla. Kurssi on maanantaisin, keskiviikkoisin ja torstaisin.|Khóa học tốt lắm! Cô giáo rất dễ mến và các bạn của tôi là Olga và Alex cũng học cùng khóa. Khóa học diễn ra vào các thứ Hai, thứ Tư và thứ Năm hàng tuần.|mukava = dễ mến, thoải mái; samalla kurssilla = cùng khóa học; đuôi -isin = diễn ra định kỳ vào các ngày trong tuần]
[dialogue:Mikko|Kolme kertaa viikossa! Ohhoh! Kohta sinä puhut suomea yhtä hyvin kuin minä!|Ba buổi một tuần cơ à! Ái chà! Chẳng mấy chốc mà bạn sẽ nói tiếng Phần trôi chảy như tôi cho mà xem!|kolme kertaa viikossa = 3 lần một tuần; kohta = sắp sửa, chẳng mấy chốc; yhtä hyvin kuin = giỏi như, ngang bằng như]
[dialogue:Pedro|Heh heh. Niin varmaan.|Ha ha. Chắc là vậy rồi.|niin varmaan = chắc vậy quá (câu đùa khiêm tốn)]
[dialogue:Mikko|Asutteko te vielä Hannan opiskelija-asunnossa Espoossa?|Hai bạn vẫn còn sống trong căn hộ sinh viên của Hanna ở Espoo à?|opiskelija-asunto = căn hộ sinh viên; Espoossa = ở thành phố Espoo]
[dialogue:Pedro|Joo, mutta me muutamme syyskuussa. Meidän uusi koti on Helsingissä.|Ừ, nhưng chúng tôi sẽ dọn nhà vào tháng 9. Căn nhà mới của chúng tôi nằm ở Helsinki.|muuttaa = chuyển nhà; syyskuussa = vào tháng 9; meidän uusi koti = ngôi nhà mới của chúng tôi]
[dialogue:Mikko|Kuulostaa hyvältä! Mutta hei, nyt minun täytyy lähteä töihin. Terveisiä Hannalle!|Nghe hay quá! Nhưng mà này, bây giờ tôi phải đi làm rồi. Cho tôi gửi lời chào thăm Hanna nhé!|Kuulostaa hyvältä = Nghe tuyệt đấy; minun täytyy = tôi phải; lähteä töihin = đi làm; Terveisiä + lle = Cho gửi lời thăm hỏi tới ai]
[dialogue:Pedro|Kiitos, minä kerron! Moikka!|Cảm ơn bạn, tôi sẽ nhắn lại với cô ấy! Tạm biệt nhé!|minä kerron = tôi sẽ kể/nhắn lại; moikka = bái bai]
[dialogue:Mikko|Moi moi!|Tạm biệt bạn nhé!|moi moi = lời chào tạm biệt thân mật]

---

### 🎙️ 4. Nghe phiên bản khẩu ngữ văn nói (Puhekieli)
Người Phần Lan khi gọi điện thoại cho bạn bè thường nói nhanh và rút gọn từ ngữ. Hãy nghe Track 34:

[audio:AUDIO_URL_2]

> 💡 **Bảng đối chiếu Văn viết (Kirjakieli) vs Khẩu ngữ (Puhekieli):**
> * **Oletko sinä?** -> Khẩu ngữ: **Ootsä?**
> * **Minä etsin** -> Khẩu ngữ: **Mä etsin**
> * **Minun ystävät** -> Khẩu ngữ: **Mun kaverit / ystävät**
> * **Sinä puhut** -> Khẩu ngữ: **Sä puhut**
> * **Asutteko te?** -> Khẩu ngữ: **Asutteks te?**
> * **Me muutamme** -> Khẩu ngữ: **Me muutetaan**
> * **Minun täytyy** -> Khẩu ngữ: **Mun täytyy**

---

### 📝 5. Thử thách phản xạ tương tác

[exercise:ex_w6_d1_pedro_soittaa_mikolle]`;

// 3. CHAPTER 3: w6_d4_luyennghe_saakeskustelu (Sivu 75-76)
const ch3_w6_d4_content = `# 👂 Luyện nghe: Harjoitus 15 - 5 Đoạn đối thoại thời tiết thực tế (Trang 76)

Thời tiết (**Sää ja ilmasto**) là chủ đề giao tiếp số 1 trong đời sống hàng ngày tại Phần Lan. Người Phần Lan có thể bắt đầu mọi cuộc trò chuyện bằng việc bình luận về nhiệt độ, cơn mưa hay ánh nắng ngoài trời.

Bài học hôm nay bao gồm **trọn vẹn 5 đoạn đối thoại Harjoitus 15 (Trang 76)** tương ứng từ Track 40 đến Track 44 trong đĩa gốc Suomen Mestari 1!

---

[dialogue_toggle:Bật/tắt tất cả bản dịch tiếng Việt]

### 🎧 1. Đoạn hội thoại 1 (Track 40): Trời trở lạnh
[audio:AUDIO_URL_1]

[dialogue:A|Hei, onpa tänään kylmä!|Kìa, hôm nay trời lạnh thật đấy!|onpa = thật là... (thán từ cảm thán nhấn mạnh); kylmä = lạnh]
[dialogue:B|Niinpä on, vain viisi astetta. Talvi taitaa tulla.|Đúng thế thật, chỉ có 5 độ thôi. Có vẻ mùa đông sắp tới rồi đấy.|vain viisi astetta = chỉ 5 độ C; talvi = mùa đông; taitaa tulla = dường như đang đến]

---

### 🎧 2. Đoạn hội thoại 2 (Track 41): Cơn mưa và gió giật
[audio:AUDIO_URL_2]

[dialogue:A|Sataako ulkona vielä?|Ngoài trời vẫn còn mưa hả bạn?|sataako = trời có mưa không; ulkona = ở ngoài trời; vielä = vẫn còn]
[dialogue:B|Ei sada enää, mutta tuulee kovasti.|Hết mưa rồi, nhưng gió đang thổi rất mạnh.|ei sada enää = không mưa nữa; tuulee kovasti = gió thổi rất mạnh]

---

### 🎧 3. Đoạn hội thoại 3 (Track 42): Ngày nắng đẹp rực rỡ
[audio:AUDIO_URL_3]

[dialogue:A|Ihana ilma tänään! Aurinko paistaa eikä sada yhtään.|Thời tiết hôm nay tuyệt vời quá! Mặt trời tỏa sáng rực rỡ và chẳng mưa tí nào.|ihana ilma = thời tiết tuyệt vời; aurinko paistaa = mặt trời chiếu sáng; eikä sada yhtään = và không mưa chút nào]
[dialogue:B|Joo, totta! Lähdetäänkö puistoon kävelylle?|Ừ, đúng rồi! Tụi mình ra công viên đi tản bộ không?|lähdetäänkö = tụi mình cùng đi nhé; kävelylle = đi dạo bộ]

---

### 🎧 4. Đoạn hội thoại 4 (Track 43): Mùa đông băng giá dưới 0 độ
[audio:AUDIO_URL_4]

[dialogue:A|Paljonko pakkasta tänään on?|Hôm nay trời âm bao nhiêu độ vậy bạn?|pakkasta = thời tiết âm độ (dưới 0°C)]
[dialogue:B|Mittari näyttää miinus viisitoista. Muista panna villapipo päähän!|Nhiệt kế đang chỉ âm 15 độ C. Nhớ đội mũ len ấm trùm đầu vào đấy nhé!|mittari näyttää = nhiệt kế hiển thị; villapipo = mũ len tròn trùm đầu; päähän = vào đầu]

---

### 🎧 5. Đoạn hội thoại 5 (Track 44): Ngày hè nóng nực
[audio:AUDIO_URL_5]

[dialogue:A|Huh huh, onpas täällä kuuma! Ainakin kolmekymmentä astetta!|Phù phù, ở đây nóng nực quá chừng! Ít nhất cũng phải 30 độ C!|huh huh = tiếng thở phào vì nóng nực; onpas kuuma = ôi nóng quá; ainakin = ít nhất]
[dialogue:B|Niin on. Mennäänkö uimarannalle uimaan?|Đúng vậy đấy. Tụi mình ra bãi biển đi bơi giải nhiệt không?|uimaranta = bãi tắm biển; uimaan = đi bơi]

---

### 📝 6. Thử thách phân biệt thời tiết

[exercise:ex_w6_h15_saa]`;

// 4. CHAPTER 3: w7_d1_giaotiep_dangky_khoahoc (Sivu 62-63)
const ch3_w7_d1_content = `# 📝 Giao tiếp: Pedro ilmoittautuu kurssille (Đăng ký khóa học tiếng Phần - Trang 63)

Chào mừng bạn đến với bài học giao tiếp thực tế của **Chương 3 (Puhutaan! - Trang 63)** trong giáo trình chuẩn **Suomen Mestari 1**!

Hôm nay chúng ta sẽ theo chân **Pedro** đến văn phòng trung tâm giáo dục cộng đồng (**aikuisopisto**) để đăng ký khóa học tiếng Phần Lan tiếp theo (**Suomi 2**), trao đổi với thư ký tuyển sinh và điền mẫu thông tin cá nhân.

Toàn bộ lời dẫn truyện và hội thoại dưới đây được giữ **chính xác 100% từng câu chữ từ sách giáo trình Suomen Mestari 1 (Trang 63)**, khớp từng giây với Audio Track 35!

---

### 🎧 1. Nghe đối thoại mẫu tại bàn tuyển sinh (Track 35)
Bấm nút bên dưới để nghe Track 35:

[audio:AUDIO_URL_1]

---

### 📖 2. Phần dẫn nhập bối cảnh

[dialogue_toggle:Bật/tắt tất cả bản dịch tiếng Việt]

[reader:Pedro haluaa ilmoittautua suomen kurssille. Hän menee aikuisopiston toimistoon.|Pedro muốn đăng ký một khóa học tiếng Phần Lan. Anh ấy đến văn phòng của trường học dành cho người lớn. (ilmoittautua = đăng ký tham gia; aikuisopisto = trường cộng đồng/học viện người lớn; toimisto = văn phòng)]

---

### 💬 3. Lời thoại chi tiết tại bàn tiếp tân (Trang 63)

[dialogue:Kurssisihteeri|Hei!|Xin chào bạn!|sihteeri = nhân viên thư ký tuyển sinh]
[dialogue:Pedro|Hei! Mä haluaisin ilmoittautua suomen kurssille, tasolle kaks.|Chào cô! Em muốn đăng ký vào một khóa học tiếng Phần Lan, lên trình độ 2 ạ.|Mä haluaisin = Tôi muốn (thể lịch sự konditionaali); tasolle kaks = lên trình độ 2 (tasolle kaksi)]
[dialogue:Kurssisihteeri|Joo-o. Seuraava Suomi 2 -kurssi alkaa jo huomenna.|Ừm, để cô xem. Khóa học Suomi 2 tiếp theo sẽ bắt đầu ngay vào ngày mai rồi.|Joo-o = Ừm, để xem nào; seuraava = tiếp theo; alkaa = bắt đầu; jo huomenna = ngay ngày mai]
[dialogue:Pedro|Ai huomenna jo! Ei, se ei käy.|Ôi ngày mai đã bắt đầu rồi cơ ạ! Không, thế thì em không tiện tham gia được rồi.|se ei käy = điều đó không được / không khả thi / không tiện lịch]
[dialogue:Kurssisihteeri|No sitten on toinen kurssi syyskuussa.|Thế thì có một khóa học khác mở vào tháng 9 đấy.|toinen kurssi = một khóa học khác; syyskuussa = vào tháng 9]
[dialogue:Pedro|Joo, se kuulostaa hyvältä. Onks kurssilla vielä tilaa?|Vâng, nghe hợp lý đấy ạ. Khóa đó vẫn còn chỗ trống chứ cô?|kuulostaa hyvältä = nghe hay đấy; onks = onko; tilaa = chỗ trống]
[dialogue:Kurssisihteeri|Hetkinen, mä tarkistan. Joo, siellä on vielä pari paikkaa vapaana.|Chờ cô một lát, để cô kiểm tra máy tính nhé. Rồi, ở đó vẫn còn vài chỗ trống.|hetkinen = chờ một lát; pari paikkaa = vài chỗ; vapaana = đang còn trống]
[dialogue:Pedro|Okei, kiva.|Dạ tốt quá.|kiva = tuyệt, hay quá]
[dialogue:Kurssisihteeri|Sanotko vielä, mikä sun nimi on.|Em đọc giúp cô tên của em là gì nào.|sanotko = em nói giúp; sun = sinun (của em)]
[dialogue:Pedro|Pedro Ribeiro.|Pedro Ribeiro ạ.|]
[dialogue:Kurssisihteeri|Anteeks, sanotko uudelleen!|Xin lỗi em, em đọc lại một lần nữa giúp cô được không!|Anteeks = Xin lỗi; sanotko uudelleen = em đọc lại nhé]
[dialogue:Pedro|Etunimi on Pedro ja sukunimi Ribeiro.|Tên của em là Pedro và họ là Ribeiro ạ.|etunimi = tên gọi; sukunimi = họ]
[dialogue:Kurssisihteeri|Okei, kiitos. Saanko vielä sun henkilötiedot. Tässä on lomake.|Được rồi, cảm ơn em. Cho cô xin thông tin cá nhân của em nữa nhé. Đây là phiếu điền đơn.|saanko = tôi có thể nhận được... không; henkilötiedot = thông tin cá nhân; lomake = mẫu đơn]
[dialogue:Pedro|Okei, kiitos.|Dạ vâng, em cảm ơn cô.|]

---

### 📋 4. Phần đối thoại hỗ trợ điền đơn (Trang 63)

[dialogue:Pedro|Anteeksi, voitko auttaa vähän? Mitä tarkoittaa postitoimipaikka?|Xin lỗi cô, cô có thể giúp em một chút được không ạ? Từ 'postitoimipaikka' có nghĩa là gì vậy cô?|voitko auttaa vähän = cô có thể giúp một chút được không; Mitä tarkoittaa = có nghĩa là gì; postitoimipaikka = địa danh bưu điện / thành phố cư trú]
[dialogue:Kurssisihteeri|Se on kaupunki, jossa sinä asut.|Đó chính là thành phố nơi mà em đang sinh sống.|kaupunki = thành phố; jossa sinä asut = nơi em đang sống]
[dialogue:Pedro|Okei, Espoo siis. Hyvä. Tää on nyt valmis. Kiitos avusta!|Dạ, như vậy là thành phố Espoo. Tốt rồi. Phiếu này em đã điền xong rồi đây ạ. Cảm ơn cô đã giúp đỡ!|siis = như vậy là; valmis = hoàn tất, xong xuôi; Kiitos avusta = Cảm ơn vì sự giúp đỡ]
[dialogue:Kurssisihteeri|Kiitos. Ilmoittautuminen on nyt tehty. Lasku tulee sähköpostitse ensi viikolla.|Cảm ơn em. Việc đăng ký hiện đã hoàn tất rồi nhé. Hóa đơn tiền học sẽ gửi qua email vào tuần tới.|ilmoittautuminen = việc đăng ký; lasku = hóa đơn thanh toán; sähköpostitse = qua thư điện tử; ensi viikolla = tuần sau]
[dialogue:Pedro|Okei, kiitti hei.|Dạ vâng, em cảm ơn cô nhiều ạ, chào cô!|kiitti hei = cảm ơn và chào]

---

### 📚 5. Thuật ngữ hành chính & Khẩu ngữ trong bài

* **ilmoittautua kurssille**: đăng ký tham gia một khóa học.
* **se ei käy**: câu từ chối lịch sự, biểu đạt \"lịch đó/điều đó không tiện cho tôi\".
* **tilaa**: dạng đối cách của *tila* (khoảng không gian / chỗ ngồi còn trống).
* **postitoimipaikka**: thành phố thuộc mã bưu chính (ví dụ: *00100 Helsinki* thì Helsinki là postitoimipaikka).
* **lasku tulee sähköpostitse**: hóa đơn sẽ gửi qua thư điện tử (hậu tố *-tse* chỉ phương tiện chuyển giao).

---

### 📝 6. Thử thách phản xạ giao tiếp tuyển sinh

[exercise:ex_w7_d1_dangky_khoahoc]`;

// 5. CHAPTER 3: w8_d3_giaotiep_lomake (Sivu 84-85)
const ch3_w8_d3_content = `# 📋 Giao tiếp: Harjoitus 27 - Điền phiếu thông tin cá nhân (Lomake - Trang 85)

Trong đời sống tại Phần Lan, khi đi đăng ký thư viện, mở tài khoản ngân hàng, thuê nhà hay đăng ký học, bạn sẽ luôn phải điền một tờ khai thông tin cá nhân (**Henkilötiedot-lomake**).

Bài học hôm nay được trích từ **Harjoitus 27 (Trang 85)** kết hợp Audio Track 45, giúp bạn làm chủ từng câu hỏi phỏng vấn thu thập thông tin của cán bộ hành chính Phần Lan.

---

### 🎧 1. Nghe đoạn hội thoại đối chiếu mẫu đơn (Track 45)
Bấm Track 45 để nghe đoạn đọc điền thông tin:

[audio:AUDIO_URL_1]

---

### 💬 2. Lời thoại phỏng vấn điền mẫu đơn (Nghe & Đọc theo sách)

[dialogue_toggle:Bật/tắt tất cả bản dịch tiếng Việt]

[dialogue:Virkailija|Mikä teidän sukunimi on?|Họ của bạn là gì vậy ạ?|sukunimi = họ]
[dialogue:Hakija|Minun sukunimi on Nieminen.|Họ của tôi là Nieminen.|]
[dialogue:Virkailija|Entä etunimet?|Còn các tên gọi thì sao?|etunimet = các tên gọi chính và tên đệm]
[dialogue:Hakija|Etunimi on Laura Maria.|Tên gọi của tôi là Laura Maria.|]
[dialogue:Virkailija|Mikä on teidän henkilötunnus?|Mã số định danh cá nhân (ID số) của bạn là số mấy?|henkilötunnus / hetu = mã định danh cá nhân 11 ký tự tại Phần Lan]
[dialogue:Hakija|Se on 140582-124A.|Mã của tôi là 140582-124A.|Ngày sinh 14/05/1982]
[dialogue:Virkailija|Mikä on teidän lähiosoite?|Địa chỉ nhà hiện tại của bạn là gì?|lähiosoite / osoite = địa chỉ đường phố, số nhà]
[dialogue:Hakija|Mäntytie neljä A seitsemän.|Đường Mäntytie số 4, lối A, căn hộ số 7.|]
[dialogue:Virkailija|Entä postinumero ja postitoimipaikka?|Còn mã bưu chính và thành phố cư trú?|postinumero = mã bưu chính (5 chữ số); postitoimipaikka = thành phố]
[dialogue:Hakija|Nolla nolla kaksi nolla nolla Helsinki.|00200 Helsinki.|]
[dialogue:Virkailija|Mikä on teidän puhelinnumero?|Số điện thoại của bạn là số mấy?|puhelinnumero = số điện thoại]
[dialogue:Hakija|Kännykkä on nolla viisi nolla, kolme neljä viisi kuusi seitsemän kahdeksan.|Số di động là 050 345678.|kännykkä = điện thoại di động]
[dialogue:Virkailija|Onko teillä sähköpostiosoite?|Bạn có địa chỉ email không?|sähköpostiosoite = địa chỉ hòm thư điện tử]
[dialogue:Hakija|Joo, laura piste nieminen ät posti piste fi.|Có ạ, laura chấm nieminen a còng posti chấm fi.|piste = dấu chấm (. ); ät = ký tự @]
[dialogue:Virkailija|Mikä on teidän kansalaisuus ja äidinkieli?|Quốc tịch và tiếng mẹ đẻ của bạn là gì?|kansalaisuus = quốc tịch; äidinkieli = tiếng mẹ đẻ]
[dialogue:Hakija|Olen suomalainen ja äidinkieli on suomi.|Tôi là người Phần Lan và tiếng mẹ đẻ là tiếng Phần Lan.|]
[dialogue:Virkailija|Hyvä, kiitos paljon. Allekirjoittakaa vielä tähän.|Tốt rồi, cảm ơn bạn rất nhiều. Bạn vui lòng ký tên vào chỗ này nữa nhé.|allekirjoittaa = ký tên; allekirjoitus = chữ ký]
[dialogue:Hakija|Kiitos.|Cảm ơn cô.|]

---

### 📝 3. Thử thách điền form thông tin cá nhân

[exercise:ex_w8_h27_lomake]`;

// 6. CHAPTER 4: w9_d1_thoai_mina (Sivu 86-88)
const ch4_w9_d1_content = `# 👤 Kappale 4: Minä - Giới thiệu bản thân & Cuộc sống (Trang 87-88)

Chào mừng bạn đến với **Chương 4 (Kappale 4)** của giáo trình chuẩn **Suomen Mestari 1** (Trang 86-88)! 

Trong chương này, chúng ta sẽ lắng nghe 3 đoạn độc thoại tự sự đặc sắc của **Olga**, **Alex** và **Pedro** khi họ miêu tả chi tiết về bản thân: ngoại hình, tính cách, tình trạng hôn nhân, người thân trong gia đình cũng như nơi ăn chốn ở tại Phần Lan.

Toàn bộ văn bản dưới đây được lấy **chính xác 100% nguyên văn từ sách giáo trình Suomen Mestari 1 (Trang 87-88)**! Mỗi câu đều có nút loa phát âm bản xứ riêng để bạn nghe và đọc theo.

---

[dialogue_toggle:Bật/tắt tất cả bản dịch tiếng Việt]

### 👩 1. Đoạn tự sự của Olga Mäkelä (Trang 87)

[reader:Minä olen Olga. Minä olen naimisissa Veijon kanssa.|Tôi là Olga. Tôi đã kết hôn với anh Veijo. (olla naimisissa + kanssa = kết hôn với ai)]
[reader:Veijo on suomalainen. Minä rakastan häntä.|Anh Veijo là người Phần Lan. Tôi rất yêu anh ấy. (rakastaa + đối cách häntä = yêu thương ai đó)]
[reader:Meillä on yksi lapsi. Hän on söpö 4-vuotias tyttö ja hänen nimi on Julia.|Chúng tôi có một đứa con. Con bé là một bé gái 4 tuổi rất đáng yêu và tên con bé là Julia. (söpö = đáng yêu, kháu khỉnh; 4-vuotias = 4 tuổi)]
[reader:Me asumme Helsingissä, mutta Veijo on töissä Espoossa. Hän on bussikuski.|Chúng tôi sống ở Helsinki, nhưng anh Veijo đi làm ở Espoo. Anh ấy là một tài xế xe buýt. (olla töissä = đang đi làm; bussikuski = tài xế lái xe buýt)]
[reader:Minulla ei ole töitä Suomessa vielä, mutta minä etsin työpaikkaa. Nyt olen opiskelija.|Tôi chưa có việc làm ở Phần Lan, nhưng tôi đang tìm việc. Hiện tại tôi là một học viên. (minulla ei ole töitä = tôi không có việc; etsiä työpaikkaa = tìm kiếm việc làm)]
[reader:Olen samalla suomen kurssilla Pedron ja Alexin kanssa.|Tôi học cùng khóa tiếng Phần Lan với Pedro và Alex. (samalla kurssilla = ở cùng khóa học; kanssa = cùng với)]

---

### 👨 2. Đoạn tự sự của Alex Mbeki (Trang 87)

[reader:Minun nimi on Alex ja olen 31 vuotta vanha.|Tên tôi là Alex và tôi 31 tuổi. (vuotta vanha = ngần ấy tuổi)]
[reader:Olen pitkä ja hoikka ja pidän urheilusta.|Tôi cao ráo và người mảnh khảnh, tôi rất thích thể thao. (pitkä = cao; hoikka = thon gọn/gầy; pitää + stä = thích điều gì; urheilu = thể thao)]
[reader:Olen rauhallinen ja ehkä myös vähän ujo. Minä olen eronnut ja nyt olen sinkku.|Tôi là người điềm tĩnh và có lẽ cũng hơi nhút nhát một chút. Tôi đã ly hôn và hiện tại đang độc thân. (rauhallinen = điềm đạm; ujo = nhút nhát; eronnut = đã ly dị; sinkku = độc thân)]
[reader:Minulla ei ole perhettä Suomessa, mutta Etelä-Afrikassa minulla on iso suku: kaksi pikkusiskoa, isoveli, neljä tätiä, kolme setää ja 18 serkkua.|Tôi không có gia đình ở Phần Lan, nhưng ở Nam Phi tôi có một dòng họ lớn: 2 em gái, 1 anh trai, 4 cô/dì, 3 chú/bác và 18 người anh chị em họ. (suku = họ hàng/dòng họ; täti = cô/dì; setä = chú/bác; serkku = anh chị em họ)]
[reader:Olen nyt helsinkiläinen. Minulla on kiva asunto Itä-Helsingissä.|Hiện tại tôi là một cư dân Helsinki. Tôi có một căn hộ xinh xắn ở khu Đông Helsinki. (helsinkiläinen = người dân Helsinki; kiva asunto = căn hộ dễ thương)]
[reader:Asunnossa on kaksi huonetta ja keittiö. Minä pidän minun asunnosta, koska se on valoisa ja viihtyisä. Talossa on neljä kerrosta.|Căn hộ có 2 phòng và một nhà bếp. Tôi rất thích căn hộ của mình vì nó tràn ngập ánh sáng và ấm cúng, dễ chịu. Tòa nhà có 4 tầng. (valoisa = sáng sủa; viihtyisä = ấm cúng, thoải mái; kerros = tầng lầu)]

---

### 🚴 3. Đoạn tự sự của Pedro Ribeiro (Trang 88)

[reader:Minun nimi on Pedro. Olen puhelias ja iloinen brasilialainen.|Tên tôi là Pedro. Tôi là một chàng trai người Brazil cởi mở, hay nói và luôn vui vẻ. (puhelias = hay nói, cởi mở; iloinen = vui tươi, rạng rỡ)]
[reader:Minulla on musta kihara tukka ja tummat silmät. Olen 178 cm pitkä.|Tôi có mái tóc đen xoăn và đôi mắt màu sẫm. Tôi cao 178 cm. (kihara tukka = tóc xoăn; tummat silmät = mắt sẫm màu; pitkä = cao)]
[reader:Minun tyttöystävä Hanna on suomalainen. Hän on opiskelija, mutta hän on myös töissä kaupassa.|Bạn gái của tôi là Hanna, người Phần Lan. Cô ấy là sinh viên, nhưng cô ấy cũng đi làm thêm tại một cửa hàng. (tyttöystävä = bạn gái; töissä kaupassa = làm việc ở cửa hàng)]
[reader:Meillä ei ole autoa. Ajamme paljon pyörällä.|Chúng tôi không có ô tô. Chúng tôi đi lại rất nhiều bằng xe đạp. (ajaa pyörällä = đi lại bằng xe đạp)]
[reader:Minulla on myös suomalainen ystävä Mikko, mutta hän ei asu nyt Suomessa. Hän on töissä Brasiliassa.|Tôi cũng có một người bạn Phần Lan tên là Mikko, nhưng anh ấy hiện không sống ở Phần Lan. Anh ấy đang làm việc ở Brazil. (ystävä = bạn bè)]

---

### 📝 4. Thử thách tương tác tự giới thiệu bản thân

[exercise:ex_w9_d1_mina]`;

// 7. CHAPTER 4: w9_d3_tuvung_vaatteet_varit (Sivu 92-93: Vaatekaupassa)
const ch4_w9_d3_content = `# 👗 Từ vựng: Quần áo, Màu sắc & Puhutaan! Vaatekaupassa (Trang 92-93)

Chào mừng bạn đến với bài học thời trang và mua sắm của **Chương 4 (Trang 92-93)** trong giáo trình **Suomen Mestari 1**!

Hôm nay chúng ta sẽ làm quen với bảng từ vựng các loại trang phục, màu sắc và bước vào đoạn đối thoại giao tiếp thực tế tại cửa hàng quần áo (**Puhutaan! Vaatekaupassa - Trang 93**).

---

### 💬 1. Lời thoại giao tiếp tại cửa hàng quần áo (Trang 93)

[dialogue_toggle:Bật/tắt tất cả bản dịch tiếng Việt]

[dialogue:Myyjä|Voinko auttaa?|Tôi có thể giúp gì được cho bạn không ạ?|Voinko auttaa? = Lời chào cửa miệng lịch sự của nhân viên bán hàng Phần Lan]
[dialogue:Asiakas|Mä vaan katselen.|Dạ cảm ơn, tôi chỉ đang dạo xem quanh thôi ạ.|mä vaan katselen = văn nói của 'minä vain katselen']
[dialogue:Asiakas|Mä etsin villapuseroa.|Tôi đang tìm một chiếc áo len chui đầu.|villapusero = áo len (dạng partitiivi: villapuseroa)]
[dialogue:Asiakas|Missä on sovituskoppi?|Phòng thử đồ ở đâu vậy bạn?|sovituskoppi = buồng thử quần áo]
[dialogue:Asiakas|Voinks mä sovittaa tätä?|Tôi có thể mặc thử chiếc áo này được không?|voinks mä = voinko minä; sovittaa = mặc thử đồ]
[dialogue:Asiakas|Onks tästä ämmää?|Chiếc này có size M không bạn?|ämmää = size M (dạng partitiivi)]
[dialogue:Asiakas|Onko tätä punaisena?|Mẫu áo này có phiên bản màu đỏ không ạ?|punaisena = màu đỏ (đuôi essiivi -na biểu thị màu sắc)]
[dialogue:Myyjä|Hetki, mä tarkistan.|Chờ một lát, tôi vào trong kiểm tra kho nhé.|hetki = một lát; tarkistaa = kiểm tra]
[dialogue:Myyjä|Onko sulla meidän kanta-asiakaskortti?|Bạn có thẻ khách hàng thân thiết của bên mình chưa?|kanta-asiakaskortti = thẻ thành viên tích điểm]
[dialogue:Myyjä|Tarvitsetko muovipussia?|Bạn có cần lấy thêm túi nilon không?|muovipussi = túi nilon (ở Phần Lan túi nilon được hỏi riêng)]
[dialogue:Myyjä|Tää tekee 97,50 €.|Chỗ đồ này của bạn tổng cộng hết 97 euro 50 cent.|tää tekee = tổng cộng là]

---

### 🏷️ 2. Bảng size quần áo chuẩn Phần Lan (Vaatekoot)

* **XS** = *äx-ässä*
* **S** = *ässä*
* **M** = *ämmä*
* **L** = *ällä*
* **XL** = *äx-ällä*

---

### 🎨 3. Bảng Màu sắc thường gặp (Värit)

| Màu sắc | Tiếng Phần Lan | Màu sắc | Tiếng Phần Lan |
| :--- | :--- | :--- | :--- |
| **Đỏ** | punainen | **Xanh dương** | sininen |
| **Xanh lá** | vihreä | **Vàng** | keltainen |
| **Đen** | musta | **Trắng** | valkoinen |
| **Xám** | harmaa | **Nâu** | ruskea |

---

### 📝 4. Thử thách tương tác mua sắm thời trang

[exercise:ex_w9_d3_vaatekauppa]`;

// 8. CHAPTER 5: w11_d3_khoidong_kappale5 (Sivu 114-116: Meidän tavallinen päivä)
const ch4_w11_d3_content = `# ⏰ Kappale 5: Meidän tavallinen päivä (Một ngày bình thường của gia đình - Trang 115-116)

Chào mừng bạn đến với bài đọc khởi động của **Chương 5 (Kappale 5)** trong giáo trình **Suomen Mestari 1** (Trang 114-116)!

Hôm nay chúng ta sẽ bước vào nhịp sống thường nhật của gia đình anh **Lauri Mäkelä** (đầu bếp), chị **Tuula** (dược sĩ) cùng hai con nhỏ **Kalle** và **Emma**. Từ tiếng chuông báo thức lúc 6 giờ sáng, bữa ăn sáng vội vã, giờ đi làm, buổi học bơi cho đến lúc cả nhà chúc nhau ngủ ngon.

Toàn bộ văn bản dưới đây được trích **chính xác 100% nguyên văn từ sách giáo trình Suomen Mestari 1 (Trang 115-116)**! Mỗi câu đọc đều tích hợp nút loa phát âm chuẩn bản xứ để bạn luyện nghe và nhại theo.

---

[dialogue_toggle:Bật/tắt tất cả bản dịch tiếng Việt]

### 🌅 1. Buổi sáng & Đi làm (Trang 115)

[reader:Minä olen Lauri Mäkelä. Olen suomalainen mies ja isä. Minulla on vaimo ja kaksi lasta.|Tôi là Lauri Mäkelä. Tôi là một người đàn ông và một người cha Phần Lan. Tôi có một người vợ và hai người con. (vaimo = vợ; kaksi lasta = 2 đứa con)]
[reader:Minä herään kello 6, kun herätyskello soi. Käyn ensin suihkussa ja puen sitten päälle.|Tôi thức dậy lúc 6 giờ khi chuông báo thức reo. Trước tiên tôi đi tắm vòi sen rồi sau đó mặc quần áo. (herätä = thức giấc; herätyskello soi = đồng hồ báo thức reo; käydä suihkussa = đi tắm vòi sen; pukea päälle = mặc đồ vào)]
[reader:Sen jälkeen teen keittiössä aamupalaa ja luen lehteä. Kun Tuula ja lapset heräävät, syömme yhdessä aamupalaa.|Sau đó tôi chuẩn bị bữa sáng trong bếp và đọc báo. Khi Tuula và các con thức dậy, chúng tôi cùng nhau ăn sáng. (sen jälkeen = sau đó; aamupala = bữa sáng; lukea lehteä = đọc báo; syödä yhdessä = ăn cùng nhau)]
[reader:Lapset syövät yleensä muroja ja minä syön leipää. Tuula ei syö aamulla mitään. Hän juo vain kahvia.|Lũ trẻ thường ăn ngũ cốc còn tôi ăn bánh mì. Tuula không ăn gì vào buổi sáng cả. Cô ấy chỉ uống cà phê. (yleensä = thường thường; murot = ngũ cốc ăn sáng; leipä = bánh mì; ei mitään = không thứ gì; juo vain kahvia = chỉ uống cà phê)]
[reader:Lähden töihin kello 7.15. Olen töissä lounasravintolassa. Olen kokki. Töissä teen ruokaa kolmen työkaverin kanssa.|Tôi rời nhà đi làm lúc 7 giờ 15. Tôi làm việc tại một nhà hàng ăn trưa. Tôi là đầu bếp. Ở chỗ làm, tôi nấu ăn cùng với ba người đồng nghiệp. (lähteä töihin = đi làm; lounasravintola = nhà hàng phục vụ bữa trưa; kokki = đầu bếp; tehdä ruokaa = nấu ăn; työkaveri = đồng nghiệp)]
[reader:Aamulla Tuula kävelee Emman kanssa päiväkotiin. Sitten hän ajaa bussilla töihin. Hän on töissä apteekissa.|Vào buổi sáng, Tuula dắt bé Emma đi bộ đến trường mầm non. Sau đó cô ấy đi xe buýt đến chỗ làm. Cô ấy làm việc tại một hiệu thuốc. (kävellä = đi bộ; päiväkoti = nhà trẻ, trường mầm non; ajaa bussilla = đi bằng xe buýt; apteekki = hiệu thuốc Tây)]

---

### 🌇 2. Buổi chiều, Hoạt động gia đình & Đi ngủ (Trang 116)

[reader:Kalle menee kouluun pyörällä. Tänään koulu loppuu kahdelta. Koulun jälkeen Kalle pelaa kaverin kanssa jalkapalloa.|Kalle đạp xe đạp đến trường. Hôm nay giờ học ở trường kết thúc lúc 2 giờ chiều. Sau giờ học, Kalle chơi bóng đá cùng với bạn bè. (mennä kouluun = đi học; koulu loppuu = trường tan học; kahdelta = lúc 2 giờ; pelata jalkapalloa = đá bóng)]
[reader:Iltaisin teemme usein jotain yhdessä. Tänään minä ja Kalle menemme uimahalliin. Uimme kaksi tuntia.|Vào các buổi tối chúng tôi thường làm gì đó cùng nhau. Hôm nay tôi và bé Kalle đi đến cung bơi lội. Chúng tôi bơi trong hai tiếng đồng hồ. (iltaisin = vào các buổi tối; usein = thường xuyên; uimahalli = hồ bơi trong nhà; uida = bơi lội; kaksi tuntia = 2 giờ đồng hồ)]
[reader:Emma ja Tuula eivät tule uimahalliin. He menevät kenkäkauppaan, koska Emma tarvitsee kesäkengät. Hän valitsee pinkit sandaalit.|Emma và Tuula không đến hồ bơi. Họ đi đến cửa hàng giày dép, vì Emma cần một đôi giày mùa hè. Con bé chọn một đôi xăng-đan màu hồng. (kenkäkauppa = cửa hàng giày dép; tarvita = cần; kesäkengät = giày dép mùa hè; valita = lựa chọn; pinkit sandaalit = dép xăng-đan màu hồng)]
[reader:Kotona Tuula tekee ruokaa. Ruoan jälkeen lapset haluavat katsoa televisiota.|Ở nhà Tuula nấu cơm tối. Sau bữa ăn, các con muốn xem tivi. (kotona = ở nhà; tehdä ruokaa = nấu ăn; katsoa televisiota = xem tivi)]
[reader:Minä olen jo väsynyt, mutta lapset eivät ole. Tuula ja lapset lukevat kirjaa. Yhdeksältä lapset pesevät hampaat. Sitten sanomme 'hyvää yötä' ja lapset menevät nukkumaan.|Tôi đã thấm mệt rồi, nhưng lũ trẻ thì vẫn chưa. Tuula và các con đọc sách. Lúc 9 giờ các con đi đánh răng. Sau đó chúng tôi chúc 'ngủ ngon' và các con lên giường đi ngủ. (väsynyt = mệt mỏi; lukea kirjaa = đọc sách; yhdeksältä = lúc 9 giờ; pestä hampaat = đánh răng; mennä nukkumaan = đi ngủ)]

---

### 📝 3. Thử thách đọc hiểu sinh hoạt gia đình

[exercise:ex_w11_d3_tavallinen_paiva]`;

// 9. CHAPTER 5: w12_d1_tuvung_sinhhoat_hangngay (Sivu 120-121: Aamupalapöydässä)
const ch5_w12_d1_content = `# ⏰ Kappale 5: Từ vựng Sinh hoạt & Puhutaan! Aamupalapöydässä (Trang 117-121)

Chào mừng bạn đến với bài học từ vựng và giao tiếp hàng ngày của **Chương 5 (Trang 117-121)** trong giáo trình **Suomen Mestari 1**!

Bên cạnh việc làm chủ các cụm động từ miêu tả lịch trình sinh hoạt từ sáng đến tối, chúng ta sẽ bước vào cuộc trò chuyện thực tế đầy sinh động bên bàn ăn sáng giữa bố Lauri và cậu con trai Kalle (**Puhutaan! Aamupalapöydässä - Trang 121**).

---

### 💬 1. Hội thoại bên bàn ăn sáng: Aamupalapöydässä (Trang 121)

[dialogue_toggle:Bật/tắt tất cả bản dịch tiếng Việt]

[dialogue:Lauri|Huomenta Kalle, nukuiks sä hyvin?|Chào buổi sáng Kalle, con ngủ ngon giấc không?|nukuiks sä = nukuitko sinä (thì quá khứ của nukkua)]
[dialogue:Kalle|Mhmm...|Dạ ừm...|tiếng ngái ngủ của trẻ nhỏ]
[dialogue:Lauri|Otaks sä muroja?|Con có lấy ngũ cốc ăn không?|otaks sä = otatko sinä; murot = ngũ cốc]
[dialogue:Kalle|Joo.|Dạ có.|]
[dialogue:Lauri|Äiti menee Emman kanssa illalla ostoksille. Tuuks sä mun kanssa uimaan?|Tối nay mẹ dẫn bé Emma đi mua sắm. Con có muốn đi bơi cùng bố không?|mennä ostoksille = đi mua sắm; Tuuks sä = Tuletko sinä; mun kanssa = cùng với bố]
[dialogue:Kalle|Ai tänään? Monelta?|Ủa hôm nay hả bố? Mấy giờ vậy bố?|Monelta? = Mihin aikaan? (Lúc mấy giờ?)]
[dialogue:Lauri|No, käyks vaikka puol viideltä? Mä tuun suoraan töistä.|Thì tầm bốn giờ rưỡi chiều được không con? Bố đi làm về ghé qua thẳng luôn.|käyks = käykö (có tiện không); puol viideltä = 16:30; suoraan töistä = thẳng từ chỗ làm]
[dialogue:Kalle|Öö tota, en mä ehdi puol viideks. Mä meen Jussin kanssa koulun jälkeen pelaamaan futista. Ja sit mun täytyy syödäkin.|Ơ dạ, bốn rưỡi thì con không kịp rồi bố ạ. Tan học con hẹn bạn Jussi đi đá bóng rồi. Với lại sau đó con cũng phải ăn cơm nữa.|en mä ehdi = tôi không kịp giờ; futis = jalkapallo (bóng đá); mun täytyy = tôi phải]
[dialogue:Lauri|No sopiiks viideltä?|Thế năm giờ chiều có tiện không con?|sopiiks = sopiiko (có hợp/tiện không?)]
[dialogue:Kalle|Joo, sopii! Missä me nähään?|Dạ được, giờ đó hợp lý đấy bố! Mình gặp nhau ở đâu vậy bố?|Missä me nähään? = Chúng ta gặp nhau ở đâu? (văn nói của nähdään)]
[dialogue:Lauri|Nähään suoraan uimahallilla.|Mình gặp nhau trực tiếp ngay tại hồ bơi nhé con.|uimahalli = hồ bơi công cộng]
[dialogue:Kalle|Okei.|Dạ vâng bố.|]

---

### 📚 2. Bảng cụm từ sinh hoạt hàng ngày cốt lõi

| Tiếng Phần Lan | Tiếng Việt | Nhóm động từ |
| :--- | :--- | :--- |
| **herätä** | thức giấc | Nhóm 4 (*herää-*) |
| **nousta ylös** | rời khỏi giường bước dậy | Nhóm 3 (*nouse- ylös*) |
| **pestä hampaat** | đánh răng | Nhóm 3 (*pese-*) |
| **käydä suihkussa** | đi tắm vòi sen | Nhóm 3 (*käy-*) |
| **pukea päälle** | mặc quần áo vào | Nhóm 1 (*puke-*) |
| **syödä aamupalaa** | ăn bữa điểm tâm sáng | Nhóm 2 (*syö-*) |
| **lähteä töihin / kouluun** | xuất phát đi làm / đi học | Nhóm 2 (*lähde-*) |
| **mennä nukkumaan** | lên giường đi ngủ | Nhóm 3 (*mene-*) |

---

### 📝 3. Thử thách phản xạ từ vựng sinh hoạt

[exercise:ex_w12_d1_sinhhoat]`;

// 10. CHAPTER 5: w14_d3_khoidong_kappale6 (Sivu 146-148: Pedro ja Hanna etsivät asuntoa & Muutto)
const ch5_w14_d3_content = `# 🏡 Kappale 6: Pedro ja Hanna etsivät asuntoa & Muutto (Trang 147-148)

Chào mừng bạn đến với bài đọc mở đầu của **Chương 6 (Kappale 6)** trong giáo trình **Suomen Mestari 1** (Trang 146-148)!

Trong bài học này, chúng ta sẽ cùng theo dõi hai câu chuyện gắn liền với văn hóa nhà ở tại Phần Lan:
1. **Tìm kiếm căn hộ cho thuê (Asuntoilmoitus & Keskustelu)**: Pedro và Hanna đọc tin rao vặt trên trang *kotitalo.com* và bàn luận về căn hộ 2 phòng tại khu Lehtelä, Helsinki.
2. **Ngày chuyển nhà (Muutto)**: Xe tải chở đồ đạc đến nơi ở mới và cuộc gặp gỡ đầu tiên đầy thân thiện giữa Pedro với hai đứa trẻ hàng xóm Kalle và Emma.

Toàn bộ văn bản dưới đây được giữ **chính xác 100% nguyên văn từ sách giáo trình Suomen Mestari 1 (Trang 147-148)**!

---

[dialogue_toggle:Bật/tắt tất cả bản dịch tiếng Việt]

### 📰 1. Đọc tin đăng cho thuê nhà: ASUNTOILMOITUS (kotitalo.com)

[reader:VUOKRALLE ANNETAAN: 45 m² | vuokra 870 e/kk + vesimaksu 14 e/hlö/kk|CHO THUÊ CĂN HỘ: 45 mét vuông | Tiền thuê 870 euro/tháng + tiền nước 14 euro/người/tháng. (vuokralle annetaan = cho thuê; vuokra = tiền thuê nhà; vesimaksu = phí tiền nước; hlö = henkilö/người; kk = kuukausi/tháng)]
[reader:2 h + k + p, Puistotie 20, Helsinki|2 phòng + bếp + ban công, Địa chỉ số 20 đường Puistotie, Helsinki. (2 h = kaksi huonetta; k = keittiö; p = parveke)]
[reader:Hyväkuntoinen valoisa kaksio kerrostalossa Lehtelässä. Rauhallinen sijainti Puistotiellä viihtyisällä alueella.|Căn hộ 2 phòng sáng sủa, tình trạng tốt nằm trong tòa chung cư tại Lehtelä. Vị trí yên tĩnh trên đường Puistotie thuộc khu dân cư tiện nghi, dễ chịu. (hyväkuntoinen = tình trạng tốt; kaksio = căn hộ 2 phòng; kerrostalo = nhà chung cư; rauhallinen sijainti = vị trí yên tĩnh; viihtyisä = ấm cúng, đáng sống)]
[reader:3. kerros, ei hissiä. Asunnossa on pieni parveke. Isossa keittiössä on tilaa ruokapöydälle.|Tầng 3, không có thang máy. Căn hộ có ban công nhỏ. Bếp rộng rãi có đủ chỗ kê bàn ăn. (kerros = tầng lầu; ei hissiä = không có thang máy; parveke = ban công; ruokapöytä = bàn ăn)]
[reader:Sauna ja pesutupa ovat kellarissa. Parkkipaikat etupihalla. Vapaa 1.9. Vuokratakuu 2 kk vuokra. Yhteydenotot sähköpostitse.|Phòng xông hơi sauna và phòng giặt đồ chung nằm ở dưới tầng hầm. Chỗ đậu xe ở sân trước. Căn hộ trống dọn vào từ 1.9. Tiền cọc đặt cọc 2 tháng tiền thuê. Liên hệ qua email. (pesutupa = phòng giặt chung; kellari = tầng hầm; vuokratakuu = tiền cọc bảo đảm thuê nhà; yhteydenotot = cách thức liên hệ)]

---

### 💬 2. Hội thoại 1: Pedro ja Hanna etsivät asuntoa (Trang 147)

[dialogue:Pedro|Hanna, katso, tämä näyttää hyvältä!|Hanna ơi, em nhìn này, căn này trông ổn quá chừng!|näyttää hyvältä = trông có vẻ rất tốt]
[dialogue:Hanna|Onko se kaksio?|Đó là căn hộ hai phòng hả anh?|kaksio = căn hộ 2 phòng]
[dialogue:Pedro|Joo, on. 45 neliötä.|Đúng rồi em. Rộng 45 mét vuông.|neliö = mét vuông]
[dialogue:Hanna|Missä päin se on?|Nó nằm ở khu vực nào vậy anh?|Missä päin = ở mạn/khu vực nào]
[dialogue:Pedro|Öö, odota, minä katson... Tämä on Lehtelässä, Puistotiellä. Eikö se ole ihan kiva alue?|Ơ để anh xem nào... Căn này ở khu Lehtelä, đường Puistotie. Khu đó chẳng phải rất dễ thương sao em?|Eikö se ole = Chẳng phải nó là... sao?; kiva alue = khu vực xinh xắn]
[dialogue:Hanna|Joo, on! Lehtelästä menee juna keskustaan. Paljonko sen vuokra on?|Vâng, đúng rồi anh! Từ Lehtelä có tàu hỏa đi thẳng vào trung tâm thành phố. Tiền thuê căn đó là bao nhiêu vậy anh?|Lehtelästä = từ Lehtelä; juna = tàu hỏa; keskustaan = vào trung tâm]
[dialogue:Pedro|870 euroa plus vesimaksut.|870 euro cộng thêm các khoản tiền nước.|plus vesimaksut = cộng tiền nước]
[dialogue:Hanna|Ohhoh, hirveän kallis!|Ái chà, đắt khủng khiếp luôn!|hirveän kallis = đắt đỏ kinh khủng]
[dialogue:Pedro|Niin on, mutta mennäänkö silti katsomaan?|Đắt thật, nhưng tụi mình vẫn cứ đi xem thử chứ em?|silti = dù sao đi nữa; mennäänkö katsomaan = tụi mình đi xem nhé]
[dialogue:Hanna|Mennään vaan. Milloin siellä on näyttö?|Đi thì đi chứ. Khi nào người ta mở cửa cho khách xem nhà vậy anh?|näyttö = buổi mở cửa xem căn hộ]
[dialogue:Pedro|En minä tiedä. Tässä on vain sähköpostiosoite.|Anh cũng không biết nữa. Ở đây người ta chỉ để mỗi địa chỉ email thôi.|En minä tiedä = Tôi không biết]
[dialogue:Hanna|Okei, no täytyy sitten kirjoittaa ja kysyä.|Được rồi, thế thì mình phải gửi email hỏi thôi.|täytyy kirjoittaa ja kysyä = phải viết thư và hỏi thăm]

---

### 🚚 3. Hội thoại 2: Muutto - Chuyển nhà & Gặp gỡ hàng xóm mới (Trang 148)

[reader:On iltapäivä. Mäkelät istuvat keittiössä ja syövät lounasta. Kalle katsoo ulos ikkunasta.|Trời đã về chiều. Gia đình Mäkelä đang ngồi trong bếp ăn bữa trưa. Cậu bé Kalle nhìn ra ngoài cửa sổ. (iltapäivä = buổi chiều; istua keittiössä = ngồi trong bếp; katsoa ulos ikkunasta = nhìn ra ngoài cửa sổ)]
[reader:Pihalle ajaa iso pakettiauto. Mies nostaa autosta monta ruskeaa laatikkoa kadulle. Nainen kantaa laatikot kadulta sisään taloon.|Một chiếc xe tải lớn chạy vào trong sân. Một người đàn ông bốc nhiều chiếc thùng các-tông màu nâu từ trên xe xuống lề đường. Một người phụ nữ khuân những chiếc thùng từ lề đường vào trong tòa nhà. (pakettiauto = xe tải van nhỏ; nostaa = nâng/bốc dỡ; ruskea laatikko = hộp/thùng màu nâu; kantaa = khuân vác)]
[reader:Emma ja Kalle menevät ulos. He haluavat nähdä, mitä pihalla tapahtuu.|Emma và Kalle chạy ra ngoài. Chúng muốn xem điều gì đang xảy ra ngoài sân. (mennä ulos = đi ra ngoài; mitä tapahtuu = điều gì đang diễn ra)]

[dialogue:Kalle|Hei, kuka sinä olet?|Chào chú, chú là ai vậy ạ?|kuka sinä olet = bạn/chú là ai]
[dialogue:Pedro|Hei, minä olen Pedro. Muutan tänään asuntoon numero 5.|Chào cháu, chú là Pedro. Hôm nay chú chuyển nhà đến căn hộ số 5.|muuttaa = chuyển nhà; asuntoon numero 5 = vào căn hộ số 5]
[dialogue:Kalle|Minä olen Kalle ja tässä on Emma. Me asumme numerossa 6. Sinä olet meidän uusi naapuri.|Cháu là Kalle và đây là bé Emma. Nhà cháu sống ở căn số 6. Vậy chú là người hàng xóm mới của tụi cháu rồi!|naapuri = người hàng xóm; uusi naapuri = hàng xóm mới]
[dialogue:Pedro|Hauska tavata!|Rất vui được gặp các cháu!|Hauska tavata = Rất vui được gặp gỡ]
[dialogue:Emma|Tarvitsetko apua?|Chú có cần tụi cháu phụ giúp gì không ạ?|tarvita apua = cần sự giúp đỡ]
[dialogue:Pedro|Joo, kiitos.|Có chứ, chú cảm ơn các cháu nhé.|]
[dialogue:Emma|Mitä minä voin tehdä?|Cháu có thể làm giúp chú việc gì ạ?|mitä voin tehdä = tôi có thể làm gì]
[dialogue:Pedro|Vie vaikka tämä lamppu pöydälle olohuoneeseen.|Cháu mang giúp chú chiếc đèn này đặt lên bàn trong phòng khách nhé.|viedä = mang đi; lamppu = chiếc đèn; olohuone = phòng khách]
[dialogue:Kalle|Entä minä?|Còn cháu thì sao hả chú?|]
[dialogue:Pedro|No, ota tuo pieni laatikko ja vie se keittiöön. Minä kannan nämä tuolit. Käyn ensin kellarissa ja tulen sitten.|Nào, cháu cầm giúp chú chiếc thùng nhỏ kia và mang nó vào phòng bếp nhé. Chú sẽ khuân mấy chiếc ghế này. Chú ghé xuống tầng hầm một lát rồi chú sẽ lên ngay.|ottaa = cầm/lấy; tuoli = chiếc ghế; kellari = tầng hầm]
[dialogue:Emma|Okei. Me menemme jo ylös. Onko ovi auki?|Dạ được ạ. Tụi cháu đi lên trên lầu trước đây. Cửa có đang mở không chú?|mennä ylös = đi lên trên; ovi on auki = cửa đang mở]
[dialogue:Pedro|Ei, mutta minun tyttöystävä Hanna on kotona.|Cửa không mở, nhưng bạn gái của chú là cô Hanna đang ở trong nhà đấy.|tyttöystävä = bạn gái; kotona = ở nhà]

---

### 📝 4. Thử thách tương tác thuê nhà & Chuyển nhà

[exercise:ex_w14_d3_asunto_muutto]`;

// 11. CHAPTER 7: w18_d1_tuvung_matkustaminen_hotelli (Sivu 184-185 & Sivu 189-190)
const ch7_w18_d1_content = `# 🚆 Kappale 7: Kylässä & Puhutaan! Hotellissa (Trang 185, 190)

Chào mừng bạn đến với **Chương 7 (Kappale 7)** của giáo trình chuẩn **Suomen Mestari 1** (Trang 184-190)!

Hôm nay chúng ta sẽ đồng hành cùng **Pedro và Hanna** trong chuyến du lịch cuối tuần tới thành phố **Tampere**:
1. **Ghé thăm nhà người thân (Kylässä - Trang 185)**: Đến thăm cô Kyllikki-täti, thưởng thức cà phê, bánh ngọt pulla và lên kế hoạch khám phá các danh thắng nổi tiếng ở Tampere.
2. **Thủ tục nhận phòng khách sạn (Hotellissa - Trang 190)**: Đoạn đối thoại thực tế nhận phòng, hỏi về bữa sáng buffet và phòng xông hơi sauna tại quầy tiếp tân khách sạn Hotelli Pirkka.

Toàn bộ văn bản dưới đây được giữ **chính xác 100% nguyên văn từ sách giáo trình Suomen Mestari 1 (Trang 185, 190)**!

---

[dialogue_toggle:Bật/tắt tất cả bản dịch tiếng Việt]

### 🏡 1. Hội thoại 1: Kylässä - Thăm nhà cô Kyllikki tại Tampere (Trang 185)

[reader:Viikonloppuna Pedro ja Hanna lähtevät Tampereelle. Ensin he käyvät kylässä Hannan Kyllikki-tädillä.|Vào dịp cuối tuần, Pedro và Hanna đi đến thành phố Tampere. Trước tiên họ ghé thăm nhà người cô Kyllikki của Hanna. (viikonloppuna = vào cuối tuần; lähteä Tampereelle = đi đến Tampere; käydä kylässä = đi thăm viếng ai đó)]

[dialogue:Kyllikki|Hei, kiva nähdä pitkästä aikaa!|Chào các cháu, thật vui được gặp lại sau một thời gian dài!|pitkästä aikaa = lâu ngày không gặp (câu chào kinh điển)]
[dialogue:Hanna|Niin sinuakin!|Cháu cũng rất vui được gặp lại cô ạ!|Niin sinuakin = Cháu cũng vậy đối với cô]
[dialogue:Pedro|Tässä kassissa on sinulle pieni tuliainen. Ole hyvä!|Trong chiếc túi này có một món quà nhỏ từ phương xa gửi biếu cô ạ. Xin mời cô!|tuliainen = món quà mua tặng khi đi đâu đó về/đến thăm nhà; Ole hyvä = Xin mời]
[dialogue:Kyllikki|Oi, kiitos paljon! Otatteko kahvia? Minulla on tuoretta pullaakin.|Ôi, cô cảm ơn hai cháu nhiều nhé! Hai cháu uống cà phê không? Cô có cả bánh ngọt pulla mới nướng nóng hổi nữa này.|tuore = tươi mới; pulla = bánh ngọt mì hương bạch đậu khấu Phần Lan]
[dialogue:Pedro|Joo, kiitos mielellämme.|Dạ vâng, chúng cháu rất sẵn lòng thưởng thức ạ.|mielellämme = chúng tôi rất sẵn lòng/rất vui lòng]
[dialogue:Kyllikki|Tulkaa pöytään. Miten matka meni? Tulitteko autolla vai junalla?|Nào mời hai cháu vào bàn. Chuyến đi thế nào hả hai cháu? Hai cháu đi bằng ô tô hay đi tàu hỏa?|Miten matka meni? = Chuyến đi diễn ra thế nào?; vai = hay là (trong câu hỏi)]
[dialogue:Hanna|Junalla. Meillä oli mukava matka, vaikka juna oli melkein puoli tuntia myöhässä.|Dạ chúng cháu đi tàu hỏa. Chuyến đi rất dễ chịu, mặc dù tàu bị trễ gần nửa tiếng đồng hồ.|vaikka = mặc dù; myöhässä = bị trễ giờ; melkein = gần như]
[dialogue:Kyllikki|No mitä te aiotte tehdä täällä?|Thế hai cháu dự định sẽ làm gì ở đây nào?|aikoa = dự định làm gì; tehdä täällä = làm ở đây]
[dialogue:Pedro|Hanna haluaa näyttää minulle kaikki tärkeät paikat, koska olen täällä ensimmäistä kertaa.|Hanna muốn dẫn cháu đi xem tất cả những địa điểm quan trọng, vì đây là lần đầu tiên cháu đến Tampere ạ.|näyttää = chỉ/cho xem; tärkeät paikat = các địa điểm quan trọng; ensimmäistä kertaa = lần đầu tiên]
[dialogue:Hanna|Joo, käymme ainakin Tammerkoskella ja museokeskus Vapriikissa. Syömme lounasta kauppahallissa ja sen jälkeen käymme Pyynikin näkötornissa.|Vâng, chúng cháu sẽ ghé ghềnh thác Tammerkoski và trung tâm bảo tàng Vapriikki. Tụi cháu sẽ ăn trưa ở chợ lồng Kauppahalli và sau đó lên tháp ngắm cảnh Pyynikki.|ainakin = ít nhất; kauppahalli = khu chợ lồng truyền thống; näkötorni = tháp ngắm cảnh toàn thành phố]
[dialogue:Kyllikki|Hyvä idea. Sieltä on upeat näköalat ja sen kahvilassa on herkulliset munkit.|Ý kiến hay đấy cháu. Từ trên tháp có tầm nhìn ngắm cảnh tuyệt đẹp và quán cà phê ở đó có món bánh rán vòng munkki ngon tuyệt đỉnh.|upeat näköalat = cảnh quan tráng lệ; munkki = bánh rán vòng phủ đường kiểu Phần]
[dialogue:Hanna|Niin onkin! Ja jos jaksamme, käymme ehkä myös Muumimuseossa tai Särkänniemen huvipuistossa.|Đúng vậy cô ạ! Và nếu còn sức, có thể chúng cháu cũng sẽ ghé thăm Bảo tàng Moomin hoặc công viên giải trí Särkänniemi.|jos jaksamme = nếu tụi cháu còn đủ sức lực; huvipuisto = công viên trò chơi]
[dialogue:Pedro|Ja minä haluan maistaa mustaamakkaraa. Minun kaveri Alex sanoi, että se on tamperelainen erikoisuus.|Và cháu rất muốn nếm thử món xúc xích đen mustamakkara. Bạn Alex của cháu bảo rằng đó là đặc sản trứ danh của Tampere.|mustamakkara = dồi/xúc xích tiết đen truyền thống Tampere; erikoisuus = nét đặc sản riêng]
[dialogue:Kyllikki|Joo, niin onkin. Me syömme sitä yleensä puolukkahillon kanssa. Missä muuten yövytte täällä?|Ừ, đúng là vậy đấy. Người dân ở đây thường ăn món đó kèm với mứt việt quất đỏ puolukka. Mà nhân tiện, hai cháu nghỉ đêm ở đâu vậy?|puolukkahillo = mứt quả việt quất đỏ lingonberry; yöpyä = ngủ trọ/nghỉ qua đêm; muuten = nhân tiện]
[dialogue:Hanna|Meillä on huone hotelli Pirkassa. Siellä oli hyvä viikonlopputarjous.|Chúng cháu đặt phòng ở khách sạn Pirkka. Ở đó có gói ưu đãi cuối tuần rất tốt ạ.|viikonlopputarjous = chương trình khuyến mãi cuối tuần]
[dialogue:Kyllikki|Aijaa, sehän on kiva!|Ồ vậy à, thế thì tuyệt quá!|]
[dialogue:Hanna|Joo, ja huomenna näemme minun tamperelaiset ystävät Paulan ja Ilkan. Heillä on mökki pienessä saaressa Näsijärvellä. Menemme sinne heidän uudella veneellä.|Vâng, và ngày mai chúng cháu sẽ gặp những người bạn ở Tampere của cháu là Paula và Ilkka. Họ có một căn nhà gỗ nhỏ trên một hòn đảo ở hồ Näsijärvi. Tụi cháu sẽ ra đó bằng chiếc thuyền mới của họ.|mökki = nhà gỗ nghỉ dưỡng; saari = hòn đảo; järvi = hồ nước; vene = chiếc thuyền]
[dialogue:Pedro|On tosi kivaa lähteä mökille. Minä tykkään saunoa ja uida järvessä.|Thật sự rất tuyệt khi được đi về mökki. Cháu rất thích tắm xông hơi sauna và bơi dưới làn nước hồ.|lähteä mökille = đi về nhà gỗ nông thôn; saunoa = tắm sauna; uida järvessä = bơi dưới hồ]
[dialogue:Hanna|Niin ja vaikka tapaamme vain pari kertaa vuodessa, meillä on aina tosi hauskaa yhdessä.|Đúng vậy, và dù chúng cháu chỉ gặp nhau đôi ba lần mỗi năm, chúng cháu lúc nào cũng có những giây phút vô cùng vui vẻ bên nhau.|pari kertaa vuodessa = vài lần trong năm; tosi hauskaa = rất vui tươi]
[dialogue:Kyllikki|No varmasti!|Chắc chắn là như vậy rồi các cháu!|No varmasti = Chắc chắn là thế rồi]

---

### 🏨 2. Hội thoại 2: Puhutaan! Hotellissa - Nhận phòng tại Hotelli Pirkka (Trang 190)

[reader:Hanna ja Pedro saapuvat hotelli Pirkkaan. Hanna menee hotellin vastaanottoon.|Hanna và Pedro đến khách sạn Pirkka. Hanna tiến lại quầy lễ tân của khách sạn. (saapua = đến nơi; vastaanotto = quầy tiếp tân)]

[dialogue:Hanna|Hei! Meillä on varaus nimellä Lahtinen.|Xin chào bạn! Chúng tôi có đặt trước phòng dưới tên Lahtinen.|varaus = sự đặt chỗ/phòng; nimellä = dưới tên của]
[dialogue:Hotellivirkailija|Joo, hetkinen. Mä tarkistan koneelta. Tässä se on: kahden hengen huone yhdeksi yöksi.|Vâng, chờ tôi một lát nhé. Tôi kiểm tra trên máy tính. Đây rồi: một phòng đôi dành cho 2 người trong 1 đêm.|tarkistan koneelta = tôi kiểm tra trên máy tính; kahden hengen huone = phòng đôi 2 người; yhdeksi yöksi = cho một đêm]
[dialogue:Hanna|Joo, just niin.|Dạ vâng, đúng chính xác là như vậy ạ.|just niin = đúng y như thế]
[dialogue:Hotellivirkailija|Voisitteko kirjoittaa tähän henkilötiedot.|Hai bạn có thể vui lòng điền thông tin cá nhân vào chỗ này giúp tôi nhé.|Voisitteko kirjoittaa = Bạn có thể viết/điền vào... không]
[dialogue:Hanna|Joo, tietysti.|Vâng, tất nhiên rồi ạ.|tietysti = tất nhiên]
[dialogue:Hotellivirkailija|Maksatteko nyt vai huomenna?|Hai bạn thanh toán luôn bây giờ hay để ngày mai ạ?|maksaa = thanh toán, trả tiền; vai = hay là]
[dialogue:Hanna|Mä voin maksaa nyt.|Tôi có thể trả luôn bây giờ ạ.|]
[dialogue:Hotellivirkailija|Hyvä, se on siis yhteensä 100 euroa ja aamiainen kuuluu hintaan.|Tốt quá, như vậy tổng cộng là 100 euro và bữa ăn sáng đã bao gồm trong giá phòng.|yhteensä = tổng cộng; aamiainen = bữa ăn sáng buffet; kuuluu hintaan = bao gồm trong giá vé/phòng]
[dialogue:Hanna|Selvä.|Dạ vâng rõ rồi.|]
[dialogue:Hotellivirkailija|Huone on 4. kerroksessa, numero 418. Tässä ovat avainkortit, olkaa hyvä. Aamiainen on kello 7-10. Ja huone täytyy luovuttaa kello 12.|Phòng của bạn ở tầng 4, phòng số 418. Đây là các thẻ khóa phòng, xin mời bạn. Bữa sáng phục vụ từ 7 đến 10 giờ. Và bạn cần phải trả phòng trước 12 giờ trưa nhé.|avainkortti = thẻ chìa khóa phòng; luovuttaa huone = trả phòng khách sạn (check-out)]
[dialogue:Hanna|Onks täällä myös sauna?|Ở đây có phòng xông hơi sauna không bạn?|onks = onko]
[dialogue:Hotellivirkailija|Kyllä on. Saunaosasto on P1-kerroksessa.|Dạ có chứ ạ. Khu vực xông hơi sauna nằm ở tầng P1.|saunaosasto = khu vực phòng xông hơi; P1-kerros = tầng hầm P1]
[dialogue:Hanna|Okei, kiitti paljon.|Dạ được rồi, cảm ơn bạn rất nhiều nhé.|kiitti paljon = cảm ơn rất nhiều]
[dialogue:Hotellivirkailija|Kiitos ja hauskaa päivää!|Cảm ơn bạn và chúc bạn có một ngày vui vẻ!|hauskaa päivää = chúc một ngày tốt lành]

---

### 📝 3. Thử thách tương tác du lịch & Đặt phòng

[exercise:ex_w18_d1_kylassa_hotellissa]`;

// 12. CHAPTER 8: w20_d1_tuvung_kulkuvalineet_liikenne (Sivu 220-222: Onnea uuteen kotiin!)
const ch8_w20_d1_content = `# 🎉 Kappale 8: Onnea uuteen kotiin! (Tiệc tân gia nhà mới - Trang 221-222)

Chào mừng bạn đến với **Chương 8 (Kappale 8)** của giáo trình chuẩn **Suomen Mestari 1** (Trang 220-222)!

Hôm nay là một ngày vô cùng đặc biệt: **Thứ Bảy ngày 3 tháng 9**, Pedro và Hanna tổ chức bữa tiệc tân gia (**Tupaantuliaiset**) tại tổ ấm mới khang trang ở Helsinki. Cùng chuẩn bị danh sách đi chợ, đón tiếp bạn bè Janita, Alex, Olga và thưởng thức món bánh kem chanh tuyệt hảo!

Toàn bộ lời dẫn truyện và hội thoại dưới đây được giữ **chính xác 100% nguyên văn từ sách giáo trình Suomen Mestari 1 (Trang 221-222)**!

---

[dialogue_toggle:Bật/tắt tất cả bản dịch tiếng Việt]

### 🛒 1. Chuẩn bị tiệc & Danh sách đi chợ (Trang 221)

[reader:Tänään on lauantai 3. syyskuuta. Illalla on Hannan ja Pedron tupaantuliaiset heidän uudessa kodissa.|Hôm nay là Thứ Bảy ngày 3 tháng Chín. Vào buổi tối sẽ diễn ra tiệc tân gia của Hanna và Pedro tại ngôi nhà mới của họ. (lauantai = thứ Bảy; syyskuu = tháng 9; tupaantuliaiset = tiệc mừng nhà mới / tiệc tân gia; uusi koti = tổ ấm mới)]

[dialogue:Hanna|Pedro, voitko sinä käydä kaupassa? Minä imuroin ja pesen lattiat sillä aikaa.|Pedro ơi, anh có thể chạy ù ra tiệm tạp hóa mua đồ giúp em được không? Em sẽ hút bụi và lau nhà trong thời gian đó.|käydä kaupassa = đi chợ/cửa hàng; imuroida = hút bụi; pestä lattiat = lau sàn nhà; sillä aikaa = trong lúc đó]
[dialogue:Pedro|Okei. Kirjoitan ensin ostoslistan. Tehdäänkö pastasalaattia ja lihapullia?|Được rồi em. Trước tiên anh ghi danh sách mua sắm đã nhé. Tụi mình làm món xà lách mì ống pasta và thịt viên lihapulla nhé em?|ostoslista = danh sách mua sắm; pastasalaatti = món xà lách mì ý pasta; lihapullat = thịt viên truyền thống Phần Lan]
[dialogue:Hanna|Joo, tehdään vaan. Ja voitko sinä leipoa sitä teidän äidin ihanaa sitruunakakkua? Se on niin hyvää!|Vâng, làm vậy đi anh. Và anh có thể nướng món bánh bông lan chanh tuyệt cú mèo của mẹ anh được không? Món đó ngon tuyệt vời luôn!|leipoa = nướng bánh; ihana = tuyệt vời, đáng yêu; sitruunakakku = bánh kem chanh vàng]
[dialogue:Pedro|Voin tietysti.|Tất nhiên là được rồi em.|Voin tietysti = Dĩ nhiên tôi có thể]
[dialogue:Hanna|Hyvä! Osta myös jotain hyvää leipää.|Tuyệt quá! Anh nhớ mua thêm chút bánh mì ngon nữa nhé.|osta = hãy mua; hyvä leipä = bánh mì ngon]
[dialogue:Pedro|Joo. Ja juotavaa tietysti.|Ừ. Và dĩ nhiên là cả đồ uống giải khát nữa chứ.|juotavaa = đồ uống, nước giải khát]

> 📝 **Danh sách đi chợ của Pedro (Ostoslista - Trang 221):**
> *pastaa (mì ống), kanaa (thịt gà), maissia (bắp ngô), mustia oliiveja (quả ô-liu đen), jauhoa (bột mì), sokeria (đường), 5 sitruunaa - luomu (5 quả chanh vàng hữu cơ), munia (trứng), voita (bơ), leipää (bánh mì), olutta (bia), vissyä (nước khoáng có ga).*

---

### 🛋️ 2. Khách đến & Tham quan căn hộ: Janita ja Pedro (Trang 222)

[reader:Vieraat saapuvat kello 19. Janita ja Pedro katselevat asuntoa.|Các vị khách đến lúc 19 giờ. Janita và Pedro cùng nhau đi xem ngắm căn hộ. (vieraat saapuvat = các vị khách đến; katsella asuntoa = ngắm nghía căn hộ)]

[dialogue:Janita|Teillä on ihana koti!|Hai bạn có một ngôi nhà tuyệt đẹp làm sao!|Teillä on = Các bạn có; ihana koti = ngôi nhà tuyệt vời]
[dialogue:Pedro|Kiitos! Meistäkin tämä on tosi kiva.|Cảm ơn bạn nhé! Bọn mình cũng cảm thấy nơi này rất dễ thương.|Meistäkin = Tụi mình cũng cảm thấy như vậy; tosi kiva = rất đẹp, rất vui]
[dialogue:Janita|Täällä on tosi avaraa ja valoisaa. Kuinka monta neliötä tässä asunnossa on?|Ở đây rất thoáng đãng và sáng sủa. Căn hộ này rộng bao nhiêu mét vuông vậy bạn?|avaraa = thoáng đãng, rộng rãi; valoisaa = ngập tràn ánh sáng; Kuinka monta neliötä = Bao nhiêu mét vuông]
[dialogue:Pedro|45.|45 mét vuông bạn ạ.|neljäkymmentäviisi neliötä]
[dialogue:Janita|Ahaa. Kiva, että keittiö on niin iso, että siellä on tilaa ruokapöydälle.|A ra vậy. Thật thích khi căn bếp rộng rãi như thế này, có đủ chỗ để kê cả một chiếc bàn ăn lớn.|iso keittiö = gian bếp rộng; ruokapöytä = bàn ăn]
[dialogue:Pedro|Joo, se on tosi hyvä, koska keittiö on myös meidän työhuone. Tässä pöydän ääressä minä teen aina kotitehtävät.|Ừ, điều đó tiện lắm, vì gian bếp này cũng là phòng làm việc của tụi mình luôn. Ngồi ngay cạnh chiếc bàn này là nơi mình luôn làm các bài tập về nhà đấy.|työhuone = phòng làm việc; kotitehtävät = bài tập về nhà]
[dialogue:Janita|Sama juttu meilläkin. Läppärit ja opiskelupaperit ovat aina ruokapöydällä.|Bên nhà mình cũng y hệt như vậy. Máy tính xách tay với giấy tờ học tập lúc nào cũng bày biện đầy trên bàn ăn.|sama juttu = điều tương tự; läppäri = laptop/máy tính xách tay; opiskelupaperit = tài liệu học tập]

---

### 🍰 3. Thưởng thức bữa ăn tân gia: Olga, Alex ja Pedro (Trang 222)

[reader:Olga, Alex ja Pedro seisovat ruokapöydän vieressä ja keskustelevat.|Olga, Alex và Pedro đứng bên cạnh bàn ăn và cùng nhau trò chuyện rôm rả. (seisoa = đứng; ruokapöydän vieressä = bên cạnh bàn ăn; keskustella = đàm đạo, trò chuyện)]

[dialogue:Olga|Tämä salaatti on tosi hyvää!|Món xà lách này ngon tuyệt vời luôn bạn ơi!|salaatti = món rau xà lách/salad]
[dialogue:Alex|Niin minustakin!|Tôi cũng thấy ngon y hệt như vậy!|Niin minustakin = Tôi cũng nghĩ/cảm thấy thế]
[dialogue:Olga|Pedro, mitä kaikkea tässä on?|Pedro này, trong món này có tất cả những nguyên liệu gì thế?|mitä kaikkea = những thứ gì tất cả]
[dialogue:Pedro|No siinä on pastaa, maissia, oliiveja, valkosipulia, kanaa ja chiliöljyä.|À thì trong đó có mì ống, bắp ngô, quả ô-liu, tỏi, thịt gà và cả dầu ớt nữa.|valkosipuli = củ tỏi; chiliöljy = dầu ớt cay]
[dialogue:Alex|Ahaa, siksi se maistuu vähän tuliselta.|À hén, hèn chi ăn thấy có vị hơi cay cay một chút.|siksi = vì thế nên; maistua tuliselta = nếm có vị cay nồng]
[dialogue:Pedro|Joo, ei kai se ole liian tulista?|Ừ, nhưng chắc là không đến nỗi quá cay đối với các bạn chứ?|ei kai = chắc là không... chứ; liian tulista = quá cay]
[dialogue:Alex|Ei ei, se on juuri sopivaa.|Không không, vị cay vừa vặn đúng điệu luôn đấy.|juuri sopivaa = vừa vặn chuẩn xác luôn]
[dialogue:Olga|Niin on. Ja tuo sitruunakakku näyttää herkulliselta.|Đúng vậy đó. Và chiếc bánh kem chanh đằng kia trông hấp dẫn ngon lành quá chừng!|näyttää herkulliselta = trông có vẻ ngon miệng, hấp dẫn]
[dialogue:Pedro|Toivottavasti se myös maistuu hyvältä! Hei Hanna, onko kahvi jo valmista?|Hy vọng là ăn vào nó cũng ngon như mắt nhìn thấy! Hanna ơi, cà phê đã pha xong chưa em?|Toivottavasti = Hy vọng rằng; onko kahvi valmista = cà phê đã sẵn sàng chưa]
[dialogue:Hanna|Joo, on. Tulkaa ottamaan kahvia ja kakkua!|Dạ xong rồi anh ơi. Mời mọi người lại đây lấy cà phê và bánh kem nhé!|Tulkaa ottamaan = Nào hãy đến lấy]

---

### 📝 4. Thử thách tương tác tiệc tân gia

[exercise:ex_w20_d1_tupaantuliaiset]`;

// 13. CHAPTER 9: w23_d1_giaotiep_laakarissa_terveyskeskus (Sivu 253-255 & Sivu 260-261)
const ch9_w23_d1_content = `# 💼 Kappale 9: Ensimmäinen työpäivä & Puhutaan! Lounaalla (Trang 255, 261)

Chào mừng bạn đến với **Chương 9 (Kappale 9)** - chương học đỉnh cao hoàn thiện giáo trình **Suomen Mestari 1** (Trang 252-261)!

Hôm nay là một cột mốc trọng đại của **Alex**: **Ngày đầu tiên đi làm (Ensimmäinen työpäivä)** tại công ty công nghệ Mix-Elektro Oy. Chúng ta sẽ cùng Alex:
1. **Làm quen với môi trường công sở (Trang 255)**: Gặp gỡ sếp Jari, nhận thẻ ra vào, bàn làm việc, tủ khóa mã số và chuẩn bị tham gia cuộc họp tuần của nhóm.
2. **Đi ăn trưa cùng đồng nghiệp (Puhutaan! Lounaalla - Trang 261)**: Đến nhà hàng ăn trưa, gọi món theo thực đơn lounaslista, chọn kanarisotto, trả tiền riêng và lấy cà phê miễn phí.

Toàn bộ văn bản dưới đây được giữ **chính xác 100% nguyên văn từ sách giáo trình Suomen Mestari 1 (Trang 255, 261)**!

---

[dialogue_toggle:Bật/tắt tất cả bản dịch tiếng Việt]

### 🏢 1. Hội thoại 1: Ensimmäinen työpäivä - Ngày đầu đi làm của Alex (Trang 255)

[reader:Tänään on Alexin ensimmäinen työpäivä Mix-Elektro Oy:ssä. Aamulla hän on niin hermostunut, että hän ei voi syödä aamupalaa.|Hôm nay là ngày làm việc đầu tiên của Alex tại công ty Mix-Elektro Oy. Buổi sáng anh ấy hồi hộp đến mức không thể nuốt nổi bữa sáng. (ensimmäinen työpäivä = ngày làm việc đầu tiên; hermostunut = lo lắng, hồi hộp; ei voi syödä = không thể ăn)]
[reader:Yhdeksältä Alexin pomo Jari odottaa Alexia yrityksen pääovella. Ensin Alex saa Jarilta työpaikan kulkukortin. Sitten he menevät hissillä toiseen kerrokseen Mix-Elektron toimistoon.|Lúc 9 giờ, người sếp của Alex là anh Jari đứng đón Alex ở cửa chính của công ty. Trước tiên Alex nhận thẻ ra vào chỗ làm từ anh Jari. Sau đó họ đi thang máy lên tầng 2 vào văn phòng công ty Mix-Elektro. (pomo = sếp, trưởng phòng; pääovi = cửa chính ra vào; kulkukortti = thẻ từ ra vào; hissi = thang máy; toinen kerros = tầng 2)]

[dialogue:Jari|No niin Alex, näytän sinulle ensin sinun työpisteen. Se on tässä.|Nào Alex, trước tiên tôi sẽ chỉ cho cậu vị trí bàn làm việc của cậu nhé. Nó ở đây này.|työpiste = vị trí/bàn làm việc cá nhân; näytän = tôi chỉ cho bạn xem]
[dialogue:Alex|Okei.|Dạ vâng anh.|]
[dialogue:Jari|Voit laittaa sinun takin ja muut tavarat tuohon kaappiin. Et tarvitse avainta, siinä on koodilukko.|Cậu có thể treo áo khoác và các đồ đạc cá nhân vào chiếc tủ khóa đằng kia. Cậu không cần chìa khóa đâu, ở đó có khóa bấm mã số rồi.|kaappi = tủ đựng đồ; avain = chìa khóa; koodilukko = khóa mật mã số]
[dialogue:Alex|Hyvä juttu!|Dạ hay quá anh!|Hyvä juttu = Tiện quá / hay quá]
[dialogue:Jari|Esittelen sinulle ensin tilat ja vähän myöhemmin tapaat meidän tiimin muut työntekijät.|Tôi sẽ giới thiệu sơ qua các phòng ốc tiện ích cho cậu trước, rồi lát nữa cậu sẽ gặp gỡ những nhân viên khác trong nhóm của chúng ta.|esitellä = giới thiệu; tilat = các cơ sở/phòng ban; työntekijä = nhân viên, người lao động]
[dialogue:Alex|Joo, kiva. Kuinka monta henkilöä meidän tiimiin kuuluu?|Dạ tuyệt. Nhóm của chúng ta gồm có bao nhiêu thành viên vậy anh?|Kuinka monta henkilöä = Bao nhiêu người; tiimiin kuuluu = thuộc về nhóm]
[dialogue:Jari|Yhteensä seitsemän. Kaikki muut paitsi Rantasen Veli-Matti ovat tänään täällä. Meidän viikkopalaveri alkaa kymmeneltä. Tapaat heidät kaikki siellä.|Tổng cộng có 7 người. Tất cả mọi người trừ anh Veli-Matti Rantanen hôm nay đều có mặt ở đây. Cuộc họp tuần của nhóm sẽ bắt đầu lúc 10 giờ. Cậu sẽ gặp đông đủ mọi người ở đó nhé.|paitsi = ngoại trừ; viikkopalaveri = cuộc họp giao ban hàng tuần; kymmeneltä = lúc 10 giờ]
[dialogue:Alex|Hienoa.|Dạ tuyệt vời anh.|]
[dialogue:Jari|Minä kerron kokouksessa myös tiimin uudesta projektista.|Trong cuộc họp tôi cũng sẽ thông báo về dự án mới của cả nhóm.|kokous = cuộc họp; uusi projekti = dự án mới]
[dialogue:Alex|Selvä.|Dạ em rõ rồi ạ.|]

---

### 🍽️ 2. Hội thoại 2: Puhutaan! Lounaalla - Gọi món ăn trưa (Trang 261)

[reader:Puoli yhdeltä Alex ja Jari menevät lounaalle pieneen lounasravintolaan.|Lúc 12 giờ rưỡi, Alex và Jari đi ăn trưa tại một nhà hàng phục vụ cơm trưa nhỏ gần đó. (puoli yhdeltä = lúc 12:30; lounasravintola = nhà hàng phục vụ bữa trưa)]

[dialogue:Tarjoilija|Hei!|Xin chào quý khách!|tarjoilija = nhân viên phục vụ bàn]
[dialogue:Jari|Hei! Mitäs teillä on tänään lounaslistalla?|Chào bạn! Hôm nay thực đơn bữa trưa của quán có những món gì thế bạn?|lounaslista = thực đơn bữa trưa]
[dialogue:Tarjoilija|Meillä on kolme eri annosta: kanarisotto, kurpitsakeitto ja savulohisalaatti. Kaikki on 10,50 €.|Dạ quán em có 3 suất ăn khác nhau: cơm Ý thịt gà kanarisotto, súp bí đỏ kurpitsakeitto và xà lách cá hồi hun khói savulohisalaatti. Đồng giá tất cả là 10 euro 50 cent ạ.|annos = suất ăn, phần ăn; kanarisotto = cơm risotto thịt gà; kurpitsakeitto = súp bí ngô; savulohisalaatti = salad cá hồi hun khói]
[dialogue:Jari|Okei, mä luulen, että mä otan kurpitsakeittoa.|Được rồi, tôi nghĩ là tôi sẽ chọn món súp bí đỏ nhé.|mä luulen = tôi nghĩ rằng; ottaa = lấy/chọn món]
[dialogue:Alex|Ja mulle kanarisottoa, kiitos.|Còn cho tôi phần cơm risotto gà nhé, cảm ơn bạn.|mulle = sinulle/minulle (cho tôi)]
[dialogue:Tarjoilija|Syöttekö täällä vai tuleeks nää mukaan?|Hai anh dùng bữa tại đây hay mang về ạ?|syödä täällä = ăn tại chỗ; tulla mukaan = mang về (take-away)]
[dialogue:Jari|Me syödään täällä.|Chúng tôi dùng bữa tại đây.|Me syödään täällä = Chúng tôi ăn ở đây]
[dialogue:Tarjoilija|Tuleeks nää samasta vai erikseen?|Hai suất này tính chung một hóa đơn hay tính tiền riêng từng người ạ?|samasta = cùng một hóa đơn; erikseen = tính riêng ra]
[dialogue:Alex|Erikseen, kiitos.|Dạ tính tiền riêng giúp chúng tôi, cảm ơn bạn.|erikseen = tính riêng]
[dialogue:Tarjoilija|Okei. Tässä on teidän tilausnumero. Ruoka tulee pöytään kohta. Tuolta voitte ottaa salaattia.|Dạ được rồi. Đây là số thứ tự gọi món của hai anh. Đồ ăn sẽ được bưng ra bàn ngay bây giờ ạ. Đằng kia hai anh có thể tự lấy rau xà lách tự chọn nhé.|tilausnumero = số thứ tự đơn gọi món; ruoka tulee pöytään = đồ ăn sẽ mang ra bàn; ottaa salaattia = lấy rau salad ở quầy buffet]
[dialogue:Alex|Kuuluuks kahvi lounaan hintaan?|Cà phê có bao gồm sẵn trong giá bữa trưa không bạn?|kuuluuko hintaan = có bao gồm trong giá tiền không (văn hóa ăn trưa Phần Lan thường bao gồm cà phê miễn phí)]
[dialogue:Tarjoilija|Joo, kuuluu.|Dạ có, đã bao gồm luôn rồi ạ.|]
[dialogue:Alex|Kiitos.|Cảm ơn bạn nhiều nhé.|]

---

### 📝 3. Thử thách tương tác công sở & Đi ăn trưa

[exercise:ex_w23_d1_tyopaiva_lounaalla]`;

// -------------------------------------------------------------
// MAIN BATCH UPDATER & PRODUCTION SYNC
// -------------------------------------------------------------

async function updateAndSyncAll() {
  console.log('🚀 === STANDARDIZING ALL DIALOGUES ACROSS CURRICULUM (CHAPTERS 2 TO 9) ===\n');

  // Mapping of updates per chapter
  const updates = [
    // Chapter 2
    {
      file: 'chapter_02_lessons.json',
      chapter: 'Kappale 2',
      lessonId: 'w5_d3_giaotiep_hinnat_puhekieli',
      content: ch2_w5_d3_content,
      audio1: '32 Harjoitus 30',
      audio2: '31 Harjoitus 30'
    },
    // Chapter 3
    {
      file: 'chapter_03_lessons.json',
      chapter: 'Kappale 3',
      lessonId: 'w6_d1_thoai_pedro_soittaa_mikolle',
      content: ch3_w6_d1_content,
      audio1: '33 Pedro',
      audio2: '34 Pedro'
    },
    {
      file: 'chapter_03_lessons.json',
      chapter: 'Kappale 3',
      lessonId: 'w6_d4_luyennghe_saakeskustelu',
      content: ch3_w6_d4_content,
      audio1: '40 Harjoitus 15',
      audio2: '41 Harjoitus 15',
      audio3: '42 Harjoitus 15',
      audio4: '43 Harjoitus 15',
      audio5: '44 Harjoitus 15'
    },
    {
      file: 'chapter_03_lessons.json',
      chapter: 'Kappale 3',
      lessonId: 'w7_d1_giaotiep_dangky_khoahoc',
      content: ch3_w7_d1_content,
      audio1: '35 Puhutaan'
    },
    {
      file: 'chapter_03_lessons.json',
      chapter: 'Kappale 3',
      lessonId: 'w8_d3_giaotiep_lomake',
      content: ch3_w8_d3_content,
      audio1: '45 Harjoitus 27'
    },
    // Chapter 4
    {
      file: 'chapter_04_lessons.json',
      chapter: 'Kappale 4',
      lessonId: 'w9_d1_thoai_mina',
      content: ch4_w9_d1_content
    },
    {
      file: 'chapter_04_lessons.json',
      chapter: 'Kappale 4',
      lessonId: 'w9_d3_tuvung_vaatteet_varit',
      content: ch4_w9_d3_content
    },
    {
      file: 'chapter_04_lessons.json',
      chapter: 'Kappale 4',
      lessonId: 'w11_d3_khoidong_kappale5',
      content: ch4_w11_d3_content
    },
    // Chapter 5
    {
      file: 'chapter_05_lessons.json',
      chapter: 'Kappale 5',
      lessonId: 'w12_d1_tuvung_sinhhoat_hangngay',
      content: ch5_w12_d1_content
    },
    {
      file: 'chapter_05_lessons.json',
      chapter: 'Kappale 5',
      lessonId: 'w14_d3_khoidong_kappale6',
      content: ch5_w14_d3_content
    },
    // Chapter 7
    {
      file: 'chapter_07_lessons.json',
      chapter: 'Kappale 7',
      lessonId: 'w18_d1_tuvung_matkustaminen_hotelli',
      content: ch7_w18_d1_content
    },
    // Chapter 8
    {
      file: 'chapter_08_lessons.json',
      chapter: 'Kappale 8',
      lessonId: 'w20_d1_tuvung_kulkuvalineet_liikenne',
      content: ch8_w20_d1_content
    },
    // Chapter 9
    {
      file: 'chapter_09_lessons.json',
      chapter: 'Kappale 9',
      lessonId: 'w23_d1_giaotiep_laakarissa_terveyskeskus',
      content: ch9_w23_d1_content
    }
  ];

  // Step 1: Update JSON files locally
  const fileCache = {};

  for (const item of updates) {
    const filePath = path.resolve(__dirname, '../../content/lessons', item.file);
    if (!fileCache[item.file]) {
      fileCache[item.file] = JSON.parse(fs.readFileSync(filePath, 'utf8'));
    }

    const data = fileCache[item.file];
    const lesson = data.lessons.find(l => l.id === item.lessonId);

    if (lesson) {
      let resolvedContent = item.content;
      const audioUrlsList = [];

      if (item.audio1) {
        const u = getAudioUrl(item.audio1);
        if (u) {
          resolvedContent = resolvedContent.replace(/AUDIO_URL_1/g, u);
          audioUrlsList.push(u);
        }
      }
      if (item.audio2) {
        const u = getAudioUrl(item.audio2);
        if (u) {
          resolvedContent = resolvedContent.replace(/AUDIO_URL_2/g, u);
          audioUrlsList.push(u);
        }
      }
      if (item.audio3) {
        const u = getAudioUrl(item.audio3);
        if (u) {
          resolvedContent = resolvedContent.replace(/AUDIO_URL_3/g, u);
          audioUrlsList.push(u);
        }
      }
      if (item.audio4) {
        const u = getAudioUrl(item.audio4);
        if (u) {
          resolvedContent = resolvedContent.replace(/AUDIO_URL_4/g, u);
          audioUrlsList.push(u);
        }
      }
      if (item.audio5) {
        const u = getAudioUrl(item.audio5);
        if (u) {
          resolvedContent = resolvedContent.replace(/AUDIO_URL_5/g, u);
          audioUrlsList.push(u);
        }
      }

      lesson.content = resolvedContent;
      if (audioUrlsList.length > 0) {
        lesson.audioUrls = audioUrlsList;
      }

      console.log(`[FILE UPDATED] ${item.file} -> Lesson: ${lesson.id} (${lesson.title})`);
    } else {
      console.warn(`[WARN] Lesson not found in ${item.file}: ${item.lessonId}`);
    }
  }

  // Save modified JSON files back to disk
  for (const [filename, contentObj] of Object.entries(fileCache)) {
    const targetPath = path.resolve(__dirname, '../../content/lessons', filename);
    fs.writeFileSync(targetPath, JSON.stringify(contentObj, null, 2), 'utf8');
    console.log(`💾 Saved ${filename} to disk.`);
  }

  // Step 2: Synchronize updated lessons to Firestore production safely
  console.log('\n🔥 === SYNCING STANDARDIZED LESSONS TO FIRESTORE PRODUCTION (MERGE MODE) ===');

  for (const item of updates) {
    const data = fileCache[item.file];
    const lesson = data.lessons.find(l => l.id === item.lessonId);
    if (!lesson) continue;

    await db.collection('lessons').doc(lesson.id).set({
      id: lesson.id,
      title: lesson.title,
      chapter: lesson.chapter || item.chapter,
      week: lesson.week || 1,
      description: lesson.description || '',
      content: lesson.content,
      audioUrls: lesson.audioUrls || [],
      updatedAt: admin.firestore.FieldValue.serverTimestamp()
    }, { merge: true });

    console.log(`✅ Synced to Firestore: [${lesson.id}] - ${lesson.title}`);
  }

  console.log('\n🎉 ALL 13 DIALOGUE & CONVERSATION LESSONS STANDARDIZED AND SYNCED SUCCESSFULLY!');
}

updateAndSyncAll().catch(err => {
  console.error('❌ Error during standardization:', err);
  process.exit(1);
});
