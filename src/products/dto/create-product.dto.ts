import {
  IsString,
  IsNumber,
  IsOptional,
  Min,
  MaxLength,
  IsUrl,
} from 'class-validator';
import { Type } from 'class-transformer';

export class CreateProductDto {
  @IsString()
  @MaxLength(200)
  name: string;

  @IsString()
  @IsOptional()
  description?: string;

  @IsNumber()
  @Min(0.01)
  @Type(() => Number)
  price: number;

  @IsNumber()
  @Type(() => Number)
  categoryId: number;

  @IsNumber()
  @IsOptional()
  @Min(0)
  @Type(() => Number)
  stock?: number;

  @IsString()
  @IsOptional()
  imageUrl?: string;
}
