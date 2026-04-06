const admin = require('firebase-admin');

// Configure emulator for development seeding
process.env.FIRESTORE_EMULATOR_HOST = 'localhost:8080';
process.env.FIREBASE_AUTH_EMULATOR_HOST = 'localhost:9099';

if (!admin.apps.length) {
  admin.initializeApp({
    projectId: 'hoc-tieng-phan'
  });
}

const db = admin.firestore();

async function seedWeek1() {
  console.log('🚀 Starting Curriculum Seeding for Week 1...');

  // 1. Get or Create Main Study Plan (Suomen Mestari 1)
  const plansSnap = await db.collection('study_plans').where('title', '==', 'Suomen Mestari 1').get();
  let planId;
  if (plansSnap.empty) {
    const newPlanRef = await db.collection('study_plans').add({
      title: 'Suomen Mestari 1',
      description: 'Lộ trình học theo giáo trình Suomen Mestari 1 (26 tuần)',
      durationWeeks: 26,
      isDefault: true,
      createdAt: admin.firestore.FieldValue.serverTimestamp()
    });
    planId = newPlanRef.id;
    console.log(`✅ Created Study Plan: ${planId}`);
  } else {
    planId = plansSnap.docs[0].id;
    console.log(`ℹ️ Using existing Study Plan: ${planId}`);
  }

  // 2. Create Lessons
  const lessonTitles = [
    'Chương 1 trang 10, 11 (Hội thoại: Hei ja tervetuloa!)',
    'Chương 1 trang 12, 13 (Từ vựng cơ bản và các câu chào hỏi)',
    'Chương 1 trang 14, 15 (Ngày trong tuần, bảng chữ cái, số đếm)'
  ];

  const lessonIds = [];
  for (const title of lessonTitles) {
    const lessonRef = await db.collection('lessons').add({
      title: title,
      chapter: 'Kappale 1',
      description: '',
      lessonContent: { text: '', videoUrl: null, imageIds: [] },
      grammarIds: [],
      speaking: { text: '', audioUrl: null, conversationUrl: null },
      exerciseIds: [],
      createdAt: admin.firestore.FieldValue.serverTimestamp()
    });
    lessonIds.push(lessonRef.id);
    console.log(`✅ Created Lesson: ${title} (${lessonRef.id})`);
  }

  // 3. Create Activities for Lessons
  const activityIds = [];
  for (let i = 0; i < lessonIds.length; i++) {
    const activityRef = await db.collection('activities').add({
      title: lessonTitles[i],
      description: 'Tài liệu học tập theo sách',
      type: 'lesson',
      lessonId: lessonIds[i],
      isPublic: true,
      createdAt: admin.firestore.FieldValue.serverTimestamp()
    });
    activityIds.push(activityRef.id);
    console.log(`✅ Created Activity for Lesson ${i+1}: ${activityRef.id}`);
  }

  // 4. Create Break Activity for Sunday
  const breakRef = await db.collection('activities').add({
    title: 'Bài học tự chọn hoặc Nghỉ ngơi',
    description: 'Tùy chọn ôn tập hoặc thư giãn chuẩn bị cho tuần mới',
    type: 'breakTime',
    isPublic: true,
    createdAt: admin.firestore.FieldValue.serverTimestamp()
  });
  const breakActivityId = breakRef.id;
  console.log(`✅ Created Break Activity: ${breakActivityId}`);

  // 5. Create Study Plan Week 1 (Tháng 1 - Tuần 1)
  const week1Data = {
    planId: planId,
    weekNumber: 1,
    title: 'Tháng 1 - Tuần 1: Khởi động Chương 1',
    days: [
      { dayName: 'Thứ 2', activityIds: [activityIds[0]] },
      { dayName: 'Thứ 3', activityIds: [] },
      { dayName: 'Thứ 4', activityIds: [activityIds[1]] },
      { dayName: 'Thứ 5', activityIds: [activityIds[2]] },
      { dayName: 'Thứ 6', activityIds: [] },
      { dayName: 'Thứ 7', activityIds: [] },
      { dayName: 'Chủ Nhật', activityIds: [breakActivityId] }
    ]
  };

  await db.collection('study_plan_weeks').add(week1Data);
  console.log('✅ Created Study Plan Week 1 successfully!');
}

seedWeek1().catch(err => {
  console.error('❌ Seeding failed:', err);
  process.exit(1);
});
