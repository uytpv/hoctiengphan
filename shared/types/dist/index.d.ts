/**
 * Opi Suomea Project - Shared Business Logic Types
 * Following Global Constitution Rule III.2
 */
export interface Timestamp {
    seconds: number;
    nanoseconds: number;
}
export interface Task {
    id: string;
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
    options?: string[];
    correctAnswer: string | string[] | number;
    explanation?: BilingualText;
    lessonId: string;
    difficulty: number;
    tags?: string[];
}
export interface Vocabulary {
    id?: string;
    finnish: string;
    pronunciation?: string;
    english: string;
    vietnamese: string;
    wordType?: 'noun' | 'verb' | 'adj' | 'adv' | 'phrase' | 'other';
    chapter?: string;
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
    content: string;
}
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
export type ImmersionType = 'music' | 'movie' | 'street_sign' | 'practical_life';
export interface ImmersionResource {
    id: string;
    type: ImmersionType;
    title: string;
    description?: string;
    mediaUrl?: string;
    thumbnailUrl?: string;
    originalContent?: string;
    vietnameseTranslation?: string;
    vocabularyNotes?: string[];
    tags?: string[];
    createdAt?: Timestamp;
    updatedAt?: Timestamp;
}
export interface ActionStep {
    stepNumber: number;
    instruction: string;
    tip?: string;
}
export type ActionItemType = 'lesson_full' | 'lesson_slice' | 'vocabulary_set' | 'grammar_point' | 'exercise_set' | 'immersion_music' | 'immersion_movie' | 'immersion_sign' | 'custom';
export interface DailyActionItem {
    id: string;
    type: ActionItemType;
    title: string;
    goal?: string;
    estimatedMinutes?: number;
    targetRefId?: string;
    specificItemIds?: string[];
    steps: ActionStep[];
    externalLink?: string;
    notes?: string;
}
export interface StudyDay {
    dayIndex: number;
    dayName: string;
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
    level: string;
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
    chapter: string;
    description?: string;
    content: string;
    vocabIds: string[];
    exerciseIds: string[];
    audioUrls: string[];
    grammarIds: string[];
    createdAt: Timestamp;
    updatedAt: Timestamp;
}
