var fs = require('fs');

fs.readFile('plik5.txt', 'utf-8', function(_err, data) 
{
    if ( _err != null )
        console.log( _err );
    else
        console.log( data );
});
