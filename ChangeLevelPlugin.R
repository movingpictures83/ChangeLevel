dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")

library(microbiome)
#library(ggplot2)
#library(phyloseq)
library(ape)
library(psadd)

input <- function(inputfile) {
  pfix = prefix()
  if (length(pfix) != 0) {
     pfix <- paste(pfix, "/", sep="")
  }
  
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1]; 
   # Need to get the three files
#paste(pfix, toString(parameters["inputfile",2]), sep="")
  otu.path <<- toString(parameters["otufile", 2])
  tree.path <<- toString(parameters["tree", 2])
  map.path <<- toString(parameters["mapping", 2])
  if (!(startsWith(otu.path, "/"))) {
   otu.path <<- paste(pfix, otu.path, sep="")
  }
  if (!(startsWith(tree.path, "/"))) {
   tree.path <<- paste(pfix, tree.path, sep="")
  }
  if (!(startsWith(map.path, "/"))) {
   map.path <<- paste(pfix, map.path, sep="")
  }
   diffcol <<- parameters["column", 2]
   #HMP <<- import_qiime(otu.path, map.path, tree.path, parseFunction = parse_taxonomy_qiime)
}
run <- function() {
   #samples.to.keep <<- sample_sums(HMP) >= 1000
   #HMP <<- prune_samples(samples.to.keep, HMP)
   #HMP <<- filter_taxa(HMP, function(x) sum(x >3) > (0.01*length(x)), TRUE)
   p0 <<- read_csv2phyloseq(otu.file=otu.path, taxonomy.file=tree.path, metadata.file=map.path)
   #print(tax_glom(p0, taxrank = 'Phylum', NArm=T))
}
output <- function(outputfile) {
  #pdf(paste(outputfile,"pdf",sep="."), width=8, height=8)#,  width = 10*300,        # 5 x 300 pixels
  #height = 10*300); #,)
  #print(rank_names(p0))
  #print(tax_table(p0))
  y <<- tax_glom(p0, taxrank = diffcol, NArm = T)
  #y <- plot_bar(p0, x="Sample", fill=diffcol) + theme(legend.position="bottom", legend.title = element_text(size=2),
  #legend.text = element_text(size=1)) + guides(col = guide_legend(ncol = 15))
  #y <- plot_bar(p0, x="Sample", fill=diffcol) + theme(legend.position="bottom", legend.title = element_text(size=3),
#legend.text = element_text(size=3)) + guides(fill = guide_legend(ncol = 12, keyheight=0.5, keywidth=0.5)) 
  #ggsave(paste(outputfile,"pdf",sep="."), y, width=10, dpi=300)
  #print(str(y))
  #print("Generating CSV...")
  #print(str(y$data))
  write.csv(otu_table(y), paste(outputfile,"otu_table.out.csv",sep="/"))
  write.csv(tax_table(y), paste(outputfile,"tax_table.out.csv",sep="/"))
  write.csv(sample_data(y), paste(outputfile,"sample_data.out.csv",sep="/"))
  #print(y)#plot_bar(HMP, x="Description", fill=diffcol))
  #dev.off()
}
#input("plugins/Bar/example/parameters.txt")
#run()
#output("plugins/Bar/example/yes.pdf")

