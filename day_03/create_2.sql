drop table symbol;

create table symbol
(
    id serial,
    y  decimal,
    x  decimal,
    ch character
);

create view part_star as
select part.id as part_id, symbol.id as symbol_id
from part,
     symbol
where symbol.x >= part.x_from - 1
  and symbol.x <= part.x_to + 1
  and symbol.y >= part.y - 1
  and symbol.y <= part.y + 1
  and symbol.ch = '*';

create or replace function gear_ratio(in_symbol_id decimal) returns decimal as
$$
declare
    result decimal   := 1;
    rec record;
begin
    for rec in select part_id
                         from part_star
                         where part_star.symbol_id = in_symbol_id
        loop
            result := result * rec.part_id;
        end loop;
    return result;
end;
$$ language plpgsql;