(deftemplate link
  (slot start)
  (slot end)
  (slot cost)
)

(deftemplate path
    (slot start)
    (slot end)
    (multislot nodes) ; Represents the nodes visited along the path
    (slot total-cost) ; Accumulated cost of the path
)

(deffacts network-topology
  (link (start "Node 1") (end "Node 2") (cost 4))
  (link (start "Node 1") (end "Node 3") (cost 2))
  (link (start "Node 2") (end "Node 3") (cost 5))
  (link (start "Node 2") (end "Node 4") (cost 13))
  (link (start "Node 3") (end "Node 4") (cost 4))
)

(defrules infer-links 
  (link (start ?start) (end ?temp) (cost ?wt1))
  (link (start ?temp)  (end ?end) (cost ?wt2))
  => 
  (assert (path
    (start ?start)
    (end ?end)
    (nodes ?temp)
    (cost (+ (?wt2 ?wt1)))
  ))
)
