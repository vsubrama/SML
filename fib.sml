fun fib x y = let 
fun f x = if x = 0 then
x::f(x+1)
else if x = 1 then
x::f(x+1)
else
f(x-1) + f(x-2)
in
f x
end;
