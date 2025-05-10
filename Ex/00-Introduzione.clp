(deftemplate person "commento opzionale"
	(slot name)
	(slot age)
	(slot eye-color)
	(slot hair-color))



(deffacts famiglia-verdi "alcuni membri della famiglia Verdi"
	(person (name "Luigi") (age 46) (eye-color brown) ( hair-color brown))
	(person (name "Maria") (age 40) (eye-color blue) ( hair-color brown))
	(person (name "Marco") (age 25) (eye-color brown) ( hair-color brown))
	(person (name "Lisa") (age 20) (eye-color blue) ( hair-color blonde))
)

(defrule birthday
	(person (name "Luigi")
	(age 46)
	(eye-color brown)
	(hair-color brown))
	(date-today April-13-02)
=>
	(printout t "Happy birthday, Luigi!" crlf )
	(assert (there-s-a-party))
)


(defrule birthday-2
	?person <- (person (name "Luigi")
	(age 46)
	(eye-color brown)
	(hair-color brown))
	(date-today April-13-02)
=>
	(printout t "Happy birthday, Luigi!" crlf)
	(modify ?person (age 47))
)

(ppdefrule birthday)


(watch facts)

(unwatch facts)

(watch rules)

(watch activations)

(unwatch activations)

(unwatch rules)



(defrule find-blue-eyes
	(person (name ?name)(eye-color blue))
=>
	(printout t ?name " has blue eyes." crlf))


