import { Injectable, NotFoundException } from '@nestjs/common';
import { FirebaseService } from '../firebase/firebase.service';
import { CreateGrammarDto } from './dto/create-grammar.dto';
import { UpdateGrammarDto } from './dto/update-grammar.dto';
import { GrammarTopic } from '@hoctiengphan/shared-types';

@Injectable()
export class GrammarService {
  constructor(private readonly firebaseService: FirebaseService) {}

  private get collection() {
    return this.firebaseService.getFirestore().collection('grammar');
  }

  async findAllTopics(): Promise<Partial<GrammarTopic>[]> {
    // Only fetch specific fields
    const snapshot = await this.collection
      .select('chapter', 'title', 'desc')
      .get();
    return snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    })) as Partial<GrammarTopic>[];
  }

  async findOne(id: string): Promise<GrammarTopic> {
    const doc = await this.collection.doc(id).get();
    if (!doc.exists) throw new NotFoundException('Grammar topic not found');
    return { id: doc.id, ...doc.data() } as GrammarTopic;
  }

  async create(dto: CreateGrammarDto): Promise<GrammarTopic> {
    const { id, ...data } = dto;
    await this.collection.doc(id).set({
      ...data,
      createdAt: new Date(),
    });
    return { id, ...data } as unknown as GrammarTopic;
  }

  async update(id: string, dto: UpdateGrammarDto) {
    await this.collection.doc(id).update({
      ...dto,
    });
    return { id, ...dto };
  }

  async remove(id: string) {
    await this.collection.doc(id).delete();
    return { id, deleted: true };
  }
}
