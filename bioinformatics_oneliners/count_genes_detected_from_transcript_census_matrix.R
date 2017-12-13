#!/bin/Rscript

library(biomaRt)
library(dplyr)
ensembl  <- useMart(host="www.ensembl.org", "ENSEMBL_MART_ENSEMBL",  dataset="hsapiens_gene_ensembl")

gene_sym_from_trsid <- function(x, query_col, mart, ...){

  query_col <- deparse(substitute(query_col))

  biomaRt_result <- getBM(attributes=c('ensembl_transcript_id', 'ensembl_gene_id', 'hgnc_symbol'), filters =
                            'ensembl_transcript_id', values = x[[query_col]], mart = mart)
  biomaRt_result <- data.frame(biomaRt_result, stringsAsFactors = FALSE)
  output <-  left_join(as.data.frame(biomaRt_result), x, by = "ensembl_transcript_id")
}

trs_detected_path <- "~/single_cell_pipeline/data/sc_cone_devel/sc_cone_devel_H_sapiens/FACS_20171031_sunlee_H_sapiens/"
trs_detected_file <- paste0(trs_detected_path, "transcripts_detected.csv")

trs_detected <- read.table(trs_detected_file, sep = "\t", stringsAsFactors = FALSE)

colnames(trs_detected) <- c("ensembl_transcript_id", "fpkm")

genes_detected <- gene_sym_from_trsid(trs_detected, ensembl_transcript_id, ensembl)

write.table(genes_detected, paste0(trs_detected_path, "genes_detected.csv"), sep = "\t", row.names = FALSE)


