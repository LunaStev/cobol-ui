*> cobol-ui declarative UI file

01 SCREEN ID "login".
   05 HEADER.
      10 TEXT VALUE "Login".
   05 BODY.
      10 ROW.
         15 LABEL VALUE "User".
         15 INPUT PIC X(20) NAME "user".
      10 ROW.
         15 LABEL VALUE "Password".
         15 INPUT PIC X(20) TYPE "password" NAME "password".
      10 ROW.
         15 BUTTON VALUE "Sign in" TYPE "submit".
