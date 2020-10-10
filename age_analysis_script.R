########################################################################
# Analysis script for the novel nominalization ending with the suffix -age
########################################################################

# Setting the working directory
################################################
getwd()
setwd("C:/Users/...")

# Loading packages
################################################
library(lmerTest)
library(LMERConvenienceFunctions)
library(lme4)
library(languageR)
library(lsmeans)
library(optimx)
library(ggplot2)
library(lattice)
library(finalfit)
library(effects)
library(forcats)
library(dplyr)

# Data preparation
################################################
Data <- read.delim("n_age_sample.txt")
summary(Data)

# Data of the 156 different verbs that gives the 181 polysemes
DataV <- read.delim("v_age_sample.txt")
summary(DataV)

# Creation of the variable "pat", that account for the patientive or non-patientive argumental structure
DataV$pat <- with(DataV, interaction( v_rol_suj,  v_rol_obj, v_rol_obq), drop = TRUE )
levels(DataV$pat)[levels(DataV$pat)=="ag.pa.na"] <- "pa"
levels(DataV$pat)[levels(DataV$pat)=="ag.pa.pa"] <- "pa"
levels(DataV$pat)[levels(DataV$pat)=="pa.na.na"] <- "pa"
levels(DataV$pat)[levels(DataV$pat)=="ag.pa.loc"] <- "pa"
levels(DataV$pat)[levels(DataV$pat)=="ag.th.na"] <- "non_pa"
levels(DataV$pat)[levels(DataV$pat)=="ag.na.na"] <- "non_pa"
levels(DataV$pat)[levels(DataV$pat)=="ag.loc.na"] <- "non_pa"
levels(DataV$pat)[levels(DataV$pat)=="ag.th.loc"] <- "non_pa"
levels(DataV$pat)[levels(DataV$pat)=="ag.na.th"] <- "non_pa"
levels(DataV$pat)[levels(DataV$pat)=="ag.th.benf"] <- "non_pa"
levels(DataV$pat)[levels(DataV$pat)=="th.loc.na"] <- "non_pa"
levels(DataV$pat)[levels(DataV$pat)=="exp.na.na"] <- "non_pa"
levels(DataV$pat)[levels(DataV$pat)=="ag.na.loc"] <- "non_pa"
levels(DataV$pat)[levels(DataV$pat)=="pa.na.pa"] <- "pa"
levels(DataV$pat)[levels(DataV$pat)=="ag.exp.na"] <- "non_pa"
levels(DataV$pat)[levels(DataV$pat)=="sg.na.na"] <- "non_pa"
levels(DataV$pat)[levels(DataV$pat)=="th.na.na"] <- "non_pa"
levels(DataV$pat)[levels(DataV$pat)=="exp.th.na"] <- "non_pa"
levels(DataV$pat)[levels(DataV$pat)=="exp.na.th"] <- "non_pa"
levels(DataV$pat)[levels(DataV$pat)=="ag.pa.th"] <- "pa"
DataV$pat = droplevels(DataV$pat)
summary(DataV)




# Data visualisation
################################################
# Grouping data by the studied factors, ie. patientitvity (pat) and telicity (v_tel)
data <- DataV %>% group_by(pat, v_tel, act_res, .drop = FALSE) %>% summarize(n=n()) %>% mutate(prop=(n/sum(n)))

# Figure of the proportion of 'action' / 'result' polysemy by factor
ggplot(data, aes(x=pat:v_tel, y=prop, fill = act_res, group = act_res)) + geom_bar(position ="stack", stat="identity") +
  geom_text(aes(label=n), color="black", size = 3.5, hjust = 0.5, vjust = -0.3, position = "stack") +
  ylab(label = "Taux de polysémie 'action' / 'résultat'") +
  scale_x_discrete(labels = c("Atélique sans patient", "Télique sans patient", "Atélique avec patient", "Télique avec patient")) +
  scale_fill_manual(name="Polysémie 'action' / 'résultat'", labels = c("Non", "Oui"), values = c("#F8766D","#00BFC4")) +
  theme_minimal() + theme(axis.title.x=element_blank(), axis.text.x = element_text(vjust= 0.3), legend.position="bottom",
                          legend.direction = "horizontal", strip.background = element_blank(), strip.text.x = element_blank())


# Data description
################################################
# Distribution of verbs by transitivity
table(DataV$v_trans)
# Distribution of verbs by aspect
table(DataV$v_asp)
# Distribution of verbs per number of arguments
table(DataV$v_nb_arg)

# Distribution of the 181 senses by ontological category
table(Data$n_onto)
# Distribution of the 181 senses by aspect
table(Data$n_rel, Data$n_onto)
# Distribution of the 181 senses by the role of their complements
table(Data$n_rol_cplt2, Data$n_rol_cplt3)

df_asp <- subset(Data, n_onto != "cog" & n_onto != "obj" & herit_asp != "na" & n_polys == "non")
df_asp$herit_asp = droplevels(df_asp$herit_asp)
summary(df_asp)
# Relation between verb aspect (vertical) and derived nouns aspect (horizontal)
table(df_asp$v_asp, df_asp$n_asp)
# Relation between verbal argumental structure (vertical) and noun argumental structure (horizontal)
table(df_asp$v_nb_arg, df_asp$n_nb_arg)


# Data chi-squared analysis
################################################
# Comparison of the transitivity data with the repartition of the verbs of "Les verbes français" (Dubois & Dubois-Charlier 1997)
df_transitivity <- data.frame("intransitif" = c(39,6029), "transitif" = c(117,19580))
chisq.test(df_transitivity, correct = FALSE)

DataEvent <- subset(Data, n_onto != "cog" & n_onto != "obj")
summary(DataEvent) # The summary indicates 8 cases of non-inheritance for 156 cases of inheritance
# Comparison of the inheritance of the aspect between the verb and the noun
df_herit <- data.frame("décalage" = c(8,12), "héritage" = c(156,44))
chisq.test(df_herit, correct = FALSE)


# Analysis of the 'action' / 'result' polysemy with a logistic regressions
################################################

# Model with patientivity as predictor
glm_act_res_pat_vtel1 = glm(act_res ~ pat,data=DataV, family="binomial")
drop1(glm_act_res_pat_vtel1, test = "Chisq")  # patientivity alone as a predictor is not significant (p = 0.1566)
# Model with telicity as predictor
glm_act_res_pat_vtel2 = glm(act_res ~ v_tel,data=DataV, family="binomial")
drop1(glm_act_res_pat_vtel2, test = "Chisq") # telicity alone as a predictor is not significant (p = 0.3188)
# Model with telicity and patientivity as predictors
glm_act_res_pat_vtel3 = glm(act_res ~ pat + v_tel,data=DataV, family="binomial")
drop1(glm_act_res_pat_vtel3, test = "Chisq") # both predictors are not significant (p = 0.2686, resp. 0.6459)
# Model with an interaction between telicity and patientivity as predictor
glm_act_res_pat_vtel4 = glm(act_res ~ pat * v_tel,data=DataV, family="binomial")
drop1(glm_act_res_pat_vtel4, test = "Chisq") # the interaction is significant (p = 0.003783)
summary(glm_act_res_pat_vtel4)

# Post-hoc multiple comparisons with the interaction term using the package lsmeans 
lsmeans(glm_act_res_pat_vtel4, pairwise~pat|v_tel, adjust="Tukey") # effect of patientivity inside both modalities of telicity
lsmeans(glm_act_res_pat_vtel4, pairwise~v_tel|pat, adjust="Tukey") # effect of telicity inside both modalities of patientivity

# The following function allows for the transformation from logit to probabilities of the estimates given by the logistic regression
logit2prob <- function(logit){odds <- exp(logit)
prob <- odds / (1 + odds)
return(prob)}

# Transformation of the results using the logit2prob function with the vector of estimate per category c(non_pa:n_tel, pa:n_tel, non_pa:tel, pa:n_tel)
round(logit2prob(c(-1.7707, -1.7707-15.7954, -1.7707-1.0019, -1.7707-1.0019-15.7954+17.4440)), 8)
