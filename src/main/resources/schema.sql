CREATE OR REPLACE FORCE VIEW game_statistics AS
SELECT
    ga.PLAYER_ID,
    ga.pool_size,
    ga.code_length,
    COUNT(*) AS games_played,
    AVG(st.guess_count) AS avg_guess_count,
    AVG(st.duration) AS avg_duration
FROM
    GAME AS ga
        JOIN guess AS gs
             ON gs.game_id = ga.GAME_ID
                 AND  gs.CORRECT = ga.CODE_LENGTH
        JOIN (
        SELECT
            gs.game_id,
            COUNT(*) AS guess_count,
            DATEDIFF('MS', MIN(gs.created), MAX(gs.created)) AS duration
        FROM
            guess AS gs
        GROUP BY
            gs.game_id
    ) as st
             ON st.GAME_ID = ga.GAME_ID
GROUP BY
    ga.PLAYER_ID,
    ga.pool_size,
    ga.code_length;


