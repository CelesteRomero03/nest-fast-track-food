import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Like, FindOptionsWhere } from 'typeorm';
import { Product } from './product.entity';
import { CategoryService } from '../categories/category.service';
import { FindProductsDto } from './dto/find-products.dto';
import { CreateProductDto } from './dto/create-product.dto';

@Injectable()
export class ProductService {
  constructor(
    @InjectRepository(Product)
    private productRepository: Repository<Product>,
    private categoryService: CategoryService,
  ) { }


  async create(createProductDto: CreateProductDto): Promise<Product> {
    await this.categoryService.findOne(createProductDto.categoryId);

    const product = Product.create(
      createProductDto.name,
      createProductDto.price,
      createProductDto.categoryId,
      createProductDto.description,
      createProductDto.stock,
      createProductDto.imageUrl,
    );

    return this.productRepository.save(product);
  }
  // async create(
  //   name: string,
  //   price: number,
  //   categoryId: number,
  //   description?: string,
  //   stock: number = 0,
  //   imageUrl?: string,
  // ): Promise<Product> {
  //   await this.categoryService.findOne(categoryId);

  //   const product = Product.create(
  //     name,
  //     price,
  //     categoryId,
  //     description,
  //     stock,
  //     imageUrl,
  //   );
  //   return await this.productRepository.save(product);
  // }
  //cambie
  async findAll(query: FindProductsDto) {
    const { search, categoryId, isAvailable, page = 1, limit = 10 } = query;
    const skip = (page - 1) * limit;

    const queryBuilder = this.productRepository.createQueryBuilder('product');
    // no hace falta leftJoinAndSelect('product.category', ...) 
    // porque tenés { eager: true } en la relación @ManyToOne,
    // TypeORM ya trae la categoría automáticamente

    if (search) {
      queryBuilder.andWhere('product.name LIKE :search', { search: `%${search}%` });
    }

    if (categoryId) {
      queryBuilder.andWhere('product.categoryId = :categoryId', { categoryId });
    }

    if (isAvailable !== undefined) {
      queryBuilder.andWhere('product.isAvailable = :isAvailable', { isAvailable });
    }

    const [data, total] = await queryBuilder
      .skip(skip)
      .take(limit)
      .getManyAndCount();

    return {
      data,
      total,
      page,
      totalPages: Math.ceil(total / limit),
    };
  }

  // async findAll(
  //   search?: string,
  //   categoryId?: number,
  //   isAvailable?: boolean,
  // ): Promise<Product[]> {
  //   const where: FindOptionsWhere<Product> = {};

  //   if (search) {
  //     where.name = Like(`%${search}%`);
  //   }

  //   if (categoryId) {
  //     where.categoryId = categoryId;
  //   }

  //   if (isAvailable !== undefined) {
  //     where.isAvailable = isAvailable;
  //   }

  //   return await this.productRepository.find({
  //     where,
  //     relations: { category: true },
  //     order: { name: 'ASC' },
  //   });
  // }

  async findAvailable(): Promise<Product[]> {

    return await this.productRepository.find({
      where: {
        isAvailable: true,
        category: {
          isActive: true
        }
      },
      relations: {
        category: true
      },
      order: {
        category: {
          name: 'ASC'
        },
        name: 'ASC'
      },
    });
    // return await this.productRepository.find({
    //   where: { isAvailable: true },
    //   relations: { category: true },
    //   order: { category: { name: 'ASC' }, name: 'ASC' },
    // });
  }

  async findByCategory(categoryId: number): Promise<Product[]> {
    await this.categoryService.findOne(categoryId);

    return await this.productRepository.find({
      where: { categoryId },
      relations: { category: true },
      order: { name: 'ASC' },
    });
  }

  async findOne(id: number): Promise<Product> {
    const product = await this.productRepository.findOne({
      where: { id },
      relations: { category: true },
    });

    if (!product) {
      throw new NotFoundException(`Product with ID ${id} not found`);
    }

    return product;
  }

  async update(
    id: number,
    name?: string,
    price?: number,
    categoryId?: number,
    description?: string,
    stock?: number,
  ): Promise<Product> {
    const product = await this.findOne(id);

    if (categoryId && categoryId !== product.categoryId) {
      await this.categoryService.findOne(categoryId);
      product.categoryId = categoryId;
    }

    if (name !== undefined && price !== undefined) {
      product.update(name, price, description, stock);
    } else if (name !== undefined) {
      product.update(name, product.price, description, stock);
    } else if (price !== undefined) {
      product.update(product.name, price, description, stock);
    }

    return await this.productRepository.save(product);
  }

  async updateStock(id: number, quantity: number): Promise<Product> {
    const product = await this.findOne(id);
    product.updateStock(quantity);
    return await this.productRepository.save(product);
  }

  async updateImage(id: number, imageUrl: string): Promise<Product> {
    const product = await this.findOne(id);
    product.updateImage(imageUrl);
    return await this.productRepository.save(product);
  }

  async toggleAvailability(id: number): Promise<Product> {
    const product = await this.findOne(id);


    product.toggleAvailability();
    return await this.productRepository.save(product);
  }

  async delete(id: number): Promise<void> {
    const product = await this.findOne(id);
    await this.productRepository.remove(product);
  }
}
