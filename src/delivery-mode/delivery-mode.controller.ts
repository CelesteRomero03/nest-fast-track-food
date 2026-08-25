import { Controller, Get, Param, Patch,ParseIntPipe, UseGuards  } from '@nestjs/common';
import { DeliveryModeService } from './delivery-mode.service';
import { JwtAuthGuard } from 'src/auth/guards/jwt-auth.guard';

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
   @UseGuards(JwtAuthGuard)
  activate(
    @Param('id', ParseIntPipe) id:number
  ){

    return this.deliveryService.activate(id);

  }



  @Patch(':id/deactivate')
   @UseGuards(JwtAuthGuard)
  deactivate(
    @Param('id', ParseIntPipe) id:number
  ){

    return this.deliveryService.deactivate(id);

  }








}
