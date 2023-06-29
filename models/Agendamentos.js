const { Sequelize, sequelize } = require('./db');

const Agendamento = sequelize.define('tipo_agendamento', {
    id_tpAgendamento : {
        type: Sequelize.INTEGER,
        primaryKey: true, // Defina a coluna 'id_pessoa' como chave primária
        autoIncrement: true // Se necessário, defina como true se a coluna for autoincrementável
    },
    nome_paciente: {
        type: Sequelize.STRING
    },
    nome_profissional: {
        type: Sequelize.STRING
    },
    podologia: {
        type: Sequelize.STRING
    },
    unha_encravada: {
        type: Sequelize.STRING
    },
    laser: {
        type: Sequelize.STRING
    },
    reflexologia: {
        type: Sequelize.STRING
    },
    spa: {
        type: Sequelize.STRING
    },
    verruga_plantar: {
        type: Sequelize.STRING
    },
    pes_diabeticos: {
        type: Sequelize.STRING
    },
    retorno: {
        type: Sequelize.STRING
    },
    data: {
        type: Sequelize.STRING
    },
    hora: {
        type: Sequelize.STRING
    }
}, {
    tableName: 'tipo_agendamento',
    timestamps: false // Se a tabela não possui colunas 'createdAt' e 'updatedAt', defina como false
});

module.exports = Agendamento;
