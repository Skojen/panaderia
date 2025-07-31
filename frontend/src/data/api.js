let cachedApiUrl = null;

const loadApiUrl = async () => {
  if (cachedApiUrl) return cachedApiUrl;

  try {
    const response = await fetch('/env.json');
    const config = await response.json();
    cachedApiUrl = config.API_URL;
    return cachedApiUrl;
  } catch (error) {
    console.error('Error cargando API_URL desde env.json:', error);
    throw new Error('No se pudo cargar API_URL');
  }
};

export const fetchProducts = async () => {
  const API_URL = await loadApiUrl();
  const res = await fetch(`${API_URL}/productos`);
  if (!res.ok) throw new Error('Error al obtener productos');
  return await res.json();
};

export const sendOrder = async (payload) => {
  const API_URL = await loadApiUrl();
  const res = await fetch(`${API_URL}/pedido`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(payload),
  });
  if (!res.ok) throw new Error('Error al enviar pedido');
  return await res.json();
};
