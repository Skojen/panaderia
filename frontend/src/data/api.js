const API_URL = process.env.REACT_APP_API_URL;

console.log('API_URL:', API_URL);

export const fetchProducts = async () => {
  const res = await fetch(`${API_URL}/productos`);
  return await res.json();
};

export const sendOrder = async (payload) => {
  const res = await fetch(`${API_URL}/pedido`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(payload),
  });
  return await res.json();
};
