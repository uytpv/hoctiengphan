import { GrammarService } from './grammar.service';
import { CreateGrammarDto } from './dto/create-grammar.dto';
import { UpdateGrammarDto } from './dto/update-grammar.dto';
export declare class GrammarController {
    private readonly grammarService;
    constructor(grammarService: GrammarService);
    getGrammarTopics(): Promise<Partial<import("@hoctiengphan/shared-types").GrammarTopic>[]>;
    getGrammarDetail(grammarId: string): Promise<import("@hoctiengphan/shared-types").GrammarTopic>;
    createGrammarTopic(dto: CreateGrammarDto): Promise<import("@hoctiengphan/shared-types").GrammarTopic>;
    updateGrammarTopic(grammarId: string, dto: UpdateGrammarDto): Promise<{
        chapter?: string | undefined;
        desc?: string | undefined;
        content?: any;
        title?: string | undefined;
        id: string;
    }>;
    deleteGrammarTopic(grammarId: string): Promise<{
        id: string;
        deleted: boolean;
    }>;
}
