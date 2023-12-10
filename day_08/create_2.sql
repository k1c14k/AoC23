create or replace function count_steps_from(starting varchar) returns decimal as
$$
declare
    steps               decimal := 0;
    instructions        character[];
    instructions_length decimal;
    curr_node           varchar := starting;
begin
    select i.path into instructions from instructions i;
    instructions_length := array_length(instructions, 1);
    while true
        loop
            select into curr_node case
                                      when instructions[mod(steps, instructions_length) + 1] = 'L' then path_left
                                      else path_right end as next_node
            from node
            where id = curr_node;
            steps := steps + 1;
            if curr_node like '%Z' then
                return steps;
            end if;
        end loop;
end;
$$ language plpgsql;

create or replace function count_steps() returns decimal as
$$
declare
    steps     decimal;
    curr_node record;
begin
    for curr_node in select count_steps_from(id) as steps from node where id like '%A'
        loop
            if steps is null then
                steps := curr_node.steps;
            else
                steps := lcm(steps, curr_node.steps);
            end if;
        end loop;
    return steps;
end;
$$ language plpgsql;