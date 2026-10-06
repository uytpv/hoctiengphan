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

// Study Plan Feature & Polymorphic Action Items
export type ImmersionType = 'music' | 'movie' | 'street_sign' | 'practical_life';

export interface ImmersionResource {
  id: string;
  type: ImmersionType;
  title: string;
  description?: string;
  mediaUrl?: string; // Audio / Video URL or Image URL for street sign
  thumbnailUrl?: string;
  originalContent?: string; // Lyrics, transcript, or street sign text
  vietnameseTranslation?: string; // Line-by-line or full translation
  vocabularyNotes?: string[]; // Highlighted vocabularies / idioms
  tags?: string[];
  createdAt?: Timestamp;
  updatedAt?: Timestamp;
}

export interface ActionStep {
  stepNumber: number;
  instruction: string;
  tip?: string;
}

export type ActionItemType =
  | 'lesson_full'
  | 'lesson_slice'
  | 'vocabulary_set'
  | 'grammar_point'
  | 'exercise_set'
  | 'immersion_music'
  | 'immersion_movie'
  | 'immersion_sign'
  | 'custom';

export interface DailyActionItem {
  id: string;
  type: ActionItemType;
  title: string;
  goal?: string;
  estimatedMinutes?: number;
  targetRefId?: string; // lessonId, grammarId, immersionResourceId, etc.
  specificItemIds?: string[]; // specific vocabIds or exerciseIds
  steps: ActionStep[];
  externalLink?: string;
  notes?: string;
}

export interface StudyDay {
  dayIndex: number; // 1-7 (Mon-Sun)
  dayName: string; // e.g. "Thứ 2", "Maanantai"
  actions: DailyActionItem[];
}

export interface StudyPlanWeek {
  id: string;
  planId: string;
  weekNumber: number;
  title: string;
  description?: string;
  days: StudyDay[];
}

export interface StudyPlan {
  id: string;
  title: string;
  description: string;
  level: string; // e.g. "A1.1", "A1.2"
  durationWeeks?: number;
  isActive: boolean;
  createdAt: Timestamp;
  updatedAt: Timestamp;
}

export interface GrammarTopic {
  id: string;
  chapter: string;
  title: string | BilingualText;
  desc?: string | BilingualText;
  content: any;
  createdAt?: Timestamp | any;
  updatedAt?: Timestamp | any;
}

export interface Lesson {
  id: string;
  title: string;
  chapter: string; // e.g. "Kappale 1"
  description?: string;
  content: string; // Markdown text containing shortcodes
  vocabIds: string[];
  exerciseIds: string[];
  audioUrls: string[];
  grammarIds: string[];
  createdAt: Timestamp;
  updatedAt: Timestamp;
}


