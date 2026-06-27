<claude-mem-context>
# Memory Context

# [facorreia-site] recent context, 2026-06-27 3:12pm GMT+1

Legend: 🎯session 🔴bugfix 🟣feature 🔄refactor ✅change 🔵discovery ⚖️decision 🚨security_alert 🔐security_note
Format: ID TIME TYPE TITLE
Fetch details: get_observations([IDs]) | Search: mem-search skill

Stats: 50 obs (20,907t read) | 1,002,786t work | 98% savings

### May 8, 2026
S36 Visual polish pass on the bookmarks knowledge graph page — cyberpunk/sci-fi aesthetic enhancements (May 8 at 2:24 AM)
S35 Enhance bookmarks knowledge graph page with ambient visual effects: cosmic dust particles, scan-line animation, reactive link particles, and hub node enhancements (May 8 at 2:24 AM)
S63 Portfolio projects section redesigned with per-project shareable landing pages, starting with Norviq iOS app (May 8 at 12:23 PM)
### May 9, 2026
S106 Add LuminaVault to the projects list in facorreia-site — same card+detail pattern as Norviq, with landing-page style detail view emphasizing why/how, placeholder App Store and Play Store links (May 9 at 6:10 PM)
### May 10, 2026
1157 5:31p 🔵 LuminaVault Brand Identity and Mascot "Lumina" Documented
1159 " 🔵 LuminaAssets Image Dimensions Confirmed, No PNG Logos Found
1161 " 🟣 LuminaVault Added to facorreia-site Homepage Projects List
1162 5:35p 🟣 LuminaVault Icon Copied to facorreia-site Static Assets
1163 " 🟣 ProjectDetailContext Extended with Play Store Fields
1164 " 🟣 LuminaVault Detail Context Added to ProjectsController
1165 " ✅ Default Case in detailContext Updated for Play Store Fields
S149 Improve project detail banner size — make it smaller, more landing-page-style, and integrated into the hero (May 10 at 5:36 PM)
### May 11, 2026
1483 8:17a ✅ Banner UI Redesign — Reduced Size, Landing Page Style
1485 " 🟣 Project Detail Banner Merged into Hero Section as Backdrop
1487 8:18a 🟣 CSS for Project Detail Hero-Banner: Layered Image + Overlay + Content
S674 LuminaVault portfolio landing page redesign — App Store-style product page with futuristic sci-fi aesthetic, plus custom app icon planning (May 11 at 8:18 AM)
### May 29, 2026
9094 2:56p 🟣 LuminaVault Landing Page & App Icon Design Plan Initiated
9095 2:57p ✅ LuminaVault Landing Page Previous Implementation Reverted
9096 3:00p 🟣 LuminaVault Gets Dedicated Branded Leaf Template Route
9097 " 🟣 LuminaContext and LuminaStep View Models Defined for Branded Landing Page
9100 " 🟣 LuminaStep and LuminaContext Swift Structs Formally Declared
9101 " 🟣 project-luminavault.leaf Leaf Template Created with Full Page Structure
9102 3:01p 🔴 App Store Icon Leaf Component Dependency Replaced with Inline SVG
9103 3:02p 🟣 LuminaVault Page-Scoped CSS Design System Added to custom.css
9104 3:03p 🟣 LuminaVault Landing Page Verified Live — All Checks Pass
S680 LuminaVault landing page restyling — replace static chibi mascot/scene image with CSS app mockup inside phone widget, and fix service worker blocking CSS updates (May 29 at 3:03 PM)
9156 3:38p 🟣 LuminaVault Landing Page Redesign Planned for Portfolio
9158 3:39p 🟣 LuminaVault Phone Mockup Replaced with CSS-Rendered App UI
9160 " 🔵 Service Worker Cache-First Strategy Was Silently Blocking CSS Updates
9170 3:43p 🔵 Headless Browser Tooling Available on Dev Machine
9172 " 🔵 Headless Chrome Screenshot Pattern Established for LuminaVault Visual Verification
9175 " 🟣 LuminaVault Page CSS App Mockup Visually Verified via Headless Screenshots
9181 3:44p 🟣 LuminaVault Hero Refactored to Asymmetric Two-Column Layout
9182 3:45p 🟣 LuminaVault Hero CSS Updated to Asymmetric Two-Column Grid Layout
9195 7:36p 🟣 LuminaVault Landing Page & App Icon Design Brief — Portfolio Project
S683 LuminaVault /projects/lumina landing page restyle — futuristic sci-fi theme with mascot-matched app icon and dynamic portfolio landing page (May 29 at 7:38 PM)
### Jun 8, 2026
13542 8:31p 🔵 LuminaVault Branded Landing Page Structure
13543 " 🔵 In-Progress Git Changes: base.leaf and configure.swift Modified
13544 8:32p ⚖️ LuminaVault Pre-Launch Messaging Plan: 5-Step Implementation
13545 " 🔵 LuminaVault CSS Already Has .lv-steps Section Styles
13546 " 🔵 /book-call Route Uses Calendly Redirect with Env-Var Override
13547 8:33p 🔵 LuminaVault ProjectItem Confirmed Pre-Launch: hasLiveLink false, No App Store URL
13548 " 🟣 LuminaVault Pre-Launch Messaging Overhaul in ProjectsController.swift
13549 8:34p 🟣 LuminaVault Leaf Template Updated with TestFlight CTAs, Steps Section, and Comparison Section
13550 " 🟣 CSS Updated for Compare Section, Mascot Image, and 4-Column Steps Grid
13553 8:35p 🔵 facorreia-site Build Stack: Vapor 4 + Leaf + SQLite + Tailwind CLI, No Node
13554 " 🟣 LuminaVault Pre-Launch Messaging Implementation Builds Successfully
13555 " 🔵 Test Suite: "Test Projects Route" Fails — Asserts "portfolio tracker backend" String Not Found
13556 8:36p 🔴 Test Failure Root Cause: Stale Assertions Reference Removed Projects "StockPlan" and "portfolio tracker backend"
13557 " 🔴 Test Suite Now Fully Green: Projects Route Assertions Updated to Current Project Data
13558 " 🔵 swift run Fails in Agent Context: Clang Module Cache Permission Denied
13559 8:37p 🔵 Dev Server Starts Successfully with Escalated Sandbox Permissions
13560 " 🟣 LuminaVault Page Verified Live at http://127.0.0.1:8080/projects/luminavault — All Sections Render Correctly
13567 8:38p 🔴 Tailwind CSS Standalone CLI Binary Not Present at ./tailwindcss
13573 8:40p 🔴 Tailwind CSS Pipeline: Both `tailwindcss` and `Public/css/output.css` Are Git-Ignored — Docker Regenerates CSS at Build Time
13574 " 🔴 swift test: 3/3 Passing After All Changes — Full Verification Run
13575 " 🔴 Dev Server Process State: PID 34186 Dead But Session 34186 Alive — Server Still Responding on :8080
13576 8:42p 🔴 Final HTML Verification Passed: All 7 Content Strings Confirmed in Live Page

Access 1003k tokens of past work via get_observations([IDs]) or mem-search skill.
</claude-mem-context>