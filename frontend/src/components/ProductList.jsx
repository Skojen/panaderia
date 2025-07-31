const ProductList = ({ products, onAdd }) => (
  <div className="card">
    <div className="card-body">
      <h2 className="card-title">Productos</h2>
      {products.map((product) => (
        <div
          key={product.id}
          className="d-flex justify-content-between align-items-center border-bottom py-2"
        >
          <span>
            {product.nombre} - ${product.precio}
          </span>
          <button className="btn btn-sm btn-primary" onClick={() => onAdd(product)}>
            Agregar
          </button>
        </div>
      ))}
    </div>
  </div>
);

export default ProductList;
