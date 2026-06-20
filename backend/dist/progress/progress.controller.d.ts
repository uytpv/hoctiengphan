import { ProgressService } from './progress.service';
import { UpdateTaskDto } from './dto/update-task.dto';
import * as admin from 'firebase-admin';
export declare class ProgressController {
    private readonly progressService;
    constructor(progressService: ProgressService);
    getUserProgress(user: admin.auth.DecodedIdToken): Promise<import("@hoctiengphan/shared-types").RoadmapProgress>;
    updateTaskProgress(user: admin.auth.DecodedIdToken, dto: UpdateTaskDto): Promise<{
        taskId: string;
        isCompleted: boolean;
    }>;
}
