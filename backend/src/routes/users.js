const {Router, json} = require('express');
const router= Router();
const faker = require('faker');
const User = require('../models/User');
router.get('/api/users',(req,res)=>{
    res.json('User list');
});
router.get('/api/users/create',async(req,res)=>{
    for(let i=0;i<5;i++){
        await User.create({
            fisrtName:faker.name.firstName(),
            lastName:faker.name.lastName(),
            avatar:faker.image.avatar()
        });
    }
    res.json('5 usuarios crweados');
})
module.exports= router;