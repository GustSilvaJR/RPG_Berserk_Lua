local gerencia_ataque_module = {}

gerencia_ataque_module.update = function(player, enemy)
end

gerencia_ataque_module.calcula_modulo_distancia = function (player, enemy)
    local modulo_distancia = player.char.x - enemy.posX;
    local dir, dir_orc;

    if (modulo_distancia < 0) then
        modulo_distancia = modulo_distancia * -1;
        dir = 'right';
        dir_orc = 'left';
    else
        dir = 'left';
        dir_orc = 'right'
    end

    return {
        dir = dir,
        dir_orc = dir_orc,
        modulo_distancia = modulo_distancia
    };
end

gerencia_ataque_module.valida_ataque = function(player, enemy, is_player_attack)

    local info_positions = gerencia_ataque_module.calcula_modulo_distancia(player, enemy);

    -- Ataque player
    if ((player.state == 'attacking' and  info_positions.modulo_distancia <= 150) or  (player.state == 'especial' and  info_positions.modulo_distancia <= 300)
    and not (State == 'death') and player.char.last_move_x ==
    info_positions.dir) then

        local defense = 0;
        local dmg = 0;

        if(player.state == 'especial') then
            dmg = player.dmg_especial;
        else
            dmg = player.dano_espada;
        end

        -- if (not (State == 'attacking')) then
        --     State = 'damaged'
        --     defense = 10;
        -- end

        print("Current Pré Ataque HP Orc: " .. enemy.vida);
        print('Acertou');

        enemy.vida = enemy.vida - dmg;
        State = 'damaged';

        if(player.state == 'especial') then
            player.state = 'peaceful'
            player.especial = 0;
            player.especial_state = false;
        else
            player.especial = player.especial+30;
        end
        if(player.especial>100) then
            player.especial = 100;
        end
        
        print("Current HP Orc: " .. enemy.vida);

        if (enemy.vida <= 0) then
            State = 'death';
        end

    end

    -- Ataque orc
    if State == 'attacking' and info_positions.modulo_distancia <= 150 and Dir_nome == info_positions.dir_orc then

        -- print("Current Pré Ataque HP Player: " .. player.vida);
        -- print('Orc Acertou');

        if player.char.y < (enemy.posY - enemy.sprites.current.quad_h + 20) then

            print(player.char.y .. '   |  ' .. enemy.sprites.current.quad_h)

        elseif (player.state == 'rolamento') then
            print('Toma gap');
        else
            if (player.state == 'defense') then

                if (player.vida > 0) then
                    player.vida = player.vida - (enemy.forca - player.defesa_bloq);

                    if player.vida < 0 then
                        player.vida = 0;
                    end
                end

            else
                if (player.vida > 0) then
                    player.vida = player.vida - enemy.forca;

                    if not (player.state == 'damaged') then
                        player.sprites.current.animation.frame = 1;
                        player.state = 'damaged';

                        player.sprites.current = player.sprites.damaged;

                        if (player.char.last_move_x == 'right') then
                            player.sprites.current.animation.direction = 'right'
                        else
                            player.sprites.current.animation.direction = 'left'
                        end
                    end

                    if player.vida < 0 then
                        player.vida = 0;
                    end
                end
            end
        end

        print("Current HP Player: " .. player.vida);

        if (player.vida <= 0) then
            player.state = 'death';
        end

    end
end

return gerencia_ataque_module;
