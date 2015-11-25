This is a proof-of-concept implementation of futures in Ada.

It tries to mimic the syntax and behaviour of the Future described here:
https://docs.oracle.com/javase/7/docs/api/java/util/concurrent/Future.html
The first example didn't seem to pan out, however, so I settled on the
syntax of the second example. (executor.execute instead of executor.submit)

I ended up with this syntax:
```
   procedure Show_Search
     (Self : in out Object;
      Target : String )
   is

      function Callable_String
        return String
      is
      begin
         return Self.Searcher.Search(Target);
      end Callable_String;

      package Future_String is
        new Futures(String);

      Future : Future_String.Object := Future_String.Create
         (Callable_String'Access);
   begin
      Self.Executor.Execute(Future.Promise);

      Self.Display_Other_Things;

      Self.Display_Text(Future.Get);
   exception
      when Future_String.Execution_Exception =>
         Ada.Text_IO.Put_Line("***Operation timed out");
         Self.Clean_Up;
   end Show_Search;
```

Note: My Raspberry Pi don't fully support Ada 2012 at the moment,
so I hacked my own version of Ada.Containers.Indefinite_Holders.
This should be changed to the real deal, where present.
