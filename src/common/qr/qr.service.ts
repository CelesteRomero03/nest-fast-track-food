import { Injectable } from '@nestjs/common';
import * as QRCode from 'qrcode';

@Injectable()
export class QrService {
  async generateQRCode(data: string): Promise<string> {
    try {
      // Generar QR como data URL (base64)
      const qrCodeDataUrl = await QRCode.toDataURL(data, {
        errorCorrectionLevel: 'H',
        margin: 1,
        width: 300,
        color: {
          dark: '#000000',
          light: '#FFFFFF',
        },
      });
      return qrCodeDataUrl;
    } catch (error) {
      throw new Error(`Error generating QR code: ${error.message}`);
    }
  }

  async generateQRCodeBuffer(data: string): Promise<Buffer> {
    return await QRCode.toBuffer(data, {
      errorCorrectionLevel: 'H',
      margin: 1,
      width: 300,
    });
  }
}
