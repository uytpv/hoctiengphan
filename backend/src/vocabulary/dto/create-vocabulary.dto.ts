import { IsString, IsOptional, IsNotEmpty } from 'class-validator';

export class CreateVocabularyDto {
  @IsString()
  @IsNotEmpty()
  finnish: string;

  @IsString()
  @IsOptional()
  english?: string;

  @IsString()
  @IsNotEmpty()
  vietnamese: string;

  @IsString()
  @IsOptional()
  category?: string;
}
