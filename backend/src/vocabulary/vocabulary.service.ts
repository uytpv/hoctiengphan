import { Injectable } from '@nestjs/common';
import { FirebaseService } from '../firebase/firebase.service';
import { CreateVocabularyDto } from './dto/create-vocabulary.dto';
import { UpdateVocabularyDto } from './dto/update-vocabulary.dto';
import { Vocabulary } from '@hoctiengphan/shared-types';

@Injectable()
export class VocabularyService {
  constructor(private readonly firebaseService: FirebaseService) {}

  private get collection() {
    return this.firebaseService.getFirestore().collection('vocabulary');
  }

  async findAll(category?: string, authorId?: string): Promise<Vocabulary[]> {
    let query: FirebaseFirestore.Query<FirebaseFirestore.DocumentData> = this.collection;
    
    if (category) {
      query = query.where('category', '==', category);
    }
    if (authorId) {
       query = query.where('authorId', '==', authorId);
    }

    const snapshot = await query.get();
    return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() } as Vocabulary));
  }

  async addPersonal(uid: string, dto: CreateVocabularyDto): Promise<Vocabulary> {
    const docRef = await this.collection.add({
      ...dto,
      authorId: uid,
      createdAt: new Date(),
      updatedAt: new Date(),
    });
    return { id: docRef.id, ...dto, authorId: uid } as any;
  }

  async createGlobal(dto: CreateVocabularyDto): Promise<Vocabulary> {
    const docRef = await this.collection.add({
      ...dto,
      authorId: null,
      createdAt: new Date(),
      updatedAt: new Date(),
    });
    return { id: docRef.id, ...dto, authorId: null } as any;
  }

  async update(id: string, dto: UpdateVocabularyDto) {
    const docRef = this.collection.doc(id);
    await docRef.update({ ...dto, updatedAt: new Date() });
    return { id, ...dto };
  }

  async remove(id: string) {
    await this.collection.doc(id).delete();
    return { id, deleted: true };
  }
}
