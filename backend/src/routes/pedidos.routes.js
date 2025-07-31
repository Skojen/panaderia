import express from 'express';
import { crearPedidoController } from '../controllers/pedidos.controller.js';

const router = express.Router();
router.post('/', crearPedidoController);
export default router;
