#
# Data Import and Cleaning
#
setwd('~/repos/djinni-graphs')

candidates <- read.csv("data/candidates.csv")
pokes <- read.csv("data/pokes.csv")
queries <- read.csv("data/searches.csv")

# Join "PM" and "Project Manager" skills
pm <- c("PM", "Project Manager", "Manager", "Product Manager")
levels(candidates$Skill)[levels(candidates$Skill) %in% pm] <- "Project Manager"
levels(pokes$Keyword)[levels(pokes$Keyword) %in% pm] <- "Project Manager"

# Join "Rails" and "Ruby" skills
ruby <- c("Rails", "Ruby")
levels(candidates$Skill)[levels(candidates$Skill) %in% ruby] <- "Ruby"
levels(pokes$Keyword)[levels(pokes$Keyword) %in% ruby] <- "Ruby"

# Join "HTML", "JavaScript", "Front-end" skills
# front_end <- c("HTML", "JavaScript", "Front-end")
# levels(candidates$Skill)[levels(candidates$Skill) %in% front_end] <- "Front-end"
# levels(pokes$Keyword)[levels(pokes$Keyword) %in% front_end] <- "Front-end"

# Change Front-end to JavaScript in pokes
levels(pokes$Keyword) <- sub("Front-end", "JavaScript", levels(pokes$Keyword))

# Remain only candidates which have online or stopped status
candidates <- candidates[which(candidates$Status == "online" | candidates$Status == "stopped"), ]

# Update factor levels for skills
candidates$Skill <- factor(candidates$Skill)

# Remove skills with less then 10 candidates
# levels <- levels(candidates$Skill)
# for (i in 1:length(levels)) {
#   if (nrow(candidates[candidates$Skill == levels[i],]) < 10) {
#     candidates <- candidates[-which(candidates$Skill == levels[i]), ]
#   }
# }

# Choose skills according to Max set
candidates <- candidates[which(candidates$Skill == "JavaScript" | candidates$Skill == "iOS" |
                                 candidates$Skill == "QA" | candidates$Skill == "PHP" | 
                                 candidates$Skill == "C++" | candidates$Skill == "Java" | 
                                 candidates$Skill == "Android" | candidates$Skill == "Lead" | 
                                 candidates$Skill == "Python" | candidates$Skill == ".NET" |
                                 candidates$Skill == ".NET" | candidates$Skill == "Project Manager" |
                                 candidates$Skill == "Ruby"), ]

# Remove empty skills and keywords
# candidates <- candidates[-which(candidates$Skill == ""), ]
# pokes <- pokes[-which(pokes$Keyword == ""), ]

# Update factor levels for skills
candidates$Skill <- factor(candidates$Skill)

# Select the same keywords as filtered candidate skills
skill <- intersect(levels(pokes$Keyword), levels(candidates$Skill))
pokes <- subset(pokes, Keyword %in% skill)

# Update factor levels for keywords
pokes$Keyword <- factor(pokes$Keyword)