import scala.concurrent.duration._

import scala.util.Random

import io.gatling.core.Predef._
import io.gatling.http.Predef._


class RinhaBackendSimulation
  extends Simulation {

  val httpProtocol = http
    .baseUrl("http://localhost:9999")
    .userAgentHeader("Agente do Caos - 2023")

  val criacaoEConsultaPessoas = scenario("Criação E Talvez Consulta de Pessoas")
    .feed(tsv("pessoas-payloads.tsv").circular())
    .exec(
      http("criação")
      .post("/pessoas").body(StringBody("#{payload}"))
      .header("content-type", "application/json")
      // 201 pros casos de sucesso :)
      // 422 pra requests inválidos :|
      // 400 pra requests bosta tipo data errada, tipos errados, etc. :(
      .check(status.in(201, 422, 400))
      // Se a criacao foi na api1 e esse location request atingir api2, a api2 tem que encontrar o registro.
      // Pode ser que o request atinga a mesma instancia, mas estatisticamente, pelo menos um request vai atingir a outra.
      // Isso garante o teste de consistencia de dados
      .check(status.saveAs("httpStatus"))
      .checkIf(session => session("httpStatus").as[String] == "201") {
        header("Location").saveAs("location")
      }
    )
    .pause(1.milliseconds, 30.milliseconds)
    .doIf(session => session.contains("location")) {
      exec(
        http("consulta")
        .get("#{location}")
      )
    }

  val buscaPessoas = scenario("Busca Válida de Pessoas")
    .feed(tsv("termos-busca.tsv").circular())
    .exec(
      http("busca válida")
      .get("/pessoas?t=#{t}")
      // qq resposta na faixa 2XX tá safe
    )

  val buscaInvalidaPessoas = scenario("Busca Inválida de Pessoas")
    .exec(
      http("busca inválida")
      .get("/pessoas")
      // 400 - bad request se não passar 't' como query string
      .check(status.is(400))
    )

  setUp(
    criacaoEConsultaPessoas.inject(
      constantUsersPerSec(2).during(10.seconds), // warm up
      constantUsersPerSec(5).during(15.seconds).randomized, // are you ready?
      
      rampUsersPerSec(6).to(300).during(3.minutes) // lezzz go!!!
    ),
    buscaPessoas.inject(
      constantUsersPerSec(2).during(25.seconds), // warm up
      
      rampUsersPerSec(6).to(50).during(3.minutes) // lezzz go!!!
    ),
    buscaInvalidaPessoas.inject(
      constantUsersPerSec(2).during(25.seconds), // warm up
      
      rampUsersPerSec(6).to(20).during(3.minutes) // lezzz go!!!
    )
  ).protocols(httpProtocol)
}
