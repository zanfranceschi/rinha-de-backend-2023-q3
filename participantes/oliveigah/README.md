# Overview

Implementação utilizando elixir + nginx + postgres

Utilizei um esquema de cache consistente para evitar ao maximo chamadas ao banco de dados.

Utilizando distributed erlang é garantido que todas as chamadas para o mesmo id serão processadas pelo mesmo node da aplicação.

Sendo assim, quando o registro é escrito no banco também é escrito na memoria do nó responsável por ele.

Com isso consigo garantir que caso o registro não seja encontrado no cache do nó responsável ele tambem não existe no banco.

Essa estrategia precisa ser adaptada para caso os nós possam sofrer restarts, para repopular o cache e afins, mas não me preocupei com isso por agora.

Repo: https://github.com/oliveigah/rinha_backend

v2: Remove coluna de fts no postgres e tweaks de docker compose