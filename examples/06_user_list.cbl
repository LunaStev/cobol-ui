*> cobol-ui declarative UI file

01 SCREEN ID "users".
   05 HEADER.
      10 TEXT VALUE "Users".
   05 BODY.
      10 ROW.
         15 TEXT VALUE "ID".
         15 TEXT VALUE "Name".
         15 TEXT VALUE "Email".
      10 ROW.
         15 TEXT VALUE "1".
         15 TEXT VALUE "Alice".
         15 TEXT VALUE "a@example.com".
