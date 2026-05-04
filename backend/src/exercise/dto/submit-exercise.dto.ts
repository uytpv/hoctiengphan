import { IsNotEmpty, IsString, IsOptional, IsObject } from 'class-validator';

export class SubmitExerciseDto {
  @IsString()
  @IsNotEmpty()
  exerciseId: string;

  @IsObject()
  @IsOptional()
  answers?: Record<string, number | string>; // questionIndex -> answerIndex or text

  @IsOptional()
  answer?: string | string[] | number; // For single question exercises

  @IsString()
  @IsOptional()
  taskId?: string;

  @IsString()
  @IsOptional()
  planId?: string;

  @IsString()
  @IsOptional()
  activityId?: string;
}
