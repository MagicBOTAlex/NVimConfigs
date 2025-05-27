;; extends

;; Highlight Svelte components (tags starting with uppercase)
(
  (tag_name) @custom.component
  (#match? @custom.component "^[A-Z]")
  (#set! "priority" 10000)
)
