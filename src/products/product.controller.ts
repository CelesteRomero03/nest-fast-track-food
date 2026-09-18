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
  UseGuards,
} from '@nestjs/common';
import { ProductService } from './product.service';
import { CreateProductDto } from './dto/create-product.dto';
import { UpdateProductDto } from './dto/update-product.dto';
import { JwtAuthGuard } from 'src/auth/guards/jwt-auth.guard';
import { ApiBearerAuth } from '@nestjs/swagger';
import { FindProductsDto } from './dto/find-products.dto';



@Controller('products')
export class ProductController {
  constructor(private readonly productService: ProductService) { }


  // @Post()
  // @UseGuards(JwtAuthGuard)
  // @ApiBearerAuth()
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

  @Post()
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
create(@Body(ValidationPipe) createProductDto: CreateProductDto) {
  return this.productService.create(createProductDto);
}



  @Get()//obtener productos y filtrado

  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  findAll(@Query() query: FindProductsDto) {
    return this.productService.findAll(query);
  }
  // findAll(
  //   @Query('search') search?: string,
  //   @Query('categoryId') categoryId?: string,
  //   @Query('isAvailable') isAvailable?: string,
  // ) {
  //   return this.productService.findAll(
  //     search,
  //     categoryId ? parseInt(categoryId) : undefined,
  //     isAvailable ? isAvailable === 'true' : undefined,
  //   );
  // }




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
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
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
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  updateStock(
    @Param('id', ParseIntPipe) id: number,
    @Body('quantity', ParseIntPipe) quantity: number,
  ) {
    return this.productService.updateStock(id, quantity);
  }

  @Patch(':id/toggle-availability')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  toggleAvailability(@Param('id', ParseIntPipe) id: number) {
    return this.productService.toggleAvailability(id);
  }

  @Delete(':id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @HttpCode(HttpStatus.NO_CONTENT)
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.productService.delete(id);
  }
}
