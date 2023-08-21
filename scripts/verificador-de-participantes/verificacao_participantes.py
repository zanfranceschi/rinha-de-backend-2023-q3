#!/usr/bin/python3

import glob
import yaml
import yaml.loader
import re

dir = "../../participantes/*/docker-compose.yml"
arquivos = 0

for arquivo in glob.glob(dir):
    arquivos += 1
    try:
        with open(arquivo, 'r') as f:
            declaracao = yaml.load(f, Loader=yaml.loader.SafeLoader)
            services = declaracao["services"]
            total_memory = 0.0
            total_cpus = 0.0
            all_ports = []
            msg = "=" * 100 + "\n"
            msg += arquivo + "\n"
            for service_key in services:
                service = services[service_key]
                if "deploy" not in service.keys():
                    continue
                memory = service["deploy"]["resources"]["limits"]["memory"]
                memory_num = re.sub(r'[a-zA-Z]', '', service["deploy"]["resources"]["limits"]["memory"])
                cpus = service["deploy"]["resources"]["limits"]["cpus"]
                ports = service["ports"] if "ports" in service.keys() else []
                for port in ports:
                    p = port.split(':')[0]
                    all_ports.append(p)
                total_cpus += float(cpus)
                total_memory += float(memory_num)
                msg += f"{service['image'].ljust(40)} memory: {memory} / cpus: {cpus} / ports: {ports}\n"

            msg += "-" * 100 + "\n"
            total_cpus = round(total_cpus, 2)
            total_memory = round(total_memory, 2)
            status = "INVÁLIDO" if total_cpus > 1.50 or total_memory > 3.00 else 'VÁLIDO'
            contains_port_9999 = any([p == '9999' for p in all_ports])
            msg += f"{'USO MEM/CPU'.ljust(40)} {status} - memory: {total_memory} / cpus: {total_cpus}\n"
            msg += f"{'PORTA 9999 EXPOSTA?'.ljust(40)} {contains_port_9999}\n"

            if (status == "INVÁLIDO"):
                print(msg)
    except:
        print(f"Erro em {arquivo}")

print(f"{arquivos} submissões")


