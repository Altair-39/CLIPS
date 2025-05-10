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

(defrule father
   (human (name ?father) (gender male))
   (hasChild (x ?father) (y ?child))
   (human (name ?child) )	
=> 
   (assert (father (x ?father) (y ?child)))
)   

(defrule mother
   (human (name ?mother) (gender female))
   (hasChild (x ?mother) (y ?child))
   (human (name ?child) )
=> 
   (assert (mother (x ?mother) (y ?child)))
)  

(defrule parent
   (or 
     (mother (x ?x) (y ?child))
     (father (x ?x) (y ?child))
   )
=> 
   (assert (parent (x ?x) (y ?child)))
)  

(defrule ancestor-1
  (parent (x ?parent) (y ?child))
 =>
   (assert (ancestor (x ?parent) (y ?child) ) )
 )
 
 (defrule ancestor-2
   (parent (x ?parent) (y ?child-z))
   (ancestor (x ?child-z) (y ?child-y))
=>
   (assert (ancestor (x ?parent) (y ?child-y)))
)   

(defrule sibling
  (goal sibling ?z ?y)
  (goal sibling ?z ?yb &(neq ?z ?y))
  (parent (x ?x) (y ?z))
  (parent (x ?x) (y ?y))
  (human (name ?z))
  (human (name ?y))
  (human (name ?x))
=>
  (assert (sibling (x ?z) (y ?y)))
)
