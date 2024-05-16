const express = require('express');
const userRouter = express.Router();

const noAuth = require('../middleware/no_auth');
const User = require('../models/user');

userRouter.get('/api/users', noAuth, async (req, res, next) => {
    try {
        const users = await User.find();
        res.json(users);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

module.exports = userRouter;