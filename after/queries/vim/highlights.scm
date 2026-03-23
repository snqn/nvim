;; vim: ft=query
;; extends

(function_definition
  (function_declaration
    name: (identifier) @snqn.definition))

(let_statement
  (identifier) @snqn.local)

(let_statement
  (scoped_identifier
    (identifier) @snqn.local))

(for_loop
  variable: (identifier) @snqn.local)
