//IMPORT FROM PACKAGES
const express = require('express');  //similar to import 'package:express/express.dart'
const mongoose = require('mongoose');
const cors = require('cors');

//IMPORT FROM OTHER FILES
const authRouter = require('./routes/auth');

//INIT
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://test:testhello123@cluster0.uxnxord.mongodb.net/?retryWrites=true&w=majority"


//middleware
app.use(express.json());
app.use(authRouter);
//app.use(cors());
app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    next();
});


// EXAMPLE CODE
// app.get('/hello-world', (req, res) => {
//     res.json("bad guy"); /*(or) res.send("hello world");*/
// });

app.listen(PORT, "0.0.0.0", () => {
    console.log(`connected at port : ${PORT}`);
});

//Connections
mongoose.connect(DB).then(() => {
    console.log("Connection Successful");
}).catch((e) => {
    console.log(e);
});