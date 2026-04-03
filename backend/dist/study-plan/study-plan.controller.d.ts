import { StudyPlanService } from './study-plan.service';
import { UpdateStudyPlanDto } from './dto/update-study-plan.dto';
export declare class StudyPlanController {
    private readonly studyPlanService;
    constructor(studyPlanService: StudyPlanService);
    getStudyPlan(): Promise<{
        id: string;
    }>;
    updateStudyPlan(dto: UpdateStudyPlanDto): Promise<{
        title: string;
        months: any[];
        id: string;
    }>;
}
