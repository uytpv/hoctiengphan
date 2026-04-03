import { IsString, IsNotEmpty, IsOptional } from 'class-validator';

export class CreateGrammarDto {
  @IsString()
  @IsNotEmpty()
  id: string;

  @IsString()
  @IsNotEmpty()
  chapter: string;

  @IsString()
  @IsNotEmpty()
  title: string;

  @IsString()
  @IsOptional()
  desc?: string;

  @IsNotEmpty()
  content: any; // Flexible JSON/HTML Object
}
