const Cart = ({ cart }) => (
  <div className="card">
    <div className="card-body">
      <h2 className="card-title">Carrito</h2>
      {cart.length === 0 ? (
        <p className="text-muted">Vacío</p>
      ) : (
        cart.map((item) => (
          <div key={item.id} className="d-flex justify-content-between">
            {item.nombre} x {item.quantity} = ${item.precio * item.quantity}
          </div>
        ))
      )}
      <hr />
      <strong>Total: ${cart.reduce((sum, item) => sum + item.precio * item.quantity, 0)}</strong>
    </div>
  </div>
);

export default Cart;
