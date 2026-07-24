import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  HttpCode,
  HttpStatus,
  ParseIntPipe,
  ValidationPipe,
} from '@nestjs/common';
import { CategoryService } from './category.service';
import { CreateCategoryDto } from './dto/create-category.dto';
import { UpdateCategoryDto } from './dto/update-category.dto';

@Controller('categories')
export class CategoryController {
  constructor(private readonly categoryService: CategoryService) {}

  @Post()
  create(@Body(ValidationPipe) createCategoryDto: CreateCategoryDto) {
    return this.categoryService.create(
      createCategoryDto.name,
      createCategoryDto.description,
    );
  }

  @Get()
  findAll() {
    return this.categoryService.findAll();
  }

  @Get('active')
  findActive() {
    return this.categoryService.findActive();
  }

  @Get(':id')
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.categoryService.findOne(id);
  }

  @Patch(':id')
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body(ValidationPipe) updateCategoryDto: UpdateCategoryDto,
  ) {
    return this.categoryService.update(
      id,
      updateCategoryDto.name,
      updateCategoryDto.description,
    );
  }

  @Patch(':id/deactivate')
  @HttpCode(HttpStatus.NO_CONTENT)
  deactivate(@Param('id', ParseIntPipe) id: number) {
    return this.categoryService.deactivate(id);
  }

  @Patch(':id/activate')
  @HttpCode(HttpStatus.NO_CONTENT)
  activate(@Param('id', ParseIntPipe) id: number) {
    return this.categoryService.activate(id);
  }

  @Delete(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.categoryService.delete(id);
  }
}
