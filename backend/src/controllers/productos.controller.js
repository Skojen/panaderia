import { getAllProductos } from '../services/productos.service.js';

export const listarProductosController = async (req, res, next) => {
  try {
    const productos = await getAllProductos();
    res.json(productos);
  } catch (error) {
    next(error);
  }
};
