setwd('~/repos/djinni-graphs')
source("code/data_import.R")

library(ggplot2)

#
# How many pokes for each skill does a candidate receive?
#
# qplot(data=candidates, x=Skill, y=PokesTotal, geom="boxplot")

#
# Supply vs Demand
#
demand <- cbind(pokes, as.factor(rep("Предложения компаний", nrow(pokes))))
names(demand) <- c("Skill", "City", "Salary", "Type")

supply <- cbind(candidates[,c("Skill", "City", "Salary")], as.factor(rep("Запросы кандидатов", nrow(candidates))))
names(supply) <- c("Skill", "City", "Salary", "Type")

demand_supply <- rbind(demand, supply)

demand_supply_plot <- ggplot(demand_supply, 
                             aes(x = Skill, y = Salary, fill = Type)) + 
  geom_boxplot() + scale_y_continuous(breaks=seq(0, 5500, 250)) + 
  coord_cartesian(ylim=c(0, 5500)) + xlab("") + ylab("Зарплата") + labs(title="Предложения компаний VS Запросы кандидатов")
