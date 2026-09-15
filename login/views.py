from django.contrib.auth.tokens import PasswordResetTokenGenerator
from django.contrib.auth import get_user_model
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.utils.encoding import force_bytes, force_str
from django.core.mail import send_mail
from django.shortcuts import render, redirect
from django.contrib import messages
from django.urls import reverse
from django.conf import settings

# Create your views here.
def inicio(request):
    return render(request, 'login/inicio.html')


User = get_user_model()
token_generator = PasswordResetTokenGenerator()



User = get_user_model()
token_generator = PasswordResetTokenGenerator()


def forgot_password_view(request):
    """Paso 1: el usuario ingresa su correo. Por ahora solo muestra la pantalla,
    sin consultar la base de datos ni enviar correos todavía."""
    if request.method == 'POST':
        # TODO: cuando quieras que sea funcional de verdad, descomenta esto
        # (requiere que ya hayas corrido `python manage.py migrate`):
        #
        # email = request.POST.get('email', '').strip()
        # user = User.objects.filter(email=email).first()
        # if user:
        #     uid = urlsafe_base64_encode(force_bytes(user.pk))
        #     token = token_generator.make_token(user)
        #     reset_link = request.build_absolute_uri(
        #         reverse('reset_password', kwargs={'uidb64': uid, 'token': token})
        #     )
        #     send_mail(
        #         subject='Restablece tu contraseña — SGR Municipal',
        #         message=f'Haz clic para restablecer tu contraseña:\n{reset_link}',
        #         from_email=settings.DEFAULT_FROM_EMAIL,
        #         recipient_list=[email],
        #         fail_silently=True,
        #     )

        return render(request, 'login/forgot_password_sent.html')

    return render(request, 'login/forgot_password.html')


def reset_password_view(request, uidb64, token):
    """Paso 2: pantalla para definir la nueva contraseña. Por ahora no valida
    el token ni guarda nada en la base de datos, solo muestra el formulario."""
    # TODO: cuando quieras que sea funcional de verdad, descomenta esto
    # (requiere que ya hayas corrido `python manage.py migrate`):
    #
    # try:
    #     uid = force_str(urlsafe_base64_decode(uidb64))
    #     user = User.objects.get(pk=uid)
    # except (TypeError, ValueError, OverflowError, User.DoesNotExist):
    #     user = None
    # valid_link = user is not None and token_generator.check_token(user, token)

    if request.method == 'POST':
        # TODO: acá iría la validación real y el user.set_password(...) + user.save()
        return redirect('login')

    return render(request, 'login/reset_password.html', {'valid_link': True})