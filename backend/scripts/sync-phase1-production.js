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
const audioUrls = JSON.parse(fs.readFileSync(path.resolve(__dirname, 'audio_urls_ch01.json'), 'utf8'));

function getAudioUrl(snippet) {
  if (!snippet) return '';
  for (const [key, url] of Object.entries(audioUrls)) {
    if (key.toLowerCase().includes(snippet.toLowerCase())) return url;
  }
  return '';
}

async function syncPhase1() {
  console.log('🚀 === STARTING MASTER PHASE 1 SYNCHRONIZATION TO FIRESTORE ===\n');

  // STEP 1: Sync Exercises
  console.log('📝 1. Synchronizing 20+ Interactive Exercises into `exercises` collection...');
  const exercisesPath = path.resolve(__dirname, '../../content/curriculum/chapter_01_exercises.json');
  const exercisesData = JSON.parse(fs.readFileSync(exercisesPath, 'utf8'));

  for (const ex of exercisesData.exercises) {
    await db.collection('exercises').doc(ex.id).set({
      id: ex.id,
      title: ex.title,
      type: ex.type || 'MULTIPLE_CHOICE',
      questions: ex.questions,
      updatedAt: admin.firestore.FieldValue.serverTimestamp()
    }, { merge: true });
    console.log(`   ✅ Synced Exercise: [${ex.id}] ${ex.title} (${ex.questions.length} questions)`);
  }

  // STEP 2: Sync Lessons
  console.log('\n📚 2. Synchronizing Rich Interactive Lessons into `lessons` collection...');
  const lessonsPath = path.resolve(__dirname, '../../content/lessons/chapter_01_lessons.json');
  const lessonsData = JSON.parse(fs.readFileSync(lessonsPath, 'utf8'));

  for (const rawLesson of lessonsData.lessons) {
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
      chapter: rawLesson.chapter || 'Kappale 1',
      week: rawLesson.week || 1,
      description: rawLesson.description || '',
      audioUrls: audioUrlsList,
      content: content,
      updatedAt: admin.firestore.FieldValue.serverTimestamp()
    }, { merge: true });

    // Also mirror immersion resources into immersion_resources collection
    if (rawLesson.id.startsWith('sign_') || rawLesson.id.startsWith('song_') || rawLesson.id.startsWith('video_')) {
      await db.collection('immersion_resources').doc(rawLesson.id).set({
        id: rawLesson.id,
        title: rawLesson.title,
        chapter: rawLesson.chapter || 'Kappale 1',
        description: rawLesson.description || '',
        content: content,
        type: rawLesson.id.startsWith('sign_') ? 'sign' : (rawLesson.id.startsWith('song_') ? 'music' : 'video'),
        updatedAt: admin.firestore.FieldValue.serverTimestamp()
      }, { merge: true });
    }

    console.log(`   ✅ Synced Lesson: [${rawLesson.id}] ${rawLesson.title}`);
  }

  // STEP 3: Sync Study Plan Weeks
  console.log('\n📅 3. Synchronizing Study Plan Weeks 1 & 2 into `study_plan_weeks`...');
  const planId = '6iWorOc6mZtnINIFBH8a';
  const week1DocId = 'gNDjRDVfunFsGMQ0ktK7';
  const week2DocId = 'wKeNBsjY9wgeV8zTh1Kx';

  const w1Path = path.resolve(__dirname, '../../content/curriculum/week_01.json');
  const w2Path = path.resolve(__dirname, '../../content/curriculum/week_02.json');
  const w1Data = JSON.parse(fs.readFileSync(w1Path, 'utf8'));
  const w2Data = JSON.parse(fs.readFileSync(w2Path, 'utf8'));

  await db.collection('study_plan_weeks').doc(week1DocId).set({
    planId: planId,
    weekNumber: 1,
    title: w1Data.title,
    description: w1Data.description,
    days: w1Data.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Study Plan Week 1 (doc: ${week1DocId})`);

  await db.collection('study_plan_weeks').doc(week2DocId).set({
    planId: planId,
    weekNumber: 2,
    title: w2Data.title,
    description: w2Data.description,
    days: w2Data.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Study Plan Week 2 (doc: ${week2DocId})`);

  console.log('\n🎉 === PHASE 1 SYNCHRONIZATION COMPLETED WITH 100% SUCCESS! ===');
}

syncPhase1().catch(err => {
  console.error('❌ Sync failed:', err);
  process.exit(1);
});
