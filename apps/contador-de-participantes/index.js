const fs = require('fs');

const gerarSVG = (count) => {
  const countStr = `${count}`.padStart(3, '0');

  return (
    '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="112"\n' +
    '  height="20" role="img" aria-label="030: participantes">\n' +
    `  <title>${count} participantes</title>\n` +
    '  <linearGradient id="s" x2="0" y2="100%">\n' +
    '    <stop offset="0" stop-color="#bbb" stop-opacity=".1" />\n' +
    '    <stop offset="1" stop-opacity=".1" />\n' +
    '  </linearGradient>\n' +
    '  <clipPath id="r">\n' +
    '    <rect width="112" height="20" rx="3" fill="#fff" />\n' +
    '  </clipPath>\n' +
    '  <g clip-path="url(#r)">\n' +
    '    <rect width="31" height="20" fill="#555" />\n' +
    '    <rect x="31" width="81" height="20" fill="#007ec6" />\n' +
    '    <rect width="112" height="20" fill="url(#s)" />\n' +
    '  </g>\n' +
    '  <g fill="#fff" text-anchor="middle" font-family="Verdana,Geneva,DejaVu Sans,sans-serif" text-rendering="geometricPrecision" font-size="110">\n' +
    `    <text aria-hidden="true" x="165" y="150" fill="#010101" fill-opacity=".3" transform="scale(.1)" textLength="210">${countStr}</text>\n` +
    `    <text x="165" y="140" transform="scale(.1)" fill="#fff" textLength="210">${countStr}</text>\n` +
    '    <text aria-hidden="true" x="705" y="150" fill="#010101" fill-opacity=".3" transform="scale(.1)" textLength="710">participantes</text>\n' +
    '    <text x="705" y="140" transform="scale(.1)" fill="#fff" textLength="710">participantes</text>\n' +
    '  </g>\n' +
    '</svg>\n'
  );
}

const AMARELO = '\x1b[33m';
const RESET = '\x1b[0m';

const participantesDir = process.argv.slice(2)[0];
const caminhoArquivoSvg = process.argv.slice(2)[1];

if (!participantesDir | !caminhoArquivoSvg) {
  console.error(
    'Tá faltando argumento ai na chamada, é pra ser assim oh:\n' +
    '\n' +
    `    node index.js ${AMARELO}../../participantes/ ../../misc/contador-participantes.svg${RESET}\n` +
    '\n' +
    'Onde:\n' +
    '\n' +
    `- "${AMARELO}../../participantes/${RESET}" é o caminho relativo para o diretório onde os\n` +
    '  participantes submetes a pasta contendo suas aplicações; e\n' +
    '\n' +
    `- "${AMARELO}../../misc/contador-participantes.svg${RESET}" é o caminho relativo para\n` +
    '  onde o arquivo SVG deverá ser escrito.\n'
  );

  process.exit(1);
}

const count =
  fs.readdirSync(participantesDir, { withFileTypes: true })
    .filter(entry => entry.isDirectory())
    .length

const svg = gerarSVG(count);

fs.writeFileSync(caminhoArquivoSvg, svg);
