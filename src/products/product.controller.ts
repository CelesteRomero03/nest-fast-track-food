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
  Query,
  ValidationPipe,
} from '@nestjs/common';
import { ProductService } from './product.service';
import { CreateProductDto } from './dto/create-product.dto';
import { UpdateProductDto } from './dto/update-product.dto';



@Controller('products')
export class ProductController {
  constructor(private readonly productService: ProductService) { }

  
  @Post()
  create(@Body(ValidationPipe) createProductDto: CreateProductDto) {
    return this.productService.create(
      createProductDto.name,
      createProductDto.price,
      createProductDto.categoryId,
      createProductDto.description,
      createProductDto.stock,
      createProductDto.imageUrl,
    );
  }

  // @UseGuards(JwtAuthGuard)
  // @Post()
  // create(@Body() createProductDto: CreateProductDto, @GetUser() user) {
  //   console.log('Usuario autenticado:', user);
  //   return this.productService.create(...);
  // }

  // @Post()
  // create(@Body(ValidationPipe) createProductDto: CreateProductDto) {
  //   return this.productService.create(
  //     createProductDto.name,
  //     createProductDto.price,
  //     createProductDto.categoryId,
  //     createProductDto.description,
  //     createProductDto.stock,
  //     createProductDto.imageUrl,
  //   );
  // }

  @Get()//obtener productos y filtrado
  findAll(
    @Query('search') search?: string,
    @Query('categoryId') categoryId?: string,
    @Query('isAvailable') isAvailable?: string,
  ) {
    return this.productService.findAll(
      search,
      categoryId ? parseInt(categoryId) : undefined,
      isAvailable ? isAvailable === 'true' : undefined,
    );
  }

  @Get('available')
  findAvailable() {
    return this.productService.findAvailable();
  }

  @Get('category/:categoryId')
  findByCategory(@Param('categoryId', ParseIntPipe) categoryId: number) {
    return this.productService.findByCategory(categoryId);
  }

  @Get(':id')
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.productService.findOne(id);
  }

  @Patch(':id')
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body(ValidationPipe) updateProductDto: UpdateProductDto,
  ) {
    return this.productService.update(
      id,
      updateProductDto.name,
      updateProductDto.price,
      updateProductDto.categoryId,
      updateProductDto.description,
      updateProductDto.stock,
    );
  }

  @Patch(':id/stock')
  updateStock(
    @Param('id', ParseIntPipe) id: number,
    @Body('quantity', ParseIntPipe) quantity: number,
  ) {
    return this.productService.updateStock(id, quantity);
  }

  @Patch(':id/toggle-availability')
  toggleAvailability(@Param('id', ParseIntPipe) id: number) {
    return this.productService.toggleAvailability(id);
  }

  @Delete(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.productService.delete(id);
  }
}
