with Ada.Exceptions;
with Ada.Text_IO;
with App;
--with Interfaces.C;
--with System;

procedure Future_Test is

   The_App : App.Object;

--     function signal(sig: in interfaces.c.int;
--                     handler: system.address)
--        return system.address;
--     pragma Import(C, signal, "signal");
--
--     oldhandler: system.address;


begin
   -- For debugging purposes only.
   -- This will disable default signal handling in the GNAT Runtime,
   -- in order to produce a corefile instead of STORAGE_ERROR with empty trace.
   --oldhandler := signal(8, system.null_address);
   --oldhandler := signal(10, system.null_address);
   --oldhandler := signal(11, system.null_address);

--  for i in 1..1000000 loop
   The_App.Show_Search("foo");
--  end loop;
exception
   when e : others =>
      Ada.Text_IO.Put_Line("ERROR: " & Ada.Exceptions.Exception_Information(e));
end Future_Test;

