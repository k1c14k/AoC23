create table category
(
    id   decimal primary key,
    name varchar
);

create table component
(
    id          decimal,
    category_id decimal references category
);

create table mapping
(
    source    decimal references category,
    target    decimal references category,
    target_id decimal,
    id        decimal,
    range     decimal
);

insert into category (id, name)
values (1, 'seed'),
       (2, 'soil'),
       (3, 'fertilizer'),
       (4, 'water'),
       (5, 'light'),
       (6, 'temperature'),
       (7, 'humidity'),
       (8, 'location');

create or replace procedure process_components() as
$$
begin
    for i in 1..7
        loop
            insert into component (id, category_id)
            select coalesce(m.target_id + c.id - m.id, c.id), i + 1
            from component c
                     left join mapping m
                               on c.category_id = m.source and c.id >= m.id and
                                  c.id < (m.id + m.range)
            where c.category_id = i;
        end loop;
end;
$$
    language plpgsql;