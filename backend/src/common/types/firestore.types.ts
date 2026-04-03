/**
 * Opi Suomea Project - Firestore Schema Models (TypeScript)
 */

export interface Timestamp {
  seconds: number;
  nanoseconds: number;
}

// 1. DỮ LIỆU HỆ THỐNG (GLOBAL DATA)

export interface Task {
  id: string; // m1w1d1t1
  title: string;
  detail: string;
  iconType: "Users" | "Monitor" | string;
  activityType: 'vocabulary' | 'grammar' | 'reading' | 'listening' | 'video' | 'quiz' | 'general';
  lessonReferenceId?: string; // Trỏ đến Grammar Lesson ID hoặc Vocab Lesson ID
  externalMediaUrl?: string; // Dùng cho Video (YouTube), Music, News
}

export interface Day {
  dayName: string; // Maanantai (Thứ Hai)
  tasks: Task[];
}

export interface Week {
  weekId: number;
  title: string;
  days: Day[];
}

export interface Roadmap {
  monthId: number;
  title: string;
  weeks: Week[];
}

export interface Vocabulary {
  finnish: string;
  pronunciation: string;
  english: string;
  vietnamese: string;
  lessonId?: string;
  categoryIds?: string[];
  authorUid?: string | null; // null nếu là từ gốc của hệ thống, UID nếu là từ user tự thêm (sẽ được global hóa)
  createdAt: Timestamp;
}

export interface GrammarLesson {
  chapter: string; // Kappale 1
  title: string;
  desc: string;
  content: string; // HTML string or Rich Text JSON
}

// 2. DỮ LIỆU NGƯỜI DÙNG CÁ NHÂN (USER DATA)

export interface UserProfile {
  email: string;
  displayName: string;
  role: 'user' | 'admin';
  createdAt: Timestamp;
  lastLogin: Timestamp;
}

export interface RoadmapProgress {
  completedTasks: Record<string, boolean>; // e.g: { "m1w1d1t1": true }
  updatedAt: Timestamp;
}

export interface NotebookVocabulary {
  vocabularyId: string; // Tham chiếu đến Global Document ID
  status: 'learned' | 'reviewing'; // 'learned' để phục vụ check mark "Từ đã học"
  addedAt: Timestamp;
}

export interface NotebookGrammar {
  grammarId: string; // Tham chiếu đến Grammar Lesson
  addedAt: Timestamp;
}
