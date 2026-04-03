import { IsString, IsNotEmpty, IsArray } from 'class-validator';

export class UpdateStudyPlanDto {
  @IsString()
  @IsNotEmpty()
  title: string;

  @IsArray()
  months: any[]; // Placeholder for nested validation
}
