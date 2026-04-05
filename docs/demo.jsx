import React from 'react';
import { BookOpen, CheckCircle, Calendar, MessageCircle, ChevronRight, ChevronLeft, RefreshCw, Volume2, ChevronDown, ChevronUp, Music, Edit3, Monitor, Users, Coffee, ArrowRight, Plus, X, Save } from 'lucide-react';

// ==========================================
// [!] BẠN HÃY GIỮ NGUYÊN CÁC MẢNG DỮ LIỆU TỪ VỰNG CỦA BẠN Ở ĐÂY
// ==========================================
const initialVocabularyData = [
  // ... (Hãy dán lại toàn bộ 600+ từ vựng của bạn vào đây) ...
  { finnish: "Hei / Moi / Terve", pronunciation: "/hei / moi / ˈter.ve/", english: "Hello / Hi", vietnamese: "Xin chào", category: "Kappale 1: Tervehdykset" },
  { finnish: "Huomenta", pronunciation: "/ˈhuo.men.tɑ/", english: "Good morning", vietnamese: "Chào buổi sáng", category: "Kappale 1: Tervehdykset" },
  { finnish: "Suomi", pronunciation: "/ˈsuo.mi/", english: "Finland", vietnamese: "Phần Lan", category: "Kappale 2: Maat" },
];

// ==========================================
// DỮ LIỆU NGỮ PHÁP (Từ Kappale 1 - 9)
// Đã sửa lỗi JSX Object bằng cách chuyển thành Arrow Functions
// ==========================================
const grammarList = [
  {
    id: 'olla', chapter: 'Kappale 1', title: 'Động từ "Olla" (To be)', desc: 'Dùng để giới thiệu bản thân, quốc tịch, tuổi tác...',
    content: () => (
      <table className="w-full text-left border-collapse bg-white rounded-lg shadow-sm border border-slate-200 overflow-hidden text-sm">
        <thead><tr className="bg-slate-50 border-b border-slate-200"><th className="py-3 px-4 font-semibold">Đại từ</th><th className="py-3 px-4 font-bold text-blue-600">Olla</th></tr></thead>
        <tbody className="divide-y divide-slate-100">
          <tr><td className="py-2 px-4">Minä (Tôi)</td><td className="py-2 px-4 font-bold text-blue-600">olen</td></tr>
          <tr><td className="py-2 px-4">Sinä (Bạn)</td><td className="py-2 px-4 font-bold text-blue-600">olet</td></tr>
          <tr><td className="py-2 px-4">Hän (Anh/Cô ấy)</td><td className="py-2 px-4 font-bold text-blue-600">on</td></tr>
          <tr><td className="py-2 px-4">Me (Chúng tôi)</td><td className="py-2 px-4 font-bold text-blue-600">olemme</td></tr>
          <tr><td className="py-2 px-4">Te (Các bạn)</td><td className="py-2 px-4 font-bold text-blue-600">olette</td></tr>
          <tr><td className="py-2 px-4">He (Họ)</td><td className="py-2 px-4 font-bold text-blue-600">ovat</td></tr>
        </tbody>
      </table>
    )
  },
  {
    id: 'vokaaliharmonia', chapter: 'Kappale 1', title: 'Vokaaliharmonia (Hài hòa nguyên âm)', desc: 'Quy tắc kết hợp nguyên âm trong một từ đơn.',
    content: () => (
      <div className="flex gap-4 text-center mt-2">
        <div className="flex-1 bg-rose-50 p-2 rounded border border-rose-200"><div className="font-semibold text-rose-600 text-xs mb-1">Nhóm sau</div><div className="font-bold">A O U</div></div>
        <div className="flex-1 bg-emerald-50 p-2 rounded border border-emerald-200"><div className="font-semibold text-emerald-600 text-xs mb-1">Nhóm trước</div><div className="font-bold">Ä Ö Y</div></div>
        <div className="flex-1 bg-slate-50 p-2 rounded border border-slate-200"><div className="font-semibold text-slate-500 text-xs mb-1">Trung lập</div><div className="font-bold">E I</div></div>
      </div>
    )
  },
  {
    id: 'verb1', chapter: 'Kappale 3', title: 'Verbityyppi 1 (Động từ nhóm 1)', desc: 'Bỏ chữ "a" hoặc "ä" cuối cùng để lấy gốc (vartalo), sau đó cộng đuôi nhân xưng.',
    content: () => (
      <div className="bg-white p-3 rounded-lg border border-slate-200 text-sm mt-2">
        <p className="font-semibold mb-2 text-blue-700">Ví dụ: Puhua (Nói) {'->'} Gốc: Puhu-</p>
        <ul className="grid grid-cols-2 gap-2">
          <li>Minä puhu<b>n</b></li><li>Me puhu<b>mme</b></li>
          <li>Sinä puhu<b>t</b></li><li>Te puhu<b>tte</b></li>
          <li>Hän puhu<b>u</b> <i>(nhân đôi)</i></li><li>He puhu<b>vat</b></li>
        </ul>
      </div>
    )
  },
  {
    id: 'kpt', chapter: 'Kappale 3', title: 'K-P-T Vaihtelu (Biến đổi phụ âm K-P-T)', desc: 'Phụ âm K, P, T bị biến đổi từ Mạnh sang Yếu khi thêm đuôi.',
    content: () => (
      <div className="bg-white p-3 rounded-lg border border-slate-200 text-sm mt-2 space-y-2">
        <p><b>Quy tắc cơ bản (Mạnh {'->'} Yếu):</b></p>
        <ul className="grid grid-cols-2 gap-x-4 gap-y-1 ml-4 list-disc text-slate-700">
          <li>kk {'->'} k (Kuk<b>k</b>a {'->'} Ku<b>k</b>an)</li><li>pp {'->'} p (Kup<b>p</b>i {'->'} Ku<b>p</b>in)</li>
          <li>tt {'->'} t (Tyt<b>t</b>ö {'->'} Ty<b>t</b>ön)</li><li>k {'->'} - (Rei<b>k</b>ä {'->'} Reiän)</li>
          <li>p {'->'} v (Leipä {'->'} Leivän)</li><li>t {'->'} d (Pöytä {'->'} Pöydän)</li>
        </ul>
      </div>
    )
  },
  {
    id: 'koko', chapter: 'Kappale 3', title: 'Kysymys -ko/-kö (Câu hỏi Yes/No)', desc: 'Thêm đuôi -ko hoặc -kö vào từ muốn hỏi.',
    content: () => (
      <div className="bg-white p-3 rounded-lg border border-slate-200 text-sm mt-2">
        <p>Puhut<b>ko</b> sinä suomea? (Bạn có nói tiếng Phần không?)</p>
        <p>On<b>ko</b> hän suomalainen? (Anh ấy có phải người Phần không?)</p>
      </div>
    )
  },
  {
    id: 'verb2_5', chapter: 'Kappale 4', title: 'Verbityyppi 2-5 (Động từ nhóm 2, 3, 4, 5)', desc: 'Cách chia các nhóm động từ còn lại.',
    content: () => (
      <div className="bg-white p-3 rounded-lg border border-slate-200 text-sm mt-2 space-y-3">
        <div><span className="font-semibold text-blue-700">Nhóm 2:</span> Juo<b>da</b> {'->'} Minä juo<b>n</b>.</div>
        <div><span className="font-semibold text-blue-700">Nhóm 3:</span> Opiskel<b>la</b> {'->'} Minä opiskele<b>n</b>.</div>
        <div><span className="font-semibold text-blue-700">Nhóm 4:</span> Tava<b>ta</b> {'->'} Minä tapaa<b>n</b>.</div>
        <div><span className="font-semibold text-blue-700">Nhóm 5:</span> Tarv<b>ita</b> {'->'} Minä tarvitse<b>n</b>.</div>
      </div>
    )
  },
  {
    id: 'partitiivi', chapter: 'Kappale 5', title: 'Partitiivi (Cách phần vị - Số ít)', desc: 'Dùng sau số đếm, đồ ăn/thức uống, hoặc hành động chưa hoàn thành.',
    content: () => (
      <ul className="list-disc pl-5 space-y-1 text-sm bg-white p-3 border rounded-lg mt-2">
        <li>Đuôi <b>-a / -ä</b>: 1 nguyên âm ngắn (kahvi {'->'} kahvi<b>a</b>).</li>
        <li>Đuôi <b>-ta / -tä</b>: 2 nguyên âm hoặc phụ âm (tee {'->'} tee<b>tä</b>).</li>
      </ul>
    )
  },
  {
    id: 'paikallissijat', chapter: 'Kappale 6', title: 'Paikallissijat (Ngữ pháp phương hướng)', desc: 'Dùng để diễn tả vị trí: Ở đâu, Từ đâu, Đến đâu.',
    content: () => (
      <div className="bg-white p-3 rounded-lg border border-slate-200 text-sm mt-2 space-y-2">
        <p>📍 <b>Missä:</b> <b>-ssa / -ssä</b> (talo<b>ssa</b>) hoặc <b>-lla / -llä</b> (tori<b>lla</b>).</p>
        <p>⬅️ <b>Mistä:</b> <b>-sta / -stä</b> hoặc <b>-lta / -ltä</b>.</p>
        <p>➡️ <b>Mihin:</b> Nhân đôi nguyên âm cuối + <b>n</b> (koulu<b>un</b>) hoặc <b>-lle</b>.</p>
      </div>
    )
  },
  {
    id: 'omistuslause', chapter: 'Kappale 7', title: 'Omistuslause (Cấu trúc "Tôi có...")', desc: 'Không có động từ "have". Cấu trúc: [Người ở dạng -lla/-llä] + on + [Vật].',
    content: () => (
      <div className="bg-white p-3 rounded-lg border border-slate-200 text-sm mt-2">
        <p className="font-medium">Vd: Minu<b>lla</b> on koira. (Tôi có chó.)</p>
      </div>
    )
  },
  {
    id: 'monikko', chapter: 'Kappale 8', title: 'Monikon nominatiivi (Số nhiều)', desc: 'Thêm đuôi "-t" vào gốc của từ.',
    content: () => (
      <div className="bg-white p-3 rounded-lg border border-slate-200 text-sm mt-2">
        <p>Talo {'->'} Talo<b>t</b> (những ngôi nhà)</p>
        <p>Tyttö {'->'} Tytö<b>t</b> (những cô gái - chú ý KPT)</p>
      </div>
    )
  },
  {
    id: 'imperfekti', chapter: 'Kappale 9', title: 'Imperfekti (Thì Quá khứ)', desc: 'Dấu hiệu nhận biết là chữ "i" nằm giữa gốc từ và đuôi nhân xưng.',
    content: () => (
      <div className="bg-white p-3 rounded-lg border border-slate-200 text-sm mt-2">
        <p>Hiện tại: Minä asu-<b>n</b> (Tôi sống)</p>
        <p className="text-blue-700 font-medium">Quá khứ: Minä asu-<b>i</b>-<b>n</b> (Tôi đã sống)</p>
      </div>
    )
  }
];

// ==========================================
// BỘ TẠO LỘ TRÌNH TỰ ĐỘNG
// Đã thay thế icon React components bằng chuỗi định danh (iconType) để tránh lỗi
// ==========================================
const createWeek = (m, w, title, lesson1Title, lesson2Title, grammar1, grammar2) => {
  return {
    weekId: w,
    title: title,
    days: [
      {
        dayName: "Maanantai (Thứ Hai)",
        tasks: [
          { id: `m${m}w${w}d1t1`, title: "Lớp học / Tự học giáo trình", iconType: 'Users', detail: `Học bài mới: ${lesson1Title}. Ghi chép cẩn thận ngữ pháp và từ vựng.`, grammarLink: grammar1 },
          { id: `m${m}w${w}d1t2`, title: "Học từ vựng Quizlet", iconType: 'Monitor', detail: "Mở Quizlet ôn tập bộ từ vựng tương ứng với bài vừa học." },
          { id: `m${m}w${w}d1t3`, title: "Nghe nhạc Phần Lan", iconType: 'Music', detail: "Nghe các nghệ sĩ Phần Lan (Haloo Helsinki, BEHM, Käärijä) để làm quen ngữ điệu." }
        ]
      },
      {
        dayName: "Tiistai (Thứ Ba)",
        tasks: [
          { id: `m${m}w${w}d2t1`, title: "Làm một nửa bài tập về nhà", iconType: 'Edit3', detail: `Làm các bài tập đầu tiên liên quan đến: ${lesson1Title}.` },
          { id: `m${m}w${w}d2t2`, title: "Luyện tập với ứng dụng (App)", iconType: 'Monitor', detail: "Sử dụng Duolingo hoặc WordDive 10-15 phút." },
          { id: `m${m}w${w}d2t3`, title: "Viết tay từ/cụm từ", iconType: 'Edit3', detail: "Lấy vở nháp, chép tay 5-10 từ mới khó nhớ nhất từ bài học." },
          { id: `m${m}w${w}d2t4`, title: "Giao tiếp: Chào hỏi", iconType: 'MessageCircle', detail: "Nói 'Moi' tai 'Huomenta' với ai đó." }
        ]
      },
      {
        dayName: "Keskiviikko (Thứ Tư)",
        tasks: [
          { id: `m${m}w${w}d3t1`, title: "Làm phần bài tập còn lại", iconType: 'Edit3', detail: `Hoàn thành nốt bài tập của phần: ${lesson1Title}.` },
          { id: `m${m}w${w}d3t2`, title: "Học từ vựng Quizlet & App", iconType: 'Monitor', detail: "Kết hợp 10p Quizlet và 10p Duolingo." },
          { id: `m${m}w${w}d3t3`, title: "Viết tay", iconType: 'Edit3', detail: "Tự viết lại 3 câu hoàn chỉnh bằng tiếng Phần Lan." },
          { id: `m${m}w${w}d3t4`, title: "Giao tiếp: Đặt câu hỏi", iconType: 'MessageCircle', detail: "Thử đặt một câu hỏi đơn giản (vd: Mitä kuuluu? / Missä on...?)" }
        ]
      },
      {
        dayName: "Torstai (Thứ Năm)",
        tasks: [
          { id: `m${m}w${w}d4t1`, title: "Lớp học / Tự học giáo trình", iconType: 'Users', detail: `Học phần tiếp theo: ${lesson2Title}. Tích cực tham gia và ghi chép.`, grammarLink: grammar2 },
          { id: `m${m}w${w}d4t2`, title: "Đọc biển báo / Nghe xung quanh", iconType: 'BookOpen', detail: "Cố gắng tìm các từ vựng đã học trên biển báo xe buýt, siêu thị, đường phố." },
          { id: `m${m}w${w}d4t3`, title: "Nghe nhạc & Hỏi", iconType: 'Music', detail: "Vừa nghe nhạc vừa thử tự hỏi mình nội dung bài." }
        ]
      },
      {
        dayName: "Perjantai (Thứ Sáu)",
        tasks: [
          { id: `m${m}w${w}d5t1`, title: "Làm nửa bài tập (của bài Thứ Năm)", iconType: 'Edit3', detail: `Làm bài tập ứng dụng cho: ${lesson2Title}.` },
          { id: `m${m}w${w}d5t2`, title: "Quizlet & App", iconType: 'Monitor', detail: "Chơi mini-game trên Quizlet (Match) để rèn phản xạ." },
          { id: `m${m}w${w}d5t3`, title: "Viết tay & Giao tiếp", iconType: 'MessageCircle', detail: "Chúc cuối tuần: 'Hyvää viikonloppua!'" }
        ]
      },
      {
        dayName: "Lauantai (Thứ Bảy)",
        tasks: [
          { id: `m${m}w${w}d6t1`, title: "Làm nốt bài tập còn lại", iconType: 'Edit3', detail: "Hoàn tất mọi bài tập trong tuần. Kiểm tra lại đáp án ở cuối sách." },
          { id: `m${m}w${w}d6t2`, title: "Xem phim / Series Phần Lan", iconType: 'Monitor', detail: "Xem Moomins (Muumilaakson tarinoita) tai phim trên Yle Areena." },
          { id: `m${m}w${w}d6t3`, title: "Giao tiếp cuối tuần", iconType: 'MessageCircle', detail: "Thử bắt chuyện ngắn gọn hoặc nhắn tin cho một người bạn Phần." }
        ]
      },
      {
        dayName: "Sunnuntai (Chủ Nhật)",
        tasks: [
          { id: `m${m}w${w}d7t1`, title: "Xem phim & Tìm từ mới", iconType: 'Monitor', detail: "Tiếp tục xem phim, ghi lại 1-2 từ mới nghe được." },
          { id: `m${m}w${w}d7t2`, title: "Ota rennosti! (Thư giãn)", iconType: 'Coffee', detail: "Hôm nay là ngày nghỉ. Dành thời gian nạp lại năng lượng cho tuần mới!" }
        ]
      }
    ]
  };
};

const studyPlan = [
  {
    monthId: 1, title: "Tháng 1: Nền tảng cơ bản (Kappale 1 & 2)",
    weeks: [
      createWeek(1, 1, "Tuần 1: Xin chào & Động từ Olla (K1)", "Kappale 1: Tervehdykset (Chào hỏi) & Đại từ nhân xưng", "Kappale 1: Động từ 'Olla' & Vokaaliharmonia", "olla", "vokaaliharmonia"),
      createWeek(1, 2, "Tuần 2: Quốc tịch & Số đếm (K2)", "Kappale 2: Minkämaalainen sinä olet? (Quốc gia)", "Kappale 2: Numerot (Số đếm 1-10)", null, null),
      createWeek(1, 3, "Tuần 3: Giao tiếp tại Ki-ốt (K2)", "Kappale 2: Hội thoại tại Jätskikiskalla", "Kappale 2: Các cụm từ hỏi giá, số đếm lớn", null, null),
      createWeek(1, 4, "Tuần 4: Tổng ôn Tháng 1", "Ôn tập Kappale 1 (Olla, Chào hỏi)", "Ôn tập Kappale 2 (Quốc gia, Ngôn ngữ, Số đếm)", "olla", null),
    ]
  },
  {
    monthId: 2, title: "Tháng 2: Thời tiết & Động từ nhóm 1 (Kappale 3)",
    weeks: [
      createWeek(2, 1, "Tuần 1: Thời tiết & Tháng (K3)", "Kappale 3: Sää (Thời tiết) & Vuodenajat (Các mùa)", "Kappale 3: Kuukaudet (Các tháng trong năm)", null, null),
      createWeek(2, 2, "Tuần 2: Verbityyppi 1 (K3)", "Kappale 3: Chia động từ Nhóm 1 (puhua, asua)", "Kappale 3: Thể phủ định (en puhu, et asu)", "verb1", null),
      createWeek(2, 3, "Tuần 3: Biến âm K-P-T (K3)", "Kappale 3: Quy tắc biến đổi phụ âm (Mạnh -> Yếu)", "Kappale 3: Câu hỏi -ko/-kö (Puhutko suomea?)", "kpt", "koko"),
      createWeek(2, 4, "Tuần 4: Tổng ôn Tháng 2", "Ôn tập Verbityyppi 1 và KPT", "Luyện đọc hiểu và hội thoại Sää", "verb1", "kpt"),
    ]
  },
  {
    monthId: 3, title: "Tháng 3: Thời gian & Thói quen (Kappale 4)",
    weeks: [
      createWeek(3, 1, "Tuần 1: Xem giờ (K4)", "Kappale 4: Mitä kello on? (Mấy giờ rồi?)", "Kappale 4: Vuorokaudenajat (Các buổi trong ngày)", null, null),
      createWeek(3, 2, "Tuần 2: Động từ nhóm 2 & 3 (K4)", "Kappale 4: Verbityyppi 2 (juoda, syödä)", "Kappale 4: Verbityyppi 3 (opiskella, tulla)", "verb2_5", "verb2_5"),
      createWeek(3, 3, "Tuần 3: Động từ nhóm 4 & 5 (K4)", "Kappale 4: Verbityyppi 4 (tavata, haluta)", "Kappale 4: Verbityyppi 5 (tarvita) & Lịch trình", "verb2_5", null),
      createWeek(3, 4, "Tuần 4: Tổng ôn Tháng 3", "Luyện kể về Thói quen hàng ngày (Päivärytmi)", "Ôn tập tổng hợp 5 nhóm động từ", "verb2_5", null),
    ]
  },
  {
    monthId: 4, title: "Tháng 4: Thực phẩm & Mua sắm (Kappale 5)",
    weeks: [
      createWeek(4, 1, "Tuần 1: Đồ ăn thức uống (K5)", "Kappale 5: Ruoka ja juoma (Thực phẩm cơ bản)", "Kappale 5: Hội thoại trong siêu thị", null, null),
      createWeek(4, 2, "Tuần 2: Ngữ pháp Partitiivi (K5)", "Kappale 5: Quy tắc tạo Partitiivi (Cách phần vị)", "Kappale 5: Dùng Partitiivi với Số đếm", "partitiivi", "partitiivi"),
      createWeek(4, 3, "Tuần 3: Partitiivi mở rộng (K5)", "Kappale 5: Động từ đi kèm Partitiivi (rakastaa)", "Kappale 5: Partitiivi trong câu phủ định", "partitiivi", null),
      createWeek(4, 4, "Tuần 4: Tổng ôn Tháng 4", "Luyện viết: Danh sách đi chợ (Ostoslista)", "Ôn tập K-P-T kết hợp Partitiivi", "kpt", "partitiivi"),
    ]
  },
  {
    monthId: 5, title: "Tháng 5: Phương hướng & Sở hữu (Kappale 6 & 7)",
    weeks: [
      createWeek(5, 1, "Tuần 1: Du lịch & Vị trí (K6)", "Kappale 6: Matkustaminen & Phương tiện", "Kappale 6: Paikallissijat (Missä? Mistä? Mihin?)", null, "paikallissijat"),
      createWeek(5, 2, "Tuần 2: Luyện tập vị trí (K6)", "Kappale 6: Diễn tả chuyển động (Tới ngân hàng...)", "Kappale 6: Từ vựng các địa điểm công cộng", "paikallissijat", null),
      createWeek(5, 3, "Tuần 3: Gia đình & Sở hữu (K7)", "Kappale 7: Perhe (Gia đình) & Họ hàng", "Kappale 7: Cấu trúc Minulla on... (Tôi có)", null, "omistuslause"),
      createWeek(5, 4, "Tuần 4: Miêu tả người (K7)", "Kappale 7: Adjektiivit (Tính từ miêu tả ngoại hình)", "Tổng ôn K6 & K7 (Vị trí và Sở hữu)", null, "omistuslause"),
    ]
  },
  {
    monthId: 6, title: "Tháng 6: Quá khứ & Tổng kết (Kappale 8 & 9)",
    weeks: [
      createWeek(6, 1, "Tuần 1: Số nhiều (K8)", "Kappale 8: Monikko (Danh từ số nhiều đuôi -t)", "Kappale 8: Từ vựng Koti & Asuminen (Nhà cửa)", "monikko", null),
      createWeek(6, 2, "Tuần 2: Thì quá khứ (K9)", "Kappale 9: Imperfekti (Giới thiệu thì Quá khứ)", "Kappale 9: Chia quá khứ cho Động từ nhóm 1", "imperfekti", "imperfekti"),
      createWeek(6, 3, "Tuần 3: Quá khứ bất quy tắc (K9)", "Kappale 9: Chia quá khứ cho Động từ nhóm 2-5", "Kappale 9: Từ vựng chỉ thời gian (Eilen, Viime...)", "imperfekti", null),
      createWeek(6, 4, "Tuần 4: Tốt nghiệp Suomen Mestari 1", "Ôn tập: Kể lại một ngày cuối tuần của bạn ở Quá khứ", "Làm bài kiểm tra cuối sách. Chúc mừng hoàn thành!", "imperfekti", null),
    ]
  }
];

// ==========================================
// DỮ LIỆU BÀI TẬP (HARJOITUKSET)
// ==========================================
const exercisesData = [
  {
    id: 'ex1',
    chapter: 'Kappale 1',
    title: 'Täydennä olla-verbi',
    description: 'Điền dạng đúng của động từ "olla" (olen, olet, on, olemme, olette, ovat) vào chỗ trống.',
    type: 'fill-in-blanks',
    questions: [
      { id: 'q1', textBefore: 'Minä ', textAfter: ' opiskelija.', correctAnswer: 'olen' },
      { id: 'q2', textBefore: 'Sinä ', textAfter: ' kotoisin Vietnamista.', correctAnswer: 'olet' },
      { id: 'q3', textBefore: 'Pedro ', textAfter: ' brasilialainen.', correctAnswer: 'on' },
      { id: 'q4', textBefore: 'Me ', textAfter: ' kurssilla.', correctAnswer: 'olemme' },
      { id: 'q5', textBefore: 'He ', textAfter: ' ystäviä.', correctAnswer: 'ovat' }
    ]
  },
  {
    id: 'ex2',
    chapter: 'Kappale 2',
    title: 'Oikein vai väärin?',
    description: 'Đọc đoạn văn sau ja chọn Oikein (Đúng) hoặc Väärin (Sai).',
    type: 'true-false',
    readingText: "Hei! Minun nimeni on Alex. Olen kotoisin Englannista, mutta nyt minä asun Suomessa, Helsingissä. Minä puhun englantia, ranskaa ja vähän suomea. Minä olen insinööri.",
    questions: [
      { id: 'q1', text: 'Alex on kotoisin Suomesta.', correctAnswer: 'Väärin' },
      { id: 'q2', text: 'Alex asuu Helsingissä.', correctAnswer: 'Oikein' },
      { id: 'q3', text: 'Hän puhuu espanjaa.', correctAnswer: 'Väärin' },
      { id: 'q4', text: 'Alex on insinööri.', correctAnswer: 'Oikein' }
    ],
    options: ['Oikein', 'Väärin']
  },
  {
    id: 'ex3',
    chapter: 'Kappale 3',
    title: 'Valitse oikea sana',
    description: 'Trắc nghiệm: Chọn từ vựng chính xác để hoàn thành câu.',
    type: 'multiple-choice',
    questions: [
      { id: 'q1', text: 'Talvella Suomessa on usein hyvin ______.', options: ['kuuma', 'kylmä', 'lämmin'], correctAnswer: 'kylmä' },
      { id: 'q2', text: 'Tänään sataa ______.', options: ['vettä', 'aurinko', 'tuulee'], correctAnswer: 'vettä' },
      { id: 'q3', text: 'Minä tykkään juoda kuumaa ______ aamulla.', options: ['leipää', 'kahvia', 'kalaa'], correctAnswer: 'kahvia' }
    ]
  }
];

// ==========================================
// COMPONENT CHÍNH CỦA ỨNG DỤNG
// ==========================================
export default function App() {
  // Đã sử dụng React.useState để khắc phục lỗi ReferenceError
  const [activeTab, setActiveTab] = React.useState('roadmap');
  
  const [flashcardIndex, setFlashcardIndex] = React.useState(0);
  const [isFlipped, setIsFlipped] = React.useState(false);
  const [vocabularyData, setVocabularyData] = React.useState(initialVocabularyData);
  const [showAddForm, setShowAddForm] = React.useState(false);
  const [newWord, setNewWord] = React.useState({ finnish: '', pronunciation: '', english: '', vietnamese: '', category: 'Oma sanasto (Từ của tôi)' });
  const [showSuccess, setShowSuccess] = React.useState(false);
  const [selectedMonth, setSelectedMonth] = React.useState(1);
  const [selectedWeek, setSelectedWeek] = React.useState(1);
  const [expandedTask, setExpandedTask] = React.useState(null);
  const [completedTasks, setCompletedTasks] = React.useState({});
  const [expandedGrammarId, setExpandedGrammarId] = React.useState('olla');

  // STATES CHO BÀI TẬP
  const [selectedExercise, setSelectedExercise] = React.useState(null);
  const [answers, setAnswers] = React.useState({});
  const [isSubmitted, setIsSubmitted] = React.useState(false);
  const [score, setScore] = React.useState(0);

  // Đã sử dụng React.useEffect
  React.useEffect(() => { setIsFlipped(false); }, [flashcardIndex]);

  // HÀM RENDER ICON CHO ROADMAP ĐỂ TRÁNH LỖI JSX OBJECT
  const renderTaskIcon = (iconType) => {
    switch (iconType) {
      case 'Users': return <Users size={18} />;
      case 'Monitor': return <Monitor size={18} />;
      case 'Music': return <Music size={18} />;
      case 'Edit3': return <Edit3 size={18} />;
      case 'MessageCircle': return <MessageCircle size={18} />;
      case 'BookOpen': return <BookOpen size={18} />;
      case 'Coffee': return <Coffee size={18} />;
      default: return <CheckCircle size={18} />;
    }
  };

  const toggleTaskStatus = (e, taskId) => { e.stopPropagation(); setCompletedTasks(prev => ({ ...prev, [taskId]: !prev[taskId] })); };
  const toggleTaskExpand = (taskId) => { setExpandedTask(expandedTask === taskId ? null : taskId); };
  const handleGoToGrammar = (grammarId) => { setActiveTab('grammar'); setExpandedGrammarId(grammarId); window.scrollTo({ top: 0, behavior: 'smooth' }); };
  
  const currentMonthData = studyPlan.find(m => m.monthId === selectedMonth);
  const currentWeekData = currentMonthData?.weeks.find(w => w.weekId === selectedWeek);
  const totalTasksInWeek = currentWeekData?.days.reduce((total, day) => total + day.tasks.length, 0) || 0;
  const completedTasksInWeek = currentWeekData?.days.reduce((total, day) => total + day.tasks.filter(task => completedTasks[task.id]).length, 0) || 0;
  const progressPercentage = totalTasksInWeek === 0 ? 0 : Math.round((completedTasksInWeek / totalTasksInWeek) * 100);
  
  const nextCard = () => setFlashcardIndex((prev) => (prev + 1) % vocabularyData.length);
  const prevCard = () => setFlashcardIndex((prev) => (prev - 1 + vocabularyData.length) % vocabularyData.length);
  const handleAddWord = (e) => {
    e.preventDefault();
    if (!newWord.finnish.trim() || (!newWord.vietnamese.trim() && !newWord.english.trim())) return;
    setVocabularyData(prev => [...prev, newWord]);
    setFlashcardIndex(vocabularyData.length);
    setShowAddForm(false);
    setNewWord({ finnish: '', pronunciation: '', english: '', vietnamese: '', category: 'Oma sanasto (Từ của tôi)' });
    setShowSuccess(true); setTimeout(() => setShowSuccess(false), 3000);
  };

  // LOGIC KIỂM TRA BÀI TẬP
  const handleAnswerChange = (questionId, value) => {
    setAnswers(prev => ({ ...prev, [questionId]: value }));
  };

  const checkAnswers = () => {
    let correctCount = 0;
    selectedExercise.questions.forEach(q => {
      const userAnswer = (answers[q.id] || '').toString().trim().toLowerCase();
      const correctAnswer = q.correctAnswer.toLowerCase();
      if (userAnswer === correctAnswer) {
        correctCount++;
      }
    });
    setScore(correctCount);
    setIsSubmitted(true);
  };

  const resetExercise = () => {
    setAnswers({});
    setIsSubmitted(false);
    setScore(0);
  };

  const closeExercise = () => {
    setSelectedExercise(null);
    resetExercise();
  };

  return (
    <div className="min-h-screen bg-slate-50 font-sans text-slate-800 pb-10">
      {/* Header */}
      <header className="bg-blue-700 text-white p-6 shadow-md">
        <div className="max-w-4xl mx-auto flex flex-col md:flex-row justify-between items-center">
          <div>
            <h1 className="text-3xl font-bold tracking-tight">Opi Suomea 🇫🇮</h1>
            <p className="text-blue-100 mt-1">Học Tiếng Phần Lan - Suomen Mestari 1</p>
          </div>
        </div>
      </header>

      {/* Navigation */}
      <nav className="bg-white border-b shadow-sm sticky top-0 z-10">
        <div className="max-w-4xl mx-auto flex overflow-x-auto">
          <button onClick={() => setActiveTab('roadmap')} className={`flex items-center px-6 py-4 font-medium whitespace-nowrap transition-colors ${activeTab === 'roadmap' ? 'text-blue-600 border-b-2 border-blue-600' : 'text-slate-500 hover:text-blue-500 hover:bg-slate-50'}`}>
            <Calendar className="w-5 h-5 mr-2" /> Lộ trình
          </button>
          <button onClick={() => setActiveTab('vocabulary')} className={`flex items-center px-6 py-4 font-medium whitespace-nowrap transition-colors ${activeTab === 'vocabulary' ? 'text-blue-600 border-b-2 border-blue-600' : 'text-slate-500 hover:text-blue-500 hover:bg-slate-50'}`}>
            <MessageCircle className="w-5 h-5 mr-2" /> Từ vựng
          </button>
          <button onClick={() => setActiveTab('grammar')} className={`flex items-center px-6 py-4 font-medium whitespace-nowrap transition-colors ${activeTab === 'grammar' ? 'text-blue-600 border-b-2 border-blue-600' : 'text-slate-500 hover:text-blue-500 hover:bg-slate-50'}`}>
            <BookOpen className="w-5 h-5 mr-2" /> Ngữ pháp
          </button>
          <button onClick={() => setActiveTab('exercises')} className={`flex items-center px-6 py-4 font-medium whitespace-nowrap transition-colors ${activeTab === 'exercises' ? 'text-blue-600 border-b-2 border-blue-600' : 'text-slate-500 hover:text-blue-500 hover:bg-slate-50'}`}>
            <Edit3 className="w-5 h-5 mr-2" /> Bài tập
          </button>
        </div>
      </nav>

      {/* Main Content */}
      <main className="max-w-4xl mx-auto p-4 md:p-6 mt-2">
        
        {/* TAB 1: ROADMAP */}
        {activeTab === 'roadmap' && (
          <div className="space-y-6 animate-in fade-in duration-300">
            <div className="bg-white rounded-xl shadow-sm p-4 border border-slate-200 flex flex-col sm:flex-row items-center gap-4 justify-between">
              <div className="flex space-x-2 w-full sm:w-auto overflow-x-auto pb-2 sm:pb-0 scrollbar-hide">
                {studyPlan.map(month => (
                  <button
                    key={month.monthId}
                    onClick={() => { setSelectedMonth(month.monthId); setSelectedWeek(1); }}
                    className={`px-4 py-2 rounded-lg text-sm font-semibold whitespace-nowrap transition-colors ${selectedMonth === month.monthId ? 'bg-blue-100 text-blue-700' : 'bg-slate-100 text-slate-600 hover:bg-slate-200'}`}
                  >
                    Tháng {month.monthId}
                  </button>
                ))}
              </div>
            </div>

            <div className="bg-white rounded-xl shadow-sm border border-slate-100 overflow-hidden">
              <div className="bg-slate-50 p-6 border-b border-slate-200">
                <div className="flex flex-col md:flex-row justify-between md:items-center gap-4">
                  <div>
                    <h2 className="text-2xl font-bold text-slate-800">{currentMonthData?.title}</h2>
                    <div className="flex gap-2 mt-3 overflow-x-auto pb-1">
                      {currentMonthData?.weeks.map(week => (
                        <button
                          key={week.weekId}
                          onClick={() => setSelectedWeek(week.weekId)}
                          className={`px-3 py-1.5 rounded-md text-sm font-medium whitespace-nowrap transition-all ${selectedWeek === week.weekId ? 'bg-blue-600 text-white shadow-md' : 'bg-white border border-slate-200 text-slate-600 hover:bg-slate-50'}`}
                        >
                          Tuần {week.weekId}
                        </button>
                      ))}
                    </div>
                  </div>

                  <div className="bg-white p-3 rounded-lg border border-slate-200 w-full md:w-48 shrink-0">
                    <div className="flex justify-between text-sm mb-1">
                      <span className="font-semibold text-slate-600">Tiến độ tuần {selectedWeek}</span>
                      <span className="font-bold text-blue-600">{progressPercentage}%</span>
                    </div>
                    <div className="w-full bg-slate-100 rounded-full h-2.5">
                      <div className="bg-blue-600 h-2.5 rounded-full transition-all duration-500" style={{ width: `${progressPercentage}%` }}></div>
                    </div>
                  </div>
                </div>
              </div>
              
              <div className="p-6">
                <div className="space-y-8">
                  {currentWeekData?.days.map((dayObj, dIndex) => (
                    <div key={dIndex} className="relative pl-4 md:pl-6 border-l-2 border-blue-100">
                      <h3 className="font-bold text-lg text-blue-800 mb-4 flex items-center">
                        <span className="absolute -left-[9px] w-4 h-4 rounded-full bg-blue-500 border-4 border-white"></span>
                        {dayObj.dayName}
                      </h3>
                      
                      <div className="space-y-3">
                        {dayObj.tasks.map((task) => {
                          const isChecked = completedTasks[task.id];
                          const isExpanded = expandedTask === task.id;
                          
                          return (
                            <div key={task.id} className={`rounded-xl border transition-all duration-200 ${isChecked ? 'bg-slate-50 border-slate-200' : 'bg-white border-blue-100 shadow-sm hover:border-blue-300'}`}>
                              <div className="flex items-center justify-between p-4 cursor-pointer" onClick={() => toggleTaskExpand(task.id)}>
                                <div className="flex items-center flex-1 gap-3">
                                  <button onClick={(e) => toggleTaskStatus(e, task.id)} className={`flex-shrink-0 w-6 h-6 rounded-full border-2 flex items-center justify-center transition-all ${isChecked ? 'bg-green-500 border-green-500 text-white' : 'border-slate-300 bg-white hover:border-green-400'}`}>
                                    {isChecked && <CheckCircle className="w-4 h-4" />}
                                  </button>
                                  <div className="flex items-center gap-2">
                                    <span className={`text-slate-400 ${isChecked ? 'opacity-50' : ''}`}>
                                      {/* Gọi hàm renderIcon */}
                                      {renderTaskIcon(task.iconType)}
                                    </span>
                                    <span className={`font-semibold transition-colors ${isChecked ? 'text-slate-400 line-through' : 'text-slate-700'}`}>{task.title}</span>
                                  </div>
                                </div>
                                <div className="text-slate-400">
                                  {isExpanded ? <ChevronUp className="w-5 h-5" /> : <ChevronDown className="w-5 h-5" />}
                                </div>
                              </div>

                              {isExpanded && (
                                <div className={`px-12 pb-4 text-sm text-slate-600 animate-in slide-in-from-top-2 duration-200 ${isChecked ? 'opacity-60' : ''}`}>
                                  <div className="bg-blue-50/50 p-4 rounded-lg border border-blue-100">
                                    <span className="font-semibold text-blue-800 mb-1 block">Nhiệm vụ chi tiết:</span>
                                    {task.detail}
                                    
                                    {task.grammarLink && (
                                      <button onClick={() => handleGoToGrammar(task.grammarLink)} className="mt-3 flex items-center text-sm font-medium text-blue-600 hover:text-blue-800 bg-white border border-blue-200 hover:border-blue-400 px-3 py-1.5 rounded-md transition-colors">
                                        <BookOpen className="w-4 h-4 mr-2" /> Xem bài ngữ pháp tương ứng <ArrowRight className="w-4 h-4 ml-1" />
                                      </button>
                                    )}
                                  </div>
                                </div>
                              )}
                            </div>
                          );
                        })}
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          </div>
        )}

        {/* TAB 2: VOCABULARY */}
        {activeTab === 'vocabulary' && (
          <div className="space-y-6 animate-in fade-in duration-300">
            <div className="bg-white rounded-xl shadow-sm p-6 border border-slate-100 flex flex-col items-center">
              <div className="w-full max-w-md flex justify-between items-center mb-2">
                <h2 className="text-2xl font-semibold">Thẻ ghi nhớ ({vocabularyData.length} từ)</h2>
                <button onClick={() => setShowAddForm(!showAddForm)} className="flex items-center text-sm bg-blue-50 text-blue-700 hover:bg-blue-100 px-3 py-2 rounded-lg font-medium transition-colors">
                  {showAddForm ? <X className="w-4 h-4 mr-1" /> : <Plus className="w-4 h-4 mr-1" />}
                  {showAddForm ? 'Đóng' : 'Thêm từ mới'}
                </button>
              </div>
              <p className="text-slate-600 mb-6 text-center text-sm">Nhấn vào thẻ để lật. Học từ vựng theo giáo trình hoặc thêm từ của riêng bạn.</p>
              
              {showSuccess && (
                <div className="w-full max-w-md bg-green-50 text-green-700 p-3 rounded-lg mb-6 text-sm font-medium flex items-center justify-center border border-green-200 animate-in fade-in slide-in-from-top-2">
                  <CheckCircle className="w-4 h-4 mr-2" /> Đã thêm từ vựng thành công!
                </div>
              )}

              {showAddForm && (
                <form onSubmit={handleAddWord} className="w-full max-w-md bg-slate-50 p-5 rounded-xl border border-slate-200 mb-8 animate-in slide-in-from-top-2">
                  <h3 className="font-semibold text-slate-700 mb-4 text-sm uppercase tracking-wider">Thêm từ vựng mới</h3>
                  <div className="space-y-3">
                    <div>
                      <label className="block text-xs font-medium text-slate-500 mb-1">Tiếng Phần Lan *</label>
                      <input required type="text" value={newWord.finnish} onChange={e => setNewWord({...newWord, finnish: e.target.value})} className="w-full px-3 py-2 border border-slate-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="vd: Ystävä" />
                    </div>
                    <div>
                      <label className="block text-xs font-medium text-slate-500 mb-1">Phiên âm</label>
                      <input type="text" value={newWord.pronunciation} onChange={e => setNewWord({...newWord, pronunciation: e.target.value})} className="w-full px-3 py-2 border border-slate-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="vd: /ˈys.tæ.væ/" />
                    </div>
                    <div className="grid grid-cols-2 gap-3">
                      <div>
                        <label className="block text-xs font-medium text-slate-500 mb-1">Tiếng Việt *</label>
                        <input required type="text" value={newWord.vietnamese} onChange={e => setNewWord({...newWord, vietnamese: e.target.value})} className="w-full px-3 py-2 border border-slate-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="vd: Bạn bè" />
                      </div>
                      <div>
                        <label className="block text-xs font-medium text-slate-500 mb-1">Tiếng Anh</label>
                        <input type="text" value={newWord.english} onChange={e => setNewWord({...newWord, english: e.target.value})} className="w-full px-3 py-2 border border-slate-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="vd: Friend" />
                      </div>
                    </div>
                    <div>
                      <label className="block text-xs font-medium text-slate-500 mb-1">Chủ đề (Tùy chọn)</label>
                      <input type="text" value={newWord.category} onChange={e => setNewWord({...newWord, category: e.target.value})} className="w-full px-3 py-2 border border-slate-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" />
                    </div>
                  </div>
                  <div className="mt-5 flex justify-end gap-2">
                    <button type="button" onClick={() => setShowAddForm(false)} className="px-4 py-2 text-sm text-slate-600 hover:bg-slate-200 rounded-md transition-colors">Hủy</button>
                    <button type="submit" className="px-4 py-2 text-sm bg-blue-600 text-white rounded-md hover:bg-blue-700 flex items-center transition-colors"><Save className="w-4 h-4 mr-2"/> Lưu từ mới</button>
                  </div>
                </form>
              )}

              <div className="w-full max-w-md">
                <div className="text-center mb-4 text-sm font-semibold text-blue-600 uppercase tracking-wider">
                  {vocabularyData[flashcardIndex]?.category || 'Chưa phân loại'}
                </div>

                <div className="relative w-full h-64 perspective-1000 cursor-pointer group" onClick={() => setIsFlipped(!isFlipped)}>
                  <div className={`w-full h-full transition-transform duration-500 transform-style-3d ${isFlipped ? 'rotate-y-180' : ''}`}>
                    <div className="absolute w-full h-full backface-hidden bg-gradient-to-br from-blue-500 to-blue-600 rounded-2xl shadow-lg flex flex-col items-center justify-center p-6 text-white text-center border-4 border-white/20">
                      <Volume2 className="absolute top-4 right-4 w-6 h-6 opacity-50 group-hover:opacity-100 transition-opacity" />
                      <h3 className="text-4xl font-bold mb-2">{vocabularyData[flashcardIndex]?.finnish}</h3>
                      {vocabularyData[flashcardIndex]?.pronunciation && (
                        <p className="text-blue-200 text-lg italic mb-4">{vocabularyData[flashcardIndex]?.pronunciation}</p>
                      )}
                      <p className="text-blue-100 text-sm opacity-80 mt-auto">Nhấn để lật thẻ</p>
                    </div>
                    
                    <div className="absolute w-full h-full backface-hidden bg-white rounded-2xl shadow-lg flex flex-col items-center justify-center p-6 text-center border border-slate-200 rotate-y-180">
                      <RefreshCw className="absolute top-4 right-4 w-5 h-5 text-slate-300 group-hover:text-blue-500 transition-colors" />
                      <div className="space-y-4">
                        <div>
                          <p className="text-xs text-slate-400 uppercase tracking-wider mb-1">Tiếng Anh</p>
                          <h3 className="text-2xl font-bold text-slate-800">{vocabularyData[flashcardIndex]?.english}</h3>
                        </div>
                        <div className="w-12 h-px bg-slate-200 mx-auto"></div>
                        <div>
                          <p className="text-xs text-slate-400 uppercase tracking-wider mb-1">Tiếng Việt</p>
                          <h3 className="text-xl font-semibold text-blue-600">{vocabularyData[flashcardIndex]?.vietnamese}</h3>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <div className="flex justify-between items-center mt-8">
                  <button onClick={prevCard} className="p-3 bg-white rounded-full shadow hover:bg-slate-50 border border-slate-100 text-slate-600 hover:text-blue-600">
                    <ChevronLeft className="w-6 h-6" />
                  </button>
                  <span className="text-sm font-medium text-slate-500">{flashcardIndex + 1} / {vocabularyData.length}</span>
                  <button onClick={nextCard} className="p-3 bg-white rounded-full shadow hover:bg-slate-50 border border-slate-100 text-slate-600 hover:text-blue-600">
                    <ChevronRight className="w-6 h-6" />
                  </button>
                </div>
              </div>
            </div>
          </div>
        )}

        {/* TAB 3: GRAMMAR */}
        {activeTab === 'grammar' && (
          <div className="space-y-6 animate-in fade-in duration-300">
            <div className="bg-white rounded-xl shadow-sm p-6 border border-slate-100">
              <h2 className="text-2xl font-semibold mb-2 text-slate-800">Sổ tay Ngữ pháp (Kielioppi)</h2>
              <p className="text-slate-600 mb-6">Tổng hợp các điểm ngữ pháp trọng tâm từ Kappale 1 đến Kappale 9.</p>
              
              <div className="space-y-4">
                {grammarList.map((item) => {
                  const isExpanded = expandedGrammarId === item.id;
                  return (
                    <div key={item.id} className={`rounded-xl border transition-all duration-200 ${isExpanded ? 'border-blue-400 shadow-md ring-1 ring-blue-100' : 'border-slate-200 hover:border-blue-200'}`}>
                      <button onClick={() => setExpandedGrammarId(isExpanded ? null : item.id)} className={`w-full text-left px-5 py-4 flex items-center justify-between rounded-xl ${isExpanded ? 'bg-blue-50/50' : 'bg-white'}`}>
                        <div>
                          <span className="inline-block px-2 py-1 bg-slate-100 text-slate-500 text-xs font-semibold rounded mb-1">{item.chapter}</span>
                          <h3 className={`text-lg font-bold ${isExpanded ? 'text-blue-800' : 'text-slate-700'}`}>{item.title}</h3>
                        </div>
                        <div className={`p-2 rounded-full ${isExpanded ? 'bg-blue-100 text-blue-600' : 'bg-slate-50 text-slate-400'}`}>
                          {isExpanded ? <ChevronUp className="w-5 h-5" /> : <ChevronDown className="w-5 h-5" />}
                        </div>
                      </button>
                      
                      {isExpanded && (
                        <div className="px-5 pb-5 pt-2 border-t border-blue-100 animate-in slide-in-from-top-2 duration-200">
                          <p className="text-sm text-slate-600 mb-3">{item.desc}</p>
                          {/* Gọi function JSX thay vì render object trực tiếp */}
                          {item.content()}
                        </div>
                      )}
                    </div>
                  );
                })}
              </div>
            </div>
          </div>
        )}

        {/* 🌟 TAB 4: BÀI TẬP (HARJOITUKSET) */}
        {activeTab === 'exercises' && (
          <div className="space-y-6 animate-in fade-in duration-300">
            {!selectedExercise ? (
              <div className="bg-white rounded-xl shadow-sm p-6 border border-slate-100">
                <h2 className="text-2xl font-semibold mb-2 text-slate-800">Bài tập thực hành (Harjoitukset)</h2>
                <p className="text-slate-600 mb-6">Luyện tập từ vựng, ngữ pháp và đọc hiểu theo giáo trình Suomen Mestari 1.</p>
                
                <div className="grid md:grid-cols-2 gap-4">
                  {exercisesData.map(ex => (
                    <div key={ex.id} onClick={() => setSelectedExercise(ex)} className="border border-slate-200 rounded-xl p-5 hover:border-blue-400 hover:shadow-md transition-all cursor-pointer bg-slate-50 hover:bg-blue-50/30 group">
                      <span className="text-xs font-bold text-blue-600 bg-blue-100 px-2 py-1 rounded mb-3 inline-block uppercase tracking-wider">{ex.chapter}</span>
                      <h3 className="text-lg font-bold text-slate-800 mb-2 group-hover:text-blue-700">{ex.title}</h3>
                      <p className="text-sm text-slate-600">{ex.description}</p>
                      <div className="mt-4 flex items-center text-sm font-medium text-blue-600">
                        Bắt đầu làm bài <ArrowRight className="w-4 h-4 ml-1" />
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            ) : (
              <div className="bg-white rounded-xl shadow-sm border border-slate-100 overflow-hidden animate-in slide-in-from-right-4 duration-300">
                <div className="bg-slate-50 p-4 border-b border-slate-200 flex justify-between items-center">
                  <div>
                    <span className="text-xs font-bold text-slate-500 uppercase tracking-wider">{selectedExercise.chapter}</span>
                    <h2 className="text-xl font-bold text-slate-800">{selectedExercise.title}</h2>
                  </div>
                  <button onClick={closeExercise} className="p-2 hover:bg-slate-200 rounded-full text-slate-500 transition-colors">
                    <X className="w-5 h-5" />
                  </button>
                </div>

                <div className="p-6">
                  <p className="text-slate-600 mb-6 font-medium bg-blue-50 p-3 rounded-lg border border-blue-100">
                    {selectedExercise.description}
                  </p>

                  {selectedExercise.readingText && (
                    <div className="mb-6 p-4 bg-amber-50 border border-amber-200 rounded-lg text-slate-800 italic">
                      "{selectedExercise.readingText}"
                    </div>
                  )}

                  <div className="space-y-6">
                    {selectedExercise.questions.map((q, index) => {
                      const userAnswer = answers[q.id] || '';
                      const isCorrect = userAnswer.toString().trim().toLowerCase() === q.correctAnswer.toLowerCase();
                      
                      return (
                        <div key={q.id} className={`p-4 rounded-lg border ${isSubmitted ? (isCorrect ? 'bg-green-50 border-green-200' : 'bg-rose-50 border-rose-200') : 'border-slate-200 bg-white'}`}>
                          
                          {selectedExercise.type === 'fill-in-blanks' && (
                            <div className="flex items-center flex-wrap gap-2 text-lg">
                              <span className="font-medium">{index + 1}. {q.textBefore}</span>
                              <input 
                                type="text" 
                                value={userAnswer}
                                onChange={(e) => handleAnswerChange(q.id, e.target.value)}
                                disabled={isSubmitted}
                                className={`border-b-2 outline-none px-2 py-1 w-24 text-center font-bold text-blue-700 bg-transparent transition-colors ${isSubmitted ? (isCorrect ? 'border-green-500 text-green-700' : 'border-rose-500 text-rose-700') : 'border-slate-300 focus:border-blue-500'}`}
                              />
                              <span className="font-medium">{q.textAfter}</span>
                            </div>
                          )}

                          {(selectedExercise.type === 'true-false' || selectedExercise.type === 'multiple-choice') && (
                            <div>
                              <p className="font-medium text-lg mb-3">{index + 1}. {q.text}</p>
                              <div className="flex flex-wrap gap-3">
                                {(selectedExercise.options || q.options).map(opt => (
                                  <button
                                    key={opt}
                                    disabled={isSubmitted}
                                    onClick={() => handleAnswerChange(q.id, opt)}
                                    className={`px-4 py-2 rounded-lg border font-medium transition-all ${
                                      userAnswer === opt 
                                        ? 'bg-blue-600 text-white border-blue-600 shadow-md' 
                                        : 'bg-white text-slate-700 border-slate-300 hover:bg-slate-50'
                                    } ${isSubmitted && opt === q.correctAnswer ? '!bg-green-500 !text-white !border-green-500' : ''} ${isSubmitted && userAnswer === opt && !isCorrect ? '!bg-rose-500 !text-white !border-rose-500' : ''}`}
                                  >
                                    {opt}
                                  </button>
                                ))}
                              </div>
                            </div>
                          )}

                          {isSubmitted && !isCorrect && (
                            <div className="mt-3 text-sm text-rose-600 font-medium flex items-center">
                              <X className="w-4 h-4 mr-1" /> Đáp án đúng: <span className="font-bold ml-1">{q.correctAnswer}</span>
                            </div>
                          )}
                          {isSubmitted && isCorrect && (
                            <div className="mt-3 text-sm text-green-600 font-medium flex items-center">
                              <CheckCircle className="w-4 h-4 mr-1" /> Chính xác!
                            </div>
                          )}
                        </div>
                      );
                    })}
                  </div>

                  <div className="mt-8 border-t border-slate-200 pt-6 flex flex-col sm:flex-row items-center justify-between gap-4">
                    {isSubmitted ? (
                      <>
                        <div className="text-xl font-bold text-slate-800">
                          Kết quả: <span className={score === selectedExercise.questions.length ? 'text-green-600' : 'text-blue-600'}>{score} / {selectedExercise.questions.length}</span>
                        </div>
                        <div className="flex gap-3 w-full sm:w-auto">
                          <button onClick={resetExercise} className="flex-1 sm:flex-none px-6 py-3 rounded-lg border border-slate-300 font-medium text-slate-700 hover:bg-slate-50 transition-colors">
                            Làm lại
                          </button>
                          <button onClick={closeExercise} className="flex-1 sm:flex-none px-6 py-3 rounded-lg bg-blue-600 font-medium text-white hover:bg-blue-700 shadow-md transition-colors">
                            Bài tập khác
                          </button>
                        </div>
                      </>
                    ) : (
                      <button onClick={checkAnswers} className="w-full sm:w-auto px-8 py-3 rounded-lg bg-green-600 font-bold text-white hover:bg-green-700 shadow-md transition-colors text-lg">
                        Tarkista! (Kiểm tra)
                      </button>
                    )}
                  </div>
                </div>
              </div>
            )}
          </div>
        )}

      </main>

      <style dangerouslySetInnerHTML={{__html: `
        .perspective-1000 { perspective: 1000px; }
        .transform-style-3d { transform-style: preserve-3d; }
        .backface-hidden { backface-visibility: hidden; }
        .rotate-y-180 { transform: rotateY(180deg); }
        .scrollbar-hide::-webkit-scrollbar { display: none; }
        .scrollbar-hide { -ms-overflow-style: none; scrollbar-width: none; }
      `}} />
    </div>
  );
}