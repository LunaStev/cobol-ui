01 SCREEN ID "edit-user".
   05 HEADER.
      10 TEXT VALUE "Edit User".
   05 BODY.
      10 ROW.
         15 LABEL VALUE "Name".
         15 INPUT PIC X(20).
      10 ROW.
         15 LABEL VALUE "Email".
         15 INPUT PIC X(30).
      10 ROW.
         15 BUTTON VALUE "Save".
         15 BUTTON VALUE "Cancel".
