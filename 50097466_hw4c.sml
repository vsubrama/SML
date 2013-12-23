(*Name: Vasanth Subramanian
email: vsubrama@buffalo.edu*)
CM.make "$cml/cml.cm";
open CML;
fun mailbox ch ch1 L=case L of
[] =>(sync(wrap (recvEvt ch,fn x =>(mailbox ch ch1 (rev(x::(rev L)))))))
| _ =>(	select [
				 wrap (recvEvt ch,fn z =>(mailbox ch ch1 (rev(z::(rev L))))),
				 wrap (sendEvt(ch1, (hd L)), fn () =>(mailbox ch ch1 (tl L)))
				 ]
				 );
				 fun sender ch1 n=if (n>=0)
then 
(
send(ch1,n);
sender ch1 (n-1)
)
else
();
fun receiver ch1=let
		val x = recv(ch1);
in
		TextIO.print("Received" ^" "^(Int.toString x)^"\n");
		receiver ch1
end;		
fun generator ch ch1 n=		
		if(n>1)
		then
		(
		spawn (fn()=>ignore(mailbox ch ch1 []));
		generator ch1 (channel()) (n-1)
		)
		else if(n = 1)
		then
		(
		spawn (fn()=>mailbox ch ch1 []);
		ch1
		)
		else
		(channel())
fun main () =
  let val chStart = channel();
	  val chEnd = generator chStart (channel()) 100;
      val _ = spawn (fn () => receiver chEnd);
	  val _ = spawn (fn()=>sender chStart 50);
      val _ = spawn (fn()=>sender chStart 50);
     
  in ()
  end;
RunCML.doit(main, SOME(Time.fromMilliseconds 10));
