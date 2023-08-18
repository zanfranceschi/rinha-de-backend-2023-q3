# [![Ruby](https://cdn.emojidex.com/emoji/hdpi/Ruby.png "Ruby") ](https://www.ruby-lang.org) a wild Ruby appears

```
     _      _           _             _               _            _         
 _ _(_)_ _ | |_  __ _  | |__  __ _ __| |_____ _ _  __| |  _ _ _  _| |__ _  _ 
| '_| | ' \| ' \/ _` | | '_ \/ _` / _| / / -_) ' \/ _` | | '_| || | '_ \ || |
|_| |_|_||_|_||_\__,_| |_.__/\__,_\__|_\_\___|_||_\__,_| |_|  \_,_|_.__/\_, |
                                                                        |__/ 
```

## Stack

* Ruby 3.2 [+YJIT](https://shopify.engineering/ruby-yjit-is-production-ready)
* PostgreSQL
* NGINX

O setup é bastante simples, basicamente contempla:

1. Duas API's Ruby atrás de um NGINX
2. Cada API sendo servida pelo Puma, um servidor HTTP multi-thread
3. Puma no modo cluster com 2 CPU workers (forking) e utilizando uma pool de até 5 threads
4. [Chespirito](https://github.com/leandronsp/chespirito), um framework web bastante simples criado pelo [@leandronsp](https://twitter.com/leandronsp)
5. Um database pool de 50 conexões
6. Busca textual no PostgreSQL ultra-rápida com ts_vector e GIN index

---

Repositório: [leandronsp/rinha-backend-ruby](https://github.com/leandronsp/rinha-backend-ruby)
Github: [leandronsp](https://github.com/leandronsp)
LinkedIn: [leandronsp](https://linkedin.com/leandronsp)
Twitter: [@leandronsp](https://twitter.com/leandronsp)
Mastodon: [@leandronsp](https://mastodon.social/@leandronsp)
DEV.to: [leandronsp](https://dev.to/leandronsp)

...e claro, não deixem de visitar [meu site](https://leandronsp.com/)

----

Arte ASCII feita com [ASCII art generator](http://www.network-science.de/ascii/)
