;; vim: ft=query
;; extends

(function_definition
  name: (word) @snqn.definition)

(variable_assignment
  name: (variable_name) @snqn.local)

(expansion
  "$" @snqn.muted
  [
    "{"
    "}"
  ] @snqn.muted
  (variable_name) @snqn.base)

(command_substitution
  "$"? @snqn.muted
  "(" @snqn.muted
  ")" @snqn.muted)
