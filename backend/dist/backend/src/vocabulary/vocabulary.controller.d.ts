import { VocabularyService } from './vocabulary.service';
import { CreateVocabularyDto } from './dto/create-vocabulary.dto';
import { UpdateVocabularyDto } from './dto/update-vocabulary.dto';
export declare class VocabularyController {
    private readonly vocabularyService;
    constructor(vocabularyService: VocabularyService);
    getVocabulary(category?: string, authorId?: string): Promise<import("@hoctiengphan/shared-types").Vocabulary[]>;
    addPersonalVocabulary(user: any, dto: CreateVocabularyDto): Promise<import("@hoctiengphan/shared-types").Vocabulary>;
    createVocabularyWord(dto: CreateVocabularyDto): Promise<import("@hoctiengphan/shared-types").Vocabulary>;
    updateVocabularyWord(wordId: string, dto: UpdateVocabularyDto): Promise<{
        finnish?: string | undefined;
        english?: string | undefined;
        vietnamese?: string | undefined;
        category?: string | undefined;
        audioUrl?: string | undefined;
        imageUrl?: string | undefined;
        id: string;
    }>;
    deleteVocabularyWord(wordId: string): Promise<{
        id: string;
        deleted: boolean;
    }>;
}
