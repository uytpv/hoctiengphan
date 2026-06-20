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

  private mapDocToVocabulary(
    doc: FirebaseFirestore.DocumentSnapshot,
  ): Vocabulary {
    const data = doc.data() as Partial<Vocabulary>;
    return {
      id: doc.id,
      ...data,
    } as Vocabulary;
  }

  async findAll(category?: string, authorUid?: string): Promise<Vocabulary[]> {
    let query: FirebaseFirestore.Query<FirebaseFirestore.DocumentData> =
      this.collection;

    if (category) {
      query = query.where('category', '==', category);
    }
    if (authorUid) {
      query = query.where('authorUid', '==', authorUid);
    }

    const snapshot = await query.get();
    return snapshot.docs.map((doc) => this.mapDocToVocabulary(doc));
  }

  async addPersonal(
    uid: string,
    dto: CreateVocabularyDto,
  ): Promise<Vocabulary> {
    const now = new Date();
    const data = {
      ...dto,
      authorUid: uid,
      createdAt: now,
    };
    const docRef = await this.collection.add(data);
    return {
      id: docRef.id,
      ...dto,
      authorUid: uid,
      createdAt: {
        seconds: Math.floor(now.getTime() / 1000),
        nanoseconds: (now.getTime() % 1000) * 1000000,
      },
    } as Vocabulary;
  }

  async createGlobal(dto: CreateVocabularyDto): Promise<Vocabulary> {
    const now = new Date();
    const data = {
      ...dto,
      authorUid: null,
      createdAt: now,
    };
    const docRef = await this.collection.add(data);
    return {
      id: docRef.id,
      ...dto,
      authorUid: null,
      createdAt: {
        seconds: Math.floor(now.getTime() / 1000),
        nanoseconds: (now.getTime() % 1000) * 1000000,
      },
    } as Vocabulary;
  }

  async update(id: string, dto: UpdateVocabularyDto) {
    const docRef = this.collection.doc(id);
    await docRef.update({ ...dto });
    return { id, ...dto };
  }

  async remove(id: string) {
    await this.collection.doc(id).delete();
    return { id, deleted: true };
  }
}
