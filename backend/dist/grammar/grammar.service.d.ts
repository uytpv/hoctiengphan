import { FirebaseService } from '../firebase/firebase.service';
import { CreateGrammarDto } from './dto/create-grammar.dto';
import { UpdateGrammarDto } from './dto/update-grammar.dto';
import { GrammarTopic } from '@hoctiengphan/shared-types';
export declare class GrammarService {
    private readonly firebaseService;
    constructor(firebaseService: FirebaseService);
    private get collection();
    findAllTopics(): Promise<Partial<GrammarTopic>[]>;
    findOne(id: string): Promise<GrammarTopic>;
    create(dto: CreateGrammarDto): Promise<GrammarTopic>;
    update(id: string, dto: UpdateGrammarDto): Promise<{
        chapter?: string | undefined;
        desc?: string | undefined;
        content?: any;
        title?: string | undefined;
        id: string;
    }>;
    remove(id: string): Promise<{
        id: string;
        deleted: boolean;
    }>;
}
