import { FirebaseService } from '../firebase/firebase.service';
import { UpdateStudyPlanDto } from './dto/update-study-plan.dto';
import { StudyPlan } from '@hoctiengphan/shared-types';
export declare class StudyPlanService {
    private readonly firebaseService;
    constructor(firebaseService: FirebaseService);
    private get collection();
    getStudyPlan(planId?: string): Promise<StudyPlan>;
    updateStudyPlan(planId: string | undefined, dto: UpdateStudyPlanDto): Promise<StudyPlan>;
}
