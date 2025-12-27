01 SCREEN NOSTYLE "true" ID "home".
   05 HEADER.
      10 CENTER.
         15 TEXT AS "h1" VALUE "Neo Park's Home Page".
         15 TEXT VALUE "Last updated: 1998-07-14".
         15 HR.
         15 MARQUEE BEHAVIOR "alternate" SCROLLAMOUNT "6" VALUE "★ Welcome to my personal homepage! ★".
         15 BR.
         15 IMAGE SRC "https://dummyimage.com/468x60/000000/ffffff.png&text=NEO+PARK+%7C+HACK+THE+PLANET" ALT "banner".
         15 BR.
         15 TEXT VALUE "Best viewed with Netscape Navigator 4.0 / Internet Explorer 4.0 at 800x600".
         15 HR.

   05 BODY.
      10 CENTER.
         15 TEXT VALUE "[ navigation ]".
         15 LINK VALUE "About" HREF "#about".
         15 TEXT VALUE " | ".
         15 LINK VALUE "Specs" HREF "#specs".
         15 TEXT VALUE " | ".
         15 LINK VALUE "Projects" HREF "#projects".
         15 TEXT VALUE " | ".
         15 LINK VALUE "Links" HREF "#links".
         15 TEXT VALUE " | ".
         15 LINK VALUE "Guestbook" HREF "#guestbook".
         15 TEXT VALUE " | ".
         15 LINK VALUE "Contact" HREF "#contact".
      10 HR.

      10 TEXT AS "h2" ID "about" VALUE "About Me".
      10 TEXT VALUE "Hi! I'm Neo Park (fictional). I like low-level programming, retro computers, and strange ideas.".
      10 TEXT VALUE "This page is generated from a COBOL-like UI declaration (.cbl) into plain HTML (no CSS!).".
      10 BR.
      10 TEXT VALUE "I believe code should be readable like a document. That's why I'm experimenting with a declarative syntax.".
      10 HR.

      10 TEXT AS "h2" VALUE "My Philosophy (1990s style)".
      10 LIST.
         15 ITEM.
            20 TEXT VALUE "I write programs that survive longer than trends.".
         15 ITEM.
            20 TEXT VALUE "I prefer clarity over cleverness.".
         15 ITEM.
            20 TEXT VALUE "I like tools that generate boring output so humans can focus on ideas.".
         15 ITEM.
            20 TEXT VALUE "If something can be described as a form, it should be written like a form.".
      10 HR.

      10 TEXT AS "h2" ID "specs" VALUE "My Computer Specs".
      10 TEXT VALUE "This is a fictional 1998-ish setup for maximum nostalgia:".
      10 TABLE BORDER "1" CELLPADDING "6" CELLSPACING "0" WIDTH "90%".
         15 TR.
            20 TD.
               25 TEXT VALUE "CPU".
            20 TD.
               25 TEXT VALUE "Pentium II 400MHz (dreaming of 450MHz)".
         15 TR.
            20 TD.
               25 TEXT VALUE "RAM".
            20 TD.
               25 TEXT VALUE "128MB SDRAM (yes, that's HUGE)".
         15 TR.
            20 TD.
               25 TEXT VALUE "HDD".
            20 TD.
               25 TEXT VALUE "8GB Ultra ATA (making weird noises)".
         15 TR.
            20 TD.
               25 TEXT VALUE "OS".
            20 TD.
               25 TEXT VALUE "Windows 98 SE + a secret Linux partition".
         15 TR.
            20 TD.
               25 TEXT VALUE "Browser".
            20 TD.
               25 TEXT VALUE "Netscape Navigator 4.7".
         15 TR.
            20 TD.
               25 TEXT VALUE "Modem".
            20 TD.
               25 TEXT VALUE "56k dial-up (DO NOT pick up the phone!)".
      10 HR.

      10 TEXT AS "h2" VALUE "ASCII Art".
      10 TEXT AS "pre" VALUE "      _   _            \n     | \\ | | ___  ___  \n     |  \\| |/ _ \\/ _ \\ \n     | |\\  |  __/ (_) |\n     |_| \\_|\\___|\\___/ \n\n  'This is fine.'  (but on dial-up)\n".
      10 HR.

      10 TEXT AS "h2" ID "projects" VALUE "Projects".
      10 TEXT VALUE "A list of totally real projects (fictional) that a 90s dev would brag about:".
      10 TABLE BORDER "1" CELLPADDING "6" CELLSPACING "0" WIDTH "95%".
         15 TR.
            20 TD.
               25 TEXT VALUE "Project".
            20 TD.
               25 TEXT VALUE "Description".
            20 TD.
               25 TEXT VALUE "Status".
         15 TR.
            20 TD.
               25 TEXT VALUE "BBS-NG".
            20 TD.
               25 TEXT VALUE "A bulletin board system with ANSI art and message threads.".
            20 TD.
               25 TEXT VALUE "Online".
         15 TR.
            20 TD.
               25 TEXT VALUE "PacketLogger".
            20 TD.
               25 TEXT VALUE "Logs packets and prints them like a receipt. Very serious.".
            20 TD.
               25 TEXT VALUE "Beta".
         15 TR.
            20 TD.
               25 TEXT VALUE "COBOL-UI".
            20 TD.
               25 TEXT VALUE "COBOL-like declarative UI → HTML generator (this page!)".
            20 TD.
               25 TEXT VALUE "Experimental".
         15 TR.
            20 TD.
               25 TEXT VALUE "UnderConstruction 3000".
            20 TD.
               25 TEXT VALUE "Generates under construction banners automatically.".
            20 TD.
               25 TEXT VALUE "Always".
      10 BR.
      10 IMAGE SRC "https://dummyimage.com/200x40/ff0000/ffffff.png&text=UNDER+CONSTRUCTION" ALT "under construction".
      10 HR.

      10 TEXT AS "h2" ID "links" VALUE "Cool Links".
      10 LIST.
         15 ITEM.
            20 LINK VALUE "The HTML 4.0 Spec (pretend)" HREF "https://www.w3.org/".
         15 ITEM.
            20 LINK VALUE "Linux (the future!)" HREF "https://www.kernel.org/".
         15 ITEM.
            20 LINK VALUE "Retro computing club" HREF "#".
         15 ITEM.
            20 LINK VALUE "My favorite ASCII art archive" HREF "#".
      10 TEXT VALUE "If a link is broken, that's authentic.".
      10 HR.

      10 TEXT AS "h2" ID "guestbook" VALUE "Guestbook".
      10 TEXT VALUE "Sign my guestbook! (Not real, static HTML for now.)".
      10 TABLE BORDER "1" CELLPADDING "6" CELLSPACING "0" WIDTH "95%".
         15 TR.
            20 TD.
               25 TEXT VALUE "Name".
            20 TD.
               25 TEXT VALUE "Message".
            20 TD.
               25 TEXT VALUE "Date".
         15 TR.
            20 TD.
               25 TEXT VALUE "Alice".
            20 TD.
               25 TEXT VALUE "Nice homepage! Love the marquee.".
            20 TD.
               25 TEXT VALUE "1998-06-02".
         15 TR.
            20 TD.
               25 TEXT VALUE "Bob".
            20 TD.
               25 TEXT VALUE "I waited 3 minutes on dial-up to load this. Worth it.".
            20 TD.
               25 TEXT VALUE "1998-06-19".
         15 TR.
            20 TD.
               25 TEXT VALUE "Charlie".
            20 TD.
               25 TEXT VALUE "The under construction sign is my spirit animal.".
            20 TD.
               25 TEXT VALUE "1998-07-01".
      10 HR.

      10 TEXT AS "h2" ID "contact" VALUE "Contact".
      10 TEXT VALUE "Email me (fictional):".
      10 LINK VALUE "neo.park@example.com" HREF "mailto:neo.park@example.com".
      10 BR.
      10 TEXT VALUE "ICQ: 1234567  |  AIM: neoPark98  |  MSN: neo_park_98".
      10 BR.
      10 TEXT VALUE "If you call my phone while I'm online, the internet will explode.".
      10 HR.

      10 CENTER.
         15 TEXT VALUE "Visitor Counter:".
         15 IMAGE SRC "https://dummyimage.com/120x30/000000/00ff00.png&text=000123" ALT "counter".
         15 BR.
         15 TEXT VALUE "© 1998 Neo Park. All rights reserved. (Do people even enforce this?)".
         15 BR.
         15 LINK VALUE "[Back to top]" HREF "#home".

   05 FOOTER.
      10 HR.
      10 CENTER.
         15 TEXT VALUE "Made with cobol-ui (COBOL-like UI DSL) → HTML".
         15 TEXT VALUE "No CSS. No frameworks. Pure nostalgia.".
