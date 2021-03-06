with Ada.Text_IO;                  use  Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Streams;                  use  Ada.Streams;
with System.IO;

with GNATCOLL.SQL.Sqlite;          use GNATCOLL.SQL.Sqlite;
with GNATCOLL.SQL.Exec;            use GNATCOLL.SQL.Exec;
with Database;                     use Database;

package body DB is

   procedure Store_Message (TM : in Stream_Element_Array) is   

      Message_String : String (1 .. 255);

      function To_String (S : Stream_Element_Array) return String is
         Result : String (1 .. S'Length);
      begin
         for I in Result'Range loop
            Result (I) :=
              Character'Val (Stream_Element'Pos
                             (S (Stream_Element_Offset (I) + S'First)));
            System.IO.Put_Line (Result);
         end loop;
         return Result;
      end To_String;

   begin

      Message_String := To_String (TM);
      
      Q := Gnatcoll.SQL.SQL_Insert (Values => (Raw_telemetry.message = Raw_TM_String));
      execute(DB, Q);
      DB.commit;

   end Store_Message;

end DB;
