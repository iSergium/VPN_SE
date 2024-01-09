import subprocess

from django.http import HttpResponse
from django.shortcuts import render


def hello_world(request):
    try:
        command = "ikev2.sh --listclients"
        process = subprocess.Popen(
            command,
            shell=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        stdout, stderr = process.communicate()

        if process.returncode == 0:
            return HttpResponse(stdout)
        else:
            return HttpResponse(stderr, status=500)
    except Exception as e:
        # Ловим исключение, если что-то пошло не так
        return HttpResponse(str(e), status=500)
