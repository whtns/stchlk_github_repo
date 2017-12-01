#!/usr/bin/Rscript

library(readxl)
library(tidyverse)
tst <- read_excel("data/aag1166_Table S1.xlsx")

tst <- mutate(tst, small_mol_druggable = ifelse(small_mol_druggable == "N", NA, small_mol_druggable)) %>% 
  mutate(bio_druggable = ifelse(bio_druggable == "N", NA, bio_druggable)) %>% 
  gather("drug_cat", "count", 10:11) %>% 
  filter(!is.na(count)) %>% 
  filter(druggability_tier != "Tier_3B") %>% 
  arrange(ensembl_gene_id)

png("doc/finan_fig_1.png")
ggplot(tst, aes(drug_cat)) + geom_bar() + facet_grid(. ~ druggability_tier) + 
  ggtitle("Number of Druggable Genes by Tier") + xlab("Druggability") + ylab("Count of Genes") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))
dev.off()


  
