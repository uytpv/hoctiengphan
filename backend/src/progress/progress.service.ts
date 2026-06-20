import { Injectable } from '@nestjs/common';
import { FirebaseService } from '../firebase/firebase.service';
import { UpdateTaskDto } from './dto/update-task.dto';
import { RoadmapProgress } from '@hoctiengphan/shared-types';

@Injectable()
export class ProgressService {
  constructor(private readonly firebaseService: FirebaseService) {}

  private get collection() {
    return this.firebaseService.getFirestore().collection('userProgress');
  }

  async getUserProgress(uid: string): Promise<RoadmapProgress> {
    const docRef = this.collection.doc(uid);
    const doc = await docRef.get();

    const completedTasksSnapshot = await docRef
      .collection('completedTasks')
      .get();

    const completedTasks: Record<string, boolean> = {};
    completedTasksSnapshot.docs.forEach((d) => {
      completedTasks[d.id] = true;
    });

    if (!doc.exists) {
      return {
        completedTasks,
        updatedAt: new Date() as any,
      };
    }

    const data = doc.data() as any;
    return {
      completedTasks,
      updatedAt: data.updatedAt || new Date(),
    } as RoadmapProgress;
  }

  async updateTaskProgress(uid: string, dto: UpdateTaskDto) {
    const userProgressRef = this.collection.doc(uid);
    const taskRef = userProgressRef.collection('completedTasks').doc(dto.taskId);

    const now = new Date();

    if (dto.isCompleted) {
      await taskRef.set({
        completedAt: now,
        isCompleted: true,
      });
    } else {
      await taskRef.delete();
    }

    // Cập nhật timestamp cho document cha
    await userProgressRef.set(
      {
        updatedAt: now,
      },
      { merge: true },
    );

    return { taskId: dto.taskId, isCompleted: dto.isCompleted };
  }
}
