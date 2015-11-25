with Ada.Text_IO;
with Futures;

package body App is


   procedure Show_Search
     (Self : in out Object;
      Target : String )
   is

      function Callable_String
        return String
      is
      begin
--         delay 10.0; -- for triggering timeout...
         return Self.Searcher.Search(Target);
      end Callable_String;

      package Future_String is
        new Futures(String);

      Future : Future_String.Object := Future_String.Create(Callable_String'Access);
   begin
      Self.Executor.Execute(Future.Promise);

      Self.Display_Other_Things;

      Self.Display_Text(Future.Get);
   exception
      when Future_String.Execution_Exception =>
         Ada.Text_IO.Put_Line("***Operation timed out");
         Self.Clean_Up;
   end Show_Search;


   procedure Display_Other_Things
     (Self : in out Object)
   is
   begin
      Ada.Text_IO.Put_Line("Display_Other_Things");
   end Display_Other_Things;


   procedure Display_Text
     (Self : in out Object;
      Text : in String)
   is
   begin
      Ada.Text_IO.Put_Line("Display_Text: " & Text);
   end Display_Text;


   procedure Clean_Up
     (Self : in out Object)
   is
   begin
      null;
   end Clean_Up;

end App;

