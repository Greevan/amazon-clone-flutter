const express = require("express");
const bcrypted = require('bcryptjs');
const jwt = require('jsonwebtoken');

const User = require("../models/user");

const authRouter = express.Router();

//SIGNUP route
authRouter.post('/api/signup', async (req, res) => {
    //get data from client
    const {name, email, password} = req.body;
    console.log('sign-up :'+ name, email, password);
    const existingUser = await User.findOne({email});
    try {
        if (existingUser) {
            return res.status(400).json({msg: "User with same email already exists!"});
        }

        const hashedPassword = await bcrypted.hash(password, 8);
        let user = new User({
            email, password: hashedPassword, name
        });
        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({error: e.message});
    }

});

//SIGNIN route
authRouter.post('/api/signin', async (req, res) => {
    const {email, password} = req.body;
    try {
        console.log('sign-in :'+ email, password);
        const user = await User.findOne({email});
        if (!user) {
            return res.status(400).json({msg: 'User with this email doesn\'t exist'});
        }

        //Password Validation
        const isMatch = await bcrypted.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({msg: 'Incorrect Password'})
        }
        const  token = jwt.sign({id: user._id}, "passwordKey");
        res.json({token, ...user._doc});

    } catch (e) {
        res.status(500).json({error: e.message})
    }
});


module.exports = authRouter;