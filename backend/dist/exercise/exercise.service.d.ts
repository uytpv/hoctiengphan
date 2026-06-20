import { FirebaseService } from '../firebase/firebase.service';
import { ProgressService } from '../progress/progress.service';
import { SubmitExerciseDto } from './dto/submit-exercise.dto';
import { Question } from '@hoctiengphan/shared-types';
export interface FeedbackItem {
    questionIndex: number;
    isCorrect: boolean;
    correctAnswer: string | number | undefined;
    explanation?: string;
}
export declare class ExerciseService {
    private readonly firebaseService;
    private readonly progressService;
    constructor(firebaseService: FirebaseService, progressService: ProgressService);
    private get collection();
    getOne(id: string): Promise<{
        id: string;
        titleFi: string;
        titleVi?: string;
        instructionFi?: string;
        instructionVi?: string;
        questions: Question[];
        lessonId?: string;
    }>;
    getExercisesByLesson(lessonId: string): Promise<{
        id: string;
        titleFi: string;
        titleVi?: string;
        instructionFi?: string;
        instructionVi?: string;
        questions: Question[];
        lessonId?: string;
    }[]>;
    submitAnswer(uid: string, dto: SubmitExerciseDto): Promise<{
        score: number;
        total: number;
        percentage: number;
        passed: boolean;
        feedback: FeedbackItem[];
    }>;
}
