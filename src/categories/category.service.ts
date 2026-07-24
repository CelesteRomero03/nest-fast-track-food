import {
  Injectable,
  NotFoundException,
  ConflictException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Category } from './category.entity';

@Injectable()
export class CategoryService {
  constructor(
    @InjectRepository(Category)
    private categoryRepository: Repository<Category>,
  ) {}

  async create(name: string, description?: string): Promise<Category> {
    const existingCategory = await this.categoryRepository.findOne({
      where: { name: name.trim() },
    });

    if (existingCategory) {
      throw new ConflictException(
        `Category with name "${name}" already exists`,
      );
    }

    const category = Category.create(name, description);
    return await this.categoryRepository.save(category);
  }

  async findAll(): Promise<Category[]> {
    return await this.categoryRepository.find({
      order: { name: 'ASC' },
    });
  }

  async findActive(): Promise<Category[]> {
    return await this.categoryRepository.find({
      where: { isActive: true },
      order: { name: 'ASC' },
    });
  }

  async findOne(id: number): Promise<Category> {
    const category = await this.categoryRepository.findOne({
      where: { id },
      relations: { products: true },
    });

    if (!category) {
      throw new NotFoundException(`Category with ID ${id} not found`);
    }

    return category;
  }

  async update(
    id: number,
    name: string,
    description?: string,
  ): Promise<Category> {
    const category = await this.findOne(id);

    if (name && name !== category.name) {
      const existingCategory = await this.categoryRepository.findOne({
        where: { name: name.trim() },
      });

      if (existingCategory && existingCategory.id !== id) {
        throw new ConflictException(
          `Category with name "${name}" already exists`,
        );
      }
    }

    category.update(name, description);
    return await this.categoryRepository.save(category);
  }

  async deactivate(id: number): Promise<void> {
    const category = await this.findOne(id);
    category.deactivate();
    await this.categoryRepository.save(category);
  }

  async activate(id: number): Promise<void> {
    const category = await this.findOne(id);
    category.activate();
    await this.categoryRepository.save(category);
  }

  async delete(id: number): Promise<void> {
    const category = await this.findOne(id);

    if (category.products && category.products.length > 0) {
      throw new ConflictException(
        `Cannot delete category "${category.name}" because it has ${category.products.length} associated products`,
      );
    }

    await this.categoryRepository.remove(category);
  }
}
