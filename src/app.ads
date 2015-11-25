with Archive_Searcher;
with Executor_Service;

package App is

   type Object is tagged limited private;

   procedure Show_Search
     (Self : in out Object;
      Target : String );

private

   procedure Display_Other_Things
     (Self : in out Object);

   procedure Display_Text
     (Self : in out Object;
      Text : in String);

   procedure Clean_Up
     (Self : in out Object);

   type Object is tagged limited
      record
         Executor : Executor_Service.Object;
         Searcher : Archive_Searcher.Object;
      end record;

end App;

