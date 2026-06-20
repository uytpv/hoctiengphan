import { ExerciseService } from './exercise.service';
import { SubmitExerciseDto } from './dto/submit-exercise.dto';
import * as admin from 'firebase-admin';
export declare class ExerciseController {
    private readonly exerciseService;
    constructor(exerciseService: ExerciseService);
    getExercisesByLesson(lessonId: string): Promise<{
        id: string;
        titleFi: string;
        titleVi?: string;
        instructionFi?: string;
        instructionVi?: string;
        questions: import("@hoctiengphan/shared-types").Question[];
        lessonId?: string;
    }[]>;
    getExerciseById(id: string): Promise<{
        id: string;
        titleFi: string;
        titleVi?: string;
        instructionFi?: string;
        instructionVi?: string;
        questions: import("@hoctiengphan/shared-types").Question[];
        lessonId?: string;
    }>;
    submitAnswer(user: admin.auth.DecodedIdToken, dto: SubmitExerciseDto): Promise<{
        score: number;
        total: number;
        percentage: number;
        passed: boolean;
        feedback: import("./exercise.service").FeedbackItem[];
    }>;
}
