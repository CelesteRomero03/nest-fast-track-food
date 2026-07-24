import { Injectable, NotFoundException, OnModuleInit } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DeliveryModeConfig } from './delivery-mode.entity';
import { Repository } from 'typeorm';
import { DeliveryMode } from 'src/orders/enums/order-status.enum';


@Injectable()
export class DeliveryModeService implements OnModuleInit {


    constructor(
        @InjectRepository(DeliveryModeConfig)
        private deliveryRepository: Repository<DeliveryModeConfig>
    ) {}



    async onModuleInit() {

        const count = await this.deliveryRepository.count();


        if(count === 0) {

            await this.deliveryRepository.save([

                {
                    mode: DeliveryMode.DELIVERY,
                    isActive: true
                },

                {
                    mode: DeliveryMode.TAKE_AWAY,
                    isActive: true
                },

                {
                    mode: DeliveryMode.DINE_IN,
                    isActive: true
                }

            ]);


            console.log('Modos de entrega creados');

        }

    }



    findAll() {

        return this.deliveryRepository.find();

    }



    async activate(id:number) {

        const modo = await this.deliveryRepository.findOne({
            where:{id}
        });


        if(!modo){
            throw new NotFoundException(
                'Modo de entrega no encontrado'
            );
        }


        modo.isActive = true;


        return this.deliveryRepository.save(modo);

    }



    async deactivate(id:number) {

        const modo = await this.deliveryRepository.findOne({
            where:{id}
        });


        if(!modo){
            throw new NotFoundException(
                'Modo de entrega no encontrado'
            );
        }


        modo.isActive = false;


        return this.deliveryRepository.save(modo);

    }


}