import { Controller, Get, Post, Body, UseGuards } from '@nestjs/common';
import { ProgressService } from './progress.service';
import { UpdateTaskDto } from './dto/update-task.dto';
import { AuthGuard } from '../auth/guards/auth.guard';
import { CurrentUser } from '../auth/decorators/user.decorator';

@UseGuards(AuthGuard)
@Controller('user/progress')
export class ProgressController {
  constructor(private readonly progressService: ProgressService) {}

  @Get()
  getUserProgress(@CurrentUser() user: any) {
    return this.progressService.getUserProgress(user.uid);
  }

  @Post('task')
  updateTaskProgress(@CurrentUser() user: any, @Body() dto: UpdateTaskDto) {
    return this.progressService.updateTaskProgress(user.uid, dto);
  }
}
