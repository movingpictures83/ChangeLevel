# ChangeLevel
# Language: R
# Input: TXT (keyword-value pairs)
# Output: PREFIX
# Tested with: PluMA 1.1, R 4.0.0
# Dependency: microbiome_1.12.0, ape_5.4.1, psadd_0.1.3

PluMA plugin to accept phyloseq-compatible input and change
the phylogenetic level of the analysis, producing phyloseq-compatible
output files at that level.

The plugin accepts as input a tab-delimited parameter file of keyword value pairs:
otufile: OTU table
tree: Taxonomy table
mapping: Metadata
column  Target taxa rank

The plugin will generate a new OTU table, taxonomy table and metadata at the level of the user-specified column.  The files will be named otu_table.out.csv, tax_table.out.csv and sample_data.out.csv, prefixed by the user-specified output PREFIX.
