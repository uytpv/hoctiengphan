import { IsNotEmpty, IsString, IsOptional, IsObject } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class SubmitExerciseDto {
  @ApiProperty({ description: 'ID of the exercise being submitted' })
  @IsString()
  @IsNotEmpty()
  exerciseId: string;

  @ApiProperty({
    description: 'Map of question index to answer index or text',
    example: { '0': 1, '1': 'correct answer' },
    required: false,
  })
  @IsObject()
  @IsOptional()
  answers?: Record<string, number | string>;

  @ApiProperty({
    description: 'Single answer for simple exercises',
    required: false,
  })
  @IsOptional()
  answer?: string | string[] | number;

  @ApiProperty({
    description: 'ID of the task in the roadmap',
    required: false,
  })
  @IsString()
  @IsOptional()
  taskId?: string;

  @ApiProperty({ description: 'ID of the study plan', required: false })
  @IsString()
  @IsOptional()
  planId?: string;

  @ApiProperty({ description: 'Legacy activity ID', required: false })
  @IsString()
  @IsOptional()
  activityId?: string;
}
