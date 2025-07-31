import { ProductoModel } from '../models/producto.model.js';

export const getAllProductos = async () => {
  return await ProductoModel.findAll();
};
