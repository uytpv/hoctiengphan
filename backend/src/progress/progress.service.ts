import { Injectable } from '@nestjs/common';
import { FirebaseService } from '../firebase/firebase.service';
import { UpdateTaskDto } from './dto/update-task.dto';

@Injectable()
export class ProgressService {
  constructor(private readonly firebaseService: FirebaseService) {}

  private get collection() {
    return this.firebaseService.getFirestore().collection('userProgress');
  }

  async getUserProgress(uid: string) {
    const snapshot = await this.collection.doc(uid).collection('completedTasks').get();
    return snapshot.docs.map(doc => doc.id); // Trả về array taskId
  }

  async updateTaskProgress(uid: string, dto: UpdateTaskDto) {
    const taskRef = this.collection.doc(uid).collection('completedTasks').doc(dto.taskId);
    
    if (dto.isCompleted) {
      await taskRef.set({
        completedAt: new Date(),
        isCompleted: true,
      });
      return { taskId: dto.taskId, isCompleted: true };
    } else {
      await taskRef.delete();
      return { taskId: dto.taskId, isCompleted: false };
    }
  }
}
