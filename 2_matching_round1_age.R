## First matching step: match FFA cases to UKB controls based on age with a ratio of 1:200

library("MatchIt")

data_ocp <- read.table("file.txt",           ## file.txt contains merged case and controls with age at assessment
                       header = TRUE,
                       stringsAsFactors = FALSE,
                       sep = "")

m.out1 <- matchit(status ~ age, data = data_ocp,
          method = "nearest", distance = "glm", ratio =200)

summary(m.out1)

m.data1 <- match.data(m.out1)

write.table(m.data1, file = "match_it_file.txt", sep = "\t", quote = FALSE,
            row.names = FALSE, col.names = TRUE)
