import { Module } from '@nestjs/common';
import { VocabularyController } from './VocabularyController';
import { VocabularyService } from './VocabularyService';

@Module({
  controllers: [VocabularyController],
  providers: [VocabularyService]
})
export class VocabularyModule {}
