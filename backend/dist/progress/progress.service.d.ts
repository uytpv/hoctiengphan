import { FirebaseService } from '../firebase/firebase.service';
import { UpdateTaskDto } from './dto/update-task.dto';
import { RoadmapProgress } from '@hoctiengphan/shared-types';
export declare class ProgressService {
    private readonly firebaseService;
    constructor(firebaseService: FirebaseService);
    private get collection();
    getUserProgress(uid: string): Promise<RoadmapProgress>;
    updateTaskProgress(uid: string, dto: UpdateTaskDto): Promise<{
        taskId: string;
        isCompleted: boolean;
    }>;
}
