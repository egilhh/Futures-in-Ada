with Ada.Exceptions;
with Ada.Text_IO;
with Ada.Unchecked_Deallocation;

package body Executor_Service is

   procedure Execute (Self : in out Object; Callback : Callable_Ptr)
   is
   begin
      Self.Executor.Run(Callback); -- should probably be put on a queue
   end Execute;


   task body Thread
   is
      Execute_Later : Callable_Ptr;
   begin
      loop
         select
            accept Run(Callback : in Callable_Ptr) do
               Execute_Later := Callback;
            end Run;
            Execute_Later.Call;
            -- don't use Execute_Later beyond this point, as it (may) have been
            -- deallocated elsewhere
            Execute_Later := null;
         or terminate;
         end select;
      end loop;
   exception
      when e : others =>
         Ada.Text_IO.Put_Line("ERROR: " & Ada.Exceptions.Exception_Information(e));
   end Thread;


end Executor_Service;

