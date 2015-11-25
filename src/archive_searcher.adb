package body Archive_Searcher is

   function Search
      (Self : in out Object;
       Search_For : in String)
       return String
   is
   begin
      return "bar";
   end Search;

end Archive_Searcher;
