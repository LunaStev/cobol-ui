*> cobol-ui declarative UI file

01 SCREEN ID "signup".
   05 HEADER.
      10 TEXT VALUE "Sign up".
   05 BODY.
      10 ROW.
         15 LABEL VALUE "Email".
         15 INPUT PIC X(30) TYPE "email".
      10 ROW.
         15 LABEL VALUE "Password".
         15 INPUT PIC X(20) TYPE "password".
      10 ROW.
         15 LABEL VALUE "Confirm".
         15 INPUT PIC X(20) TYPE "password".
      10 ROW.
         15 BUTTON VALUE "Create account".
