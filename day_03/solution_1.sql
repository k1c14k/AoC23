select sum(part.id)
from part,
     symbol
where symbol.x >= part.x_from - 1
  and symbol.x <= part.x_to + 1
  and symbol.y >= part.y - 1
  and symbol.y <= part.y + 1;