import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import axios from 'axios'

// NOTA: Esta es una implementación simulada
// Para producción, usar APIs reales como Twilio, WhatsApp Business API, etc.

@Injectable()
export class WhatsAppService {
  private commercePhone: string;
  private whatsappToken: string;
  private phoneId: string;

  private apiVersion: string;

  constructor(private configService: ConfigService) {
    // Número del comercio (debe configurarse en .env)
    this.commercePhone =
      this.configService.get('COMMERCE_WHATSAPP') || '543888453334';

    this.whatsappToken =
      this.configService.get('WHATSAPP_TOKEN') || '';


    this.phoneId =
      this.configService.get('WHATSAPP_PHONE_NUMBER_ID') || '';

    this.apiVersion =
      this.configService.get('WHATSAPP_API_VERSION') || 'v25.0';
  }

  async sendOrderNotification(
    orderNumber: string,
    customerName: string,
    customerLastName: string,
    orderDetails: string,
    total: number,
  ): Promise<boolean> {
   
    try {
      

      const response = await axios.post(

        `https://graph.facebook.com/${this.apiVersion}/${this.phoneId}/messages`,

        {
          messaging_product: "whatsapp",

          to: this.commercePhone,

          type: "template",

          template: {

            name: "jaspers_market_order_confirmation_v1",

            language: {
              code: "en_US"
            },

            components: [
              {
                type: "body",

                parameters: [

                  {
                    type: "text",
                    text: `${customerName} ${customerLastName}`
                  },

                  {
                    type: "text",
                    text: orderNumber
                  },

                  {
                    type: "text",
                    text: new Date().toLocaleDateString()
                  }

                ]
              }
            ]
          }
        },

        {
          headers: {
            Authorization: `Bearer ${this.whatsappToken}`,
            "Content-Type": "application/json"
          }
        }

      );


      console.log(
        "WhatsApp enviado:",
        response.data
      );


      return true;


    } catch (error) {

      if (axios.isAxiosError(error)) {

        console.log(
          "Error enviando WhatsApp:",
          error.response?.data
        );

      } else {

        console.log(
          "Error desconocido:",
          error
        );

      }

      return false;

    }

  }

  // Método para enviar al cliente (opcional)
  async sendOrderConfirmationToCustomer(
    phone: string,
    orderNumber: string,
    total: number,
  ): Promise<boolean> {
   
    try {

      const response = await axios.post(

        `https://graph.facebook.com/${this.apiVersion}/${this.phoneId}/messages`,

        {
          messaging_product: "whatsapp",

          to: phone.startsWith('54')
            ? phone
            : `54${phone}`,

          type: "template",

          template: {

            name: "jaspers_market_order_confirmation_v1",

            language: {
              code: "en_US"
            },

            components: [
              {
                type: "body",

                parameters: [

                  {
                    type: "text",
                    text: "Cliente"
                  },

                  {
                    type: "text",
                    text: orderNumber
                  },

                  {
                    type: "text",
                    text: `$${total}`
                  }

                ]
              }
            ]

          }
        },

        {
          headers: {

            Authorization:
              `Bearer ${this.whatsappToken}`,

            "Content-Type":
              "application/json"

          }
        }

      );


      console.log(
        "WhatsApp cliente enviado:",
        response.data
      );


      return true;


    } catch (error) {


      if (axios.isAxiosError(error)) {

        console.log(
          "Error WhatsApp cliente:",
          error.response?.data
        );

      } else {

        console.log(
          "Error desconocido:",
          error
        );

      }


      return false;

    }
  }
}