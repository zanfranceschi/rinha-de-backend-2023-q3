#!/usr/bin/python3

import random
import json
import string

def get_stacks_validas():
    stacks = [
        "Javascript"
        , "Python"
        , "Go"
        , "Java"
        , "Kotlin"
        , "PHP"
        , "C#"
        , "Swift"
        , "R"
        , "Ruby"
        , "C"
        , "C++"
        , "Matlab"
        , "TypeScript"
        , "Scala"
        , "SQL"
        , "HTML"
        , "CSS"
        , "NoSQL"
        , "Rust"
        , "Perl"
        , "C#"
        , "Clojure"
        , "MySQL"
        , "Postgres"]
    tem_stack = random.choice([i != 11  for i in range(1, 15)])
    valor_stacks = None
    if tem_stack:
        valor_stacks = random.choices(stacks, k=random.randint(1, len(stacks) + 1))
    return valor_stacks

def get_apelido_valido():
    return ''.join(random.choice(string.ascii_letters) for i in range(100))[:random.randint(1, 32)]

def get_nome_valido():
    return ''.join(random.choice(string.ascii_letters + ' ') for i in range(100))[:random.randint(1, 100)]

def get_nascimento_valido():
    return str(random.randint(1940, 2020)) + '-' + str(random.randint(1, 12+1)).rjust(2, '0') + '-' + str(random.randint(1, 28+1)).rjust(2, '0')

def get_stacks_invalidas():
    return random.choice([["1111111111111111111111111111111111111111"], "string", 1])

def get_nick_invalido():
    return ''.join(random.choice(string.ascii_letters) for i in range(35))

def get_nome_invalido():
    return ''.join(random.choice(string.ascii_letters + ' ') for i in range(120))

def get_nascimento_invalido():
    return json.dumps(random.choice(["12-12-2000", None, 10, "?!?!?"]))

def get_payload():
    gera_apelido_valido = random.choice([i != 1  for i in range(1, 100)])
    get_apelido = get_apelido_valido if gera_apelido_valido else get_nick_invalido

    gera_nome_valido = random.choice([i != 1  for i in range(1, 100)])
    get_nome = get_nome_valido if gera_nome_valido else get_nome_invalido
    
    gera_nascimento_valido = random.choice([i != 1  for i in range(1, 100)])
    get_nascimento = get_nascimento_valido if gera_nascimento_valido else get_nascimento_invalido
    
    gera_stacks_validas = random.choice([i != 1  for i in range(1, 100)])
    get_stacks = get_stacks_validas if gera_stacks_validas else get_stacks_invalidas

    payload = {"apelido" : get_apelido(), "nome" : get_nome(), "nascimento" : get_nascimento(), "stack" : get_stacks()}
    return json.dumps(payload)

def get_termo_busca():
    t = ''.join(random.choice(string.ascii_letters + ' ') for i in range(100))[:random.randint(1, 50)]
    return t.strip() or 'x'

def gera_payloads(numero_registros):
    with open("user-files/resources/pessoas-payloads.tsv", "w") as f:
        f.write("payload\n")
        for _ in range(numero_registros):
            f.write(f"{get_payload()}\n")

def gera_termos_busca(numero_registros):
    with open("user-files/resources/termos-busca.tsv", "w") as f:
        f.write("t\n")
        for _ in range(numero_registros):
            f.write(get_termo_busca() + "\n")

gera_payloads(100_000)
gera_termos_busca(5_000)