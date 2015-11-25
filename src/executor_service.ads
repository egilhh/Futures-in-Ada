
package Executor_Service is

   type Object is tagged limited private;

   type Callable is limited interface;
   type Callable_Ptr is access all Callable'Class;
   procedure Call(Self : in out Callable) is abstract;

   procedure Execute(Self : in out Object; Callback : Callable_Ptr);

private

   task type Thread is
      entry Run(Callback : in Callable_Ptr);
   end Thread;

   type Object is tagged limited
      record
         Executor : Thread;
      end record;


end Executor_Service;

