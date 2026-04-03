import { GrammarService } from './grammar.service';
import { CreateGrammarDto } from './dto/create-grammar.dto';
import { UpdateGrammarDto } from './dto/update-grammar.dto';
export declare class GrammarController {
    private readonly grammarService;
    constructor(grammarService: GrammarService);
    getGrammarTopics(): Promise<{
        id: string;
    }[]>;
    getGrammarDetail(grammarId: string): Promise<{
        id: string;
    }>;
    createGrammarTopic(dto: CreateGrammarDto): Promise<{
        chapter: string;
        title: string;
        desc?: string;
        content: any;
        id: string;
    }>;
    updateGrammarTopic(grammarId: string, dto: UpdateGrammarDto): Promise<{
        desc?: string | undefined;
        chapter?: string | undefined;
        title?: string | undefined;
        content?: any;
        id: string;
    }>;
    deleteGrammarTopic(grammarId: string): Promise<{
        id: string;
        deleted: boolean;
    }>;
}
