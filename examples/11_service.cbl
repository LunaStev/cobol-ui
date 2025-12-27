01 SCREEN ID "app" CLASS "saas-app".
   05 HEADER ID "topbar" CLASS "topbar".
      10 ROW CLASS "topbar-row".
         15 COL CLASS "brand".
            20 TEXT VALUE "COBOL UI Studio" CLASS "brand-title".
            20 TEXT VALUE "Declarative UI → HTML generator" CLASS "brand-subtitle".
         15 COL CLASS "topnav".
            20 ROW CLASS "topnav-links".
               25 LINK VALUE "Dashboard" HREF "#dashboard" CLASS "nav-link".
               25 LINK VALUE "Users" HREF "#users" CLASS "nav-link".
               25 LINK VALUE "Billing" HREF "#billing" CLASS "nav-link".
               25 LINK VALUE "Settings" HREF "#settings" CLASS "nav-link".
               25 LINK VALUE "Support" HREF "#support" CLASS "nav-link".
         15 COL CLASS "userbox".
            20 ROW CLASS "userbox-row".
               25 IMAGE SRC "https://dummyimage.com/48x48/cccccc/000000.png&text=U" ALT "User avatar" CLASS "avatar".
               25 COL CLASS "user-meta".
                  30 TEXT VALUE "LunaStev" CLASS "user-name".
                  30 TEXT VALUE "workspace: wavefnd" CLASS "user-workspace".
               25 BUTTON VALUE "Sign out" TYPE "button" CLASS "btn secondary".

   05 BODY ID "dashboard" CLASS "layout".
      10 ROW CLASS "layout-row".

         15 COL ID "sidebar" CLASS "sidebar".
            20 TEXT VALUE "Workspace" CLASS "sidebar-title".
            20 LINK VALUE "Overview" HREF "#dashboard" CLASS "sidebar-link".
            20 LINK VALUE "Activity" HREF "#activity" CLASS "sidebar-link".
            20 LINK VALUE "Reports" HREF "#reports" CLASS "sidebar-link".
            20 LINK VALUE "Analytics" HREF "#analytics" CLASS "sidebar-link".
            20 TEXT VALUE "Projects" CLASS "sidebar-title".
            20 LINK VALUE "UI DSL" HREF "#project-ui" CLASS "sidebar-link".
            20 LINK VALUE "Compiler" HREF "#project-compiler" CLASS "sidebar-link".
            20 LINK VALUE "Website" HREF "#project-web" CLASS "sidebar-link".
            20 TEXT VALUE "Admin" CLASS "sidebar-title".
            20 LINK VALUE "Users" HREF "#users" CLASS "sidebar-link".
            20 LINK VALUE "Roles" HREF "#roles" CLASS "sidebar-link".
            20 LINK VALUE "Audit log" HREF "#audit" CLASS "sidebar-link".
            20 TEXT VALUE "Billing" CLASS "sidebar-title".
            20 LINK VALUE "Plans" HREF "#plans" CLASS "sidebar-link".
            20 LINK VALUE "Invoices" HREF "#invoices" CLASS "sidebar-link".
            20 LINK VALUE "Payment" HREF "#payment" CLASS "sidebar-link".
            20 TEXT VALUE "Support" CLASS "sidebar-title".
            20 LINK VALUE "Tickets" HREF "#support" CLASS "sidebar-link".
            20 LINK VALUE "Status" HREF "#status" CLASS "sidebar-link".
            20 LINK VALUE "Docs" HREF "#docs" CLASS "sidebar-link".

         15 COL ID "content" CLASS "content".

            20 COL CLASS "page-header".
               25 TEXT VALUE "Dashboard" CLASS "page-title".
               25 TEXT VALUE "Service-like demo page generated from a .cbl UI declaration." CLASS "page-desc".
               25 ROW CLASS "page-actions".
                  30 BUTTON VALUE "New Campaign" TYPE "button" CLASS "btn primary".
                  30 BUTTON VALUE "Invite User" TYPE "button" CLASS "btn".
                  30 LINK VALUE "Open docs" HREF "#docs" CLASS "btn linklike".

            20 ROW ID "kpi" CLASS "kpi-row".
               25 COL CLASS "card kpi-card".
                  30 TEXT VALUE "Active users" CLASS "kpi-label".
                  30 TEXT VALUE "12,048" CLASS "kpi-value".
                  30 TEXT VALUE "+4.2% vs last week" CLASS "kpi-sub".
               25 COL CLASS "card kpi-card".
                  30 TEXT VALUE "Requests / day" CLASS "kpi-label".
                  30 TEXT VALUE "1,920,331" CLASS "kpi-value".
                  30 TEXT VALUE "p95 latency 38ms" CLASS "kpi-sub".
               25 COL CLASS "card kpi-card".
                  30 TEXT VALUE "Errors" CLASS "kpi-label".
                  30 TEXT VALUE "0.12%" CLASS "kpi-value".
                  30 TEXT VALUE "last incident 18 days ago" CLASS "kpi-sub".
               25 COL CLASS "card kpi-card".
                  30 TEXT VALUE "Revenue" CLASS "kpi-label".
                  30 TEXT VALUE "$3,210" CLASS "kpi-value".
                  30 TEXT VALUE "MRR projection stable" CLASS "kpi-sub".

            20 ROW CLASS "grid-row".

               25 COL CLASS "card wide".
                  30 TEXT VALUE "Quick actions" CLASS "card-title".
                  30 ROW CLASS "quick-actions".
                     35 BUTTON VALUE "Build HTML" TYPE "button" CLASS "btn primary".
                     35 BUTTON VALUE "Validate DSL" TYPE "button" CLASS "btn".
                     35 BUTTON VALUE "Export examples" TYPE "button" CLASS "btn".
                     35 LINK VALUE "Release notes" HREF "#reports" CLASS "btn linklike".
                  30 TEXT VALUE "Tip: keep the DSL strict. Let the generator do the boring parts." CLASS "muted".

               25 COL CLASS "card".
                  30 TEXT VALUE "Notifications" CLASS "card-title".
                  30 ROW CLASS "notif".
                     35 TEXT VALUE "• build #184 succeeded" CLASS "mono".
                  30 ROW CLASS "notif".
                     35 TEXT VALUE "• new user signup: alice@example.com" CLASS "mono".
                  30 ROW CLASS "notif".
                     35 TEXT VALUE "• invoice paid: INV-2025-1201" CLASS "mono".
                  30 ROW CLASS "notif".
                     35 TEXT VALUE "• warning: rate limit near threshold" CLASS "mono".
                  30 LINK VALUE "See all notifications" HREF "#activity" CLASS "small-link".

            20 COL ID "activity" CLASS "card".
               25 TEXT VALUE "Recent activity" CLASS "card-title".
               25 ROW CLASS "table head".
                  30 TEXT VALUE "Time" CLASS "th".
                  30 TEXT VALUE "Actor" CLASS "th".
                  30 TEXT VALUE "Action" CLASS "th".
                  30 TEXT VALUE "Target" CLASS "th".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "09:12" CLASS "td".
                  30 TEXT VALUE "system" CLASS "td".
                  30 TEXT VALUE "deploy" CLASS "td".
                  30 TEXT VALUE "web-gateway" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "09:24" CLASS "td".
                  30 TEXT VALUE "LunaStev" CLASS "td".
                  30 TEXT VALUE "create" CLASS "td".
                  30 TEXT VALUE "campaign: winter-2025" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "10:01" CLASS "td".
                  30 TEXT VALUE "alice" CLASS "td".
                  30 TEXT VALUE "login" CLASS "td".
                  30 TEXT VALUE "console" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "10:13" CLASS "td".
                  30 TEXT VALUE "billing" CLASS "td".
                  30 TEXT VALUE "charge" CLASS "td".
                  30 TEXT VALUE "invoice INV-2025-1201" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "10:22" CLASS "td".
                  30 TEXT VALUE "security" CLASS "td".
                  30 TEXT VALUE "rotate" CLASS "td".
                  30 TEXT VALUE "api-key #7" CLASS "td".
               25 LINK VALUE "View full audit log" HREF "#audit" CLASS "small-link".

            20 COL ID "project-ui" CLASS "card".
               25 TEXT VALUE "Create campaign" CLASS "card-title".
               25 TEXT VALUE "A form-like section (still static HTML). Use it to test IDs, FOR, and input props." CLASS "muted".

               25 ROW CLASS "form-row".
                  30 COL CLASS "field".
                     35 LABEL VALUE "Campaign name" FOR "campaign-name".
                     35 INPUT PIC X(32) ID "campaign-name" NAME "campaign_name" PLACEHOLDER "winter-2025" TYPE "text".
                  30 COL CLASS "field".
                     35 LABEL VALUE "Channel" FOR "campaign-channel".
                     35 INPUT PIC X(16) ID "campaign-channel" NAME "channel" PLACEHOLDER "email / push / ads" TYPE "text".

               25 ROW CLASS "form-row".
                  30 COL CLASS "field".
                     35 LABEL VALUE "Start date" FOR "campaign-start".
                     35 INPUT PIC X(16) ID "campaign-start" NAME "start_date" TYPE "date".
                  30 COL CLASS "field".
                     35 LABEL VALUE "End date" FOR "campaign-end".
                     35 INPUT PIC X(16) ID "campaign-end" NAME "end_date" TYPE "date".

               25 ROW CLASS "form-row".
                  30 COL CLASS "field".
                     35 LABEL VALUE "Daily budget" FOR "campaign-budget".
                     35 INPUT PIC X(12) ID "campaign-budget" NAME "budget" TYPE "number" PLACEHOLDER "50".
                  30 COL CLASS "field".
                     35 LABEL VALUE "Currency" FOR "campaign-currency".
                     35 INPUT PIC X(8) ID "campaign-currency" NAME "currency" TYPE "text" PLACEHOLDER "USD".

               25 ROW CLASS "form-row".
                  30 COL CLASS "field".
                     35 LABEL VALUE "Landing URL" FOR "campaign-url".
                     35 INPUT PIC X(40) ID "campaign-url" NAME "landing_url" TYPE "url" PLACEHOLDER "https://example.com/landing".
                  30 COL CLASS "field".
                     35 LABEL VALUE "Contact email" FOR "campaign-email".
                     35 INPUT PIC X(32) ID "campaign-email" NAME "contact_email" TYPE "email" PLACEHOLDER "ops@example.com".

               25 ROW CLASS "form-row".
                  30 COL CLASS "field wide".
                     35 LABEL VALUE "Description" FOR "campaign-desc".
                     35 INPUT PIC X(64) ID "campaign-desc" NAME "description" TYPE "text" PLACEHOLDER "short summary…" CLASS "textarea-like".

               25 ROW CLASS "form-row".
                  30 COL CLASS "field".
                     35 LABEL VALUE "Enable tracking" FOR "campaign-track".
                     35 INPUT ID "campaign-track" TYPE "checkbox" NAME "tracking" CHECKED "true".
                  30 COL CLASS "field".
                     35 LABEL VALUE "Send test before launch" FOR "campaign-test".
                     35 INPUT ID "campaign-test" TYPE "checkbox" NAME "send_test".

               25 ROW CLASS "form-actions".
                  30 BUTTON VALUE "Create campaign" TYPE "submit" CLASS "btn primary".
                  30 BUTTON VALUE "Save draft" TYPE "button" CLASS "btn".
                  30 BUTTON VALUE "Reset" TYPE "reset" CLASS "btn secondary".
                  30 LINK VALUE "Learn campaign best practices" HREF "#docs" CLASS "btn linklike".

            20 COL ID "users" CLASS "card".
               25 TEXT VALUE "Users" CLASS "card-title".
               25 ROW CLASS "table head".
                  30 TEXT VALUE "ID" CLASS "th".
                  30 TEXT VALUE "Name" CLASS "th".
                  30 TEXT VALUE "Email" CLASS "th".
                  30 TEXT VALUE "Role" CLASS "th".
                  30 TEXT VALUE "Status" CLASS "th".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "u-001" CLASS "td".
                  30 TEXT VALUE "LunaStev" CLASS "td".
                  30 TEXT VALUE "owner@wavefnd.org" CLASS "td".
                  30 TEXT VALUE "Owner" CLASS "td".
                  30 TEXT VALUE "Active" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "u-002" CLASS "td".
                  30 TEXT VALUE "Alice" CLASS "td".
                  30 TEXT VALUE "alice@example.com" CLASS "td".
                  30 TEXT VALUE "Admin" CLASS "td".
                  30 TEXT VALUE "Active" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "u-003" CLASS "td".
                  30 TEXT VALUE "Bob" CLASS "td".
                  30 TEXT VALUE "bob@example.com" CLASS "td".
                  30 TEXT VALUE "Viewer" CLASS "td".
                  30 TEXT VALUE "Invited" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "u-004" CLASS "td".
                  30 TEXT VALUE "Charlie" CLASS "td".
                  30 TEXT VALUE "charlie@example.com" CLASS "td".
                  30 TEXT VALUE "Billing" CLASS "td".
                  30 TEXT VALUE "Suspended" CLASS "td".
               25 ROW CLASS "inline-actions".
                  30 BUTTON VALUE "Invite new user" TYPE "button" CLASS "btn primary".
                  30 LINK VALUE "Manage roles" HREF "#roles" CLASS "btn linklike".

            20 COL ID "roles" CLASS "card".
               25 TEXT VALUE "Roles & access" CLASS "card-title".
               25 ROW CLASS "table head".
                  30 TEXT VALUE "Role" CLASS "th".
                  30 TEXT VALUE "Permissions" CLASS "th".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "Owner" CLASS "td".
                  30 TEXT VALUE "all access" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "Admin" CLASS "td".
                  30 TEXT VALUE "manage users, deployments, settings" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "Billing" CLASS "td".
                  30 TEXT VALUE "invoices, payment methods, plan" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "Viewer" CLASS "td".
                  30 TEXT VALUE "read-only dashboards" CLASS "td".
               25 TEXT VALUE "Tip: later we can add a PERMISSION block and compile to policy JSON too." CLASS "muted".

            20 COL ID "audit" CLASS "card".
               25 TEXT VALUE "Audit log" CLASS "card-title".
               25 TEXT VALUE "A longer table to stress-test layout + pretty printing." CLASS "muted".
               25 ROW CLASS "table head".
                  30 TEXT VALUE "Seq" CLASS "th".
                  30 TEXT VALUE "Time" CLASS "th".
                  30 TEXT VALUE "Actor" CLASS "th".
                  30 TEXT VALUE "Event" CLASS "th".
                  30 TEXT VALUE "Meta" CLASS "th".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "0001" CLASS "td".
                  30 TEXT VALUE "08:01" CLASS "td".
                  30 TEXT VALUE "system" CLASS "td".
                  30 TEXT VALUE "startup" CLASS "td".
                  30 TEXT VALUE "cold boot ok" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "0002" CLASS "td".
                  30 TEXT VALUE "08:05" CLASS "td".
                  30 TEXT VALUE "scheduler" CLASS "td".
                  30 TEXT VALUE "job" CLASS "td".
                  30 TEXT VALUE "daily-report queued" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "0003" CLASS "td".
                  30 TEXT VALUE "08:12" CLASS "td".
                  30 TEXT VALUE "LunaStev" CLASS "td".
                  30 TEXT VALUE "update" CLASS "td".
                  30 TEXT VALUE "settings: theme=system" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "0004" CLASS "td".
                  30 TEXT VALUE "08:16" CLASS "td".
                  30 TEXT VALUE "security" CLASS "td".
                  30 TEXT VALUE "policy" CLASS "td".
                  30 TEXT VALUE "rate-limit tightened" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "0005" CLASS "td".
                  30 TEXT VALUE "08:30" CLASS "td".
                  30 TEXT VALUE "billing" CLASS "td".
                  30 TEXT VALUE "invoice" CLASS "td".
                  30 TEXT VALUE "generated INV-2025-1201" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "0006" CLASS "td".
                  30 TEXT VALUE "08:31" CLASS "td".
                  30 TEXT VALUE "billing" CLASS "td".
                  30 TEXT VALUE "payment" CLASS "td".
                  30 TEXT VALUE "card authorized" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "0007" CLASS "td".
                  30 TEXT VALUE "08:40" CLASS "td".
                  30 TEXT VALUE "deploy-bot" CLASS "td".
                  30 TEXT VALUE "deploy" CLASS "td".
                  30 TEXT VALUE "api v0.4.2" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "0008" CLASS "td".
                  30 TEXT VALUE "08:41" CLASS "td".
                  30 TEXT VALUE "deploy-bot" CLASS "td".
                  30 TEXT VALUE "healthcheck" CLASS "td".
                  30 TEXT VALUE "pass 200" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "0009" CLASS "td".
                  30 TEXT VALUE "08:52" CLASS "td".
                  30 TEXT VALUE "alice" CLASS "td".
                  30 TEXT VALUE "invite" CLASS "td".
                  30 TEXT VALUE "bob@example.com" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "0010" CLASS "td".
                  30 TEXT VALUE "09:03" CLASS "td".
                  30 TEXT VALUE "system" CLASS "td".
                  30 TEXT VALUE "backup" CLASS "td".
                  30 TEXT VALUE "snapshot ok" CLASS "td".

            20 COL ID "billing" CLASS "card".
               25 TEXT VALUE "Billing" CLASS "card-title".
               25 ROW CLASS "grid-row".
                  30 COL CLASS "card inner".
                     35 TEXT VALUE "Current plan" CLASS "kpi-label".
                     35 TEXT VALUE "Pro" CLASS "kpi-value".
                     35 TEXT VALUE "$29 / month" CLASS "muted".
                     35 BUTTON VALUE "Change plan" TYPE "button" CLASS "btn".
                  30 COL CLASS "card inner".
                     35 TEXT VALUE "Payment method" CLASS "kpi-label".
                     35 TEXT VALUE "Visa •••• 4242" CLASS "kpi-value".
                     35 TEXT VALUE "Expires 12/28" CLASS "muted".
                     35 BUTTON VALUE "Update card" TYPE "button" CLASS "btn".

            20 COL ID "plans" CLASS "card".
               25 TEXT VALUE "Plans" CLASS "card-title".
               25 ROW CLASS "grid-row".
                  30 COL CLASS "card inner".
                     35 TEXT VALUE "Free" CLASS "kpi-value".
                     35 TEXT VALUE "For experiments" CLASS "muted".
                     35 TEXT VALUE "• 1 project" CLASS "mono".
                     35 TEXT VALUE "• 100 builds/month" CLASS "mono".
                     35 BUTTON VALUE "Select" TYPE "button" CLASS "btn".
                  30 COL CLASS "card inner".
                     35 TEXT VALUE "Pro" CLASS "kpi-value".
                     35 TEXT VALUE "For small teams" CLASS "muted".
                     35 TEXT VALUE "• 10 projects" CLASS "mono".
                     35 TEXT VALUE "• 50k builds/month" CLASS "mono".
                     35 BUTTON VALUE "Selected" TYPE "button" CLASS "btn primary".
                  30 COL CLASS "card inner".
                     35 TEXT VALUE "Enterprise" CLASS "kpi-value".
                     35 TEXT VALUE "For big orgs" CLASS "muted".
                     35 TEXT VALUE "• unlimited" CLASS "mono".
                     35 TEXT VALUE "• SSO + audit" CLASS "mono".
                     35 BUTTON VALUE "Contact sales" TYPE "button" CLASS "btn".

            20 COL ID "invoices" CLASS "card".
               25 TEXT VALUE "Invoices" CLASS "card-title".
               25 ROW CLASS "table head".
                  30 TEXT VALUE "Invoice" CLASS "th".
                  30 TEXT VALUE "Date" CLASS "th".
                  30 TEXT VALUE "Amount" CLASS "th".
                  30 TEXT VALUE "Status" CLASS "th".
                  30 TEXT VALUE "Action" CLASS "th".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "INV-2025-1201" CLASS "td".
                  30 TEXT VALUE "2025-12-01" CLASS "td".
                  30 TEXT VALUE "$29.00" CLASS "td".
                  30 TEXT VALUE "Paid" CLASS "td".
                  30 LINK VALUE "Download" HREF "#download-inv-2025-1201" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "INV-2025-1101" CLASS "td".
                  30 TEXT VALUE "2025-11-01" CLASS "td".
                  30 TEXT VALUE "$29.00" CLASS "td".
                  30 TEXT VALUE "Paid" CLASS "td".
                  30 LINK VALUE "Download" HREF "#download-inv-2025-1101" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "INV-2025-1001" CLASS "td".
                  30 TEXT VALUE "2025-10-01" CLASS "td".
                  30 TEXT VALUE "$29.00" CLASS "td".
                  30 TEXT VALUE "Paid" CLASS "td".
                  30 LINK VALUE "Download" HREF "#download-inv-2025-1001" CLASS "td".

            20 COL ID "payment" CLASS "card".
               25 TEXT VALUE "Update payment method" CLASS "card-title".
               25 ROW CLASS "form-row".
                  30 COL CLASS "field".
                     35 LABEL VALUE "Card number" FOR "card-number".
                     35 INPUT PIC X(24) ID "card-number" TYPE "text" PLACEHOLDER "4242 4242 4242 4242".
                  30 COL CLASS "field".
                     35 LABEL VALUE "Name on card" FOR "card-name".
                     35 INPUT PIC X(24) ID "card-name" TYPE "text" PLACEHOLDER "LunaStev".
               25 ROW CLASS "form-row".
                  30 COL CLASS "field".
                     35 LABEL VALUE "Expiry" FOR "card-exp".
                     35 INPUT PIC X(8) ID "card-exp" TYPE "text" PLACEHOLDER "12/28".
                  30 COL CLASS "field".
                     35 LABEL VALUE "CVC" FOR "card-cvc".
                     35 INPUT PIC X(6) ID "card-cvc" TYPE "password" PLACEHOLDER "123".
               25 ROW CLASS "form-actions".
                  30 BUTTON VALUE "Save payment method" TYPE "submit" CLASS "btn primary".
                  30 BUTTON VALUE "Cancel" TYPE "button" CLASS "btn secondary".

            20 COL ID "settings" CLASS "card".
               25 TEXT VALUE "Settings" CLASS "card-title".
               25 ROW CLASS "form-row".
                  30 COL CLASS "field".
                     35 LABEL VALUE "Workspace name" FOR "ws-name".
                     35 INPUT PIC X(24) ID "ws-name" TYPE "text" PLACEHOLDER "wavefnd".
                  30 COL CLASS "field".
                     35 LABEL VALUE "Public page" FOR "ws-public".
                     35 INPUT PIC X(32) ID "ws-public" TYPE "url" PLACEHOLDER "https://example.com/wavefnd".
               25 ROW CLASS "form-row".
                  30 COL CLASS "field".
                     35 LABEL VALUE "Enable email alerts" FOR "set-email".
                     35 INPUT ID "set-email" TYPE "checkbox" NAME "email_alerts" CHECKED "true".
                  30 COL CLASS "field".
                     35 LABEL VALUE "Enable SMS alerts" FOR "set-sms".
                     35 INPUT ID "set-sms" TYPE "checkbox" NAME "sms_alerts".
               25 ROW CLASS "form-row".
                  30 COL CLASS "field".
                     35 LABEL VALUE "Strict mode (parser)" FOR "set-strict".
                     35 INPUT ID "set-strict" TYPE "checkbox" NAME "strict_mode" CHECKED "true".
                  30 COL CLASS "field".
                     35 LABEL VALUE "Experimental features" FOR "set-exp".
                     35 INPUT ID "set-exp" TYPE "checkbox" NAME "experimental".
               25 ROW CLASS "form-actions".
                  30 BUTTON VALUE "Save settings" TYPE "submit" CLASS "btn primary".
                  30 LINK VALUE "Read configuration docs" HREF "#docs" CLASS "btn linklike".

            20 COL ID "support" CLASS "card".
               25 TEXT VALUE "Support ticket" CLASS "card-title".
               25 TEXT VALUE "Write a ticket-like form. Later you can compile it to JSON for an API." CLASS "muted".
               25 ROW CLASS "form-row".
                  30 COL CLASS "field".
                     35 LABEL VALUE "Subject" FOR "ticket-subject".
                     35 INPUT PIC X(40) ID "ticket-subject" TYPE "text" PLACEHOLDER "Build fails on Linux".
                  30 COL CLASS "field".
                     35 LABEL VALUE "Priority" FOR "ticket-priority".
                     35 INPUT PIC X(10) ID "ticket-priority" TYPE "text" PLACEHOLDER "low / medium / high".
               25 ROW CLASS "form-row".
                  30 COL CLASS "field wide".
                     35 LABEL VALUE "Message" FOR "ticket-message".
                     35 INPUT PIC X(64) ID "ticket-message" TYPE "text" PLACEHOLDER "Describe the issue…" CLASS "textarea-like".
               25 ROW CLASS "form-row".
                  30 COL CLASS "field".
                     35 LABEL VALUE "Email" FOR "ticket-email".
                     35 INPUT PIC X(32) ID "ticket-email" TYPE "email" PLACEHOLDER "you@example.com".
                  30 COL CLASS "field".
                     35 LABEL VALUE "Attach log URL" FOR "ticket-log".
                     35 INPUT PIC X(40) ID "ticket-log" TYPE "url" PLACEHOLDER "https://paste.example.com/..." .
               25 ROW CLASS "form-actions".
                  30 BUTTON VALUE "Submit ticket" TYPE "submit" CLASS "btn primary".
                  30 BUTTON VALUE "Clear" TYPE "reset" CLASS "btn secondary".
                  30 LINK VALUE "Check service status" HREF "#status" CLASS "btn linklike".

            20 COL ID "status" CLASS "card".
               25 TEXT VALUE "Service status" CLASS "card-title".
               25 ROW CLASS "table head".
                  30 TEXT VALUE "Component" CLASS "th".
                  30 TEXT VALUE "Status" CLASS "th".
                  30 TEXT VALUE "Note" CLASS "th".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "API" CLASS "td".
                  30 TEXT VALUE "Operational" CLASS "td".
                  30 TEXT VALUE "p95 38ms" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "Web" CLASS "td".
                  30 TEXT VALUE "Operational" CLASS "td".
                  30 TEXT VALUE "deploy ok" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "Billing" CLASS "td".
                  30 TEXT VALUE "Operational" CLASS "td".
                  30 TEXT VALUE "no backlog" CLASS "td".
               25 ROW CLASS "table row".
                  30 TEXT VALUE "Email" CLASS "td".
                  30 TEXT VALUE "Degraded" CLASS "td".
                  30 TEXT VALUE "provider throttling" CLASS "td".

            20 COL ID "docs" CLASS "card".
               25 TEXT VALUE "Docs (demo)" CLASS "card-title".
               25 TEXT VALUE "This section exists to show deep pages without writing any HTML." CLASS "muted".
               25 TEXT VALUE "• Use 01/05/10 levels as nesting." CLASS "mono".
               25 TEXT VALUE "• End every statement with a dot." CLASS "mono".
               25 TEXT VALUE "• Use ID/CLASS + custom props (HREF/SRC/TYPE/NAME/PLACEHOLDER...)." CLASS "mono".
               25 TEXT VALUE "• Keep it strict; generators love strict input." CLASS "mono".
               25 LINK VALUE "Back to top" HREF "#dashboard" CLASS "small-link".

   05 FOOTER ID "footer" CLASS "footer".
      10 ROW CLASS "footer-row".
         15 COL CLASS "footer-left".
            20 TEXT VALUE "cobol-ui demo — generated UI from .cbl" CLASS "muted".
            20 TEXT VALUE "Not a real service, but structured like one." CLASS "muted".
         15 COL CLASS "footer-right".
            20 ROW CLASS "footer-links".
               25 LINK VALUE "GitHub" HREF "https://github.com/" CLASS "small-link".
               25 LINK VALUE "License" HREF "#license" CLASS "small-link".
               25 LINK VALUE "Privacy" HREF "#privacy" CLASS "small-link".
               25 LINK VALUE "Terms" HREF "#terms" CLASS "small-link".
