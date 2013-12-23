fun squareroot(x:real):real = let
val delta = 0.000002
fun goodenough(guess:real):bool = 
((guess * guess) - x) < delta
fun improve(guess:real):real =
(guess+ x/guess)/2.0
fun tryguess(guess:real):real =
if(goodenough(guess)) then guess
else tryguess(improve(guess))
in
tryguess(1.0)
end;
