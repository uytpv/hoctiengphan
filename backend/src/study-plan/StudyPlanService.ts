import { Injectable, NotFoundException } from '@nestjs/common';
import { FirebaseService } from '../firebase/firebase.service';
import { UpdateStudyPlanDto } from './dto/update-study-plan.dto';

@Injectable()
export class StudyPlanService {
  constructor(private readonly firebaseService: FirebaseService) {}

  private get collection() {
    return this.firebaseService.getFirestore().collection('studyPlans');
  }

  async getStudyPlan(planId: string = 'suomen_mestari_1') {
    const doc = await this.collection.doc(planId).get();
    if (!doc.exists) throw new NotFoundException('Study plan not found');
    return { id: doc.id, ...doc.data() };
  }

  async updateStudyPlan(planId: string = 'suomen_mestari_1', dto: UpdateStudyPlanDto) {
    await this.collection.doc(planId).set(dto, { merge: true });
    return { id: planId, ...dto };
  }
}
