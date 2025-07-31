import { crearPedido } from '../services/pedidos.service.js';

export const crearPedidoController = async (req, res, next) => {
  try {
    const { cliente, productos } = req.body;
    const pedido = await crearPedido(cliente, productos);
    res.status(201).json(pedido);
  } catch (error) {
    next(error);
  }
};
