create table game
(
    id decimal primary key
);

create table game_subset
(
    subset  decimal,
    game_id decimal references game,
    red     decimal,
    green   decimal,
    blue    decimal
);
