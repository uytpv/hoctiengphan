import { ExerciseService } from './exercise.service';
import { SubmitExerciseDto } from './dto/submit-exercise.dto';
export declare class ExerciseController {
    private readonly exerciseService;
    constructor(exerciseService: ExerciseService);
    getExercisesByLesson(lessonId: string): Promise<{
        id: string;
    }[]>;
    getExerciseById(id: string): Promise<{
        id: string;
    }>;
    submitAnswer(user: any, dto: SubmitExerciseDto): Promise<{
        score: number;
        total: number;
        percentage: number;
        results: any[];
    }>;
}
