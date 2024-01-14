/* 
Krok 1 - Instalacja OpenSSL na Linuxa
apt-get install openssl

Krok 2 - generowanie klucza prywatnego i publicznego w OpenSSL (o nazwie zad2_key.pem)
openssl genrsa -out zad2_key.pem 2048 

Krok 3 - generowanie zadania certyfikacyjnego CSR
openssl req -new -key zad2_key.pem -out zad2_csr.pem
challenge password - 1234

Krok 4 - generowanie certyfikatu na podstawie zadania z poprzedniego kroku
openssl x509 -req -days 365 -in zad2_csr.pem -signkey zad2_key.pem -out certificate3.cer
Nazwa certyfikatu - certificate3.cer

Krok 5 - eksport do kontenera .pfx
openssl pkcs12 -export -in certificate3.cer -inkey zad2_key.pem -out Container.pfx
*/

// serwer można odpalić poleceniem:
// $ node zadanie2.js (linux)
// > node.exe .\zadanie2.js (win10)

var fs = require('fs');
var https = require('https');

const pfx = {
    key:  fs.readFileSync('zad2_key.pem'),
    cert: fs.readFileSync('certificate.pem')
};

https.createServer(pfx, 
        (req, res) => {
            res.setHeader('Content-type', 'text/html; charset=utf-8');
            res.end(`hello world ${new Date()}`);
        }).listen(2137);
console.log('started');
