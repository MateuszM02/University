const fs = require('fs');
const readline = require('readline');

const file = readline.createInterface({
    input: fs.createReadStream('data6.txt'),
});

var Users = {}; // zapisuje ilosc wystapien danego adresu IP

// Wczytuje plik linijka po linijce
file.on('line', (line) => {
    var ip = line.split(" ")[1];
    if (Users.hasOwnProperty(ip))
        Users[ip]++;
    else
        Users[ip] = 1;
});

//funkcja, ktora wywola sie po zakonczeniu wczytywania danych z pliku
file.on('close', function() { 
    //tworzymy strukture zapamietujaca ID 3 najaktywniejszych uzytkownikow i ich ilosc zadan
    var topUsers = {
        1: ["fakeID1", -1], //1 miejsce
        2: ["fakeID2", -1], //2 miejsce
        3: ["fakeID3", -1], //3 miejsce
    };
    //uzupelniamy ta strukture
    for (var IP in Users) {
        if (Users[IP] > topUsers[3][1]){ //jesli aktualny uzytkownik ma wiecej zadan niz trzeci z dotychczasowych liderow
            var currentUser = [IP, Users[IP]]; //zapamietujemy dane aktualnego uzytkownika
            for (var topID in topUsers) //porownujemy ilosc zadan aktualnego uzytkownika z kolejno 1,2,3 miejscem
            {
                if (currentUser[1] > topUsers[topID][1]) //jesli aktualny uzytkownik ma wiecej zadan niz n-ty z liderow
                {
                    var temp = topUsers[topID];
                    topUsers[topID] = currentUser;
                    currentUser = temp;
                }
            }
        }
    }
    //Na koniec wyświetlamy wyniki:
    console.log(topUsers[1][0], topUsers[1][1]);
    console.log(topUsers[2][0], topUsers[2][1]);
    console.log(topUsers[3][0], topUsers[3][1]);
});
