(deftemplate human "un essere umano"
  (slot name)
  (slot gender)
)

(deftemplate mother
  (slot x) ; x madre di y
  (slot y)
)

(deftemplate father
  (slot x) ; x padre di y
  (slot y)
)

(deftemplate parent
  (slot x) ; x genitore di y
  (slot y)
)

(deftemplate hasChild
  (slot x) ; x ha come figlio y
  (slot y)
)

(deftemplate sibling
  (slot x) ; x e y sono fratelli/sorelle 
  (slot y)
)

(deftemplate ancestor
   (slot x)  ;x è antenato di y
   (slot y)
)  

; FATTI

(deffacts i-facts
	(human (name Luigi) (gender male))
	(human (name Marta) (gender female))
	(human (name Luca) (gender male))
	(human (name Maria) (gender female))
	(human (name Ludovico) (gender male))
	(human (name Mirta) (gender female))
	(human (name Lucrezia) (gender female))
	(human (name Miriam) (gender female))	
	(hasChild (x Luigi) (y Marta))
	(hasChild (x Luigi) (y Luca))
	(hasChild (x Marta) (y Maria))
	(hasChild (x Marta) (y Lucrezia))
	(hasChild (x Maria) (y Ludovico))
	(hasChild (x Ludovico) (y Mirta))
	(hasChild (x Ludovico) (y Miriam))	
)

; REGOLE

(defrule goal-ancestor-base
   (goal ancestor ?x ?y&~?x)
   (human (name ?x))
   (human (name ?y))
=>
   (assert (goal parent ?x ?y))
)

(defrule goal-parent-solved
   (goal parent ?x ?y)
   (human (name ?x))
   (human (name ?y))
   (hasChild (x ?x) (y ?y))
=>
   (assert (parent (x ?x) (y ?y)))
)

(defrule goal-ancestor-rec
   (goal ancestor ?x ?y&~?x)
   (human (name ?x))
   (human (name ?y))  
   (human (name ?z & ~?x & ~?y))     
=>
   (assert (goal parent ?x ?z) (goal ancestor ?z ?y))
)

(defrule goal-ancestor-solved-1
  (goal ancestor ?x ?y)
  (parent (x ?x) (y ?y))
=>
  (assert (ancestor (x ?x) (y ?y)))
)

(defrule goal-ancestor-solved-2
   (goal ancestor ?x ?y)
   (parent (x ?x) (y ?z))
   (ancestor (x ?z) (y ?y))
=>
   (assert (ancestor (x ?x) (y ?y)))
)   
