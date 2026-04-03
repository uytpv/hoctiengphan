import { Controller, Get, Put, Body, UseGuards } from '@nestjs/common';
import { StudyPlanService } from './study-plan.service';
import { UpdateStudyPlanDto } from './dto/update-study-plan.dto';
import { AuthGuard } from '../auth/guards/auth.guard';
import { AdminGuard } from '../auth/guards/admin.guard';

@Controller()
export class StudyPlanController {
  constructor(private readonly studyPlanService: StudyPlanService) {}

  @Get('studyPlan')
  @UseGuards(AuthGuard)
  getStudyPlan() {
    return this.studyPlanService.getStudyPlan();
  }

  @Put('admin/studyPlan')
  @UseGuards(AdminGuard)
  updateStudyPlan(@Body() dto: UpdateStudyPlanDto) {
    return this.studyPlanService.updateStudyPlan('suomen_mestari_1', dto);
  }
}
