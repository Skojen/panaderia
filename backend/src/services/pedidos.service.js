import { PedidoModel } from '../models/pedido.model.js';

export const crearPedido = async (cliente, productos) => {
  let total = 0;
  const pedidoId = await PedidoModel.createPedido(cliente);

  for (const { producto_id, cantidad } of productos) {
    const precio = await PedidoModel.getPrecioProducto(producto_id);
    total += precio * cantidad;
    await PedidoModel.addProductoToPedido(pedidoId, producto_id, cantidad);
  }

  await PedidoModel.actualizarTotal(pedidoId, total);
  return { pedidoId, total };
};
