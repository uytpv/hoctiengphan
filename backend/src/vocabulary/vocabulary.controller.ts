import { Controller, Get, Post, Put, Delete, Body, Param, Query, UseGuards } from '@nestjs/common';
import { VocabularyService } from './vocabulary.service';
import { CreateVocabularyDto } from './dto/create-vocabulary.dto';
import { UpdateVocabularyDto } from './dto/update-vocabulary.dto';
import { AuthGuard } from '../auth/guards/auth.guard';
import { AdminGuard } from '../auth/guards/admin.guard';
import { CurrentUser } from '../auth/decorators/user.decorator';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';

@ApiTags('Vocabulary')
@ApiBearerAuth()
@Controller()
export class VocabularyController {
  constructor(private readonly vocabularyService: VocabularyService) {}

  @Get('vocabulary')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Get vocabulary list' })
  @ApiResponse({ status: 200, description: 'List of vocabulary words' })
  getVocabulary(
    @Query('category') category?: string,
    @Query('authorId') authorId?: string,
  ) {
    return this.vocabularyService.findAll(category, authorId);
  }

  @Post('vocabulary/personal')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Add personal vocabulary word' })
  @ApiResponse({ status: 201, description: 'Personal word added' })
  addPersonalVocabulary(@CurrentUser() user: any, @Body() dto: CreateVocabularyDto) {
    return this.vocabularyService.addPersonal(user.uid, dto);
  }

  @Post('admin/vocabulary')
  @UseGuards(AdminGuard)
  @ApiOperation({ summary: 'Create a global vocabulary word' })
  @ApiResponse({ status: 201, description: 'Global word created' })
  createVocabularyWord(@Body() dto: CreateVocabularyDto) {
    return this.vocabularyService.createGlobal(dto);
  }

  @Put('admin/vocabulary/:wordId')
  @UseGuards(AdminGuard)
  @ApiOperation({ summary: 'Update a vocabulary word' })
  @ApiResponse({ status: 200, description: 'Word updated' })
  updateVocabularyWord(@Param('wordId') wordId: string, @Body() dto: UpdateVocabularyDto) {
    return this.vocabularyService.update(wordId, dto);
  }

  @Delete('admin/vocabulary/:wordId')
  @UseGuards(AdminGuard)
  @ApiOperation({ summary: 'Delete a vocabulary word' })
  @ApiResponse({ status: 200, description: 'Word deleted' })
  deleteVocabularyWord(@Param('wordId') wordId: string) {
    return this.vocabularyService.remove(wordId);
  }
}
