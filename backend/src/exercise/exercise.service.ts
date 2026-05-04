import { Injectable, NotFoundException } from '@nestjs/common';
import { FirebaseService } from '../firebase/firebase.service';
import { ProgressService } from '../progress/progress.service';
import { SubmitExerciseDto } from './dto/submit-exercise.dto';
import { Exercise } from '../../../shared/types/src/index';

@Injectable()
export class ExerciseService {
  constructor(
    private readonly firebaseService: FirebaseService,
    private readonly progressService: ProgressService,
  ) {}

  private get collection() {
    return this.firebaseService.getFirestore().collection('exercises');
  }

  async getOne(id: string) {
    const doc = await this.collection.doc(id).get();
    if (!doc.exists) {
      throw new NotFoundException('Exercise not found');
    }
    const data = doc.data();
    // Omit answers for questions
    if (data.questions && Array.isArray(data.questions)) {
      data.questions = data.questions.map((q: any) => {
        const { correctIndex, correctText, ...publicQ } = q;
        return publicQ;
      });
    }
    return { id: doc.id, ...data };
  }

  async getExercisesByLesson(lessonId: string) {
    const snapshot = await this.collection.where('lessonId', '==', lessonId).get();
    return snapshot.docs.map(doc => {
      const data = doc.data();
      if (data.questions && Array.isArray(data.questions)) {
        data.questions = data.questions.map((q: any) => {
          const { correctIndex, correctText, ...publicQ } = q;
          return publicQ;
        });
      }
      return { id: doc.id, ...data };
    });
  }

  async submitAnswer(uid: string, dto: SubmitExerciseDto) {
    const doc = await this.collection.doc(dto.exerciseId).get();
    if (!doc.exists) {
      throw new NotFoundException('Exercise not found');
    }

    const exerciseData = doc.data();
    let score = 0;
    let total = 1;
    let results: any[] = [];

    if (exerciseData.questions && Array.isArray(exerciseData.questions) && dto.answers) {
      total = exerciseData.questions.length;
      results = exerciseData.questions.map((q: any, index: number) => {
        const userAnswer = dto.answers[index.toString()];
        let isCorrect = false;

        if (q.type === 'MULTIPLE_CHOICE' || !q.type) {
          isCorrect = userAnswer === q.correctIndex;
        } else if (q.type === 'FILL_IN_BLANK') {
          const userStr = String(userAnswer || '').trim().toLowerCase();
          const correctStr = String(q.correctText || '').trim().toLowerCase();
          isCorrect = userStr === correctStr;
        }

        if (isCorrect) score++;
        return {
          index,
          isCorrect,
          correctIndex: q.correctIndex,
          correctText: q.correctText,
        };
      });
    } else {
      // Fallback for single question or old format
      const isCorrect = this.checkAnswer(exerciseData as Exercise, dto.answer);
      if (isCorrect) score = 1;
      results = [{ isCorrect, correctIndex: (exerciseData as any).correctIndex }];
    }

    const percentage = (score / total) * 100;

    // Mark activity as completed if score is passing (e.g. > 70% or just any score)
    if (percentage >= 70 && dto.planId && dto.activityId) {
       // Using firestore directly here for simplicity, but could be in a service
       const db = this.firebaseService.getFirestore();
       // Try both studyPlans and study_plans as we saw discrepancy
       try {
         await db.collection('studyPlans').doc(dto.planId).collection('activities').doc(dto.activityId).update({
           isCompleted: true,
           score: percentage,
           updatedAt: new Date()
         });
       } catch (e) {
         // Fallback to study_plans
         await db.collection('study_plans').doc(dto.planId).collection('activities').doc(dto.activityId).update({
           isCompleted: true,
           score: percentage,
           updatedAt: new Date()
         });
       }
    }

    return {
      score,
      total,
      percentage,
      results,
    };
  }

  private checkAnswer(exercise: Exercise, userAnswer: any): boolean {
    const correct = (exercise as any).correctIndex ?? exercise.correctAnswer;

    if (Array.isArray(correct)) {
      if (!Array.isArray(userAnswer)) return false;
      return (
        correct.length === userAnswer.length &&
        correct.every((val, index) => val === userAnswer[index])
      );
    }

    if (typeof correct === 'number' || typeof userAnswer === 'number') {
      return correct?.toString() === userAnswer?.toString();
    }

    return correct === userAnswer;
  }
}
