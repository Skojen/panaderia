import { query } from '../config/db/index.js';

export class ProductoModel {
  static async findAll() {
    const result = await query('SELECT * FROM productos');
    return result.rows;
  }
}
