import { FirebaseService } from '../firebase/firebase.service';
import { ProgressService } from '../progress/progress.service';
import { SubmitExerciseDto } from './dto/submit-exercise.dto';
export declare class ExerciseService {
    private readonly firebaseService;
    private readonly progressService;
    constructor(firebaseService: FirebaseService, progressService: ProgressService);
    private get collection();
    getOne(id: string): Promise<{
        id: string;
    }>;
    getExercisesByLesson(lessonId: string): Promise<{
        id: string;
    }[]>;
    submitAnswer(uid: string, dto: SubmitExerciseDto): Promise<{
        score: number;
        total: number;
        percentage: number;
        results: any[];
    }>;
    private checkAnswer;
}
