import { query } from '../config/db/index.js';

export class PedidoModel {
  static async createPedido(cliente) {
    const result = await query(
      'INSERT INTO pedidos(cliente, total, fecha) VALUES ($1, $2, CURRENT_TIMESTAMP) RETURNING id',
      [cliente, 0]
    );
    return result.rows[0].id;
  }

  static async addProductoToPedido(pedidoId, productoId, cantidad) {
    await query(
      'INSERT INTO pedido_productos(pedido_id, producto_id, cantidad) VALUES ($1, $2, $3)',
      [pedidoId, productoId, cantidad]
    );
  }

  static async getPrecioProducto(productoId) {
    const result = await query('SELECT precio FROM productos WHERE id = $1', [productoId]);
    return result.rows[0]?.precio || 0;
  }

  static async actualizarTotal(pedidoId, total) {
    await query('UPDATE pedidos SET total = $1 WHERE id = $2', [total, pedidoId]);
  }
}
