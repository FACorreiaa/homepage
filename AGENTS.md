<claude-mem-context>
# Memory Context

# [facorreia-site] recent context, 2026-06-08 8:31pm GMT+1

Legend: 🎯session 🔴bugfix 🟣feature 🔄refactor ✅change 🔵discovery ⚖️decision 🚨security_alert 🔐security_note
Format: ID TIME TYPE TITLE
Fetch details: get_observations([IDs]) | Search: mem-search skill

Stats: 50 obs (19,242t read) | 937,483t work | 98% savings

### May 8, 2026
218 2:24a 🟣 Added Background Particles Canvas and Scan-Line Animation to Bookmarks Graph View
S36 Visual polish pass on the bookmarks knowledge graph page — cyberpunk/sci-fi aesthetic enhancements (May 8 at 2:24 AM)
S35 Enhance bookmarks knowledge graph page with ambient visual effects: cosmic dust particles, scan-line animation, reactive link particles, and hub node enhancements (May 8 at 2:24 AM)
245 7:28a 🟣 Knowledge Graph UI Enhancement: Sci-Fi/Futuristic Visual Redesign Planned
246 " 🔵 Reference Screenshot Loaded: Sci-Fi Knowledge Graph UI
267 7:31a 🔵 Canvas2D Hub Node Rendering Bug Root Cause Identified
268 " ⚖️ Sci-Fi Enhancement Plan for Bookmarks Knowledge Graph
269 12:22p 🟣 Twinkling Animation Added to File Nodes in Knowledge Graph
271 " 🟣 Knowledge Graph Background Enhanced with Multi-Point Nebula Gradients
272 " 🟣 HUD Corner Brackets Animated with Pulsing Glow Keyframe
S63 Portfolio projects section redesigned with per-project shareable landing pages, starting with Norviq iOS app (May 8 at 12:23 PM)
### May 9, 2026
608 6:03p ⚖️ Portfolio Projects Redesign: Dedicated Landing Pages per Project
609 " ✅ Norviq App Icons Copied to Portfolio Static Assets
615 6:04p 🟣 ProjectsController Refactored to Support Per-Project Detail Routes and Rich Landing Page Contexts
617 " 🟣 Projects Index Leaf Template Redesigned with Clickable Card-v2 Layout
621 6:05p 🟣 New project-detail.leaf Leaf Template Created for Individual Project Landing Pages
624 " 🟣 CSS Added for Project Card v2 and Project Detail Page Styles
630 6:06p 🔵 Swift Build Succeeds After ProjectsController Refactor
631 6:09p 🔵 Vapor Dev Server Already Running on Port 8080 During Development
632 " 🔵 Running Server Serving Stale Binary — All New Routes Return 404
633 " 🔵 Port 8080 Occupied by a Different Project (FanAPI), Not facorreia-site
S106 Add LuminaVault to the projects list in facorreia-site — same card+detail pattern as Norviq, with landing-page style detail view emphasizing why/how, placeholder App Store and Play Store links (May 9 at 6:10 PM)
### May 10, 2026
1154 5:30p 🟣 LuminaVault Project Added to ObsidianClaudeBrain Projects List
1155 " 🔵 ObsidianClaudeBrain Repository Structure Revealed
1156 " 🔵 LuminaVault README Content and Assets Catalogued for Landing Page
1157 5:31p 🔵 LuminaVault Brand Identity and Mascot "Lumina" Documented
1158 " 🔵 LuminaVaultServer Architecture: Tenant-First Swift 6 Hummingbird Backend
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
**Investigated**: Existing /projects/lumina page structure within the facorreia-site portfolio project; current layout, section organization, and visual style; service worker caching issues that were causing stale CSS to appear unstyled in browser previews.

**Learned**: A stale `fc-studio-v1` service worker was caching old CSS, making every prior redesign iteration appear unstyled in the browser. The actual fix is: Safari → Develop → Empty Caches → reload twice (or manually unregister the service worker). Build pipeline is functional — pages return 200 and render correctly at desktop width when cache is cleared. Headless Chrome screenshots were used for render verification rather than relying on live browser previews.

**Completed**: - Hero section redesigned to asymmetric split layout: copy (eyebrow, wordmark, tagline, lede, App Store CTA + "Book a call", iOS 17+ meta strip) on the left, phone mock on the right
    - Removed duplicate content row — "How it works" steps that mirrored the Pillars cards were dropped
    - Story section converted to two-column framed panel (sticky heading left, prose right) replacing centered text wall
    - Section rhythm improved with kickers (The idea / Capabilities / Under the hood) and left-aligned headings
    - Section gaps tightened from 5.5–6rem down to 4.5rem to eliminate dead space
    - Build verified green, all sections (hero, value props, story, features grid, tech, CTA) render correctly at desktop width
    - Temp screenshot server started and stopped as part of render-test workflow

**Next Steps**: Awaiting user decision: commit current changes as-is, or adjust colors, copy, or app-mock content before committing. App icon (1024x1024 transparent background, LuminaVault chibi mascot) generation may still be pending as part of the original brief.


Access 937k tokens of past work via get_observations([IDs]) or mem-search skill.
</claude-mem-context>