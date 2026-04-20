import { FirebaseService } from '../firebase/firebase.service';
import { UpdateStudyPlanDto } from './dto/update-study-plan.dto';
export declare class StudyPlanService {
    private readonly firebaseService;
    constructor(firebaseService: FirebaseService);
    private get collection();
    getStudyPlan(planId?: string): Promise<{
        id: string;
    }>;
    updateStudyPlan(planId: string | undefined, dto: UpdateStudyPlanDto): Promise<{
        title: string;
        months: any[];
        id: string;
    }>;
}
