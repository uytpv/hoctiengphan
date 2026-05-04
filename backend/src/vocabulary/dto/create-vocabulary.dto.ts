import { IsString, IsOptional, IsNotEmpty } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateVocabularyDto {
  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  finnish: string;

  @ApiProperty({ required: false })
  @IsString()
  @IsOptional()
  english?: string;

  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  vietnamese: string;

  @ApiProperty({ required: false })
  @IsString()
  @IsOptional()
  category?: string;

  @ApiProperty({ required: false })
  @IsString()
  @IsOptional()
  audioUrl?: string;

  @ApiProperty({ required: false })
  @IsString()
  @IsOptional()
  imageUrl?: string;
}
