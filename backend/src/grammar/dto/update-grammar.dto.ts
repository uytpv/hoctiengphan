import { PartialType, OmitType } from '@nestjs/mapped-types';
import { CreateGrammarDto } from './create-grammar.dto';

export class UpdateGrammarDto extends PartialType(OmitType(CreateGrammarDto, ['id'] as const)) {}
