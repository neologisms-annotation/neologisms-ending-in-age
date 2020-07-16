###############################################################################
######## Retrieval of candidate neologisms ending with -age from frWaC ########
###############################################################################

## Before to run the script, we need a list extracted from NoSketchEngine : https://www.clarin.si/noske/run.cgi/first_form?corpname=frwac;align=
## We select 'CQL' and request [word=".{3,}ages?"]
## We want at least three characters (.{3,}) before -age and singular or plural words ending in -age singular (ages?).
## With the list generated we select 'Frequency > Node forms' at the left tab and click 'Save' at the top, with '100000' as the maximum of lines.
## We then download the results all the script is based on this file, named here 'frwac_age.txt'.

## We also need to download the dictionary lists :
    # 'Lexique.382.csv' (from http://www.lexique.org)
    # 'lefff-3.4.elex' (from https://www.labri.fr/perso/clement/lefff/)

import re
from collections import Counter

##### Word extraction from frWaC ####
#####################################

words_frwac = Counter()

with open('frwac_age.txt', encoding='utf-8') as res_frwac:
    for line in res_frwac:
        line = line.rstrip()
        # We search for a regex pattern such as : "pistonnage    9"
        res_search = re.search('([^\t]+)\t([0-9]+)', line)
        if res_search:
            word, freq = res_search.groups()
            freq = int(freq) # we convert the frequency from string to integers
            word = word.lower() # we lowercase the words to reduce variation
            if re.search(r"\W|[0-9]|([a-zA-Z])\1{2}|http|Message|Page|Image", word):
                # this regex eliminate all -age ending entries that are clearly not deverbal words (URL, 3 times the same letter, etc.)
                continue
            if word[-1] == 's':
                word = word[:-1]
            words_frwac[word] += freq

## We thus obtain data with -age ending words and their frequencies
print("The first list of -age ending words contain " + str(len(words_frwac.keys())) + " entries")

#### Comparison with Lexique.org and Lefff
#####################################

## We take a set() to keep only unique forms
set_words_lexique = set() # set of forms of Lexique
words_age_lexique = set() # set of -age ending forms of Lexique

with open('Lexique382.csv', encoding='utf-8') as lexique:
    for line in lexique:
        if not line.startswith('1_ortho'):
            word = line.split(';')[0]
            if word[-1] == 's':
                word = word[:-1]
            set_words_lexique.add(word)
            if re.search('.{3,}ages?$', word):
                words_age_lexique.add(word)

print("{} different forms in Lexique.org and {} ending in -age".format(len(set_words_lexique), len(words_age_lexique)))

## Now we compare the lists of frWaC and Lexique with the difference() function
set_words_frwac = set(words_frwac.keys())
diff = set_words_frwac.difference(set_words_lexique)
print("There is {} forms ending in -age not present in Lexique.org".format(len(diff)))

# We do with the file 'lefff-3.4.elex2 the same as we did for 'Lexique382.csv'
set_words_lefff = set()
words_age_lefff = set()

with open('lefff-3.4.elex') as lexique:
    for line in lexique:
        word = line.split('\t')[0]
        if word[-1] == 's':
            word = word[:-1]
        set_words_lefff.add(word)
        if re.search('.{3,}ages?', word):
            words_age_lefff.add(word)

print("{} different forms in Lefff and {} ending in -age".format(len(set_words_lefff), len(words_age_lefff)))

diff_lefff = set_words_frwac.difference(set_words_lefff)
print("il y a {} formes en 'age' not present in Lefff".format(len(diff_lefff)))

diff_lefff_lexique = diff.difference(set_words_lefff)
print("il y a {} formes en 'age' not present in Lefff et and Lexique".format(len(diff_lefff_lexique)))

new_words = sorted(diff, key=lambda x: words_frwac[x], reverse=True)
new_words_counts = [words_frwac[w] for w in new_words]

with open('candidate-age-frwac.txt', 'w') as f_diff:
    for item in sorted(diff_lefff, key=lambda x: words_frwac[x], reverse=True):
        print(item, words_frwac[item], file=f_diff)

#### Sampling of new_words list #####
#####################################

## As the list is too long we sample it following the method below
k = 20
N = len(new_words)
q = N // k  # division rounded of to 0
r = N % k   # gives the remainder of the rounded of to 0 division

sublists = [new_words[i*q:(i+1)*q] for i in range(k)]  # splits the q*k first words in k sublists
sublists[-1] += new_words[-r:]  # add the remainder to the last sublist

from random import seed, sample
seed(0)

## We randomly draw 100 words per sublist and write them into a file

with open('sampled_words.txt', 'w') as file:
    for sublist in sublists:
        sampled = sample(sublist, 100)
        for word in sorted(sampled, key=lambda w: -words_frwac[w]):
            print(word, " ", words_frwac[word], file=file)