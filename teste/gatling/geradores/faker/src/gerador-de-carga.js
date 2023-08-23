#! /usr/bin/env node

const { fakerPT_BR: faker } = require('@faker-js/faker')

//
// UTILS
//

function randNumFactory(numPossibilities) {
  return function __randNumFactory() {
    return ~~(Math.random() * numPossibilities)
  }
}

function pickRandFactory(values) {
  const randFn = randNumFactory(values.length)

  return function __pickRand() {
    return values[randFn()] || null
  }
}

function itsMeantToBe(randNumFn) {
  return randNumFn() == 0
  //                  ^ chances de `1:n`, onde n é número de possiveis números
  //                    únicos gerados pela função `randNumFn`. Por exemplo,
  //                    se `randNumFn` pode gerar números de 0 à 99 (100 números
  //                    únicos), então as chances são `1:100`.
}

const oneInOneHundred = randNumFactory(100)
const oneInSixteen = randNumFactory(16)

//
// GERADORES DE CAMPOS
//

// NOME

function getValidNome() {
  return faker.person.fullName()
}

function getInvalidNome() {
  return faker.person.fullName().padEnd(121, '1')
  //                                    ^ limite é 120
}

// APELIDO

const randApelidoSuffix = pickRandFactory([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])

function getValidApelido() {
  return faker.internet.userName() + randApelidoSuffix()
}

function getInvalidApelido() {
  return faker.internet.userName().padEnd(33, '1')
  //                                      ^ limite é 32
}

// NASCIMENTO

function getValidNascimento() {
  const bday = faker.date.birthdate()
  const year = bday.getUTCFullYear()
  const month = (bday.getUTCMonth() + 1).toString().padStart(2, '0')
  const day = bday.getUTCDate().toString().padStart(2, '0')

  return `${year}-${month}-${day}`
}

const pickRandChar = pickRandFactory(['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
                                      'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
                                      'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'Y',
                                      'X', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
                                      'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
                                      'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
                                      'w', 'y', 'x', 'z'])

function getInvalidNascimento() {
  const year = pickRandChar() + pickRandChar() + pickRandChar() + pickRandChar()
  const month = pickRandChar() + pickRandChar()
  const day = pickRandChar() + pickRandChar()

  return `${year}-${month}-${day}`
}

// STACK

const pickRandStack = pickRandFactory(["Javascript", "Python", "Go", "Java",
                                       "Kotlin", "PHP", "C#", "Swift", "R",
                                       "Ruby", "C", "C++", "Matlab", "TypeScript",
                                       "Scala", "SQL", "HTML", "CSS", "NoSQL",
                                       "Rust", "Perl", "C#", "Clojure", "MySQL",
                                       "Postgres"])

function getValidStack() {
  if (itsMeantToBe(oneInSixteen)) {
    return null
  }

  return [ pickRandStack(), pickRandStack(), pickRandStack() ]
}

function getInvalidStack() {
  return [
    pickRandStack().padEnd(33, '1')
    //                     ^ o limite é 32
  ]
}

//
// GERADORES DE OBJETOS
//

function gerarPessoa() {
  return {
    nome: itsMeantToBe(oneInOneHundred) ? getInvalidNome() : getValidNome(),
    apelido: itsMeantToBe(oneInOneHundred) ? getInvalidApelido() : getValidApelido(),
    nascimento: itsMeantToBe(oneInOneHundred) ? getInvalidNascimento() : getValidNascimento(),
    stack: itsMeantToBe(oneInOneHundred) ? getInvalidStack() : getValidStack()
  }
}

const randBetween4And8 = pickRandFactory([4, 5, 6, 7, 8])
const randBetween4And12 = pickRandFactory([4, 5, 6, 7, 8, 9, 10, 11, 12])

function gerarTermoDeBusca() {
  if (itsMeantToBe(oneInSixteen)) {
    return pickRandStack()
  }

  if (itsMeantToBe(oneInSixteen)) {
    return faker.internet.userName()
  }

  if (itsMeantToBe(oneInSixteen)) {
    return faker.person.lastName()
  }

  if (itsMeantToBe(oneInSixteen)) {
    return faker.person.firstName()
  }

  if (itsMeantToBe(oneInSixteen)) {
    const max = randBetween4And8()

    let term = ""
    for (let i = 0; i < max; i++) {
      term += pickRandChar()
    }

    return term
  }

  return faker.person
    .firstName()
    .slice(0, randBetween4And12())
    .trim()
}

//
// EXPORTS
//

module.exports = { gerarPessoa, gerarTermoDeBusca }
