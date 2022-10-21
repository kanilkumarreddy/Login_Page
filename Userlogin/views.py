from django.shortcuts import render

def login(request):
    return render(request,'login.html')

def Welcome(request):
    user=request.POST.get("username")
    password=request.POST.get("password")
    if request.method=="POST":
        if user=='Anil' and password=='Anil123':
            return render(request,"Anil.html")
        elif user=='Hari' and password=='Hari123':
            return render(request,"Hari.html")
        elif user=='Ram' and password=='Ram123':
            return render(request,"Ram.html")
        else:
            return render(request,"login.html",{'error':"Enter valid user name and password"})
    else:
        return render(request,"login.html",{'error':"Enter valid user name and password"})
