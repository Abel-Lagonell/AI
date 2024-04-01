(deftemplate path
    (slot start)
    (slot end)
    (multislot nodes) ; Represents the nodes visited along the path
    (slot total-cost) ; Accumulated cost of the path
)

(deffacts network-topology
  (path (start "Node 1") (end "Node 2") (total-cost 4))
  (path (start "Node 1") (end "Node 3") (total-cost 2))
  (path (start "Node 2") (end "Node 3") (total-cost 5))
  (path (start "Node 2") (end "Node 4") (total-cost 13))
  (path (start "Node 3") (end "Node 4") (total-cost 4))
)

(defrule infer-paths 
  (path (start ?start) (end ?temp) (nodes $?nodes1) (total-cost ?wt1))
  (path (start ?temp)  (end ?end) (nodes $?nodes2) (total-cost ?wt2))
  => 
  (assert (path
    (start ?start)
    (end ?end)
    (nodes $?nodes1 ?temp $?nodes2)
    (total-cost (+ ?wt2 ?wt1))
  ))
)

(defrule best-paths
  ?f1 <- (path (start ?start1) (end ?end1) (nodes $?nodes1) (total-cost ?wt1))
  ?f2 <- (path (start ?start2)  (end ?end2) (nodes $?nodes2) (total-cost ?wt2))
  (test (eq ?start1 ?start2))
  (test (eq ?end1 ?end2))
  (test (> ?wt1 ?wt2))
  =>
  (retract ?f1)
)

(defrule print-paths
  (path (start ?start) (end ?end) (nodes $?nodes) (total-cost ?c))
  =>
  (bind ?node-string (implode$ ?nodes))
  (printout t "The most cost-effective path from " ?start " to " ?end " is ( " ?start ", "?node-string", " ?end ") with a total cost of " ?c crlf)
)
