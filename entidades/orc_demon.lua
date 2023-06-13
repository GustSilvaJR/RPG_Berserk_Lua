local inimigo = require('entidades/inimigo')
local gerencia_inimigo = require('entidades/gerencia_inimigo')
local orc_module = {}

Data_sprites = {

    run = {

        name = 'run',
        sprite = love.graphics.newImage("imagens/enemyOrcWarrior/Run.png"),

        width_sprite = 576,
        height_sprite = 96,

        width_quad = 95,
        height_quad = 96,

        quant_quads = 6,
        duration = 0.2
    },

    stopped = {
        name = 'stopped',
        sprite = love.graphics.newImage("imagens/enemyOrcWarrior/Idle.png"),
        width_sprite = 480,
        height_sprite = 96,

        width_quad = 96,
        height_quad = 96,

        quant_quads = 5,
        duration = 0.2
    },
    
    attack_1 = {
        name = 'attack_1',
        sprite = love.graphics.newImage("imagens/enemyOrcWarrior/Attack_1.png"),
        width_sprite = 384,
        height_sprite = 96,

        width_quad = 96,
        height_quad = 96,

        quant_quads = 4,
        duration = 0.3
    },

    damaged = {
        name = 'damaged',
        sprite = love.graphics.newImage("imagens/enemyOrcWarrior/Hurt.png"),
        width_sprite = 192,
        height_sprite = 96,

        width_quad = 96,
        height_quad = 96,

        quant_quads = 2,
        duration = 0.2
    },

    death = {
        name = 'death',
        sprite = love.graphics.newImage("imagens/enemyOrcWarrior/Death2.png"),
        width_sprite = 404,
        height_sprite = 96,

        width_quad = 92,
        height_quad = 93,

        quant_quads = 4,
        duration = 0.2
    }

}

function orc_module.load_sprites(orc, data)
    local curr = false;

    if data.name == 'stopped' then
        curr = true;
    end

    gerencia_inimigo.generate_sprite(orc, data.name, data.sprite, data.width_sprite, data.height_sprite,
        data.width_quad, data.height_quad, data.quant_quads, 'right', curr, data.duration);
end

--function orc_module.keep_track(orc)

function orc_module.novo(posX, posY, name)
    local data_enemy = inimigo.novo('25', 'Orc', 100);
    local orc_demon = {};

    orc_demon.forca = data_enemy.forca;
    orc_demon.categoria = data_enemy.categoria;
    orc_demon.vida = data_enemy.vida;
    orc_demon.posX = posX;
    orc_demon.posY = posY - (Data_sprites.stopped.height_quad + 60);
    orc_demon.name = name;
    orc_demon.sprites = {};

    for k, v in pairs(Data_sprites) do
        orc_module.load_sprites(orc_demon, v);
    end

    return orc_demon;
end

return orc_module;
