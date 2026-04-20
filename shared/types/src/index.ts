/**
 * Opi Suomea Project - Shared Business Logic Types
 * Following Global Constitution Rule III.2
 */

export interface Timestamp {
  seconds: number;
  nanoseconds: number;
}

// 1. GLOBAL SYSTEM DATA

export interface Task {
  id: string; // m1w1d1t1
  title: string;
  detail: string;
  iconType: "Users" | "Monitor" | string;
  activityType: 'vocabulary' | 'grammar' | 'reading' | 'listening' | 'video' | 'quiz' | 'general';
  lessonReferenceId?: string;
  externalMediaUrl?: string;
}

export interface Day {
  dayName: string;
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
  authorUid?: string | null;
  createdAt: Timestamp;
}

export interface GrammarLesson {
  chapter: string;
  title: string;
  desc: string;
  content: string;
}

// 2. USER INDIVIDUAL DATA

export interface UserProfile {
  email: string;
  displayName: string;
  role: 'user' | 'admin';
  createdAt: Timestamp;
  lastLogin: Timestamp;
}

export interface RoadmapProgress {
  completedTasks: Record<string, boolean>;
  updatedAt: Timestamp;
}

export interface NotebookVocabulary {
  vocabularyId: string;
  status: 'learned' | 'reviewing';
  addedAt: Timestamp;
}

export interface NotebookGrammar {
  grammarId: string;
  addedAt: Timestamp;
}

// Study Plan Feature
export interface StudyPlan {
  id: string;
  title: string;
  description: string;
  level: string;
  isActive: boolean;
  createdAt: Timestamp;
  updatedAt: Timestamp;
}
