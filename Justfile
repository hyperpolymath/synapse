# SYNAPSE - Rust-to-SwiftUI Meta-Compiler
# ========================================
# A Zig-based code generator that bridges the Rust↔Swift divide.
#
# COMMANDS:
#   just build      - Build the Synapse binary
#   just gen-ui     - Generate Swift ViewModels from Rust structs
#   just test       - Run all tests
#   just clean      - Clean build artifacts
#   just help       - Show this help
#
# PHILOSOPHY:
#   When Apple changes SwiftUI syntax, you update Synapse templates.
#   Then run `just gen-ui`. The entire app is upgraded instantly.

# Default recipe - show help
default:
    @just --list

# Build the Synapse binary
build:
    zig build

# Generate SwiftUI ViewModels from Rust structs
# This is the main command you'll use in your workflow
gen-ui input="examples/rust/models.rs" output="examples/swift/Generated.swift" ios="17":
    @echo "🔄 Synapse: Generating SwiftUI bindings..."
    @zig build run -- --input {{input}} --output {{output}} --ios {{ios}}
    @echo "✓ Done! Check {{output}}"

# Generate with legacy ObservableObject (iOS 14-16 support)
gen-ui-legacy input="examples/rust/models.rs" output="examples/swift/Generated.swift":
    @echo "🔄 Synapse: Generating legacy SwiftUI bindings..."
    @zig build run -- --input {{input}} --output {{output}} --legacy-observable
    @echo "✓ Done! Check {{output}}"

# Run all tests
test:
    zig build test

# Clean build artifacts
clean:
    rm -rf zig-out .zig-cache

# Show help for Synapse CLI
help:
    @zig build run -- --help

# Development: watch for changes and rebuild
watch:
    @echo "Watching for changes... (Ctrl+C to stop)"
    @while true; do \
        find src -name "*.zig" | entr -d just build; \
    done

# Generate and copy to Xcode project
# Usage: just deploy-ios ~/MyApp/MyApp/Generated
deploy-ios dest:
    @just gen-ui
    @cp examples/swift/Generated.swift {{dest}}/Generated.swift
    @echo "✓ Deployed to {{dest}}"

# Lint Zig code
lint:
    zig fmt src/

# Show stats about generated code
stats:
    @echo "=== Synapse Statistics ==="
    @echo "Zig source files:"
    @find src -name "*.zig" | wc -l
    @echo "Lines of Zig code:"
    @find src -name "*.zig" -exec cat {} \; | wc -l
    @echo ""
    @echo "Generated Swift files:"
    @find examples/swift -name "*.swift" | wc -l
    @echo "Lines of generated Swift:"
    @find examples/swift -name "*.swift" -exec cat {} \; | wc -l 2>/dev/null || echo "0"

# ==========================================
# USAGE EXAMPLE FOR YOUR DRIFT PROJECT:
# ==========================================
#
# 1. Write your Rust structs in src/models/
#    #[derive(Synapse)]
#    pub struct PlayerState { ... }
#
# 2. Run the generator:
#    just gen-ui input=src/models/state.rs output=ios/DriftApp/Generated.swift
#
# 3. Import in Xcode and use:
#    @StateObject var player = PlayerStateViewModel()
#
# 4. When Apple changes SwiftUI (iOS 19+), update src/templates/swift_templates.zig
#    Then run `just gen-ui` - entire app is upgraded!
# ==========================================
