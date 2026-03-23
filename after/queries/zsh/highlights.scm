;; vim: ft=query
;; extends

(expansion
  "$" @snqn.muted
  [
    "{"
    "}"
  ] @snqn.muted
  name: (simple_variable_name) @snqn.base)

(command_substitution
  "$"? @snqn.muted
  "(" @snqn.muted
  ")" @snqn.muted)
