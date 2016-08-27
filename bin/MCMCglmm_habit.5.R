# run general linear mixed model including phylogeny to test quant traits vs. growth habit
library(ape)
library(MCMCglmm)

# working directory on cluster
setwd("~/Analysis/moorea")

# define function to extract p value table from summary as dataframe, append model name
summary_to_csv <- function (model) {
  results.df <- as.data.frame(summary(model)$solutions)
  results.df$model <- paste(model$Fixed$formula[2], model$Fixed$formula[1], model$Fixed$formula[3], sep = " ")
  results.df$effect <- rownames(results.df)
  rownames(results.df) <- NULL
  colnames(results.df) <- c("Parameter estimate", "Lower 95% CI", "Upper 95% CI", "Effective sample size", "P-value", "Model", "Effect")
  return(results.df)
}

# set tree file
tree_file <- "data/treepl_Moorea_Tahiti_2016-01-03.tre"

# load tree
phy <- read.tree(tree_file)

# to run on cluster, use pre-processed trait data
trait_file <- "data/traits_glmm.csv"
traits <- read.csv(trait_file, row.names=1)

# trim to only species with trait data
phy <- drop.tip(phy, phy$tip.label[!(phy$tip.label %in% rownames(traits))])

# get traits in same order as tips
traits <- traits[phy$tip.label,]

################################
### set up data for MCMCglmm ###
################################

# define traits to test
sporo_traits <-c("stipe", "length", "width", "rhizome", "dissection", "pinna", "SLA")
traits.test <- c(sporo_traits, "habit")

# MCMCglmm can't take NA values
# make list of trait dataframes and phylogenies which only include species with no NA values for the traits I'm going to test
traits.list <- list()
phy.list <- list()
inv.phy <- list()
for (i in 1:length(traits.test)) {
  traits.list[[i]] <- traits[!(is.na(traits[,traits.test[i]])), ]
  phy.list[[i]] <- drop.tip(phy,  phy$tip.label[!(phy$tip.label %in% rownames(traits.list[[i]]))])
  inv.phy[[i]] <-inverseA(phy.list[[i]],nodes="TIPS",scale=TRUE)
  traits.list[[i]] <- traits.list[[i]][phy.list[[i]]$tip.label, ]
  traits.list[[i]]$species <- rownames(traits.list[[i]])
}

# run MCMCglmm

# set number of generations
# 10,000 thousand takes about 13 sec
# 5,000,000 takes about 2 hr? (recommended number in tutorial)
# http://www.mpcm-evolution.org/practice/online-practical-material-chapter-11/chapter-11-1-simple-model-mcmcglmm
# set to 600,000 (about 1 hr) to test on cluster
# num <- 600000
num <- 10000

# define new prior list. Need one G for each random effect, one R for each fixed effect
my.prior<-list(G=list(G1=list(V=1,nu=0.02)),
               R=list(R1=list(V=1,nu=0.02)))

# Set trait number
i <- 5

# Start the clock!
ptm <- proc.time()

# run MCMCglmm
model <-MCMCglmm(formula(paste(traits.test[i], "~ habit"), sep=""), 
                random=~species, 
                family="gaussian", 
                ginverse=list(species=inv.phy[[i]]$Ainv), 
                prior=my.prior, 
                data=traits.list[[i]], 
                nitt=num,burnin=1000,thin=500)

# Stop the clock
proc.time() - ptm

# print output
summary(model)

results.df <- summary_to_csv(model)

write.csv (results.df, file=paste("bin/", Sys.Date(),"/","mcmcglmm_habit_", traits.test[i], ".csv",sep=""))

pdf(file=paste("bin/",Sys.Date(),"/","mcmcglmm_habit_", traits.test[i], ".pdf",sep=""))
plot(model$Sol, auto.layout=F)
dev.off()