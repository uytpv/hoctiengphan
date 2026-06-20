export interface Timestamp {
    seconds: number;
    nanoseconds: number;
}
export interface Task {
    id: string;
    title: string;
    detail: string;
    iconType: string;
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
