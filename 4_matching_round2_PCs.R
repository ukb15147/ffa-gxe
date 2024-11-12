## Refine the matching of FFA cases to UKB controls, by matching on the first four ancestry PCs
## within the previously matched control group (to a ratio of 1:66)

library("MatchIt")

data_ocp2 <- read.table("file2.txt",          ## File containing FFA status (case/control) and 4x ancestry PCs
                       header = TRUE,
                       stringsAsFactors = FALSE,
                       sep = "")

m.out2 <- matchit(status ~ PC1 + PC2 + PC3 + PC4,
                  data = data_ocp2,
                  method = "nearest",
                  distance = "glm",
                  ratio =66)

summary(m.out2)
m.data2 <- match.data(m.out2)

write.table(m.data2, file = "match_it_file2.txt", sep = "\t", quote = FALSE,
            row.names = FALSE, col.names = TRUE)
