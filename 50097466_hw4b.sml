(*Name: Vasanth Subramanian
email: vsubrama@buffalo.edu*)
CM.make "$cml/cml.cm";
open CML;
val chan1: int chan = channel();
val chan2: int chan = channel();
val chan3: int chan = channel();
fun sender1 a n= let
		val _ = send(chan1,a);
		val x = recv(chan2);
in
		if(x<=n)
		then
			sender1 x n
		else
			TextIO.print("Sender 1 Thread End" ^" "^"\n")
end;			
fun sender2 b= let
		val y = recv(chan1);
		val z = b + y;
in
		send(chan3,y);
		send(chan2,b);
		sender2 z
end;
fun receiver () = let
		val m = recv(chan3);
in
		TextIO.print((Int.toString m)^"\n");
		receiver ()
end;		
fun main ()= let
		val _ = spawn(fn()=>sender1 0 200000);
		val _ = spawn(fn()=>sender2 1);
		val _ = spawn (receiver); 
in
		()
end;		
RunCML.doit(main, SOME(Time.fromMilliseconds 10));
