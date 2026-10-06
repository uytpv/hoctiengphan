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

// 1. Load Audio URLs mapping
const audioUrls = JSON.parse(fs.readFileSync(path.resolve(__dirname, 'audio_urls_ch01.json'), 'utf8'));

function getAudioUrl(snippet) {
  if (!snippet) return '';
  for (const [key, url] of Object.entries(audioUrls)) {
    if (key.toLowerCase().includes(snippet.toLowerCase())) return url;
  }
  return '';
}

// 2. Load Lessons from JSON
const lessonsData = JSON.parse(fs.readFileSync(path.resolve(__dirname, '../../content/lessons/chapter_01_lessons.json'), 'utf8'));

async function syncAll() {
  console.log('🚀 Synchronizing 15 Rich Interactive Lessons to Firestore Production...');

  for (const rawLesson of lessonsData.lessons) {
    let content = rawLesson.content;
    const audioUrlsList = [];

    if (rawLesson.audioSnippet) {
      const u1 = getAudioUrl(rawLesson.audioSnippet);
      if (u1) {
        content = content.replace('AUDIO_URL_1', u1);
        audioUrlsList.push(u1);
      }
    }

    if (rawLesson.audioSnippet2) {
      const u2 = getAudioUrl(rawLesson.audioSnippet2);
      if (u2) {
        content = content.replace('AUDIO_URL_2', u2);
        audioUrlsList.push(u2);
      }
    }

    await db.collection('lessons').doc(rawLesson.id).set({
      id: rawLesson.id,
      title: rawLesson.title,
      chapter: rawLesson.chapter,
      week: rawLesson.week,
      description: rawLesson.description,
      audioUrls: audioUrlsList,
      vocabIds: [],
      exerciseIds: [],
      grammarIds: [],
      content: content,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp()
    }, { merge: true });

    console.log(`✅ Synced Lesson: ${rawLesson.id} - ${rawLesson.title}`);
  }

  // 3. Update Study Plan Weeks
  console.log('\n🔄 Updating Study Plan Weeks 1 & 2 Action Items...');
  const planId = '6iWorOc6mZtnINIFBH8a';
  const week1DocId = 'gNDjRDVfunFsGMQ0ktK7';
  const week2DocId = 'wKeNBsjY9wgeV8zTh1Kx';

  // Read week_01.json and week_02.json
  const w1Path = path.resolve(__dirname, '../../content/curriculum/week_01.json');
  const w2Path = path.resolve(__dirname, '../../content/curriculum/week_02.json');
  const w1Data = JSON.parse(fs.readFileSync(w1Path, 'utf8'));
  const w2Data = JSON.parse(fs.readFileSync(w2Path, 'utf8'));

  // Target Ref ID mapping by Action ID
  const targetMap = {
    'w1_d1_act1': 'w1_d1_thoai_heijatervetuloa',
    'w1_d2_act1': 'w1_d2_tuvung_chaohoi',
    'w1_d2_act2': 'w1_d2_phatam_nguyenam',
    'w1_d3_act1': 'w1_d3_nguphap_vokaaliharmonia',
    'w1_d3_act2': 'sign_tervetuloa',
    'w1_d4_act1': 'w1_d4_bangchucai_sodem',
    'w1_d4_act2': 'song_numerolaulu',
    'w1_d5_act1': 'w1_d5_baitap_harjoitus567',
    'w1_d6_act1': 'w1_d6_ngaythang_harjoitus8910',
    'w1_d6_act2': 'sign_aukioloajat',
    'w1_d7_act1': 'w1_d7_onluyenthuchanh_tonghop',
    'w1_d7_act2': 'song_viikonpaivat',

    'w2_d1_act1': 'w2_d1_daitunhansung_dongtuolla',
    'w2_d2_act1': 'w2_d2_nguphap_phudinh_olla',
    'w2_d3_act1': 'w2_d3_cauhoi_kophaykhong',
    'w2_d4_act1': 'w2_d4_quocgia_ngonngu_quoctich',
    'w2_d5_act1': 'w2_d5_luyentap_harjoitus171819',
    'w2_d6_act1': 'w2_d6_docquocgia_harjoitus202122',
    'w2_d7_act1': 'w2_d7_kiemtra_danhgia_kappale1'
  };

  for (const day of w1Data.days) {
    for (const act of day.actions) {
      if (targetMap[act.id]) {
        act.targetRefId = targetMap[act.id];
      }
    }
  }

  for (const day of w2Data.days) {
    for (const act of day.actions) {
      if (targetMap[act.id]) {
        act.targetRefId = targetMap[act.id];
      }
    }
  }

  // Save back JSON
  fs.writeFileSync(w1Path, JSON.stringify(w1Data, null, 2), 'utf8');
  fs.writeFileSync(w2Path, JSON.stringify(w2Data, null, 2), 'utf8');

  // Push to Firestore
  await db.collection('study_plan_weeks').doc(week1DocId).set({
    planId: planId,
    weekNumber: 1,
    title: w1Data.title,
    description: w1Data.description,
    days: w1Data.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`✅ Synced Study Plan Week 1 (doc: ${week1DocId})`);

  await db.collection('study_plan_weeks').doc(week2DocId).set({
    planId: planId,
    weekNumber: 2,
    title: w2Data.title,
    description: w2Data.description,
    days: w2Data.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`✅ Synced Study Plan Week 2 (doc: ${week2DocId})`);

  console.log('\n🎉 ALL 15 RICH LESSONS & STUDY PLAN WEEKS SYNCED SUCCESSFULLY TO FIRESTORE PRODUCTION!');
}

syncAll().catch(err => {
  console.error('❌ Sync failed:', err);
  process.exit(1);
});
