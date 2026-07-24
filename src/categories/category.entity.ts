import {
    Entity,
    Column,
    PrimaryGeneratedColumn,
    CreateDateColumn,
    UpdateDateColumn,
    OneToMany,
} from 'typeorm';
import { Product } from '../products/product.entity';

@Entity('categories')
export class Category {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({ unique: true, length: 100 })
    name: string;

    @Column({ type: 'text', nullable: true })
    description: string | null;

    @Column({ default: true })
    isActive: boolean;

    @CreateDateColumn()
    createdAt: Date;

    @UpdateDateColumn()
    updatedAt: Date;

    @OneToMany(() => Product, (product) => product.category)
    products: Product[];

    // Lógica de negocio
    activate(): void {
        this.isActive = true;
    }

    deactivate(): void {
        this.isActive = false;
    }

    update(name: string, description?: string): void {
        if (!name || name.trim().length === 0) {
            throw new Error('Category name is required');
        }
        if (name.length < 3) {
            throw new Error('Category name must have at least 3 characters');
        }

        this.name = name.trim();
        if (description !== undefined) {
            this.description = description.trim() || (null as string | null);
        }
    }

    static create(name: string, description?: string): Category {
        const category = new Category();
        category.update(name, description);
        return category;
    }
}
