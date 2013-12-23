(*Name: Vasanth Subramanian
email: vsubrama@buffalo.edu*)
CM.make "$cml/cml.cm";
open CML;
val chan: int chan = channel();
fun sender n= if (n<=100)
then 
(
send(chan,n);
sender (n+1)
)
else
()

fun receiver ()=let
		val a = recv(chan);
in
		if (a<100)
		then
		(
		TextIO.print((Int.toString a)^"\n");
        receiver ()
        )
        else
        (
		TextIO.print((Int.toString a)^"\n");
		exit ()
        )
end;		
fun main ()= let
        val _ = spawn (fn()=>sender 0);
        val _ = spawn receiver;
in
        ()
end;
RunCML.doit(main, SOME(Time.fromMilliseconds 10));
