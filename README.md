# Neologisms ending in -age in contemporary French
This repository stores scripts and annotated lists of neologisms and verbs used in a study of neologisms ending in -age in contemporary French.

This repository provides:
- a Jupyter Notebook script in French that allowed the extraction of the candidate neologisms from the corpus frWaC (frwac_extraction.ipynb),
- a table obtained through manual annotation of the 181 different final senses of novel words ending in -age (n_age_sample.txt),
- a table obtained through manual annotation of the 156 different verbs from which the novel words are derived (v_age_sample.txt),
- a statistical analysis R script of the two tables (age_analysis_script.R).

The columns of the two tables encode different characteristics:
- 'nom' gives the deverbal novel word sometimes followed by a number to distinguish the different meanings of a same deverbal form,
- 'freq' gives the frequency of the form in the frWaC corpus,
- 'verbe' gives the verbal base from which the deverbal novel word is derived,
- 'v_dico' indicates 'oui' if the verbal base has an entry in the Petit Robert or the Trésor de la Langue Française informatisé dictionaries, and otherwise 'non',
- 'v_corpus' indicates 'oui' if the verbal base is present in the frWaC corpus, and otherwise 'non',
- 'v_trans' indicates 'trans' if the verbal base is transitive and 'intrans' if it is intransitive,
- 'v_asp'
- 'v_tel' indicates '1' if the verbal base is telic, '0' if it is atelic and '2' if the telicity is variable, i.e. it is a degree achievement verb. Note that in the list of the verbs (v_age_sample.txt) we considered the degree achievement verbs as telic ('tel') in order to distiguish only between 'tel' for telic and 'n_tel' for atelic and thus simplify the statistical analysis.
- 'v_rol_suj', 'v_rol_obj', 'v_rol_obq' indicate respectively the protoypical role of the subject, the object and the oblique arguments. They can take the values 'pa' for patient, 'th' for theme, 'ag' for agent, 'loc' for location, 'exp' for experiencer, 'sg' for siège (???) and 'benf' for beneficiary,
- 'v_nb_arg' indicate the number of prototypical arguments that the verb can take,
- 'n_onto' indicates the ontological type of the novel word and can take the values 'act' for action, 'cog' for cognitive object, 'obj' for object and 'ppt' for property,
- 'n_rel' indicates the relational type of the novel word and can take the values 'res' for result, 'instr' for instrument, 'loc' for location and 'na' if there is no relation involved between the noun and the process denoted by the verbal base (eg. if the noun denote the process itself),
- 'n_asp'
- n_rol_cplt1
- n_rol_cplt2
- n_rol_cplt3
- n_nb_arg
- n_polys
- v_polys
- si_polys_v_base_unq
- act_res
- herit_asp
- v_rol_inc
- n_rol_inc
- herit_Sa

Note that the annotation criteria are described more precisely in the correspondant study.

