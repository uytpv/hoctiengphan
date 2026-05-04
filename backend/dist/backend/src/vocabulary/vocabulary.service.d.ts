import { FirebaseService } from '../firebase/firebase.service';
import { CreateVocabularyDto } from './dto/create-vocabulary.dto';
import { UpdateVocabularyDto } from './dto/update-vocabulary.dto';
import { Vocabulary } from '@hoctiengphan/shared-types';
export declare class VocabularyService {
    private readonly firebaseService;
    constructor(firebaseService: FirebaseService);
    private get collection();
    findAll(category?: string, authorId?: string): Promise<Vocabulary[]>;
    addPersonal(uid: string, dto: CreateVocabularyDto): Promise<Vocabulary>;
    createGlobal(dto: CreateVocabularyDto): Promise<Vocabulary>;
    update(id: string, dto: UpdateVocabularyDto): Promise<{
        finnish?: string | undefined;
        english?: string | undefined;
        vietnamese?: string | undefined;
        category?: string | undefined;
        audioUrl?: string | undefined;
        imageUrl?: string | undefined;
        id: string;
    }>;
    remove(id: string): Promise<{
        id: string;
        deleted: boolean;
    }>;
}
