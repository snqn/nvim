;; vim: ft=query
;; extends

(method_definition
  name: (property_identifier) @snqn.definition)

(function_declaration
  name: (identifier) @snqn.definition)

(lexical_declaration
  (variable_declarator
    name: (identifier) @snqn.definition
    value: [
      (arrow_function)
      (function_expression)
    ]))

(variable_declaration
  (variable_declarator
    name: (identifier) @snqn.definition
    value: [
      (arrow_function)
      (function_expression)
    ]))
