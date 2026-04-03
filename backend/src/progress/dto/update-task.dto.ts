import { IsString, IsBoolean, IsNotEmpty } from 'class-validator';

export class UpdateTaskDto {
  @IsString()
  @IsNotEmpty()
  taskId: string;

  @IsBoolean()
  @IsNotEmpty()
  isCompleted: boolean;
}
