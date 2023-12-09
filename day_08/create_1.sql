create table instructions
(
    path character[]
);

create table node
(
    id         varchar,
    path_left  varchar,
    path_right varchar
);

create or replace function count_steps() returns decimal as
$$
declare
    steps               decimal := 0;
    instructions        character[];
    instructions_length decimal;
    curr_node           varchar := 'AAA';
begin
    select i.path into instructions from instructions i;
    instructions_length := array_length(instructions, 1);
    while curr_node != 'ZZZ'
        loop
            select into curr_node case
                                      when instructions[mod(steps, instructions_length) + 1] = 'L' then path_left
                                      else path_right end as next_node
            from node
            where id = curr_node;
            steps := steps + 1;
            raise notice 'step %, node %', steps, curr_node;
        end loop;
    return steps;
end;
$$ language plpgsql;
