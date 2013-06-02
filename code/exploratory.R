source("code/data_import.R")

# On average how many pokes for each skill does a candidate receive?
plot(candidates$Skill, candidates$PokesTotal, las=2)

# How many search queries for each skill do we have?
plot(queries$Keyword)

# On average how many pokes does a candidate receive if he is looking for fulltime,
# fulltime+relocate or freelance job?
par(mfrow=c(1, 1), mar=c(6, 4, 2, 2))
plot(candidates$Employment, candidates$PokesTotal, las=2)

# Supply vs Demand
par(mfrow=c(2, 1), mar=c(5, 4, 4, 2))
plot(candidates$Skill, candidates$Salary, las=2, main="Dev's demand", ylim=c(0, 8000))
plot(pokes$Keyword, pokes$Salary, las=2, main="Corps supply", ylim=c(0, 8000))

distance <- dist(candidates$PokesTotal)
