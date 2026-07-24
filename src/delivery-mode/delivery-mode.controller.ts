import { Controller, Get, Param, Patch,ParseIntPipe  } from '@nestjs/common';
import { DeliveryModeService } from './delivery-mode.service';

@Controller('delivery-mode')
export class DeliveryModeController {


constructor(
    private deliveryService:DeliveryModeService
){}

 @Get()
  findAll(){

    return this.deliveryService.findAll();

  }



  @Patch(':id/activate')
  activate(
    @Param('id', ParseIntPipe) id:number
  ){

    return this.deliveryService.activate(id);

  }



  @Patch(':id/deactivate')
  deactivate(
    @Param('id', ParseIntPipe) id:number
  ){

    return this.deliveryService.deactivate(id);

  }








}
