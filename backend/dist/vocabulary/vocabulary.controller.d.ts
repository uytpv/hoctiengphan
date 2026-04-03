import { VocabularyService } from './vocabulary.service';
import { CreateVocabularyDto } from './dto/create-vocabulary.dto';
import { UpdateVocabularyDto } from './dto/update-vocabulary.dto';
export declare class VocabularyController {
    private readonly vocabularyService;
    constructor(vocabularyService: VocabularyService);
    getVocabulary(category?: string, authorId?: string): Promise<{
        id: string;
    }[]>;
    addPersonalVocabulary(user: any, dto: CreateVocabularyDto): Promise<{
        authorId: string;
        finnish: string;
        english?: string;
        vietnamese: string;
        category?: string;
        id: string;
    }>;
    createVocabularyWord(dto: CreateVocabularyDto): Promise<{
        authorId: null;
        finnish: string;
        english?: string;
        vietnamese: string;
        category?: string;
        id: string;
    }>;
    updateVocabularyWord(wordId: string, dto: UpdateVocabularyDto): Promise<{
        finnish?: string | undefined;
        english?: string | undefined;
        vietnamese?: string | undefined;
        category?: string | undefined;
        id: string;
    }>;
    deleteVocabularyWord(wordId: string): Promise<{
        id: string;
        deleted: boolean;
    }>;
}
