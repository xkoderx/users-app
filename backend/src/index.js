const app=require('./app');
const {connect}=require('./database');
async function main(){
    //conecion a la base de datos
    await connect();
    //app express
    await app.listen(4000);
    console.log('Server on port 4000 conectado');
};
main();