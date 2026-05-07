# FacorreiaSite Makefile
# =========================================================================
# Usage:
#   make setup      - Download Tailwind CSS CLI + Basecoat CSS
#   make dev        - Start dev server + Tailwind watch
#   make build      - Build production binary + minified CSS
#   make css        - Build CSS once
#   make clean      - Remove build artifacts
# =========================================================================

PROJECT_NAME := FacorreiaSite

.PHONY: all build run css css-watch css-minify dev setup clean help sync-vault sync-vault-restart sync-vault-local

all: build

# =========================================================================
# Setup & Dependencies
# =========================================================================

setup: ## Download Tailwind CSS CLI + Basecoat CSS (no node_modules)
	@echo "📥 Installing Tailwind CSS standalone CLI..."
	@mkdir -p Public/css
	@cd Public && curl -sL daisyui.com/fast | bash
	@mv Public/tailwindcss tailwindcss 2>/dev/null || true
	@echo "📥 Downloading Basecoat CSS..."
	@curl -sL -o Public/css/basecoat.min.css https://cdn.jsdelivr.net/npm/basecoat-css@latest/dist/basecoat.min.css
	@echo "🧹 Cleaning up DaisyUI files..."
	@rm -f Public/input.css Public/output.css Public/daisyui.mjs Public/daisyui-theme.mjs 2>/dev/null || true
	@echo ""
	@echo "✅ Setup complete! Run 'make dev' to start development."

# =========================================================================
# CSS
# =========================================================================

css: ## Build CSS once
	@./tailwindcss -i Public/css/input.css -o Public/css/output.css

css-watch: ## Build CSS in watch mode
	@./tailwindcss -i Public/css/input.css -o Public/css/output.css --watch

css-minify: ## Build CSS minified (production)
	@./tailwindcss -i Public/css/input.css -o Public/css/output.css --minify

# =========================================================================
# Development
# =========================================================================

dev: ## Start dev server + Tailwind watch in parallel
	@echo "🚀 Starting development (Swift + Tailwind watch)..."
	@make -j2 dev-server dev-css

dev-server:
	@swift run $(PROJECT_NAME) serve --hostname 0.0.0.0 --port 8080

dev-css:
	@sleep 2 && ./tailwindcss -i Public/css/input.css -o Public/css/output.css --watch

# =========================================================================
# Build
# =========================================================================

build: css-minify ## Build production binary + minified CSS
	@echo "🔨 Building Swift binary..."
	swift build -c release
	@echo "✅ Build complete!"

run: build ## Build and run the application
	@./.build/release/$(PROJECT_NAME) serve --hostname 0.0.0.0 --port 8080

# =========================================================================
# Clean
# =========================================================================

clean: ## Remove build artifacts
	rm -rf .build/
	rm -f Public/css/output.css
	rm -f tailwindcss

# =========================================================================
# Vault Sync (Obsidian notes)
# =========================================================================

HERMES_HOST   := root@78.46.192.73
HERMES_VAULT  := ~/.hermes/obsidian-vault/FACorreia/raw/
HOMEPAGE_HOST := root@49.13.165.238
HOMEPAGE_VAULT := /var/www/homepage/vault/raw/

sync-vault: ## Sync Obsidian vault from Hermes → Homepage server
	@echo "📚 Syncing vault from Hermes to Homepage server..."
	ssh $(HERMES_HOST) "rsync -avz --delete \
		--exclude='.*' \
		--exclude='*sync-conflict*' \
		$(HERMES_VAULT) $(HOMEPAGE_HOST):$(HOMEPAGE_VAULT)"
	@echo "✅ Vault synced!"

sync-vault-restart: sync-vault ## Sync vault + restart the container
	@echo "🔄 Restarting container..."
	ssh $(HOMEPAGE_HOST) "cd /var/www/homepage && docker compose restart app"
	@echo "✅ Done!"

sync-vault-local: ## Sync vault from local machine → Homepage server
	@echo "📚 Syncing local vault to Homepage server..."
	rsync -avz --delete \
		--exclude='.*' \
		--exclude='*sync-conflict*' \
		/Users/fernando_idwell/Developer/Vaults/FACorreia/raw/ \
		$(HOMEPAGE_HOST):$(HOMEPAGE_VAULT)
	@echo "✅ Vault synced!"

# =========================================================================
# Help
# =========================================================================

help: ## Show this help message
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

