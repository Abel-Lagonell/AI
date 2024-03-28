(deftemplate path 
  (multislot nodes)
)
(deffacts the-given-paths
  (path (nodes A B))  
  (path (nodes B C))
  (path (nodes B D))
  (path (nodes D E))
  (path (nodes E F))
)
(defrule infer-indirect-paths
  (path (nodes $?begin ?temp))
  (path (nodes ?temp $?end))
  =>
  (assert (path (nodes ?begin ?temp ?end)))
)
(defrule print-nodes
  (path (nodes ?begin $?nodes ?end))
  =>
  (printout t "Path: (" ?begin " " $?nodes " " ?end ")" crlf)
)
