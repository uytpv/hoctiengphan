import { FirebaseService } from '../firebase/firebase.service';
import { CreateVocabularyDto } from './dto/create-vocabulary.dto';
import { UpdateVocabularyDto } from './dto/update-vocabulary.dto';
export declare class VocabularyService {
    private readonly firebaseService;
    constructor(firebaseService: FirebaseService);
    private get collection();
    findAll(category?: string, authorId?: string): Promise<{
        id: string;
    }[]>;
    addPersonal(uid: string, dto: CreateVocabularyDto): Promise<{
        authorId: string;
        finnish: string;
        english?: string;
        vietnamese: string;
        category?: string;
        id: string;
    }>;
    createGlobal(dto: CreateVocabularyDto): Promise<{
        authorId: null;
        finnish: string;
        english?: string;
        vietnamese: string;
        category?: string;
        id: string;
    }>;
    update(id: string, dto: UpdateVocabularyDto): Promise<{
        finnish?: string | undefined;
        english?: string | undefined;
        vietnamese?: string | undefined;
        category?: string | undefined;
        id: string;
    }>;
    remove(id: string): Promise<{
        id: string;
        deleted: boolean;
    }>;
}
