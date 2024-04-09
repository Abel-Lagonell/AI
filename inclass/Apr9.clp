(deffacts letters-and-digits
(letter C)
(letter A)
(letter T)
(letter D)
(letter O)
(letter G)
(letter P)
(letter E)
(digit 0)
(digit 1)
(digit 2)
(digit 3)
(digit 4)
(digit 5)
(digit 6)
(digit 7)
(digit 8)
(digit 9))

(defrule all-replacements
(letter ?letter)
(digit ?digit)
=>
(assert (replace ?letter ?digit)))

(defrule forward-checking
;checking the 1’s place
(replace T ?t)
(replace G ?g&~?t)
(test (= (mod (+ ?t ?g) 10) ?t))
;checking up to 10’s place
(replace A ?a&~?t&~?g)
(replace O ?o&~?t&~?g&~?a)
(replace E ?e&~?t&~?g&~?a&~?o)
(test (= (mod (+ ?t ?g (* ?a 10) (* ?o 10)) 100) (+ (* ?e 10) ?t)))
;checking up to 100’s place
(replace C ?c&~?t&~?g&~?a&~?o&~?e)
(replace D ?d&~?t&~?g&~?a&~?o&~?e&~?c)
(replace P ?p&~?t&~?g&~?a&~?o&~?e&~?c&~?d)
(test (= (+ ?t ?g (* ?a 10) (* ?o 10) (* ?c 100) (* ?d 100)) (+ (* ?p 100) (* ?e 10) ?t)))
=>
;display all solutions
(printout t "C=" ?c ", A=" ?a ", T=" ?t ", D=" ?d ", O=" ?o ", G=" ?g  ", P=" ?p ", E=" ?e crlf)
(printout t " " ?c ?a ?t crlf)
(printout t " + " ?d ?o ?g crlf)
(printout t " ------" crlf)
(printout t " " ?p ?e ?t crlf crlf))
