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

export interface BilingualText {
  fi: string;
  vi: string;
  en?: string;
}

export type ExerciseType = 'MULTIPLE_CHOICE' | 'FILL_IN_BLANK' | 'MATCHING' | 'TRUE_FALSE';

export interface Question {
  prompt: string;
  type: ExerciseType;
  options?: string[];
  correctIndex?: number;
  correctText?: string;
  explanation?: string;
}

export interface MultiQuestionExercise {
  id: string;
  titleFi: string;
  titleVi?: string;
  instructionFi?: string;
  instructionVi?: string;
  questions: Question[];
  lessonId?: string;
}

export interface Exercise {
  id: string;
  type: ExerciseType;
  question: BilingualText;
  options?: string[]; // For MULTIPLE_CHOICE or MATCHING
  correctAnswer: string | string[] | number; // Single value or list of valid answers
  explanation?: BilingualText;
  lessonId: string;
  difficulty: number; // 1-5
  tags?: string[]; // e.g. ["verb", "kpt-change"]
}

export interface Vocabulary {
  id?: string;
  finnish: string;
  pronunciation?: string;
  english: string;
  vietnamese: string;
  wordType?: 'noun' | 'verb' | 'adj' | 'adv' | 'phrase' | 'other';
  chapter?: string; // e.g. "SM1-K1"
  lessonId?: string;
  categoryIds?: string[];
  authorUid?: string | null;
  audioUrl?: string;
  imageUrl?: string;
  createdAt: Timestamp;
}

export interface GrammarLesson {
  chapter: string;
  title: BilingualText;
  desc: BilingualText;
  content: string; // Markdown supported
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
