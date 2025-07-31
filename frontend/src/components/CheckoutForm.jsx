import { useState } from 'react';

const CheckoutForm = ({ onSubmit }) => {
  const [nombre, setNombre] = useState('');
  const [correo, setCorreo] = useState('');
  const [status, setStatus] = useState(null); // 'success' | 'error'
  const [message, setMessage] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (!nombre || !correo.includes('@')) {
      setStatus('error');
      setMessage('Por favor, completa correctamente los campos.');
      return;
    }

    try {
      await onSubmit({ nombre, correo });
      setStatus('success');
      setMessage('Pedido enviado correctamente.');
      setNombre('');
      setCorreo('');
    } catch (err) {
      setStatus('error');
      setMessage('Error al enviar el pedido.');
    }

    setTimeout(() => {
      setStatus(null);
      setMessage('');
    }, 4000);
  };

  return (
    <form className="card mt-3 p-3" onSubmit={handleSubmit}>
      <h2>Datos del Cliente</h2>

      {status && (
        <div className={`alert alert-${status === 'success' ? 'success' : 'danger'}`} role="alert">
          {message}
        </div>
      )}

      <div className="mb-3">
        <input
          type="text"
          className="form-control"
          placeholder="Nombre completo"
          value={nombre}
          onChange={(e) => setNombre(e.target.value)}
          required
        />
      </div>

      <div className="mb-3">
        <input
          type="email"
          className="form-control"
          placeholder="Correo electrónico"
          value={correo}
          onChange={(e) => setCorreo(e.target.value)}
          required
        />
      </div>

      <button className="btn btn-success w-100" type="submit">
        Finalizar Pedido
      </button>
    </form>
  );
};

export default CheckoutForm;
