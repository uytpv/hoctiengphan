import { Controller, Get, Post, Put, Delete, Body, Param, Query, UseGuards } from '@nestjs/common';
import { VocabularyService } from './vocabulary.service';
import { CreateVocabularyDto } from './dto/create-vocabulary.dto';
import { UpdateVocabularyDto } from './dto/update-vocabulary.dto';
import { AuthGuard } from '../auth/guards/auth.guard';
import { AdminGuard } from '../auth/guards/admin.guard';
import { CurrentUser } from '../auth/decorators/user.decorator';

@Controller()
export class VocabularyController {
  constructor(private readonly vocabularyService: VocabularyService) {}

  @Get('vocabulary')
  @UseGuards(AuthGuard)
  getVocabulary(
    @Query('category') category?: string,
    @Query('authorId') authorId?: string,
  ) {
    return this.vocabularyService.findAll(category, authorId);
  }

  @Post('vocabulary/personal')
  @UseGuards(AuthGuard)
  addPersonalVocabulary(@CurrentUser() user: any, @Body() dto: CreateVocabularyDto) {
    return this.vocabularyService.addPersonal(user.uid, dto);
  }

  @Post('admin/vocabulary')
  @UseGuards(AdminGuard)
  createVocabularyWord(@Body() dto: CreateVocabularyDto) {
    return this.vocabularyService.createGlobal(dto);
  }

  @Put('admin/vocabulary/:wordId')
  @UseGuards(AdminGuard)
  updateVocabularyWord(@Param('wordId') wordId: string, @Body() dto: UpdateVocabularyDto) {
    return this.vocabularyService.update(wordId, dto);
  }

  @Delete('admin/vocabulary/:wordId')
  @UseGuards(AdminGuard)
  deleteVocabularyWord(@Param('wordId') wordId: string) {
    return this.vocabularyService.remove(wordId);
  }
}
