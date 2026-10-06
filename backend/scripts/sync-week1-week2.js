const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');
const serviceAccount = require('../hoc-tieng-phan-firebase-adminsdk-fbsvc-cbfffbc13f.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

async function sync() {
  console.log('🚀 Synchronizing Week 1 and Week 2 to Firestore Production...');

  // 1. Read JSON files
  const w1Data = JSON.parse(fs.readFileSync(path.resolve(__dirname, '../../content/curriculum/week_01.json'), 'utf8'));
  const w2Data = JSON.parse(fs.readFileSync(path.resolve(__dirname, '../../content/curriculum/week_02.json'), 'utf8'));

  const planId = '6iWorOc6mZtnINIFBH8a';
  const week1DocId = 'gNDjRDVfunFsGMQ0ktK7';
  const week2DocId = 'wKeNBsjY9wgeV8zTh1Kx';

  // 2. Update Week 1
  await db.collection('study_plan_weeks').doc(week1DocId).set({
    planId: planId,
    weekNumber: 1,
    title: w1Data.title,
    description: w1Data.description,
    days: w1Data.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`✅ Updated Week 1 (doc: ${week1DocId}) with ${w1Data.days.length} days`);

  // 3. Update Week 2
  await db.collection('study_plan_weeks').doc(week2DocId).set({
    planId: planId,
    weekNumber: 2,
    title: w2Data.title,
    description: w2Data.description,
    days: w2Data.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`✅ Updated Week 2 (doc: ${week2DocId}) with ${w2Data.days.length} days`);

  // 4. Seed Immersion Resources
  const immersionItems = [
    {
      id: 'sign_tervetuloa',
      type: 'street_sign',
      title: 'Biển hiệu: TERVETULOA! (Chào mừng)',
      description: 'Biển chào mừng phổ biến nhất tại Phần Lan, xuất hiện ở cửa ra vào sân bay Helsinki-Vantaa, nhà ga, trung tâm thương mại và siêu thị.',
      originalContent: 'TERVETULOA! Tervetuloa Suomeen! Tervetuloa meille!',
      vietnameseTranslation: 'CHÀO MỪNG! Chào mừng đến Phần Lan! Chào mừng đến nhà chúng tôi!',
      vocabularyNotes: ['tervetuloa: chào mừng (terve = khỏe mạnh + tuloa = sự đến)', 'meille: đến nhà chúng tôi'],
      tags: ['kappale1', 'biển_báo', 'giao_tiếp']
    },
    {
      id: 'song_numerolaulu',
      type: 'music',
      title: 'Bài hát thiếu nhi: Numerolaulu (Học đếm 1-10)',
      description: 'Giai điệu vui tươi giúp trẻ em và người mới học ghi nhớ số đếm từ 1 đến 10 một cách tự nhiên.',
      originalContent: 'Yksi, kaksi, kolme, neljä, viisi, kuusi, seitsemän, kahdeksan, yhdeksän, kymmenen!',
      vietnameseTranslation: 'Một, hai, ba, bốn, năm, sáu, bảy, tám, chín, mười!',
      vocabularyNotes: ['yksi = 1', 'kaksi = 2', 'kolme = 3', 'neljä = 4', 'viisi = 5', 'kuusi = 6', 'seitsemän = 7', 'kahdeksan = 8', 'yhdeksän = 9', 'kymmenen = 10'],
      mediaUrl: 'https://www.youtube.com/watch?v=D31jVwRhyO8',
      tags: ['kappale1', 'bài_hát', 'số_đếm']
    },
    {
      id: 'sign_aukioloajat',
      type: 'street_sign',
      title: 'Biển báo: AUKIOLOAJAT (Giờ mở cửa siêu thị)',
      description: 'Bảng giờ mở cửa thực tế tại các chuỗi bán lẻ lớn như S-Market, K-Market, Prisma, Alepa.',
      originalContent: 'AUKIOLOAJAT\nMa-Pe: 07:00 - 22:00\nLa: 08:00 - 21:00\nSu: 10:00 - 21:00\nAvoinna 24h / Suljettu',
      vietnameseTranslation: 'GIỜ MỞ CỬA\nThứ 2 - Thứ 6: 07:00 - 22:00\nThứ 7: 08:00 - 21:00\nChủ Nhật: 10:00 - 21:00\nMở cửa 24/24 / Đã đóng cửa',
      vocabularyNotes: ['aukioloajat: giờ mở cửa (auki = mở + olo = tình trạng + ajat = những thời gian)', 'avoinna: đang mở', 'suljettu: đã đóng'],
      tags: ['kappale1', 'biển_báo', 'đời_sống']
    },
    {
      id: 'song_viikonpaivat',
      type: 'music',
      title: 'Bài hát thiếu nhi: Viikonpäivät (7 ngày trong tuần)',
      description: 'Bài hát kinh điển giúp ghi nhớ thứ tự 7 ngày trong tuần và thói quen phát âm trọng âm âm tiết đầu.',
      originalContent: 'Maanantai, tiistai, keskiviikko, torstai, perjantai, lauantai ja sunnuntai!',
      vietnameseTranslation: 'Thứ Hai, thứ Ba, thứ Tư, thứ Năm, thứ Sáu, thứ Bảy và Chủ Nhật!',
      vocabularyNotes: ['viikonpäivät: các ngày trong tuần (viikko = tuần + päivät = những ngày)', 'viikonloppu: cuối tuần'],
      mediaUrl: 'https://www.youtube.com/watch?v=Jm3Uo6001wQ',
      tags: ['kappale1', 'bài_hát', 'ngày_tháng']
    }
  ];

  for (const item of immersionItems) {
    await db.collection('immersion_resources').doc(item.id).set({
      ...item,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp()
    }, { merge: true });
    console.log(`✅ Seeded Immersion Resource: ${item.id} (${item.title})`);
  }

  console.log('🎉 Week 1 & Week 2 synchronization completed successfully!');
}

sync().catch(console.error);
