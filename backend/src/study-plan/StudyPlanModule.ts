import { Module } from '@nestjs/common';
import { StudyPlanController } from './StudyPlanController';
import { StudyPlanService } from './StudyPlanService';

@Module({
  controllers: [StudyPlanController],
  providers: [StudyPlanService]
})
export class StudyPlanModule {}
