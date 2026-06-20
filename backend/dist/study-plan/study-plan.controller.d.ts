import { StudyPlanService } from './study-plan.service';
import { UpdateStudyPlanDto } from './dto/update-study-plan.dto';
export declare class StudyPlanController {
    private readonly studyPlanService;
    constructor(studyPlanService: StudyPlanService);
    getStudyPlan(): Promise<import("@hoctiengphan/shared-types").StudyPlan>;
    updateStudyPlan(dto: UpdateStudyPlanDto): Promise<import("@hoctiengphan/shared-types").StudyPlan>;
}
