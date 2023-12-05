select sum(spv.point_value)
from (select card_point_value(winning, draw) as point_value from scratchcard) as spv;