;; SPDX-License-Identifier: MIT
;; SPDX-FileCopyrightText: 2024 Synapse Contributors
;;
;; STATE.scm - AI Session Checkpoint for Synapse
;; Format: https://github.com/hyperpolymath/state.scm
;;
;; This file preserves AI conversation context across sessions.
;; Re-reading this file restores project state without token waste.

(define state-version "1.0.0")

;; ============================================
;; METADATA
;; ============================================
(define metadata
  '((format-version . "1.0.0")
    (created . "2024-12-08")
    (last-modified . "2024-12-08")
    (project . "synapse")
    (repository . "hyperpolymath/synapse")))

;; ============================================
;; USER CONTEXT
;; ============================================
(define user-context
  '((role . "maintainer")
    (preferences
      (language . "en")
      (tools . ("zig" "just" "git"))
      (workflow . "rsr-gold-compliant"))
    (principles
      ("single-source-of-truth" . "Rust defines the World, Swift is interface")
      ("template-based" . "Update templates once, regenerate everywhere")
      ("zero-runtime" . "Build-time only, no runtime overhead"))))

;; ============================================
;; SESSION CONTEXT
;; ============================================
(define session-context
  '((session-id . "state-scm-init")
    (purpose . "Document project state for AI session continuity")
    (token-status . "fresh")))

;; ============================================
;; CURRENT FOCUS
;; ============================================
(define focus
  '((project . "synapse")
    (phase . "alpha-development")
    (milestone . "v0.2.0")
    (blockers
      ("generic-extraction" . "Vec<T> and Option<T> lose inner type")
      ("platform-verification" . "Build not tested on all targets"))))

;; ============================================
;; PROJECT CATALOG
;; ============================================
(define projects
  '(;; Core Synapse
    (synapse-core
      (status . in-progress)
      (completion . 35)
      (category . "meta-compiler")
      (phase . "alpha")
      (description . "Rust-to-SwiftUI ViewModel generator")
      (dependencies . ())
      (blockers
        ("generic-type-extraction" . "Vec<String> becomes [Any] not [String]")
        ("optional-type-extraction" . "Option<T> becomes Any? not T?")
        ("enum-support" . "Rust enums not yet parseable")
        ("nested-structs" . "Struct fields with struct types not handled"))
      (next-actions
        "Implement generic parameter extraction in rust_parser.zig"
        "Add enum parsing support"
        "Write comprehensive parser tests"))

    ;; Parser Module
    (rust-parser
      (status . in-progress)
      (completion . 60)
      (category . "parser")
      (phase . "functional")
      (description . "Parses Rust struct definitions with derive attributes")
      (dependencies . ())
      (implemented
        "Basic struct parsing"
        "Derive attribute extraction (Synapse, DriftUI, SwiftBridge)"
        "Field name and type extraction"
        "Doc comment preservation"
        "Visibility modifier handling"
        "Primitive type recognition")
      (missing
        "Generic type parameter extraction"
        "Enum parsing"
        "Nested struct handling"
        "Lifetime annotation handling"
        "Attribute macro parsing")
      (next-actions
        "Extract inner type from Vec<T> and Option<T>"
        "Add RustEnum type to parser"))

    ;; Template System
    (swift-templates
      (status . in-progress)
      (completion . 70)
      (category . "code-generation")
      (phase . "functional")
      (description . "SwiftUI ViewModel template generation")
      (dependencies . (rust-parser))
      (implemented
        "iOS 17+ @Observable macro generation"
        "iOS 14-16 ObservableObject protocol generation"
        "@MainActor annotations"
        "from(rust:) convenience initializer"
        "SwiftUI Preview provider generation"
        "Type mapping for primitives")
      (missing
        "Proper generic type mapping"
        "@Bindable property generation"
        "Combine publisher generation"
        "async/await bridging"
        "Custom property wrapper support")
      (next-actions
        "Fix mapRustTypeToSwift for generics"
        "Add Bindable support for iOS 17+"))

    ;; CLI
    (synapse-cli
      (status . in-progress)
      (completion . 80)
      (category . "tooling")
      (phase . "functional")
      (description . "Command-line interface for generation")
      (dependencies . (rust-parser swift-templates))
      (implemented
        "--input and --output flags"
        "--ios version targeting"
        "--no-previews flag"
        "--legacy-observable flag"
        "--help documentation"
        "Error messaging")
      (missing
        "--watch mode"
        "--validate flag"
        "stdin/stdout streaming"
        "Config file support")
      (next-actions
        "Add watch mode for file changes"))

    ;; Build & Test
    (build-infrastructure
      (status . in-progress)
      (completion . 75)
      (category . "infrastructure")
      (phase . "functional")
      (description . "Zig build system and test harness")
      (dependencies . ())
      (implemented
        "build.zig configuration"
        "Module dependencies"
        "Test targets"
        "Justfile commands"
        "CI/CD pipeline")
      (missing
        "Cross-platform verification"
        "Integration tests"
        "Benchmark suite")
      (next-actions
        "Test build on macOS and Windows"))

    ;; UniFFI Integration (future)
    (uniffi-integration
      (status . pending)
      (completion . 0)
      (category . "integration")
      (phase . "planned")
      (description . "Direct UniFFI UDL parsing and proc-macro recognition")
      (dependencies . (rust-parser))
      (blockers
        ("parser-completion" . "Need robust generic handling first"))
      (next-actions
        "Research UniFFI UDL format"
        "Design integration architecture"))))

;; ============================================
;; KNOWN ISSUES
;; ============================================
(define issues
  '((critical . ())
    (high
      ("GEN-001"
        (title . "Generic type parameters not extracted")
        (description . "Vec<String> maps to [Any] instead of [String]")
        (file . "src/parser/rust_parser.zig")
        (line . 274)
        (impact . "Generated code requires manual type fixes")))
    (medium
      ("GEN-002"
        (title . "Option<T> loses inner type")
        (description . "Option<i32> maps to Any? instead of Int?")
        (file . "src/templates/swift_templates.zig")
        (line . 200)
        (impact . "Optional fields have wrong types"))
      ("PARSE-001"
        (title . "No enum support")
        (description . "Rust enums are completely ignored")
        (file . "src/parser/rust_parser.zig")
        (impact . "Cannot generate Swift enums from Rust")))
    (low
      ("DX-001"
        (title . "No watch mode")
        (description . "Must manually re-run generation")
        (impact . "Developer experience friction")))))

;; ============================================
;; QUESTIONS FOR MAINTAINER
;; ============================================
(define questions
  '(("Q1"
      (question . "Should generic extraction prioritize correctness or compatibility?")
      (context . "Extracting Vec<CustomType> requires knowing if CustomType exists in Swift")
      (options
        ("strict" . "Fail if type unknown")
        ("passthrough" . "Use type name as-is, trust UniFFI")))
    ("Q2"
      (question . "Target Zig version for long-term support?")
      (context . "Zig 0.11 vs 0.12+ have module system differences")
      (options
        ("0.11" . "Current stable, wider compatibility")
        ("0.12+" . "Newer features, module improvements")))
    ("Q3"
      (question . "Priority: enum support vs nested structs vs generics?")
      (context . "All three block v0.2.0, limited resources")
      (options
        ("generics-first" . "Fixes existing use cases")
        ("enums-first" . "Enables new patterns")
        ("nested-first" . "Enables composition")))))

;; ============================================
;; ROUTE TO MVP v1.0.0
;; ============================================
(define mvp-roadmap
  '((current-version . "0.1.0-alpha")
    (target-version . "1.0.0")
    (milestones
      (v0.2.0
        (name . "Enhanced Type Support")
        (status . next)
        (items
          ("Generic type extraction" . pending)
          ("Optional type handling" . pending)
          ("Nested struct support" . pending)
          ("Enum generation" . pending)
          ("Associated type mapping" . pending)))
      (v0.3.0
        (name . "UniFFI Integration")
        (status . planned)
        (items
          ("Direct UniFFI UDL parsing" . pending)
          ("Proc-macro attribute recognition" . pending)
          ("Combined UniFFI + Synapse workflow" . pending)
          ("Automatic from(rust:) using UniFFI bindings" . pending)))
      (v0.4.0
        (name . "Advanced SwiftUI Patterns")
        (status . planned)
        (items
          ("@Bindable property generation" . pending)
          ("Custom property wrappers" . pending)
          ("Combine publisher generation" . pending)
          ("async/await bridging" . pending)))
      (v0.5.0
        (name . "Developer Experience")
        (status . planned)
        (items
          ("Watch mode (just watch)" . pending)
          ("Incremental generation" . pending)
          ("Error messages with Rust source locations" . pending)
          ("Xcode integration guide" . pending)))
      (v0.6.0
        (name . "Testing & Validation")
        (status . planned)
        (items
          ("Generated code validation" . pending)
          ("Swift syntax checking" . pending)
          ("Type compatibility verification" . pending)
          ("Round-trip testing" . pending)))
      (v1.0.0
        (name . "Stable Release")
        (status . planned)
        (items
          ("API stability guarantee" . pending)
          ("Comprehensive documentation" . pending)
          ("Migration guides" . pending)
          ("Performance benchmarks" . pending)
          ("Community template registry" . pending))))))

;; ============================================
;; LONG-TERM ROADMAP (Beyond v1.0)
;; ============================================
(define long-term-roadmap
  '((platform-expansion
      (description . "Extend beyond iOS/Swift")
      (items
        ("Android/Kotlin support via UniFFI" . future)
        ("Web/TypeScript support" . future)))
    (extensibility
      (description . "Enable customization")
      (items
        ("Custom template language" . future)
        ("Community template registry" . future)))
    (tooling
      (description . "IDE and build integration")
      (items
        ("VS Code extension" . future)
        ("Xcode plugin" . future)
        ("WASM target for browser-based generation" . future)))))

;; ============================================
;; HISTORY TRACKING
;; ============================================
(define history
  '((snapshots
      (("2024-12-08" . ((overall . 35)
                        (parser . 60)
                        (templates . 70)
                        (cli . 80)
                        (infra . 75)))))
    (velocity . "initial-baseline")))

;; ============================================
;; CRITICAL NEXT ACTIONS
;; ============================================
(define next-actions
  '(("HIGH" . (
      "Implement generic parameter extraction in parseRustType"
      "Update mapRustTypeToSwift to handle extracted generics"
      "Add unit tests for Vec<String> and Option<i32>"))
    ("MEDIUM" . (
      "Add RustEnum type to parser"
      "Design nested struct handling"
      "Test build on macOS"))
    ("LOW" . (
      "Add --watch flag to CLI"
      "Create Xcode integration guide"
      "Set up benchmark suite"))))

;; ============================================
;; FILE REFERENCE
;; ============================================
;; Key files for AI context:
;;   src/generators/synapse.zig:97    - Main generation entry point
;;   src/parser/rust_parser.zig:261   - Type parsing (needs generic work)
;;   src/templates/swift_templates.zig:190 - Type mapping (needs generic work)
;;   examples/rust/models.rs          - Test input models
;;   ROADMAP.md                       - Detailed milestone planning
;;   CLAUDE.md                        - AI assistant context

;; ============================================
;; QUERY HELPERS (for minikanren-style use)
;; ============================================
(define (current-focus) focus)
(define (blocked-items)
  (filter (lambda (p) (assoc 'blockers (cdr p))) projects))
(define (get-completion project-name)
  (let ((proj (assoc project-name projects)))
    (if proj (cdr (assoc 'completion (cdr proj))) #f)))
(define (all-next-actions)
  (append-map (lambda (p)
    (let ((actions (assoc 'next-actions (cdr p))))
      (if actions (cdr actions) '())))
    projects))

;; EOF
