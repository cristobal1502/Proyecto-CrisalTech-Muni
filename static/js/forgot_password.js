const forgotForm = document.getElementById('forgotForm');
const emailInput = document.getElementById('email');

function mostrarAlertaForgot(caso){
  switch(caso){
    case 'email_vacio':
      Swal.fire({
        icon: 'error',
        title: 'Falta el correo',
        text: 'Ingresa tu correo institucional.',
        confirmButtonColor: 'var(--red-primary)'
      });
      emailInput.classList.add('field-invalid');
      break;

    case 'email_invalido':
      Swal.fire({
        icon: 'error',
        title: 'Correo inválido',
        text: 'Ingresa un correo electrónico con formato válido.',
        confirmButtonColor: 'var(--red-primary)'
      });
      emailInput.classList.add('field-invalid');
      break;
  }
}

forgotForm.addEventListener('submit', (e) => {
  emailInput.classList.remove('field-invalid');

  const email = emailInput.value.trim();
  const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  if(email === ''){
    e.preventDefault();
    mostrarAlertaForgot('email_vacio');
    emailInput.focus();
    return;
  }
  if(!emailPattern.test(email)){
    e.preventDefault();
    mostrarAlertaForgot('email_invalido');
    emailInput.focus();
    return;
  }
  // Si pasa las validaciones, el form sigue su envío normal (POST a Django).
});