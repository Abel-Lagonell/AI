(deftemplate path 
  (multislot nodes)
  (slot cost)
)
; Defining Facts
(deffacts direct-links
  (path (nodes f e) (cost 2))  
  (path (nodes e b) (cost 2))
  (path (nodes b a) (cost 3))
  (path (nodes a d) (cost 2))
  (path (nodes d c) (cost 1))
  (path (nodes c a) (cost 1))
  (path (nodes b c) (cost 2))
  (path (nodes f c) (cost 3))
)

; Defining Paths
(defrule find-paths
  (path (nodes ?begin $?temp) (cost ?c1))
  (path (nodes $?temp ?end) (cost ?c2))
  (test (neq ?begin ?end))
  =>
  (assert (path (nodes ?begin $?temp ?end) (cost (+ ?c1 ?c2))))
)

(defrule print-paths
  (path (nodes $?nodes) (cost ?c))
  =>
  (printout t "The cost of the path " $?nodes " is " ?c crlf)
)
