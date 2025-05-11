(deftemplate gruppo
  (slot id)
  (slot CFU (type INTEGER))
  (multislot cluster)
)

(deftemplate insegnamento
  (slot id)
  (slot nome (type STRING))
  (slot CFU (type INTEGER))
)

(deftemplate piano-studi
  (slot id)
  (slot studente (type STRING))
  (multislot scelte)
  (slot CFU-prova-finale (type INTEGER))
  (slot CFU-totali)
)

(deftemplate gruppo-in-ps
 (slot ips) ;;id piano studi
 (slot igr) ;;id gruppo nel piano studi
 (multislot scelte) ;;insegnamenti scelti per soddisfare un particolare gruppo
)

(deftemplate vincolo
  (slot id)
  (slot gruppo)
  (slot min (type INTEGER))
  (slot max (type INTEGER))
)

(deffacts insegnamenti

  (insegnamento (id INS01) (nome "Intelligenza Artificiale e Laboratorio") (CFU 9))
  (insegnamento (id INS02) (nome "Tecniche e architetture avanzate per lo sviluppo del software") (CFU 9))
  (insegnamento (id INS03) (nome "Modelli e architetture avanzati di basi di dati") (CFU 9))
  (insegnamento (id INS04) (nome "Tecnologia del linguaggio naturale") (CFU 9))
  (insegnamento (id INS05) (nome "Apprendimento automatico") (CFU 9))
  (insegnamento (id INS06) (nome "Basi di dati multimediali") (CFU 9))
  (insegnamento (id INS07) (nome "Reti neurali e deep learning") (CFU 9))
  (insegnamento (id INS08) (nome "Agenti Intelligenti") (CFU 6))
  (insegnamento (id INS09) (nome "Etica Società e privacy") (CFU 6))  
  (insegnamento (id INS10) (nome "Modellazione Concettuale per il web semantico") (CFU 6))
  (insegnamento (id INS11) (nome "Modellazione di dati e processi aziendali") (CFU 6))  
  
  
  
  (gruppo (id GRU01) (cluster INS01 INS02 INS03))
  (gruppo (id GRU02) (cluster INS01 INS02 INS03 INS04 INS05 INS06 INS07))
  (gruppo (id GRU03) (cluster INS08 INS09 INS10 INS11))  
  
  (vincolo (id VIN01) (gruppo GRU01) (min 2) (max 99))
  (vincolo (id VIN02) (gruppo GRU02) (min 3) (max 99))
   
  (piano-studi (id PS01) (studente "Mario Rossi") )
   
 )

(defrule check-vincoli-ok
 (piano-studi (id ?id) (scelte $?piano))
 (gruppo-in-ps (ips ?id) (igr ?gid) (scelte $?scelte))
 
 (vincolo (id ?vid) (gruppo ?gid) (min ?min) (max ?max))
 (gruppo (id ?gid) (cluster $?cluster))
 
 (test  (>= (length$ (intersection$ $?scelte $?cluster)) ?min))
 (test  (<= (length$ (intersection$ $?scelte $?cluster)) ?max)) 
 
 (not (gruppo-in-ps (ips ?id) (igr ?gid-other &~?gid)
    (scelte $?scelte-other & :(  >  (length$ (intersection$ $?scelte $?scelte-other))  0 ))))

=>
  (assert (checked-ok ?id ?vid))
)

(defrule check-vincoli-ko (declare (salience -10))
 (piano-studi (id ?id) (scelte $?piano))
 (vincolo (id ?vid) (gruppo ?gid) (min ?min) (max ?max))
 (not (checked-ok ?id ?vid))
=>
  (assert (checked-ko ?id ?vid))
)

