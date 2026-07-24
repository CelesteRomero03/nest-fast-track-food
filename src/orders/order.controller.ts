import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
  UseGuards,
  HttpCode,
  HttpStatus,
  ParseIntPipe,
  ValidationPipe,
} from '@nestjs/common';
import { OrderService } from './order.service';
import { CreateOrderDto } from './dto/create-order.dto';
import { UpdateOrderStatusDto } from './dto/update-order-status.dto';
import { AddItemsDto } from './dto/add-items.dto';
import { UpdateItemsDto } from './dto/update-items.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { GetUser } from '../auth/decorators/get-user.decorator';
import { OrderStatus, DeliveryMode } from './enums/order-status.enum';
import { QrService } from '../common/qr/qr.service';
import { WhatsAppService } from '../common/whatsapp/whatsapp.service';
import type { Response } from 'express';
import { Res } from '@nestjs/common';


@Controller('orders')
export class OrderController {
  constructor(
    private readonly orderService: OrderService,
    private readonly qrService: QrService,
    private readonly whatsappService: WhatsAppService,
  ) {}

  // ==================== ENDPOINTS PÚBLICOS (Clientes - sin autenticación) ====================

  @Post()
  create(@Body(ValidationPipe) createOrderDto: CreateOrderDto) {
    return this.orderService.createOrder(createOrderDto);
  }

  @Get('track/:orderNumber')
  trackOrder(@Param('orderNumber') orderNumber: string) {
    return this.orderService.findByOrderNumber(orderNumber);
  }

  // ==================== ENDPOINTS PROTEGIDOS (Admin/Employee) ====================
@Get()
  @UseGuards(JwtAuthGuard)
  findAll(
    @Query('status') status?: OrderStatus,
    @Query('deliveryMode') deliveryMode?: DeliveryMode,
    @Query('startDate') startDate?: string,
    @Query('endDate') endDate?: string,
    @Query('search') search?: string,
  ) {
    return this.orderService.findAllOrders(
      status,
      deliveryMode,
      startDate ? new Date(startDate) : undefined,
      endDate ? new Date(endDate) : undefined,
      search,
    );
  }

  @Get('pending-actions')
  @UseGuards(JwtAuthGuard)
  getPendingActions() {
    return this.orderService.getPendingActions();
  }

  @Get('stats')
  @UseGuards(JwtAuthGuard)
  getStats() {
    return this.orderService.getOrderStats();
  }

  @Get('status/:status')
  @UseGuards(JwtAuthGuard)
  findByStatus(@Param('status') status: OrderStatus) {
    return this.orderService.findByStatus(status);
  }

  @Get(':id')
  @UseGuards(JwtAuthGuard)
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.orderService.findOneOrder(id);
  }

  @Patch(':id/status')
  @UseGuards(JwtAuthGuard)
  updateStatus(
    @Param('id', ParseIntPipe) id: number,
    @Body(ValidationPipe) updateStatusDto: UpdateOrderStatusDto,
    @GetUser('id') userId: number,
  ) {
    return this.orderService.updateOrderStatus(id, updateStatusDto, userId);
  }

  @Post(':id/confirm')
  @UseGuards(JwtAuthGuard)
  @HttpCode(HttpStatus.OK)
  confirmOrder(
    @Param('id', ParseIntPipe) id: number,
    @GetUser('id') userId: number,
  ) {
    return this.orderService.confirmOrder(id, userId);
  }

  @Post(':id/reject')
  @UseGuards(JwtAuthGuard)
  @HttpCode(HttpStatus.OK)
  rejectOrder(
    @Param('id', ParseIntPipe) id: number,
    @Body('reason') reason: string,
    @GetUser('id') userId: number,
  ) {
    return this.orderService.rejectOrder(id, reason, userId);
  }

  @Post(':id/cancel')
  @UseGuards(JwtAuthGuard)
  @HttpCode(HttpStatus.OK)
  cancelOrder(
    @Param('id', ParseIntPipe) id: number,
    @Body('reason') reason: string,
    @GetUser('id') userId: number,
  ) {
    return this.orderService.cancelOrder(id, reason, userId);
  }

  @Post(':id/items')
  @UseGuards(JwtAuthGuard)
  addItems(
    @Param('id', ParseIntPipe) id: number,
    @Body(ValidationPipe) addItemsDto: AddItemsDto,
    @GetUser('id') userId: number,
  ) {
    return this.orderService.addItemsToOrder(id, addItemsDto, userId);
  }

  @Patch(':id/items')
  @UseGuards(JwtAuthGuard)
  updateItems(
    @Param('id', ParseIntPipe) id: number,
    @Body(ValidationPipe) updateItemsDto: UpdateItemsDto,
    @GetUser('id') userId: number,
  ) {
    return this.orderService.updateOrderItems(id, updateItemsDto, userId);
  }

  @Delete(':orderId/items/:itemId')
  @UseGuards(JwtAuthGuard)
  @HttpCode(HttpStatus.OK)
  removeItem(
    @Param('orderId', ParseIntPipe) orderId: number,
    @Param('itemId', ParseIntPipe) itemId: number,
    @GetUser('id') userId: number,
  ) {
    return this.orderService.removeOrderItem(orderId, itemId, userId);
  }


  // ==================== NUEVOS ENDPOINTS ====================

  @Get(':orderNumber/qr')
  async getOrderQR(
    @Param('orderNumber') orderNumber: string,
    @Res() res: Response,
  ) {
    const order = await this.orderService.findByOrderNumber(orderNumber);
    const qrData = order.getQRData();
    const qrCodeBuffer = await this.qrService.generateQRCodeBuffer(qrData);

    res.setHeader('Content-Type', 'image/png');
    res.send(qrCodeBuffer);
  }

  @Get(':orderNumber/qr-base64')
  async getOrderQRBase64(@Param('orderNumber') orderNumber: string) {
    const order = await this.orderService.findByOrderNumber(orderNumber);
    const qrData = order.getQRData();
    const qrCode = await this.qrService.generateQRCode(qrData);

    return { qrCode, orderNumber: order.orderNumber };
  }

  @Post(':orderNumber/notify-whatsapp')
  @HttpCode(HttpStatus.OK)
  async notifyWhatsApp(@Param('orderNumber') orderNumber: string) {
    const order = await this.orderService.findByOrderNumber(orderNumber);

    const orderDetails = order.items
      .map(
        (item) => `${item.quantity}x ${item.productName} - $${item.unitPrice}`,
      )
      .join('\n');

    await this.whatsappService.sendOrderNotification(
      order.orderNumber,
      order.customerName,
      order.customerLastName,
      orderDetails,
      order.total,
    );

    return { message: 'Notificación enviada al comercio' };
  }
}
