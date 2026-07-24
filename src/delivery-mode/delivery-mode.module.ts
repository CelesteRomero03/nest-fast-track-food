import { Module } from '@nestjs/common';
import { DeliveryModeController } from './delivery-mode.controller';
import { DeliveryModeService } from './delivery-mode.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DeliveryModeConfig } from './delivery-mode.entity';

@Module({

  imports:[TypeOrmModule.forFeature([
    DeliveryModeConfig
  ])
],
  controllers: [DeliveryModeController],
  providers: [DeliveryModeService]
})
export class DeliveryModeModule {}
