create table scratchcard
(
    id      decimal,
    winning decimal[],
    draw    decimal[]
);

create or replace function card_point_value(winning decimal[], draw decimal[]) returns decimal as
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
    if result > 0 then
        result := power(2, result - 1);
    end if;
    return result;
end;
$$ language plpgsql;