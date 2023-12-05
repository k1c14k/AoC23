alter table scratchcard
    add primary key (id);

create table scratchcard_count
(
    id    decimal references scratchcard,
    count decimal default 1
);

create or replace function calculate_matches(winning decimal[], draw decimal[]) returns decimal as
$$
declare
    result      decimal := 0;
    draw_number decimal;
begin
    foreach draw_number in array draw
        loop
            if draw_number = any (winning) then
                result := result + 1;
            end if;
        end loop;
    return result;
end;
$$ language plpgsql;

create or replace procedure process_cards() as
$$
declare
    current_card  record;
    current_count decimal;
    matches       decimal;
begin
    for current_card in select * from scratchcard order by id
        loop
            matches := calculate_matches(current_card.winning, current_card.draw);
            select count into current_count from scratchcard_count where id = current_card.id;
            update scratchcard_count
            set count = count + current_count
            where id > current_card.id and id <= current_card.id + matches;
        end loop;
end;
$$
    language plpgsql;