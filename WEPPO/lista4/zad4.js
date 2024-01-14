process.stdout.write("Witaj, podaj swoje imię: ");

process.stdin.on('data', function(input) {
    process.stdout.write("Witaj " + input);
    process.exit();
})

process.on('exit', function() {
    process.stdout.write("Do zobaczenia!\n");
})
