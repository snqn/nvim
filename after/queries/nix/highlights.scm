;; vim: ft=query
;; extends

(binding
  attrpath: (attrpath
    attr: (identifier) @snqn.definition))

(binding
  attrpath: (attrpath
    attr: (identifier) @snqn.definition
    attr: (identifier) @snqn.base))

(binding
  attrpath: (attrpath
    attr: (identifier) @snqn.definition
    attr: (identifier) @snqn.base
    attr: (identifier) @snqn.base))

(binding
  attrpath: (attrpath
    attr: (string_expression
      (string_fragment) @snqn.definition)))

(binding
  attrpath: (attrpath
    attr: (string_expression
      (string_fragment) @snqn.definition)
    attr: (identifier) @snqn.base))

(binding
  attrpath: (attrpath
    attr: (string_expression
      (string_fragment) @snqn.definition)
    attr: (identifier) @snqn.base
    attr: (identifier) @snqn.base))

(binding
  expression: (variable_expression
    name: (identifier) @snqn.constant)
  (#match? @snqn.constant "^(true|false|null)$"))

(let_expression
  (binding_set
    (binding
      attrpath: (attrpath
        attr: (identifier) @snqn.local))))

(function_expression
  universal: (identifier) @snqn.local)

(formal
  name: (identifier) @snqn.local)

(interpolation
  "${" @snqn.muted
  (variable_expression
    name: (identifier) @snqn.base)
  "}" @snqn.muted)

(interpolation
  "${" @snqn.muted
  (select_expression
    expression: (variable_expression
      name: (identifier) @snqn.base)
    attrpath: (attrpath
      attr: (identifier) @snqn.base))
  "}" @snqn.muted)
