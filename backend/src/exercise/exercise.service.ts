import { Injectable, NotFoundException } from '@nestjs/common';
import { FirebaseService } from '../firebase/firebase.service';
import { ProgressService } from '../progress/progress.service';
import { SubmitExerciseDto } from './dto/submit-exercise.dto';
import { MultiQuestionExercise, Question } from '@hoctiengphan/shared-types';

export interface FeedbackItem {
  questionIndex: number;
  isCorrect: boolean;
  correctAnswer: string | number | undefined;
  explanation?: string;
}

type PublicQuestion = Omit<Question, 'correctIndex' | 'correctText'>;

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
    const data = doc.data() as MultiQuestionExercise;

    // Omit answers for questions for public view
    if (data.questions && Array.isArray(data.questions)) {
      // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
      data.questions = data.questions.map((q: Question): PublicQuestion => {
        // eslint-disable-next-line @typescript-eslint/no-unused-vars
        const { correctIndex, correctText, ...publicQ } = q;
        return publicQ;
      }) as any;
    }
    return { ...data, id: doc.id };
  }

  async getExercisesByLesson(lessonId: string) {
    const snapshot = await this.collection
      .where('lessonId', '==', lessonId)
      .get();
    return snapshot.docs.map((doc) => {
      const data = doc.data() as MultiQuestionExercise;
      if (data.questions && Array.isArray(data.questions)) {
        // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
        data.questions = data.questions.map((q: Question): PublicQuestion => {
          // eslint-disable-next-line @typescript-eslint/no-unused-vars
          const { correctIndex, correctText, ...publicQ } = q;
          return publicQ;
        }) as any;
      }
      return { ...data, id: doc.id };
    });
  }

  async submitAnswer(uid: string, dto: SubmitExerciseDto) {
    const doc = await this.collection.doc(dto.exerciseId).get();
    if (!doc.exists) {
      throw new NotFoundException('Exercise not found');
    }

    const exerciseData = doc.data() as MultiQuestionExercise;
    let score = 0;
    const questions = exerciseData.questions || [];
    const total = questions.length || 1;
    const feedback: FeedbackItem[] = [];

    if (questions.length > 0 && dto.answers) {
      for (let i = 0; i < questions.length; i++) {
        const q = questions[i];
        const userAnswer = dto.answers[i.toString()];
        let isCorrect = false;

        if (q.type === 'MULTIPLE_CHOICE' || q.type === 'TRUE_FALSE') {
          isCorrect = userAnswer === q.correctIndex;
        } else if (q.type === 'FILL_IN_BLANK') {
          const userStr = String(userAnswer || '')
            .trim()
            .toLowerCase();
          const correctStr = String(q.correctText || '')
            .trim()
            .toLowerCase();
          isCorrect = userStr === correctStr;
        }

        if (isCorrect) score++;

        feedback.push({
          questionIndex: i,
          isCorrect,
          correctAnswer:
            q.type === 'FILL_IN_BLANK' ? q.correctText : q.correctIndex,
          explanation: q.explanation,
        });
      }
    }

    const percentage = (score / total) * 100;
    const percentageRounded = Math.round(percentage * 100) / 100;
    const passed = percentageRounded >= 70;

    // Mark task as completed if passed
    if (passed && uid && dto.taskId) {
      await this.progressService.updateTaskProgress(uid, {
        taskId: dto.taskId,
        isCompleted: true,
      });
    }

    return {
      score,
      total,
      percentage: percentageRounded,
      passed,
      feedback,
    };
  }
}
