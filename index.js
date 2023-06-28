const express = require("express");
const app = express();
const bodyParser = require('body-parser');
const session = require('express-session');
const Post = require('./models/Post');
const { sequelize, Sequelize } = require('./models/db'); // Importa o modelo Post e a instância do Sequelize
const { Op } = require('sequelize');
const Agendamento = require('./models/Agendamentos');
const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
app.set('view engine', 'ejs');
const moment = require('moment');

// Configuração do Passport.js
passport.use(new LocalStrategy({
  usernameField: 'email',
  passwordField: 'senha'
}, async function (ds_email, senha, done) {
  try {
    const pessoa = await Post.findOne({ where: { ds_email } });

    if (pessoa) {
      // Email já cadastrado, retorna um erro
      return done(null, false, { message: 'Email já cadastrado.' });
    }

    // Email não cadastrado, retorna sucesso
    return done(null, true);
  } catch (error) {
    return done(error);
  }
}));

// Configuração do middleware express-session
app.use(session({
  secret: 'chave-secreta',
  resave: false,
  saveUninitialized: false
}));

// Configuração do body-parser
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// Rota de início
app.get("/", function (req, res) {
  res.sendFile(__dirname + "/views/startview.html");
});

// Rota de cadastro
app.get("/cadastro", function (req, res) {
  res.sendFile(__dirname + "/views/cadastro.html");
});

// Rota de login
app.get("/login", function (req, res) {
  res.sendFile(__dirname + "/views/login.html");
});

// Rota de cadastro
app.post('/add', function (req, res, next) {
  const { nm_pessoa, ds_email, nr_cpf, nr_telefone, dt_nascimento, ds_senha } = req.body;

  Post.findOne({
    where: {
      [Op.or]: [
        { nm_pessoa: Sequelize.where(Sequelize.fn('LOWER', Sequelize.col('nm_pessoa')), nm_pessoa.toLowerCase()) },
        { ds_email: ds_email }
      ]
    }
  }).then(function (result) {
    if (result) {
      if (result.nm_pessoa.toLowerCase() === nm_pessoa.toLowerCase()) {
        res.send("Nome de usuário já cadastrado. <a href='/cadastro'>Voltar ao cadastro</a>");
      } else if (result.ds_email === ds_email) {
        res.send("E-mail já cadastrado. <a href='/cadastro'>Voltar ao cadastro</a>");
      }
    } else {
      Post.create({
        nm_pessoa: nm_pessoa,
        ds_email: ds_email,
        nr_cpf: nr_cpf,
        nr_telefone: nr_telefone,
        dt_nascimento: dt_nascimento,
        ds_senha: ds_senha
      }).then(function () {
        res.sendFile(__dirname + "/views/login.html");
      }).catch(function (erro) {
        res.send("Houve um erro: " + erro);
      });
    }
  }).catch(function (erro) {
    res.send("Houve um erro: " + erro);
  });
});

// Rota de login
app.post('/logar', function (req, res) {
  const { email, senha } = req.body;
  const md5 = require('md5');
  const senhaMD5 = md5(senha); // Gera o hash MD5 da senha


  Post.findOne({
    where: {
      ds_email: email,
      ds_senha: senhaMD5 // Compara com o hash MD5 da senha no banco de dados
    }
  }).then(function (result) {
    if (result) {
      res.sendFile(__dirname + "/views/agendamento.html");
    } else {
      res.send("E-mail ou senha incorretos. <a href='/login'>Voltar para login</a>");
    }
  }).catch(function (erro) {
    res.send("Houve um erro: " + erro);
  });
});

app.post('/agendamento', function (req, res, next) {
  passport.authenticate('local', function (err, info) {
    if (err) {
      return res.send("Houve um erro: " + err);
    }
    Agendamento.create({
      nome_paciente: req.body.nome_paciente,
      podologia: req.body.podologia,
      unha_encravada: req.body.unha_encravada,
      laser: req.body.laser,
      reflexologia: req.body.reflexologia,
      spa: req.body.spa,
      verruga_plantar: req.body.verruga_plantar,
      pes_diabeticos: req.body.pes_diabeticos,
      retorno: req.body.retorno,
      data: req.body.data,
      hora: req.body.hora
    }).then(function () {
      res.sendFile(__dirname + "/views/consultaMarcada.html");
    }).catch(function (erro) {
      res.send("Houve um erro: " + erro);
    });
  })(req, res, next);
});

// Rota de de procedimentos
app.get("/procedimentos", function (req, res) {
  res.sendFile(__dirname + "/views/procedimentos.html");
});

app.get('/consultas', function (req, res) {
  Agendamento.findAll({
    order: [['data', 'DESC'], ['hora', 'DESC']]
  }).then(function (results) {
    const consultas = results.map(consulta => ({
      id_tpAgendamento: consulta.id_tpAgendamento,
      data: moment(consulta.data).format('DD/MM/YYYY'),
      hora: consulta.hora,
      nome_paciente: consulta.nome_paciente,
      podologia: consulta.podologia,
      unha_encravada: consulta.unha_encravada,
      laser: consulta.laser,
      reflexologia: consulta.reflexologia,
      spa: consulta.spa,
      verruga_plantar: consulta.verruga_plantar,
      pes_diabeticos: consulta.pes_diabeticos,
      retorno: consulta.retorno
    }));

    res.render('consultas', { consultas });
  }).catch(function (err) {
    console.error('Erro ao consultar o banco de dados:', err);
    res.status(500).send('Erro ao consultar o banco de dados');
  });
});

app.get('/employee', function (req, res) {
  Post.findAll().then(function (results) {
    // Renderiza a página HTML e passa as informações para ela
    res.render('employee', { employee: results });
  }).catch(function (err) {
    // Lida com o erro, se houver
    console.error('Erro ao consultar o banco de dados:', err);
    res.status(500).send('Erro ao consultar o banco de dados');
  });
});

// Endpoint para excluir usuário
app.post('/excluir-usuario', function (req, res) {
  const { id } = req.body;

  // Verifica se o ID foi fornecido
  if (!id) {
    return res.status(400).send('ID do funcionário não fornecido');
  }

  // Realiza a exclusão do usuário no banco de dados
  Post.destroy({
    where: {
      id_pessoa: id
    }
  })
    .then(function () {
      // Exclusão bem-sucedida
      res.redirect('/employee'); // Redireciona para a rota de listagem de funcionários
    })
    .catch(function (err) {
      // Exclusão falhou
      console.error('Erro ao excluir usuário:', err);
      res.status(500).send('Erro ao excluir usuário');
    });
});


// Rota para buscar pessoa
app.get('/buscar-pessoa', function (req, res) {
  const { id } = req.query;

  // Verifica se o ID foi fornecido
  if (!id) {
    return res.status(400).send('ID da pessoa não fornecido');
  }

  // Realiza a busca no banco de dados com base no ID
  Post.findByPk(id)
    .then(function (pessoa) {
      if (pessoa) {
        // Retorna os dados da pessoa como resposta
        res.json({
          name: pessoa.nm_pessoa,
          email: pessoa.ds_email,
          phone: pessoa.nr_telefone,
          cpf: pessoa.nr_cpf
        });
      } else {
        res.status(404).send('Pessoa não encontrada');
      }
    })
    .catch(function (err) {
      console.error('Erro ao buscar pessoa:', err);
      res.status(500).send('Erro ao buscar pessoa');
    });
});


// Endpoint para atualizar pessoa
app.post('/atualizar-pessoa', function (req, res) {
  const { name, email, phone, cpf } = req.body;

  // Verifica se todos os campos foram fornecidos
  if (!name || !email || !phone || !cpf) {
    return res.status(400).send('Todos os campos devem ser fornecidos');
  }

  // Realiza a atualização dos dados da pessoa no banco de dados
  Post.update(
    { nm_pessoa: name, ds_email: email, nr_telefone: phone },
    { where: { nr_cpf: cpf } }
  )
    .then(function () {
      // Atualização bem-sucedida
      res.redirect('/employee');
    })
    .catch(function (err) {
      // Atualização falhou
      console.error('Erro ao atualizar pessoa:', err);
      res.status(500).send('Erro ao atualizar pessoa');
    });
});

// Inicia o servidor
app.listen(3000, function () {
  console.log("Servidor rodando na porta 3000");
});