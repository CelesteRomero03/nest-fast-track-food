import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

// NOTA: Esta es una implementación simulada
// Para producción, usar APIs reales como Twilio, WhatsApp Business API, etc.

@Injectable()
export class WhatsAppService {
  private commercePhone: string;

  constructor(private configService: ConfigService) {
    // Número del comercio (debe configurarse en .env)
    this.commercePhone =
      this.configService.get('COMMERCE_WHATSAPP') || '5491112345678';
  }

  async sendOrderNotification(
    orderNumber: string,
    customerName: string,
    customerLastName: string,
    orderDetails: string,
    total: number,
  ): Promise<boolean> {
    // Mensaje formateado para WhatsApp
    const message =
      `🍕 *NUEVO PEDIDO - FOOD SERVICE* 🍔\n\n` +
      `*Código:* ${orderNumber}\n` +
      `*Cliente:* ${customerName} ${customerLastName}\n` +
      `*Total:* $${total}\n\n` +
      `📋 *Detalle del pedido:*\n${orderDetails}\n\n` +
      `🔗 *Seguimiento:* http://localhost:3000/orders/track/${orderNumber}\n\n` +
      `_Mensaje generado automáticamente_`;

    // Simular envío (en desarrollo solo muestra en consola)
    console.log('========================================');
    console.log('📱 WHATSAPP NOTIFICATION');
    console.log(`To: ${this.commercePhone}`);
    console.log('========================================');
    console.log(message);
    console.log('========================================');

    // En producción, usar API real:
    // const response = await fetch('https://api.whatsapp.com/send', {
    //   method: 'POST',
    //   headers: { 'Content-Type': 'application/json' },
    //   body: JSON.stringify({ phone: this.commercePhone, message })
    // });

    // Por ahora retornamos true simulando éxito
    return true;
  }

  // Método para enviar al cliente (opcional)
  async sendOrderConfirmationToCustomer(
    phone: string,
    orderNumber: string,
    total: number,
  ): Promise<boolean> {
    const message =
      `🍕 *FOOD SERVICE - PEDIDO CONFIRMADO* 🍔\n\n` +
      `Hola! Tu pedido *${orderNumber}* ha sido recibido.\n` +
      `Total: $${total}\n\n` +
      `Podés seguir tu pedido aquí:\n` +
      `http://localhost:3000/orders/track/${orderNumber}\n\n` +
      `¡Gracias por tu compra! 🎉`;

    console.log('========================================');
    console.log('📱 WHATSAPP TO CUSTOMER');
    console.log(`To: ${phone}`);
    console.log('========================================');
    console.log(message);
    console.log('========================================');

    return true;
  }
}
