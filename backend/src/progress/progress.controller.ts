import { Controller, Get, Post, Body, UseGuards } from '@nestjs/common';
import { ProgressService } from './progress.service';
import { UpdateTaskDto } from './dto/update-task.dto';
import { AuthGuard } from '../auth/guards/auth.guard';
import { CurrentUser } from '../auth/decorators/user.decorator';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';

@ApiTags('Progress')
@ApiBearerAuth()
@UseGuards(AuthGuard)
@Controller('user/progress')
export class ProgressController {
  constructor(private readonly progressService: ProgressService) {}

  @Get()
  @ApiOperation({ summary: 'Get user progress' })
  @ApiResponse({ status: 200, description: 'User progress details' })
  getUserProgress(@CurrentUser() user: any) {
    return this.progressService.getUserProgress(user.uid);
  }

  @Post('task')
  @ApiOperation({ summary: 'Update task progress' })
  @ApiResponse({ status: 200, description: 'Task progress updated' })
  updateTaskProgress(@CurrentUser() user: any, @Body() dto: UpdateTaskDto) {
    return this.progressService.updateTaskProgress(user.uid, dto);
  }
}
