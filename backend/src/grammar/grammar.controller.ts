import { Controller, Get, Post, Put, Delete, Body, Param, UseGuards } from '@nestjs/common';
import { GrammarService } from './grammar.service';
import { CreateGrammarDto } from './dto/create-grammar.dto';
import { UpdateGrammarDto } from './dto/update-grammar.dto';
import { AuthGuard } from '../auth/guards/auth.guard';
import { AdminGuard } from '../auth/guards/admin.guard';

@Controller()
export class GrammarController {
  constructor(private readonly grammarService: GrammarService) {}

  @Get('grammar/topics')
  @UseGuards(AuthGuard)
  getGrammarTopics() {
    return this.grammarService.findAllTopics();
  }

  @Get('grammar/:grammarId')
  @UseGuards(AuthGuard)
  getGrammarDetail(@Param('grammarId') grammarId: string) {
    return this.grammarService.findOne(grammarId);
  }

  @Post('admin/grammar')
  @UseGuards(AdminGuard)
  createGrammarTopic(@Body() dto: CreateGrammarDto) {
    return this.grammarService.create(dto);
  }

  @Put('admin/grammar/:grammarId')
  @UseGuards(AdminGuard)
  updateGrammarTopic(@Param('grammarId') grammarId: string, @Body() dto: UpdateGrammarDto) {
    return this.grammarService.update(grammarId, dto);
  }

  @Delete('admin/grammar/:grammarId')
  @UseGuards(AdminGuard)
  deleteGrammarTopic(@Param('grammarId') grammarId: string) {
    return this.grammarService.remove(grammarId);
  }
}
