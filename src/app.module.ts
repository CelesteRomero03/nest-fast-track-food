import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CategoriesModule } from './categories/category.module';
import { ProductsModule } from './products/product.module';
import { UsersModule } from './users/user.module';
import { AuthModule } from './auth/auth.module';
import { OrdersModule } from './orders/order.module';
import { DeliveryModeModule } from './delivery-mode/delivery-mode.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: '.env',
    }),
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => ({
        type: 'mysql',
        host: configService.get('DB_HOST'),
        port: parseInt(configService.get('DB_PORT') || '3306'),
        username: configService.get('DB_USER'),
        password: configService.get('DB_PASSWORD'),
        database: configService.get('DB_NAME'),
        entities: [__dirname + '/**/*.entity{.ts,.js}'],
        synchronize: false,
        logging: false,
      }),
      inject: [ConfigService],
    }),
    CategoriesModule,
    ProductsModule,
    UsersModule,
    AuthModule,
    OrdersModule,
    DeliveryModeModule,
  ],
})
export class AppModule {}