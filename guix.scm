;; SPDX-License-Identifier: MIT OR AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2024-2025 hyperpolymath
;;
;; synapse - Guix Package Definition
;; Run: guix shell -D -f guix.scm

(use-modules (guix packages)
             (guix gexp)
             (guix git-download)
             (guix build-system gnu)
             ((guix licenses) #:prefix license:)
             (gnu packages base))

(define-public synapse
  (package
    (name "synapse")
    (version "0.1.0")
    (source (local-file "." "synapse-checkout"
                        #:recursive? #t
                        #:select? (git-predicate ".")))
    (build-system gnu-build-system)
    (synopsis "Rust-to-SwiftUI meta-compiler")
    (description "Synapse is a Zig-based meta-compiler that generates SwiftUI
ViewModels from Rust struct definitions. It bridges the Rust-Swift divide,
eliminating boilerplate while maintaining type safety and Apple platform
compliance. Part of the RSR ecosystem.")
    (home-page "https://github.com/hyperpolymath/synapse")
    ;; Dual-licensed: users may choose either MIT or AGPL-3.0-or-later
    (license (list license:expat license:agpl3+))))

;; Return package for guix shell
synapse
