from django.contrib.auth import authenticate, login, logout
from django.shortcuts import render, redirect
from .forms import CustomLoginForm
from django.contrib.auth.decorators import login_required

def user_login(request):
    if request.method == "POST":
        form = CustomLoginForm(data=request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)  
            return redirect('home')  # Redireciona para a página dashboard após o login bem sucedido
    else:
        form = CustomLoginForm()

    return render(request, 'login.html', {'form': form})

def user_logout(request):
    logout(request)
    return redirect('login')  # Redireciona para a página de login após logout 

@login_required
def home(request):
    return render(request, 'home.html')


