import env from '../env.js';

let db;

if (env.DB_ENGINE === 'postgres') {
  db = await import('./postgres.js');
} else {
  throw new Error(`DB_ENGINE ${env.DB_ENGINE} no soportado`);
}

export const query = db.query;
