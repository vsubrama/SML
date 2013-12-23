fun day_of_week_cs(i:int):day =
(case i mod 7 of 
 0 => sun
|1 => mon
|2 => tue
|3 => wed
|4 => thur
|5 => fri
|6 => sat)