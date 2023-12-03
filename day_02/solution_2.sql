select sum(mp.power)
from (select mrmgmb.max_blue * mrmgmb.max_green * mrmgmb.max_red as power
      from (select max(red) as max_red, max(green) as max_green, max(blue) as max_blue
            from game_subset
            group by game_id) as mrmgmb) as mp;