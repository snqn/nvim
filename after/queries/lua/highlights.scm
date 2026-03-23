;; vim: ft=query
;; extends

(variable_declaration
  (assignment_statement
    (variable_list
      name: (identifier) @snqn.local)))

(variable_declaration
  (variable_list
    name: (identifier) @snqn.local))

(function_declaration
  name: (identifier) @snqn.definition)

(assignment_statement
  (variable_list
    name: (dot_index_expression
      field: (identifier) @snqn.definition))
  (expression_list
    value: (function_definition)))

(assignment_statement
  (variable_list
    name: (identifier) @snqn.definition)
  (expression_list
    value: (function_definition)))

(function_declaration
  name: (dot_index_expression
    field: (identifier) @snqn.definition))
