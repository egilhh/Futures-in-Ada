--with Ada.Dispatching;
with Ada.Exceptions;
with Ada.Text_IO;
with Ada.Unchecked_Deallocation;


package body Futures is


   function Create
     (Callback : Callback_Function)
      return Object
   is
   begin
      return Self : Object := Object'
        (Callback => Callback,
        others => <>);
   end Create;


   procedure Call(Self : in out Object)
   is
   begin
      select
         delay 5.0;
         Self.Future_Value.Timed_Out;
      then abort
         Self.Future_Value.Put_Promise
           (Self.Callback.all);
      end select;
   end Call;


   function Get(Self : in out Object)
     return Item
   is
      Value : Items.Holder;
      Timed_Out : Boolean;
   begin
      Self.Future_Value.Wait_For_Promise(Value, Timed_Out);
      if Timed_Out then
         raise Execution_Exception;
      end if;
      return Value.Element;
   end Get;


   function Promise
     (Self : in out Object)
      return Executor_Service.Callable_Ptr
   is
   begin
      -- don't seem to get away from an Unchecked_Access here
      return Executor_Service.Callable_Ptr'(Self'Unchecked_Access);
   end Promise;


   protected body Future_Data is

      procedure Put_Promise(Value : in Item)
      is
      begin
         -- only first promise will modify the value
         if Future_Data.Value.Is_Empty then
            Future_Data.Value.Replace_Element(Value);
         end if;
      end Put_Promise;

      procedure Timed_Out
      is
      begin
         Is_Timed_Out := True;
      end Timed_Out;

      entry Wait_For_Promise(Value : out Items.Holder; Timed_Out : out Boolean)
        when Is_Timed_Out or not Value.Is_Empty
      is
      begin
         if not Is_Timed_Out then
            Value :=Future_Data.Value;
         end if;
         Timed_Out := Is_Timed_Out;
      end Wait_For_Promise;

   end Future_Data;

end Futures;

