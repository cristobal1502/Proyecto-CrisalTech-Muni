from django.shortcuts import render

# Create your views here.
def dashboard(request):
    return render(request, 'dashboard/dashboard.html')

def agenda(request):
    return render(request, 'dashboard/agenda.html')

def casos_sociales(request):
    return render (request, 'dashboard/casos_sociales.html')

def busqueda(request):
    return render(request, 'dashboard/busqueda.html')