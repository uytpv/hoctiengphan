import { Controller, Get, Post, Body, Param, UseGuards } from '@nestjs/common';
import { ExerciseService } from './exercise.service';
import { SubmitExerciseDto } from './dto/submit-exercise.dto';
import { AuthGuard } from '../auth/guards/auth.guard';
import { CurrentUser } from '../auth/decorators/user.decorator';
import * as admin from 'firebase-admin';
import {
  ApiTags,
  ApiOperation,
  ApiResponse,
  ApiBearerAuth,
} from '@nestjs/swagger';

@ApiTags('Exercise')
@ApiBearerAuth()
@Controller('exercises')
export class ExerciseController {
  constructor(private readonly exerciseService: ExerciseService) {}

  @Get('lesson/:lessonId')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Get all exercises for a lesson' })
  @ApiResponse({
    status: 200,
    description: 'List of exercises (without answers)',
  })
  getExercisesByLesson(@Param('lessonId') lessonId: string) {
    return this.exerciseService.getExercisesByLesson(lessonId);
  }

  @Get(':id')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Get exercise by ID' })
  @ApiResponse({
    status: 200,
    description: 'The exercise data (without answers)',
  })
  getExerciseById(@Param('id') id: string) {
    return this.exerciseService.getOne(id);
  }

  @Post('submit')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Submit an exercise answer' })
  @ApiResponse({ status: 200, description: 'Result of the submission' })
  submitAnswer(
    @CurrentUser() user: admin.auth.DecodedIdToken,
    @Body() dto: SubmitExerciseDto,
  ) {
    return this.exerciseService.submitAnswer(user.uid, dto);
  }
}
