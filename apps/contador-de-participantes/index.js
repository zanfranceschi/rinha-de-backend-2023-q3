const fs = require('fs');
const marked = require('marked');
marked.use({
    mangle: false,
    headerIds: false
})
const cheerio = require('cheerio')

const mdToHtml = (fileMd) => {
    return new Promise((resolve, reject) => {
        // Leitura do arquivo Markdown
        fs.readFile(fileMd, 'utf8', (err, data) => {
            if (err) {
                console.error('Erro ao ler o arquivo Markdown:', err);
                return reject(err);
            }

            // Conversão para HTML
            const html = marked.parse(data);

            return resolve(html);
        })
    });
}

const generateSVG = (number) => {
    return new Promise((resolve, reject) => {
        const svgTemplate = `
          <svg width="100" height="50" xmlns="http://www.w3.org/2000/svg">
            <rect width="100%" height="100%" fill="#f0f0f0" />
            <text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle" font-size="24">${number}</text>
          </svg>
        `;

        if (!fs.existsSync('dist')) {
            fs.mkdirSync('dist');
        }
        
        // Grava o conteúdo do SVG em um arquivo
        fs.writeFile('dist/number.svg', svgTemplate, (err) => {
            if (err) {
                console.error('Erro ao gravar o arquivo SVG:', err);
                return reject(err);
            }
            console.log('SVG gerado e salvo com sucesso em "number.svg"!');
            return resolve()
        });
    })
}



mdToHtml('../README.md').then(async (html) => {
    // Carregar o conteúdo HTML usando o Cheerio
    const $ = cheerio.load(html);

    // Encontrar a tabela usando um seletor CSS (substitua 'table' pelo seletor correto)
    const table = $('table tbody');

    // Contar o número de linhas na tabela
    const rowCount = table.find('tr').length;

    console.log('Número de linhas na tabela:', rowCount);

    await generateSVG(rowCount);
})