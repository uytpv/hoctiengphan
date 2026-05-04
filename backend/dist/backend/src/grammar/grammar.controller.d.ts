import { GrammarService } from './grammar.service';
import { CreateGrammarDto } from './dto/create-grammar.dto';
import { UpdateGrammarDto } from './dto/update-grammar.dto';
export declare class GrammarController {
    private readonly grammarService;
    constructor(grammarService: GrammarService);
    getGrammarTopics(): Promise<GrammarTopic[]>;
    getGrammarDetail(grammarId: string): Promise<GrammarTopic>;
    createGrammarTopic(dto: CreateGrammarDto): Promise<GrammarTopic>;
    updateGrammarTopic(grammarId: string, dto: UpdateGrammarDto): Promise<{
        title?: string | undefined;
        desc?: string | undefined;
        content?: any;
        chapter?: string | undefined;
        id: string;
    }>;
    deleteGrammarTopic(grammarId: string): Promise<{
        id: string;
        deleted: boolean;
    }>;
}
