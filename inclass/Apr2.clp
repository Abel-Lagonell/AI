(deffacts init
  (state 0 0)
  (path [ 0 0 ])
)

(defrule op1
  (path $?begin [ ?x ?y ])
  (test (< ?x 4))
  (not (exists (state 4 ?y)))
  =>
  (assert (state 4 ?y))
  (assert (path $?begin [ ?x ?y ] [ 4 ?y ])))

(defrule op2
  (path $?begin [ ?x ?y ])
  (test (< ?y 3))
  (not (exists (state ?x 3)))
  =>
  (assert (state ?x 3))
  (assert (path $?begin [ ?x ?y ] [ ?x 3 ])))

(defrule op3
  (path $?begin [ ?x ?y ])
  (test (< ?x 4))
  (test (>= (+ ?x ?y) 4))
  (not (exists (state 4 =(- (+ ?x ?y) 4))))
  =>
  (assert (state 4 =(- (+ ?x ?y) 4)))
  (assert (path $?begin [ ?x ?y ] [ 4 =(- (+ ?x ?y) 4) ])))

(defrule op4
  (path $?begin [ ?x ?y ])
  (test (< ?y 3))
  (test (>= (+ ?x ?y) 3))
  (not (exists (state =(- (+ ?x ?y) 3) 3)))
  =>
  (assert (state =(- (+ ?x ?y) 3) 3))
  (assert (path $?begin [ ?x ?y ] [ =(- (+ ?x ?y) 3) 3 ])))

(defrule op5
  (path $?begin [ ?x ?y ])
  (test (> ?x 0))
  (test (<= (+ ?x ?y) 3))
  (not (exists (state 0 =(+ ?x ?y))))
  =>
  (assert (state 0 =(+ ?x ?y)))
  (assert (path $?begin [ ?x ?y ] [ 0 =(+ ?x ?y) ])))

(defrule op6
  (path $?begin [ ?x ?y ])
  (test (> ?y 0))
  (test (<= (+ ?x ?y) 4))
  (not (exists (state =(+ ?x ?y) 0)))
  =>
  (assert (state =(+ ?x ?y) 0))
  (assert (path $?begin [ ?x ?y ] [ =(+ ?x ?y) 0 ])))


(defrule op7
  (path $?begin  [ ?x ?y ])
  (test (> ?x 0))
  (not (exists (state 0 ?y)) )
  =>
  (assert (state 0 ?y))
  (assert (path $?begin [ ?x ?y ] [ 0 ?y ])))

(defrule op8
  (path $?begin  [ ?x ?y ])
  (test (> ?y 0))
  (not (exists (state ?x 0)) )
  =>
  (assert (state ?x 0))
  (assert (path $?begin [ ?x ?y ] [ ?x 0 ])))

(defrule print-solutions
  (path [ 0 0 ] $?middle [ 2 ?y ])
  =>
  (bind $?solution (create$ [ 0 0 ] $?middle [ 2 ?y ]))
  (printout t "Solution: " $?solution crlf)
)
