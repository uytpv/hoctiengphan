import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Body,
  Param,
  UseGuards,
} from '@nestjs/common';
import { GrammarService } from './grammar.service';
import { CreateGrammarDto } from './dto/create-grammar.dto';
import { UpdateGrammarDto } from './dto/update-grammar.dto';
import { AuthGuard } from '../auth/guards/auth.guard';
import { AdminGuard } from '../auth/guards/admin.guard';
import {
  ApiTags,
  ApiOperation,
  ApiResponse,
  ApiBearerAuth,
} from '@nestjs/swagger';

@ApiTags('Grammar')
@ApiBearerAuth()
@Controller()
export class GrammarController {
  constructor(private readonly grammarService: GrammarService) {}

  @Get('grammar/topics')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Get all grammar topics' })
  @ApiResponse({ status: 200, description: 'List of grammar topics' })
  getGrammarTopics() {
    return this.grammarService.findAllTopics();
  }

  @Get('grammar/:grammarId')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Get grammar topic detail' })
  @ApiResponse({ status: 200, description: 'Grammar topic detail' })
  getGrammarDetail(@Param('grammarId') grammarId: string) {
    return this.grammarService.findOne(grammarId);
  }

  @Post('admin/grammar')
  @UseGuards(AdminGuard)
  @ApiOperation({ summary: 'Create a new grammar topic' })
  @ApiResponse({ status: 201, description: 'Topic created' })
  createGrammarTopic(@Body() dto: CreateGrammarDto) {
    return this.grammarService.create(dto);
  }

  @Put('admin/grammar/:grammarId')
  @UseGuards(AdminGuard)
  @ApiOperation({ summary: 'Update a grammar topic' })
  @ApiResponse({ status: 200, description: 'Topic updated' })
  updateGrammarTopic(
    @Param('grammarId') grammarId: string,
    @Body() dto: UpdateGrammarDto,
  ) {
    return this.grammarService.update(grammarId, dto);
  }

  @Delete('admin/grammar/:grammarId')
  @UseGuards(AdminGuard)
  @ApiOperation({ summary: 'Delete a grammar topic' })
  @ApiResponse({ status: 200, description: 'Topic deleted' })
  deleteGrammarTopic(@Param('grammarId') grammarId: string) {
    return this.grammarService.remove(grammarId);
  }
}
