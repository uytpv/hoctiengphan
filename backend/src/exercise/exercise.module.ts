import { Module } from '@nestjs/common';
import { ExerciseController } from './exercise.controller';
import { ExerciseService } from './exercise.service';
import { FirebaseModule } from '../firebase/firebase.module';
import { ProgressModule } from '../progress/progress.module';

@Module({
  imports: [FirebaseModule, ProgressModule],
  controllers: [ExerciseController],
  providers: [ExerciseService],
  exports: [ExerciseService],
})
export class ExerciseModule {}
