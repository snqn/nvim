;; vim: ft=query
;; extends

(binding
  attrpath: (attrpath
    attr: (identifier) @snqn.definition))

(binding
  attrpath: (attrpath
    attr: (identifier) @snqn.definition
    attr: (identifier)))

(binding
  attrpath: (attrpath
    attr: (identifier) @snqn.definition
    attr: (identifier)
    attr: (identifier)))

(binding
  attrpath: (attrpath
    attr: (string_expression
      (string_fragment) @snqn.definition)))

(binding
  attrpath: (attrpath
    attr: (string_expression
      (string_fragment) @snqn.definition)
    attr: (identifier)))

(binding
  attrpath: (attrpath
    attr: (string_expression
      (string_fragment) @snqn.definition)
    attr: (identifier)
    attr: (identifier)))
