import { Controller, Get, Put, Body, UseGuards } from '@nestjs/common';
import { StudyPlanService } from './study-plan.service';
import { UpdateStudyPlanDto } from './dto/update-study-plan.dto';
import { AuthGuard } from '../auth/guards/auth.guard';
import { AdminGuard } from '../auth/guards/admin.guard';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';

@ApiTags('Study Plan')
@ApiBearerAuth()
@Controller()
export class StudyPlanController {
  constructor(private readonly studyPlanService: StudyPlanService) {}

  @Get('studyPlan')
  @UseGuards(AuthGuard)
  @ApiOperation({ summary: 'Get study plan' })
  @ApiResponse({ status: 200, description: 'Study plan details' })
  getStudyPlan() {
    return this.studyPlanService.getStudyPlan();
  }

  @Put('admin/studyPlan')
  @UseGuards(AdminGuard)
  @ApiOperation({ summary: 'Update study plan' })
  @ApiResponse({ status: 200, description: 'Study plan updated' })
  updateStudyPlan(@Body() dto: UpdateStudyPlanDto) {
    return this.studyPlanService.updateStudyPlan('suomen_mestari_1', dto);
  }
}
