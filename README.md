# Neologisms ending in -age in contemporary French
This repository stores scripts and annotated lists of neologisms and verbs used in a study of neologisms ending in -age in contemporary French.

This repository provides:
- a Python script that was used to retrieve the candidate neologisms from the corpus frWaC (frwac_extraction.pip),
- a table obtained through manual annotation of the 181 different final senses of novel words ending in -age (n_age_sample.txt),
- a table obtained through manual annotation of the 156 different verbs from which the novel words are derived (v_age_sample.txt),
- a statistical analysis R script of the two tables (age_analysis_script.R).

The columns of the two tables encode the following properties:
- 'nom': deverbal novel word ending in -age sometimes followed by a number to distinguish the different meanings of a same deverbal form,
- 'freq': frequency of the form in the frWaC corpus,
- 'verbe': base verb from which the deverbal novel word is derived,
- 'v_dico': 'oui' if the base verb has an entry in the Petit Robert or the Trésor de la Langue Française informatisé, 'non' otherwise,
- 'v_corpus': 'oui' if the base verb is present in the frWaC corpus, 'non' otherwise,
- 'v_trans': 'trans' if the base verb is direct-transitive, 'intrans' otherwise,
- 'v_asp': aspect of the base verb ('acc' for accomplishment verb, 'ach' for achievement verb, 'ach_grad' for degree achievement verb, 'act' for activity verb and 'etat' for state verb),
- 'v_tel': '1' if the base verb is telic, '0' if it is atelic, '2' if the telicity is variable (degree achievement verb).
- 'v_rol_suj', 'v_rol_obj', 'v_rol_obq': semantic role of resp. subject, object and oblique arguments ('ag' for agent, 'benf' for beneficiary, 'exp' for experiencer, 'loc' for location, 'pa' for patient, 'sg' for pivot and 'th' for theme),
- 'v_nb_arg': number of arguments that the verb can take,
- 'n_onto': semantic ontological type of the noun ('act' for action, 'cog' for cognitive object, 'obj' for object and 'ppt' for property),
- 'n_rel': semantic relational type of the noun ('instr' for instrument, 'loc' for location, 'res' for result and 'na' if the noun denotes the same eventuality as the verb),
- 'n_asp': lexical aspect of the noun ('acc' for accomplishment noun, 'ach' for achievement noun, 'ach_grad' for degree achievement noun, 'act' for activity noun and 'etat' for state noun),
- 'n_rol_cplt1', 'n_rol_cplt2' and 'n_rol_cplt3': semantic role of the different arguments of the noun ('pa' for patient, 'th' for theme, 'ag' for agent, 'loc' for location, 'exp' for experiencer, 'sg' for pivot, 'part' for part, 'tt' for whole and 'benf' for beneficiary),
- 'n_nb_arg': number of arguments of the noun,
- 'n_polys': 'oui' if the nominal form is polysemous (i.e. has different entries in the table), 'non' otherwise,
- 'v_polys': 'oui' if the different meanings of the noun are derived from different meanings of the base verb (i.e. the base verb has different entries in the table), 'non' otherwise,
- 'si_polys_v_base_unq': 'oui' if the different meanings of the noun are derived from the same verb meaning, 'non' otherwise,
- 'act_res': 'oui' if the nominal form is polysemous between 'action' and 'result', 'non' otherwise,
- 'herit_asp': 'oui' if the eventuality-denoting -age noun inherits its lexical aspect from the base verb, 'non' if the eventuality-denoting -age noun does not inherit its lexical aspect from the base verb, 'na' if the -age noun does not denote eventualities,
- 'v_rol_inc': 'incl' if the arguments of the base verb are included in the argument structure of the noun, 'noninc' otherwise,
- 'n_rol_inc': 'incl' if the arguments of the noun are included in the argument structure of the base verb, 'noninc' otherwise,
- 'herit_Sa': 'oui' if the argument structure of the noun is inherited from the argument structure of the base verb, 'non' otherwise.

Note that the annotation criteria are described more precisely in the article.

