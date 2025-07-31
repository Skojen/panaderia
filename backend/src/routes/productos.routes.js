import express from 'express';
import { listarProductosController } from '../controllers/productos.controller.js';

const router = express.Router();
router.get('/', listarProductosController);
export default router;
