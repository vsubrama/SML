CM.make "$cml/cml.cm";
open CML;
fun mailbox inch outch lis = case lis of
_ =>select [
              wrap (sendEvt(outch, (hd lis)), fn ()=> mailbox inch outch (tl lis)),
              wrap (recvEvt (inch), fn a => mailbox inch outch (lis @ [a]))
              ]
| h = (sync(wrap (recvEvt ch,fn x =>(mailbox ch ch1 (lis::[x])))))              

fun generator inch outch num= let
	val ochan = channel();
in	
if (num>=0) then
(
spawn(fn()=>mailbox inch ochan []); 
generator ochan (channel()) (num-1)
)
else
ochan
end;
fun receiver outch= let
val c = recv(outch);
in
TextIO.print(Int.toString(c) ^ "\n");
receiver outch
end;

fun sender inch x=if (x>=0) then
(
sync(sendEvt(inch,x));
sender inch (x-1)
)
else
()
fun main () =
  let val chStart = channel()
      val chEnd = generator chStart (channel()) 100
      val _ = spawn (fn () => receiver chEnd)
      val _ = spawn (fn () => ignore (sender chStart 50))
      val _ = spawn (fn () => ignore (sender chStart 50))
  in ()
  end;
  RunCML.doit(main,NONE);
