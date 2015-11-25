package Archive_Searcher is

   type Object is tagged null record;

   function Search
     (Self : in out Object;
      Search_For : in String)
      return String;

end Archive_Searcher;

