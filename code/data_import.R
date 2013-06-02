#
# Data Import and Cleaning
#
setwd('~/repos/djinni-graphs')
#library(reshape)

candidates <- read.csv("data/candidates.csv")
pokes <- read.csv("data/pokes.csv")
queries <- read.csv("data/searches.csv")

# Join "PM" and "Project Manager" skills
pm <- c("PM", "Project Manager", "Manager", "Product Manager")
levels(candidates$Skill)[levels(candidates$Skill) %in% pm] <- "PM"
levels(pokes$Keyword)[levels(pokes$Keyword) %in% pm] <- "PM"

# Join "Rails" and "Ruby" skills
ruby <- c("Rails", "Ruby")
levels(candidates$Skill)[levels(candidates$Skill) %in% ruby] <- "Ruby"
levels(pokes$Keyword)[levels(pokes$Keyword) %in% ruby] <- "Ruby"

# Remove skills with less then 10 candidates
levels <- levels(candidates$Skill)
for (i in 1:length(levels)) {
  if (nrow(candidates[candidates$Skill == levels[i],]) < 30) {
    candidates <- candidates[-which(candidates$Skill == levels[i]), ]
  }
}

# Remove empty skills and keywords
candidates <- candidates[-which(candidates$Skill == ""), ]
pokes <- pokes[-which(pokes$Keyword == ""), ]
candidates$Skill <- factor(candidates$Skill)

# Select the same keywords as filtered candidate skills
skill <- intersect(levels(pokes$Keyword), levels(candidates$Skill))
pokes <- subset(pokes, Keyword %in% skill)

# Remove empty skills and keywords
pokes$Keyword <- factor(pokes$Keyword)