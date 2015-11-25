with Ada.Unchecked_Deallocation;

package body Ada_Containers_Indefinite_Holders is

   procedure Free is
     new Ada.Unchecked_Deallocation (Element_Type, Element_Access);

 procedure Adjust (Self : in out Holder) is
   begin
         Self.Element := new Element_Type'(Self.Element.all);
   end Adjust;

   -------------
   -- Element --
   -------------

   function Element (Container : Holder) return Element_Type is
   begin
      return Container.Element.all;
   end Element;

   --------------
   -- Finalize --
   --------------

   procedure Finalize (Self: in out Holder) is
   begin
      Free (Self.Element);
   end Finalize;

   --------------
   -- Is_Empty --
   --------------

   function Is_Empty (Container : Holder) return Boolean is
   begin
      return Container.Element = null;
   end Is_Empty;

 procedure Replace_Element
     (Container : in out Holder;
      New_Item  : Element_Type)
   is
   begin
      declare
         X : Element_Access := Container.Element;

         --  Element allocator may need an accessibility check in case actual
         --  type is class-wide or has access discriminants (RM 4.8(10.1) and
         --  AI12-0035).

         pragma Unsuppress (Accessibility_Check);

      begin
         Container.Element := new Element_Type'(New_Item);
         Free (X);
      end;
   end Replace_Element;
end Ada_Containers_Indefinite_Holders;
