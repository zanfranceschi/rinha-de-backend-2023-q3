#! /usr/bin/env python3

import random
import string
import sys

def get_termo_busca():
    t = ''.join(random.choice(string.ascii_letters + ' ') for i in range(100))[:random.randint(1, 50)]
    return t.strip() or 'x'

def gera_termos_busca(numero_registros):
    sys.stdout.write("t\n")
    for _ in range(numero_registros):
        sys.stdout.write(get_termo_busca() + "\n")

gera_termos_busca(50_000)