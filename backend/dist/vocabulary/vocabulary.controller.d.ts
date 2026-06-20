import { VocabularyService } from './vocabulary.service';
import { CreateVocabularyDto } from './dto/create-vocabulary.dto';
import { UpdateVocabularyDto } from './dto/update-vocabulary.dto';
import * as admin from 'firebase-admin';
export declare class VocabularyController {
    private readonly vocabularyService;
    constructor(vocabularyService: VocabularyService);
    getVocabulary(category?: string, authorUid?: string): Promise<import("@hoctiengphan/shared-types").Vocabulary[]>;
    addPersonalVocabulary(user: admin.auth.DecodedIdToken, dto: CreateVocabularyDto): Promise<import("@hoctiengphan/shared-types").Vocabulary>;
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
