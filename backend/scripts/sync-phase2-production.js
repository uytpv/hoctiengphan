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

async function syncPhase2() {
  console.log('🚀 === STARTING PHASE 2 (WEEKS 3, 4, 5 - CHAPTER 2) SYNCHRONIZATION TO FIRESTORE ===\n');

  // STEP 1: Sync Exercises
  console.log('📝 1. Synchronizing Phase 2 Interactive Exercises into `exercises` collection...');
  const exercisesPath = path.resolve(__dirname, '../../content/curriculum/chapter_02_exercises.json');
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
  console.log('\n📚 2. Synchronizing Phase 2 Rich Interactive Lessons into `lessons` collection...');
  const lessonsPath = path.resolve(__dirname, '../../content/lessons/chapter_02_lessons.json');
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
      chapter: rawLesson.chapter || 'Kappale 2',
      week: rawLesson.week || 3,
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
        chapter: rawLesson.chapter || 'Kappale 2',
        description: rawLesson.description || '',
        content: content,
        type: rawLesson.id.startsWith('sign_') ? 'sign' : (rawLesson.id.startsWith('song_') ? 'music' : 'video'),
        updatedAt: admin.firestore.FieldValue.serverTimestamp()
      }, { merge: true });
    }

    console.log(`   ✅ Synced Lesson: [${rawLesson.id}] ${rawLesson.title}`);
  }

  // STEP 3: Sync Study Plan Weeks 3, 4, 5
  console.log('\n📅 3. Synchronizing Study Plan Weeks 3, 4, 5 into `study_plan_weeks`...');
  const planId = '6iWorOc6mZtnINIFBH8a';
  const week3DocId = 'jRAxRf8jDqDYG9Al7pXH';
  const week4DocId = 'FGpDFgWOzyGBcd9H14Ro';
  const week5DocId = 'H2JgipTNNJNwwOxDr6Zm';

  const w3Path = path.resolve(__dirname, '../../content/curriculum/week_03.json');
  const w4Path = path.resolve(__dirname, '../../content/curriculum/week_04.json');
  const w5Path = path.resolve(__dirname, '../../content/curriculum/week_05.json');

  const w3Data = JSON.parse(fs.readFileSync(w3Path, 'utf8'));
  const w4Data = JSON.parse(fs.readFileSync(w4Path, 'utf8'));
  const w5Data = JSON.parse(fs.readFileSync(w5Path, 'utf8'));

  await db.collection('study_plan_weeks').doc(week3DocId).set({
    planId: planId,
    weekNumber: 3,
    title: w3Data.title,
    description: w3Data.description,
    days: w3Data.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Week 3 (doc: ${week3DocId})`);

  await db.collection('study_plan_weeks').doc(week4DocId).set({
    planId: planId,
    weekNumber: 4,
    title: w4Data.title,
    description: w4Data.description,
    days: w4Data.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Week 4 (doc: ${week4DocId})`);

  await db.collection('study_plan_weeks').doc(week5DocId).set({
    planId: planId,
    weekNumber: 5,
    title: w5Data.title,
    description: w5Data.description,
    days: w5Data.days,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }, { merge: true });
  console.log(`   ✅ Synced Week 5 (doc: ${week5DocId})`);

  console.log('\n🎉 ALL PHASE 2 CONTENT & STUDY PLAN WEEKS SYNCED SUCCESSFULLY TO FIRESTORE PRODUCTION!');
}

syncPhase2().catch(err => {
  console.error('❌ Phase 2 Sync failed:', err);
  process.exit(1);
});
