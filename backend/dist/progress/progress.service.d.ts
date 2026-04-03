import { FirebaseService } from '../firebase/firebase.service';
import { UpdateTaskDto } from './dto/update-task.dto';
export declare class ProgressService {
    private readonly firebaseService;
    constructor(firebaseService: FirebaseService);
    private get collection();
    getUserProgress(uid: string): Promise<string[]>;
    updateTaskProgress(uid: string, dto: UpdateTaskDto): Promise<{
        taskId: string;
        isCompleted: boolean;
    }>;
}
