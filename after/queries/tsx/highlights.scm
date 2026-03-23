;; vim: ft=query
;; extends

(interface_declaration
  name: (type_identifier) @snqn.definition)

(type_alias_declaration
  name: (type_identifier) @snqn.definition)

(method_definition
  name: (property_identifier) @snqn.definition)

(function_declaration
  name: (identifier) @snqn.definition)

(variable_declarator
  name: (identifier) @snqn.definition
  value: [
    (arrow_function)
    (function_expression)
  ])

(variable_declarator
  name: (identifier) @snqn.local)

(variable_declarator
  name: (array_pattern
    (identifier) @snqn.local))

(variable_declarator
  name: (object_pattern
    (shorthand_property_identifier_pattern) @snqn.local))

(variable_declarator
  name: (object_pattern
    (pair_pattern
      key: (property_identifier) @snqn.local)))

(template_substitution
  "${" @snqn.muted
  (identifier) @snqn.base
  "}" @snqn.muted)

(template_substitution
  "${" @snqn.muted
  (member_expression
    object: (identifier) @snqn.base
    property: (property_identifier) @snqn.base)
  "}" @snqn.muted)
