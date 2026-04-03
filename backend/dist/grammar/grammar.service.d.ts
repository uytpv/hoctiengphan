import { FirebaseService } from '../firebase/firebase.service';
import { CreateGrammarDto } from './dto/create-grammar.dto';
import { UpdateGrammarDto } from './dto/update-grammar.dto';
export declare class GrammarService {
    private readonly firebaseService;
    constructor(firebaseService: FirebaseService);
    private get collection();
    findAllTopics(): Promise<{
        id: string;
    }[]>;
    findOne(id: string): Promise<{
        id: string;
    }>;
    create(dto: CreateGrammarDto): Promise<{
        chapter: string;
        title: string;
        desc?: string;
        content: any;
        id: string;
    }>;
    update(id: string, dto: UpdateGrammarDto): Promise<{
        desc?: string | undefined;
        chapter?: string | undefined;
        title?: string | undefined;
        content?: any;
        id: string;
    }>;
    remove(id: string): Promise<{
        id: string;
        deleted: boolean;
    }>;
}
