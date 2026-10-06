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

// 1. Audio URLs mapping
const audioUrls = JSON.parse(fs.readFileSync(path.resolve(__dirname, 'audio_urls_all.json'), 'utf8'));

function getAudioUrl(snippet) {
  if (!snippet) return '';
  for (const [key, url] of Object.entries(audioUrls)) {
    if (key.toLowerCase().includes(snippet.toLowerCase())) return url;
  }
  return '';
}

async function syncStandardizedLessons() {
  console.log('🚀 === SYNCHRONIZING STANDARDIZED CHAPTER 1 & 2 LESSONS TO FIRESTORE PRODUCTION ===\n');

  // 1. Chapter 1: w1_d1_thoai_heijatervetuloa
  const ch1Path = path.resolve(__dirname, '../../content/lessons/chapter_01_lessons.json');
  const ch1Data = JSON.parse(fs.readFileSync(ch1Path, 'utf8'));
  const lessonCh1 = ch1Data.lessons.find(l => l.id === 'w1_d1_thoai_heijatervetuloa');

  if (lessonCh1) {
    let content = lessonCh1.content;
    const audioUrlsList = [];
    if (lessonCh1.audioSnippet) {
      const u1 = getAudioUrl(lessonCh1.audioSnippet);
      if (u1) {
        content = content.replace(/AUDIO_URL_1/g, u1);
        audioUrlsList.push(u1);
      }
    }
    if (lessonCh1.audioSnippet2) {
      const u2 = getAudioUrl(lessonCh1.audioSnippet2);
      if (u2) {
        content = content.replace(/AUDIO_URL_2/g, u2);
        audioUrlsList.push(u2);
      }
    }

    await db.collection('lessons').doc(lessonCh1.id).set({
      id: lessonCh1.id,
      title: lessonCh1.title,
      chapter: lessonCh1.chapter || 'Kappale 1',
      week: lessonCh1.week || 1,
      description: lessonCh1.description || '',
      audioUrls: audioUrlsList,
      content: content,
      updatedAt: admin.firestore.FieldValue.serverTimestamp()
    }, { merge: true });

    console.log(`✅ Synced standardized Lesson [${lessonCh1.id}]: ${lessonCh1.title}`);
  }

  // 2. Chapter 2: w3_d1_thoai_minkamaalainen, w3_d2_tuvung_quocgia_ngonngu, w3_d3_giaotiep_jatskikiskalla
  const ch2Path = path.resolve(__dirname, '../../content/lessons/chapter_02_lessons.json');
  const ch2Data = JSON.parse(fs.readFileSync(ch2Path, 'utf8'));
  const targetCh2Ids = [
    'w3_d1_thoai_minkamaalainen',
    'w3_d2_tuvung_quocgia_ngonngu',
    'w3_d3_giaotiep_jatskikiskalla'
  ];

  for (const id of targetCh2Ids) {
    const rawLesson = ch2Data.lessons.find(l => l.id === id);
    if (!rawLesson) continue;

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
      chapter: rawLesson.chapter || 'Kappale 2',
      week: rawLesson.week || 3,
      description: rawLesson.description || '',
      audioUrls: audioUrlsList,
      content: content,
      updatedAt: admin.firestore.FieldValue.serverTimestamp()
    }, { merge: true });

    console.log(`✅ Synced standardized Lesson [${rawLesson.id}]: ${rawLesson.title}`);
  }

  console.log('\n🎉 === STANDARDIZED CHAPTER 1 & 2 LESSONS SUCCESSFULLY SYNCED TO FIRESTORE PRODUCTION! ===');
}

syncStandardizedLessons().catch(err => {
  console.error('❌ Sync failed:', err);
  process.exit(1);
});
