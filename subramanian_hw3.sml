datatype 'a inflist = NIL | CONS of 'a * (unit -> 'a inflist);

fun HD (CONS(a,b)) = a | HD NIL = raise Subscript;

fun TL (CONS(a,b)) = b() | TL NIL = raise Subscript;

fun NULL NIL = true | NULL _ = false;

fun FILTER f l = if NULL l then NIL else if f (HD l) then CONS(HD l, fn () => (FILTER f (TL l))) else FILTER f (TL l);

fun TAKE(xs, 0) = []
  | TAKE(NIL, n) = raise Subscript
  | TAKE(CONS(x,xf), n) = x::TAKE(xf(), n-1);

fun even n = if n mod 2 = 0 then true else false;
(*val even = fn : int -> bool*)
fun odd n = if n mod 2 = 0 then false else true;

fun fib x y = CONS( x, fn() => fib y (x+y));

val fibs = fib 0 1;

fun SIFTEVEN NIL = NIL | SIFTEVEN L = let val a = HD L in CONS(a, fn () => SIFTEVEN(FILTER (even) (TL L) )) end;

val evenFibs = SIFTEVEN (fibs);

fun SIFTODD NIL = NIL | SIFTODD L = let val a = HD(TL L) in CONS(a, fn () => SIFTODD(FILTER (odd) (TL L) )) end;

val oddFibs = SIFTODD (fibs);

fun printGenList f [] = print(" ") | printGenList f L = (f (hd L) ; printGenList f (tl L));

fun printList L = printGenList (fn x:int => print( Int.toString x ^ " ")) L;

fun printPairList L = printGenList (fn (n:int,x:int) => print( "(" ^ Int.toString n ^ "," ^ " " ^ Int.toString x ^ ")")) L;

fun zip (x,y) = case x of L => CONS( ((HD x),(HD y)) , fn()=>zip ((TL x),(TL y)) );

(*TEST*)

printList(TAKE(fibs,20));

printList(TAKE(evenFibs,10));

printList(TAKE(oddFibs,10));

printPairList(TAKE(zip(evenFibs,oddFibs),10));

