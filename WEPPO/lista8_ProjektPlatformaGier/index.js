var http = require('http');
var express = require('express');
var uuid = require('uuid').v4;
var socket = require('socket.io');
var cookieParser = require('cookie-parser');
var room = require('./room.js').room;
var path = require('path');

var app = express();
var server = http.createServer(app);
var io = socket(server);

app.set('view engine', 'ejs');
app.set('views', './views');

//app.use(express.urlencoded({extended:true}));
app.use(cookieParser());
app.use(express.urlencoded({ extended: true}));

// WAZNE! - dzieki temu dzialaja wszystkie pliki z folderu views/static, czyli cala grafika
app.use(express.static(path.join(__dirname, 'views/static')))

let rooms = [];
let roomslist = [];
let games = require('./games.js').games;

function get_user(req, res){
    var username;
    var userid;
    if(!req.cookies.userid) {
        username = 'guest';
        userid = uuid();
        res.cookie('username', username);
        res.cookie('userid', userid);
    }
    else {
        username = req.cookies.username;
        userid = req.cookies.userid;
    }
    return {username: username,userid: userid}
}

app.get( '/', (req, res) => {
    var roomnumber = roomslist.length;
    let {username,userid} =get_user(req,res);//dodaj opcje nicku TODO
    res.render('index', {roomslist,newroom: undefined,imie:username,roomnumber});
});

app.post('/', (req, res) => {
    var newroom = req.body.newroom;
    var existingroom = req.body.existingroom;
    var imie = req.body.imie;
    var id;
    let {username,userid} = get_user(req,res);
  //  console.log("home "+userid);
    if (newroom)
    {
   //     console.log("zapytanie");
        if(rooms[newroom.toString()]==undefined){

        id = uuid().toString();
   //     console.log(newroom);
        var r = new room(games,newroom.toString(),id);
        r.ID_first=userid;
        rooms[id] = r;// console.log("utworzono pokój o id "+id); if(rooms[id].room_ID) console.log(rooms[id].room_ID);
        rooms[newroom.toString()] = r;
        roomslist.push(r);

        }
    }
    else if (existingroom)
    {
        id = existingroom.toString();
     //   console.log("aaaasadwq "+id);
     //   if(rooms[id]) console.log("jest");
    ///    else console.log("nie ma");
        if (!rooms[id].ID_second)
        {
            rooms[id].ID_second = userid;
        }
       // res.redirect("/rooms?room="+id);
    }
    if(imie){
        res.cookie('username', imie);
    }
    res.redirect("/rooms?room="+id);
  //  res.redirect("/rooms?room="+id);
});

app.get( '/rooms', (req, res) => {
    var id = req.query.room;
    var room = rooms[id];
 //   console.log(room)

    if (room == undefined)
    {
        res.redirect("/");
    }
    else if (room.current_game != undefined)
    {
        res.render('rooms_e',{room,games});
    }
    else res.render('rooms_n', {room,games});
});

app.post('/rooms', (req, res) => {
    let {username,userid} = get_user(req,res);
    var id = req.query.room;
    var game = req.body.games;
    var room = rooms[id];
  //  console.log("rooms "+userid);
    if(userid==room.ID_first || (room.ID_second && userid==room.ID_second)){
        if (room.current_game == undefined)
        {
            room.newgame(game);
        }
        else game=room.game_short;
    }
    res.redirect("/games?room="+id+"&game="+game);
});

app.get( '/games' ,(req,res) => {
    var id = req.query.room;
    var game = req.query.game;
    var room = rooms[id];
    if (id == undefined || games[game] == undefined || room == undefined)
    {
        res.redirect("/");
    }
    let {username,userid} = get_user(req,res);
    res.render(game,{room,userid,username});
});

app.post( '/games',(req,res) => {

});

io.on('connection', function(socket) {

    socket.on('join room', function(roomid) {
        socket.join(roomid.toString());
        console.log("join ");
        console.log(socket.rooms);
        for(var i=0; i<roomslist.length;i++){
            if(roomid==roomslist[i].room_ID) roomslist[i].players++;
        }
    });


    socket.on('chat-message', function(move,roomid,userid){
        var room = rooms[roomid];
        if((room.ID_first && room.ID_first==userid )|| (room.ID_second && room.ID_second==userid)){
         // if((room.ID_first && room.ID_second) && (room.ID_first==userid || room.ID_second==userid)){ //ten jesli chce zablokować ruch jak nie ma dwuch graczy
         //   console.log(socket.rooms);
            if(room.ID_first==userid){
                room.current_game.move(0,move);
            }
            else{
                room.current_game.move(1,move);
            }
            var board = room.current_game.getstate().board;
            io.to(roomid.toString()).emit('board',board);
        }
    })

    socket.on('disconnecting', () => {
        console.log("rozlacz ");
        console.log(socket.rooms);
        let pokoje = socket.rooms;
        console.log("przed");
        for(var i=0; i<roomslist.length;i++) console.log(roomslist[i].room_ID+" "+roomslist[i].players);
        for(var i=0; i<roomslist.length;i++){
            if(pokoje.has(roomslist[i].room_ID)){
                console.log(roomslist[i].room_ID + " "+roomslist[i].players);
                roomslist[i].players--;
                console.log(roomslist[i].room_ID + " "+roomslist[i].players);
                if(roomslist[i].players<=0){
                    roomslist.splice(i,1); console.log("aborcja");
                }
            }
        }
        console.log("po")
        for(var i=0; i<roomslist.length;i++) console.log(roomslist[i].room_ID+" "+roomslist[i].players);
    });
});

server.listen(3000);
