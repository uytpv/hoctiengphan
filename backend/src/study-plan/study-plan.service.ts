import { Injectable, NotFoundException } from '@nestjs/common';
import { FirebaseService } from '../firebase/firebase.service';
import { UpdateStudyPlanDto } from './dto/update-study-plan.dto';
import { StudyPlan } from '@hoctiengphan/shared-types';

@Injectable()
export class StudyPlanService {
  constructor(private readonly firebaseService: FirebaseService) {}

  private get collection() {
    return this.firebaseService.getFirestore().collection('studyPlans');
  }

  async getStudyPlan(planId: string = 'suomen_mestari_1'): Promise<StudyPlan> {
    const doc = await this.collection.doc(planId).get();
    if (!doc.exists) throw new NotFoundException('Study plan not found');
    return { id: doc.id, ...doc.data() } as StudyPlan;
  }

  async updateStudyPlan(
    planId: string = 'suomen_mestari_1',
    dto: UpdateStudyPlanDto,
  ): Promise<StudyPlan> {
    await this.collection.doc(planId).set(
      {
        ...dto,
        updatedAt: new Date(),
      },
      { merge: true },
    );
    const updated = await this.getStudyPlan(planId);
    return updated;
  }
}
