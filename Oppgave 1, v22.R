# Henter inn alle pakkene jeg skal bruke
# - - - - - - - - - - - - - - - - - - - 

library(readr)
library(zoo)
library(ggplot2)
library(dplyr)
library(gglorenz)
library(ineq)
library(tidyr)
library(tidyverse)

# Oppgave 1
# Henter inn datasettet og gir den navn "lt" 
# - - - - - - - - - - - - - - - - - - - - - 


lt <- read_table2("https://www.nsstc.uah.edu/data/msu/v6.0/tlt/uahncdc_lt_6.0.txt")
View(lt)


# Fjerner de unødvendige radene nederst på datasettet 
# - - - - - - - - - - - - - - - - - - - - - - - - - -

lt <- lt[-c(518 : 529), ]


# Lager en plot og regner ut gjennomsnittet 
# - - - - - - - - - - - - - - - - - - - - - - - - - - - 

lt.cut <- subset(lt, select = -c(Mo, Land, Ocean, NH, Land_1, Ocean_1, SH, Land_2, Ocean_2, Trpcs, Land_3, Ocean_3, NoExt, Land_4, Ocean_4, SoExt, Land_5, Ocean_5, NoPol, Land_6, Ocean_6, SoPol, Land_7, Ocean_7, USA48, USA49, AUST))

lt.cut.1 <- lt.cut %>% select(-Year)

lt.gjennomsnitt <- zoo(lt.cut.1, 12)

lt.gjennomsnitt

plot(lt.cut, ylim = c(-0.7, 0.9), main = "Temperatur i den nedre troposføre",
     ylab = "Temperatur",
     xlab = "Årstall",
     type = "b",
     col = "blue")


# Oppgave 2
# Henter inn alle datasettene og kutter dem
# - - - - - - - - - - - - - - - - - - - - -

library(readr)
mt <- read_table2("https://www.nsstc.uah.edu/data/msu/v6.0/tmt/uahncdc_mt_6.0.txt")
View(mt)

mt <- mt[-c(518 : 529), ]

library(readr)
tp <- read_table2("https://www.nsstc.uah.edu/data/msu/v6.0/ttp/uahncdc_tp_6.0.txt")
View(tp)

tp <- tp[-c(518 : 529), ]

library(readr)
ls <- read_table2("https://www.nsstc.uah.edu/data/msu/v6.0/tls/uahncdc_ls_6.0.txt")
View(ls)

ls <- ls[-c(518 : 529), ]

# Kombinerer de forskjellige datasettene 
# - - - - - - - - - - - - - - - - - - - -

nopol <- do.call("rbind", list(lt, mt, tp, ls))

nopol

nopol <- nopol %>% select(-Mo, -Globe, -Land, -Ocean, -NH, -Land_1, -Ocean_1, -SH, -Land_2, -Ocean_2, -Trpcs, -Land_3, -Ocean_3, -NoExt, -Land_4, -Ocean_4, -SoExt, -Land_5, -Ocean_5, -Land_6, -Ocean_6, -SoPol, -Land_7, -Ocean_7, -USA48, -USA49, -AUST)

nopol

# lager et plot og regner ut gjennomsnittet
# - - - - - - - - - - - - - - - - - - - - -

nopol.o <- nopol %>% select(-Year)

nopol.gjennomsnitt <- zoo(nopol.o, 12)

nopol.gjennomsnitt

plot(nopol$Year,nopol$NoPol,
     main = "Temperatur i atmosføren",
     ylab = "Temperatur",
     xlab = "Årstall",
     col = "blue")

