;; SPDX-License-Identifier: MIT OR AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2024-2025 hyperpolymath
;; ECOSYSTEM.scm — synapse

(ecosystem
  (version "1.0.0")
  (name "synapse")
  (type "project")
  (purpose "*Rust-to-SwiftUI Meta-Compiler*")

  (position-in-ecosystem
    "Part of hyperpolymath ecosystem. Follows RSR guidelines.")

  (related-projects
    (project (name "rhodium-standard-repositories")
             (url "https://github.com/hyperpolymath/rhodium-standard-repositories")
             (relationship "standard")))

  (what-this-is "*Rust-to-SwiftUI Meta-Compiler*")
  (what-this-is-not "- NOT exempt from RSR compliance"))
