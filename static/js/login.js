const loginForm = document.getElementById('loginForm');
const usuarioInput = document.getElementById('usuario');
const passwordInput = document.getElementById('password');
const togglePassword = document.getElementById('togglePassword');
const submitBtn = document.getElementById('submitBtn');

/**
 * Muestra un popup de SweetAlert2 según el "caso" detectado en la validación.
 * Cada case define: ícono, título y texto del popup.
 */
function mostrarAlerta(caso){
  switch(caso){
    case 'usuario_vacio':
      Swal.fire({
        icon: 'error',
        title: 'Falta el correo',
        text: 'Ingresa tu correo institucional.',
        confirmButtonColor: 'var(--red-primary)'
      });
      usuarioInput.classList.add('field-invalid');
      break;

    case 'usuario_invalido':
      Swal.fire({
        icon: 'error',
        title: 'Correo inválido',
        text: 'Ingresa un correo electrónico con formato válido.',
        confirmButtonColor: 'var(--red-primary)'
      });
      usuarioInput.classList.add('field-invalid');
      break;

    case 'password_vacio':
      Swal.fire({
        icon: 'error',
        title: 'Falta la contraseña',
        text: 'Ingresa tu contraseña.',
        confirmButtonColor: 'var(--red-primary)'
      });
      passwordInput.classList.add('field-invalid');
      break;

    case 'password_corto':
      Swal.fire({
        icon: 'warning',
        title: 'Contraseña muy corta',
        text: 'La contraseña debe tener al menos 8 caracteres.',
        confirmButtonColor: 'var(--red-primary)'
      });
      passwordInput.classList.add('field-invalid');
      break;

    case 'password_sin_mayuscula':
      Swal.fire({
        icon: 'warning',
        title: 'Falta una mayúscula',
        text: 'La contraseña debe incluir al menos una letra mayúscula.',
        confirmButtonColor: 'var(--red-primary)'
      });
      passwordInput.classList.add('field-invalid');
      break;

    case 'password_sin_numero':
      Swal.fire({
        icon: 'warning',
        title: 'Falta un número',
        text: 'La contraseña debe incluir al menos un número.',
        confirmButtonColor: 'var(--red-primary)'
      });
      passwordInput.classList.add('field-invalid');
      break;

    case 'password_sin_especial':
      Swal.fire({
        icon: 'warning',
        title: 'Falta un carácter especial',
        text: 'La contraseña debe incluir al menos un carácter especial (ej: ! @ # $ % &).',
        confirmButtonColor: 'var(--red-primary)'
      });
      passwordInput.classList.add('field-invalid');
      break;

    case 'credenciales_invalidas':
      Swal.fire({
        icon: 'error',
        title: 'No pudimos iniciar sesión',
        text: 'Correo o contraseña incorrectos. Inténtalo nuevamente.',
        confirmButtonColor: 'var(--red-primary)'
      });
      usuarioInput.classList.add('field-invalid');
      passwordInput.classList.add('field-invalid');
      break;

    case 'validando':
      Swal.fire({
        icon: 'success',
        title: 'Credenciales válidas',
        text: 'Iniciando sesión…',
        timer: 1200,
        showConfirmButton: false
      });
      break;

    default:
      Swal.fire({
        icon: 'error',
        title: 'Ocurrió un problema',
        text: 'No pudimos validar tus datos. Intenta nuevamente.',
        confirmButtonColor: 'var(--red-primary)'
      });
  }
}

function clearFieldErrors(){
  usuarioInput.classList.remove('field-invalid');
  passwordInput.classList.remove('field-invalid');
}

togglePassword.addEventListener('click', () => {
  const isPassword = passwordInput.type === 'password';
  passwordInput.type = isPassword ? 'text' : 'password';
  togglePassword.classList.toggle('active', isPassword);
});

loginForm.addEventListener('submit', (e) => {
  e.preventDefault();
  clearFieldErrors();

  const usuario = usuarioInput.value.trim();
  const password = passwordInput.value;
  const usuarioPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  // Validación secuencial: se detiene en el primer caso que falle.
  if(usuario === ''){
    mostrarAlerta('usuario_vacio');
    usuarioInput.focus();
    return;
  }
  if(!usuarioPattern.test(usuario)){
    mostrarAlerta('usuario_invalido');
    usuarioInput.focus();
    return;
  }
  if(password === ''){
    mostrarAlerta('password_vacio');
    passwordInput.focus();
    return;
  }
  if(password.length < 8){
    mostrarAlerta('password_corto');
    passwordInput.focus();
    return;
  }
  if(!/[A-Z]/.test(password)){
    mostrarAlerta('password_sin_mayuscula');
    passwordInput.focus();
    return;
  }
  if(!/[0-9]/.test(password)){
    mostrarAlerta('password_sin_numero');
    passwordInput.focus();
    return;
  }
  if(!/[!@#$%^&*()_+\-=[\]{};':"\\|,.<>/?]/.test(password)){
    mostrarAlerta('password_sin_especial');
    passwordInput.focus();
    return;
  }

  // Todo válido en el cliente: mostramos estado de éxito.
  // Aquí es donde normalmente enviarías el form a tu vista de Django
  // (por ejemplo dejando que el <form> haga submit real con method="post").
  mostrarAlerta('validando');
  submitBtn.disabled = true;
  submitBtn.textContent = 'Ingresando…';

  setTimeout(() => {
    // Redirige al dashboard. La URL viene del atributo data-dashboard-url
    // del <body>, generado por Django con {% url 'dashboard' %}.
    const dashboardUrl = document.body.dataset.dashboardUrl;
    window.location.href = dashboardUrl;
  }, 1200);
});