import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  UpdateDateColumn,
  ManyToOne,
  JoinColumn,
} from 'typeorm';
import { Category } from '../categories/category.entity';

@Entity('products')
export class Product {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ length: 200 })
  name: string;

  @Column({ type: 'text', nullable: true })
  description: string | null;

  @Column({ type: 'decimal', precision: 10, scale: 2 })
  price: number;

  @Column({ nullable: true })
  imageUrl: string;

  @Column({ default: true })
  isAvailable: boolean;

  @Column({ default: 0 })
  stock: number;

  @ManyToOne(() => Category, (category) => category.products, { eager: true })
  @JoinColumn({ name: 'categoryId' })
  category: Category;

  @Column()
  categoryId: number;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  // Lógica de negocio
  update(
    name: string,
    price: number,
    description?: string,
    stock?: number,
  ): void {
    if (!name || name.trim().length === 0) {
      throw new Error('Product name is required');
    }
    if (name.length < 3) {
      throw new Error('Product name must have at least 3 characters');
    }
    if (price <= 0) {
      throw new Error('Price must be greater than 0');
    }
    if (stock !== undefined && stock < 0) {
      throw new Error('Stock cannot be negative');
    }

    this.name = name.trim();
    this.price = price;
    this.description = description?.trim() || null as string | null;
    if (stock !== undefined) {
      this.stock = stock;
    }
  }

  updateImage(imageUrl: string): void {
    this.imageUrl = imageUrl;
  }

  updateStock(quantity: number): void {
    const newStock = this.stock + quantity;
    if (newStock < 0) {
      throw new Error(`Insufficient stock. Available: ${this.stock}`);
    }
    this.stock = newStock;
  }

  toggleAvailability(): void {
    this.isAvailable = !this.isAvailable;
  }

  makeAvailable(): void {
    this.isAvailable = true;
  }

  makeUnavailable(): void {
    this.isAvailable = false;
  }

  static create(
    name: string,
    price: number,
    categoryId: number,
    description?: string,
    stock: number = 0,
    imageUrl?: string,
  ): Product {
    const product = new Product();
    product.update(name, price, description, stock);
    product.categoryId = categoryId;
    if (imageUrl) {
      product.imageUrl = imageUrl;
    }
    return product;
  }
}