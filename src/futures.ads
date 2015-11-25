with Ada_Containers_Indefinite_Holders; --use the real deal where present...
with Ada.Finalization;
with Executor_Service;

generic
   type Item(<>) is private;
package Futures is

   type Object(<>) is limited
     new Executor_Service.Callable with private;

   type Callback_Function is access function return Item;

   function Create
     (Callback : Callback_Function)
      return Object;

   Execution_Exception : exception;

   function Get
     (Self : in out Object)
      return Item;

   function Promise
     (Self : in out Object)
      return Executor_Service.Callable_Ptr;

private

   -- to support indefinite types, for example String,
   -- especially since entries must return values as out parameters
   package Items is
     new Ada_Containers_Indefinite_Holders(Item);

   protected type Future_Data is
      procedure Put_Promise(Value : in Item);
      procedure Timed_Out;
      entry Wait_For_Promise(Value : out Items.Holder; Timed_Out : out Boolean);
   private
      Value : Items.Holder;
      Is_Timed_Out : Boolean := False;
   end Future_Data;

   type Object is limited
     new Executor_Service.Callable with
      record
         Callback : Callback_Function;
         Future_Value : Future_Data;
      end record;

   overriding
   procedure Call(Self : in out Object);


end Futures;

