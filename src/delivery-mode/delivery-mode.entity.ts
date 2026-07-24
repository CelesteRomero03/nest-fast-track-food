import { DeliveryMode } from "src/orders/enums/order-status.enum";
import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";







@Entity('delivery_modes')
export class DeliveryModeConfig {




    @PrimaryGeneratedColumn()
    id!:number;



    @Column({
        type:'enum',
        enum:DeliveryMode,
        unique:true
    })
    mode!:DeliveryMode;


    @Column({
        default:true
    })
    isActive!:boolean
}