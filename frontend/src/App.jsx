import { useEffect, useState } from 'react';
import ProductList from './components/ProductList';
import Cart from './components/Cart';
import CheckoutForm from './components/CheckoutForm';
import { fetchProducts, sendOrder } from './data/api';

const App = () => {
  const [products, setProducts] = useState([]);
  const [cart, setCart] = useState([]);

  useEffect(() => {
    fetchProducts().then(setProducts);
  }, []);

  const addToCart = (product) => {
    setCart((prev) => {
      const exists = prev.find((item) => item.id === product.id);
      if (exists) {
        return prev.map((item) =>
          item.id === product.id ? { ...item, quantity: item.quantity + 1 } : item
        );
      }
      return [...prev, { ...product, quantity: 1 }];
    });
  };

  const finalizeOrder = async (cliente) => {
    await sendOrder({
      cliente,
      productos: cart.map((p) => ({ id: p.id, cantidad: p.quantity })),
    });
    setCart([]);
  };

  return (
    <div className="container mt-4">
      <div className="row">
        {/* Columna izquierda: Lista de productos */}
        <div className="col-md-7 mb-4">
          <ProductList products={products} onAdd={addToCart} />
        </div>

        {/* Columna derecha: Carrito + Formulario */}
        <div className="col-md-5">
          <Cart cart={cart} />
          <CheckoutForm onSubmit={finalizeOrder} />
        </div>
      </div>
    </div>
  );
};

export default App;
