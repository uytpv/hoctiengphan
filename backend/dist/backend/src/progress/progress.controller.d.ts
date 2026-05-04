import { ProgressService } from './progress.service';
import { UpdateTaskDto } from './dto/update-task.dto';
export declare class ProgressController {
    private readonly progressService;
    constructor(progressService: ProgressService);
    getUserProgress(user: any): Promise<string[]>;
    updateTaskProgress(user: any, dto: UpdateTaskDto): Promise<{
        taskId: string;
        isCompleted: boolean;
    }>;
}
