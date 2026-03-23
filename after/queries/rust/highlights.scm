;; vim: ft=query
;; extends

(struct_item
  name: (type_identifier) @snqn.definition)

(enum_item
  name: (type_identifier) @snqn.definition)

(trait_item
  name: (type_identifier) @snqn.definition)

(impl_item
  type: (type_identifier) @snqn.definition)

(impl_item
  type: (scoped_type_identifier
    name: (type_identifier) @snqn.definition))

(function_item
  name: (identifier) @snqn.definition)

(macro_definition
  name: (identifier) @snqn.definition)
