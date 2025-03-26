with Ada.Text_IO;
with Ada.Float_Text_IO;
with Ada.Integer_Text_IO;

procedure Calculator is
   -- Değişken türü
   type Variable_Type is record
      Name : String(1..10);  -- Değişken adı
      Value : Float;         -- Değişkenin değeri
   end record;

   -- Değişkenler dizisini 10 değişkenle sınırlı tuttum.
   type Variable_Array is array(1..10) of Variable_Type;
   Variables : Variable_Array;
   
   -- Değişkeni bulan fonksiyon
   function Find_Variable(Name : String) return Integer is
      Index : Integer := 0;
   begin
      for I in 1..10 loop
         if Variables(I).Name = Name then
            Index := I;
            return Index;
         end if;
      end loop;
      return 0;  -- Değişken bulunamazsa 0 döner
   end Find_Variable;

   -- Değişkene değer atayan fonksiyon
   procedure Assign_Variable(Name : String; Value : Float) is
      Index : Integer := Find_Variable(Name);
   begin
      if Index = 0 then
         -- İlk boş yeri bul
         for I in 1..10 loop
            if Variables(I).Name = "" then
               Variables(I).Name := Name;
               Variables(I).Value := Value;
               return;
            end if;
         end loop;
      else
         -- Eğer değişken varsa değerini güncelle
         Variables(Index).Value := Value;
      end if;
   end Assign_Variable;

   -- İşlem değerlendirme fonksiyonu
   function Evaluate(Expression : String) return Float is
      Left_Value, Right_Value, Result : Float;
      Left_Operand, Right_Operand : String(1..10);
      Operator : Character;
      Index : Integer;
   begin
      -- İfadeyi soldaki sayı, operatör ve sağdaki sayı olarak ayır
      for I in 1..Expression'Length loop
         if Expression(I) = '+' or else Expression(I) = '-' or else
            Expression(I) = '*' or else Expression(I) = '/' then
            Operator := Expression(I);
            Left_Operand := Expression(1..I-1);
            Right_Operand := Expression(I+1..Expression'Length);
            exit;
         end if;
      end loop;

      -- Soldaki sayıyı değerlendir
      Index := Find_Variable(Left_Operand);
      if Index /= 0 then
         Left_Value := Variables(Index).Value;
      else
         Left_Value := Float'Value(Left_Operand);
      end if;

      -- Sağdaki sayıyı değerlendir
      Index := Find_Variable(Right_Operand);
      if Index /= 0 then
         Right_Value := Variables(Index).Value;
      else
         Right_Value := Float'Value(Right_Operand);
      end if;

      -- İşlemi gerçekleştir
      case Operator is
         when '+' => Result := Left_Value + Right_Value;
         when '-' => Result := Left_Value - Right_Value;
         when '*' => Result := Left_Value * Right_Value;
         when '/' =>
            if Right_Value = 0.0 then
               raise Constraint_Error with "Sifira bolunmez.";
            else
               Result := Left_Value / Right_Value;
            end if;
         when others => raise Program_Error with "Gecersiz operator";
      end case;

      return Result;
   end Evaluate;
