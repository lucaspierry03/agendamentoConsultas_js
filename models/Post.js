const { Sequelize, sequelize } = require('./db');
const md5 = require('md5');

const Post = sequelize.define('pessoa', {
    id_pessoa: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    nm_pessoa: {
        type: Sequelize.STRING
    },
    ds_email: {
        type: Sequelize.STRING
    },
    nr_cpf: {
        type: Sequelize.STRING
    },
    nr_telefone: {
        type: Sequelize.STRING
    },
    dt_nascimento: {
        type: Sequelize.STRING
    },
    ds_senha: {
        type: Sequelize.STRING
    },
    tp_pessoa: {
        type: Sequelize.STRING
    }
}, {
    tableName: 'pessoa',
    timestamps: false
});

// Hook beforeCreate
Post.beforeCreate((post, options) => {
    if (post.ds_senha) {
        const senhaMD5 = md5(post.ds_senha);
        post.ds_senha = senhaMD5;
    }
});

module.exports = Post;

// Sincronize a tabela (descomente a parte do código que você mencionou)
//Post.sync()
  //.then(() => {
    //console.log('Tabela sincronizada com sucesso');
  //})
  //.catch((error) => {
  //  console.error('Erro ao sincronizar tabela:', error);
//  });
