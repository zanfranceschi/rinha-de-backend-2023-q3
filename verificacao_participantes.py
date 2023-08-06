import glob
import yaml
import yaml.loader
import re

dir = "./participantes/*/docker-compose.yml"

for arquivo in glob.glob(dir):
    with open(arquivo, 'r') as f:
        declaracao = yaml.load(f, Loader=yaml.loader.SafeLoader)
        services = declaracao["services"]
        total_memory = 0.0
        total_cpus = 0.0
        all_ports = [] 
        print("=" * 100)
        print(arquivo)
        for service_key in services:
            service = services[service_key]
            memory = service["deploy"]["resources"]["limits"]["memory"]
            memory_num = re.sub(r'[a-zA-Z]', '', service["deploy"]["resources"]["limits"]["memory"])
            cpus = service["deploy"]["resources"]["limits"]["cpus"]
            ports = service["ports"]
            for port in ports:
                p = port.split(':')[0]
                all_ports.append(p)
            total_cpus += float(cpus)
            total_memory += float(memory_num)
            print(f"{service['image'].ljust(40)} memory: {memory} / cpus: {cpus} / ports: {ports}")
        print("-" * 100)
        status = "INVÁLIDO" if total_cpus > 1.5 or total_memory > 3.0 else 'VÁLIDO'
        contains_port_9999 = any([p == '9999' for p in all_ports])
        print(f"{'USO MEM/CPU'.ljust(40)} {status} - memory: {total_memory} / cpus: {total_cpus}")
        print(f"{'PORTA 9999 EXPOSTA?'.ljust(40)} {contains_port_9999}")
        print("=" * 100)
        

        

