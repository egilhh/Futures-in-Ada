with Ada.Finalization;

generic
   type Element_Type(<>) is private;
   with function "=" (Left, Right : Element_Type) return Boolean is <>;
package Ada_Containers_Indefinite_Holders is
   pragma Preelaborate(Ada_Containers_Indefinite_Holders);
   
   type Holder is tagged private;
pragma Preelaborable_Initialization (Holder);

--   Empty_Holder : constant Holder;

--   function "=" (Left, Right : Holder) return Boolean;

--   function To_Holder (New_Item : Element_Type) return Holder;

   function Is_Empty (Container : Holder) return Boolean;

--   procedure Clear (Container : in out Holder);

   function Element (Container : Holder) return Element_Type;

   procedure Replace_Element (Container : in out Holder;
                               New_Item  : in     Element_Type);


private

  type Element_Access is access all Element_Type;

  type Holder is new Ada.Finalization.Controlled with record
      Element : Element_Access;
   end record;


   overriding procedure Adjust(Self : in out Holder);
   overriding procedure Finalize(Self : in out Holder);

end Ada_Containers_Indefinite_Holders;
