import express from 'express';
import cors from 'cors';
import productosRoutes from './routes/productos.routes.js';
import pedidosRoutes from './routes/pedidos.routes.js';
import { errorHandler } from './middleware/errorHandler.js';

const app = express();
app.use(cors());

app.use(express.json());
app.use('/productos', productosRoutes);
app.use('/pedido', pedidosRoutes);
app.use(errorHandler);

export default app;
