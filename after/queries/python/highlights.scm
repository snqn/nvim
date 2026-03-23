;; vim: ft=query
;; extends

(function_definition
  name: (identifier) @snqn.definition)

(class_definition
  name: (identifier) @snqn.definition)

(assignment
  left: (identifier) @snqn.local)

(interpolation
  "{" @snqn.muted
  expression: (identifier) @snqn.base
  "}" @snqn.muted)

(interpolation
  "{" @snqn.muted
  expression: (attribute
    object: (identifier) @snqn.base
    attribute: (identifier) @snqn.base)
  "}" @snqn.muted)
