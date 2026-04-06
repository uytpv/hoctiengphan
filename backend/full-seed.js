const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');

// Configure emulator to use 127.0.0.1 (matches Flutter config)
process.env.FIRESTORE_EMULATOR_HOST = '127.0.0.1:8080';
process.env.FIREBASE_AUTH_EMULATOR_HOST = '127.0.0.1:9099';

if (!admin.apps.length) {
  admin.initializeApp({
    projectId: 'hoc-tieng-phan'
  });
}

const db = admin.firestore();

async function fullSeed() {
  console.log('🚀 Dọn dẹp dữ liệu cũ (trừ users)...');
  const collectionsToDelete = ['vocabularies', 'lessons', 'categories', 'activities', 'grammars', 'exercises', 'study_plans', 'study_plan_weeks'];
  for (const coll of collectionsToDelete) {
    const snap = await db.collection(coll).get();
    const batch = db.batch();
    snap.docs.forEach(doc => batch.delete(doc.ref));
    await batch.commit();
    console.log(`✅ Đã xóa ${snap.size} documents trong ${coll}`);
  }

  // 1. Tạo Activity Nghỉ ngơi (Break)
  const breakActivityRef = await db.collection('activities').add({
    title: 'Nghỉ ngơi (Break)',
    type: 'breakTime',
    description: 'Thời gian nghỉ ngơi để nạp lại năng lượng.',
    isPublic: true,
    createdAt: admin.firestore.FieldValue.serverTimestamp()
  });
  const breakActivityId = breakActivityRef.id;
  console.log('✅ Đã tạo Activity: Nghỉ ngơi');

  // 2. Tạo Grammar & Exercise mẫu
  const grammarRef = await db.collection('grammars').add({
    title: 'Động từ Olla',
    content: 'Olla là động từ quan trọng nhất trong tiếng Phần Lan (to be)...',
    isPublic: true
  });
  const grammarId = grammarRef.id;
  console.log('✅ Đã tạo Grammar: Động từ Olla');

  const exerciseRef = await db.collection('exercises').add({
    title: 'bài tập 1',
    description: 'Bài tập cơ bản về chia động từ Olla',
    isPublic: true
  });
  const exerciseId = exerciseRef.id;
  console.log('✅ Đã tạo Exercise: bài tập 1');

  // 3. Phân tích studyPlans.txt
  console.log('📖 Đang phân tích studyPlans.txt...');
  const studyPlansPath = path.join(__dirname, '../docs/studyPlans.txt');
  const studyPlansContent = fs.readFileSync(studyPlansPath, 'utf-8');
  
  const lessonEntries = []; // { weekNum, dayName, title, chapter }
  const lines = studyPlansContent.split('\n');
  let currentWeekNum = 0;
  
  for (const line of lines) {
    const weekMatch = line.match(/### \*\*Tháng \d+ - Tuần (\d+):/i);
    if (weekMatch) {
      currentWeekNum = parseInt(weekMatch[1]);
      continue;
    }
    
    // Match line: *   **Thứ 2:** ...
    const dayMatch = line.match(/^\*   \*\*(Thứ [234567]|Chủ Nhật|Maanantai|Tiistai|Keskiviikko|Torstai|Perjantai|Lauantai|Sunnuntai):\*\*\s*(.*)/i);
    if (dayMatch && currentWeekNum > 0) {
      const dayName = dayMatch[1].trim();
      const title = dayMatch[2].trim();
      
      const chapterMatch = title.match(/Chương (\d+)/i);
      const chapterLabel = chapterMatch ? `Chương ${chapterMatch[1]}` : 'Tổng ôn';
      lessonEntries.push({ weekNum: currentWeekNum, dayName, title, chapter: chapterLabel });
    }
  }
  console.log(`✅ Tìm thấy ${lessonEntries.length} bài học từ studyPlans.txt.`);

  // 4. Tạo Lessons & Activities
  const lessonsMap = new Map(); // Title -> LessonId
  const lessonActivityMap = new Map(); // LessonId -> ActivityId
  const chapterToFirstLessonId = new Map();

  for (const entry of lessonEntries) {
    const lessonRef = await db.collection('lessons').add({
      title: entry.title,
      chapter: entry.chapter,
      weekNumber: entry.weekNum,
      description: `Bài học chi tiết: ${entry.title}`,
      lessonContent: {
        text: `Nội dung học tập cho bài ${entry.title}... [Hội thoại & Từ vựng]`,
        imageIds: []
      },
      speaking: {
        text: `Hội thoại mẫu cho bài ${entry.title}...`,
        audioUrl: ''
      },
      grammarIds: entry.title.includes('Ngữ pháp') ? [grammarId] : [],
      exerciseIds: entry.title.includes('Bài tập') ? [exerciseId] : [],
      createdAt: admin.firestore.FieldValue.serverTimestamp()
    });
    
    const lid = lessonRef.id;
    lessonsMap.set(entry.title, lid);
    if (!chapterToFirstLessonId.has(entry.chapter)) {
      chapterToFirstLessonId.set(entry.chapter, lid);
    }

    const activityRef = await db.collection('activities').add({
      title: entry.title,
      description: `Bài học ngày ${entry.dayName}, tuần ${entry.weekNum}`,
      type: 'lesson',
      lessonId: lid,
      isPublic: true,
      createdAt: admin.firestore.FieldValue.serverTimestamp()
    });
    lessonActivityMap.set(lid, activityRef.id);
  }
  console.log(`✅ Đã tạo ${lessonEntries.length} Lessons & Activities.`);

  // 5. Nhập 825 từ vựng
  console.log('📖 Đang nhập 825 từ vựng từ initialVocabularyData.js...');
  const vocabPath = path.join(__dirname, '../docs/initialVocabularyData.js');
  const vocabContent = fs.readFileSync(vocabPath, 'utf-8');
  const vocabArrayString = vocabContent.substring(vocabContent.indexOf('['), vocabContent.lastIndexOf(']') + 1);
  const vocabularyData = new Function(`return ${vocabArrayString}`)();
  
  // Categories
  const categoryNamesSet = new Set();
  vocabularyData.forEach(item => {
    if (item.category.includes(':')) {
      categoryNamesSet.add(item.category.split(':')[1].trim());
    } else {
      categoryNamesSet.add(item.category.trim());
    }
  });

  const categoriesMap = new Map();
  for (const name of categoryNamesSet) {
    const catRef = await db.collection('categories').add({ 
      name, 
      createdAt: admin.firestore.FieldValue.serverTimestamp() 
    });
    categoriesMap.set(name, catRef.id);
  }

  let vocabCount = 0;
  let batch = db.batch();
  for (const item of vocabularyData) {
    const vocabRef = db.collection('vocabularies').doc();
    
    let lessonName = "Chương chung";
    let catName = item.category.trim();
    if (item.category.includes(':')) {
      const parts = item.category.split(':');
      lessonName = parts[0].trim(); 
      catName = parts[1].trim();
    }
    
    const displayChapter = lessonName.replace(/kappale/i, 'Chương');
    const linkedLessonId = chapterToFirstLessonId.get(displayChapter) || null;

    batch.set(vocabRef, {
      finnish: item.finnish,
      pronunciation: item.pronunciation,
      english: item.english,
      vietnamese: item.vietnamese,
      isGlobal: true,
      lessonId: linkedLessonId,
      categoryIds: [categoriesMap.get(catName)],
      createdAt: admin.firestore.FieldValue.serverTimestamp()
    });

    vocabCount++;
    if (vocabCount % 500 === 0) {
      await batch.commit();
      batch = db.batch();
      console.log(`...đã nạp ${vocabCount} từ vựng.`);
    }
  }
  await batch.commit();
  console.log(`✅ Đã nạp thành công ${vocabCount} từ vựng.`);

  // 6. Tạo Study Plan & 24 Weeks
  const studyPlanRef = await db.collection('study_plans').add({
    title: 'Lộ trình 24 Tuần Suomen Mestari 1',
    description: 'Chi tiết lộ trình 6 tháng học tiếng Phần...',
    durationWeeks: 24,
    isDefault: true,
    createdAt: admin.firestore.FieldValue.serverTimestamp()
  });
  const planId = studyPlanRef.id;

  for (let w = 1; w <= 24; w++) {
    const weekLessons = lessonEntries.filter(e => e.weekNum === w);
    const dayNames = ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'Chủ Nhật'];
    const daysData = dayNames.map(dName => {
      let aIds = [];
      const dayMatches = weekLessons.filter(lesson => lesson.dayName === dName);
      
      for(const dm of dayMatches) {
        const lid = lessonsMap.get(dm.title);
        const aid = lessonActivityMap.get(lid);
        if(aid) aIds.push(aid);
      }

      if (dName === 'Chủ Nhật') aIds.push(breakActivityId);
      
      return {
        dayName: dName,
        activityIds: aIds
      };
    });

    await db.collection('study_plan_weeks').add({
      planId: planId,
      weekNumber: w,
      title: `Tuần ${w}`,
      days: daysData
    });
  }
  console.log('✅ Đã tạo Study Plan & 24 Weeks!');
  console.log('🎉 TOÀN BỘ CURRICULUM ĐÃ ĐƯỢC SEED THÀNH CÔNG!');
}

fullSeed().catch(err => {
  console.error('❌ Seeding failed:', err);
  process.exit(1);
});
