# --- 
# title: "Methodological quality, research disclosures, editorial decisions, and social dissemination efforts influence differently the bibliometric impact of systematic reviews and meta-analysis about psoriasis" 
# author: "Juan Ruano" 
# date: "09 June 2017" 
# institutions: Department of Dermatology, IMIBIC/Reina Sofia University Hospital/University of Cordoba, Cordoba, Spain
# analysis: 01_abstract and full text readability
# --- 
# 
# R version 3.3.3 (2017-03-06)
# Platform: x86_64-apple-darwin13.4.0 (64-bit)
# Running under: OS X Mavericks 10.9.5

####### R packages -----------
########  Altmetrics analysis ---------------
install.packages('rAltmetric')
devtools::install_github("ropensci/rAltmetric")
library("rAltmetric")
library("magrittr")
library("purrr")

########  Data visualitation and analysis ---------------
library("tidyverse")
library("ggplot2")
library("forcats")

########  Boxplots and ANOVAs ---------------
install.packages("ggpubr")
library("ggpubr")
library("ggsignif")
library("ggrepel")
library("ggExtra")

########  Panel plot ---------------
library("ggthemes")
library("scales")

########  Multiple Factor Analysis (MFA) ---------------
library("FactoMineR")
library("missMDA")

########  Comparing dendrograms ---------------
library("factoextra")
library("dendextend")
library("viridis")

####### 1: Altmetrics analysis ---------------------------------
####### list of DOIs -----------
# commented DOIs got faillure when trying to scrape from Altmetrics

ids                <- list(c(
                        "10.1007/s12016-016-8560-9",
                        "10.1016/j.smrv.2015.09.003",
                        "10.1007/s10096-016-2647-3",
                        "10.1586/1744666X.2016.1147954",
                        "10.1111/bjd.14435",
                        "10.1186/s12944-016-0271-y",
                       # "10.3109/08916934.2016.1166215",
                       # "10.1080/09546634.2016.1178375",
                        "10.1371/journal.pone.0153740",
                        "10.1177/1203475415616073",
                        "10.1016/j.jdermsci.2016.02.008",
                        "10.1053/j.gastro.2016.03.037",
                       # "10.1016/j.ctim.2015.12.014",
                        "10.4103/0378-6323.175919",
                        "10.1089/acm.2014.0212",
                        "10.4103/0019-5154.177771",
                      #  "10.1002/14651858.CD009687.pub2.",
                      #  "10.1080/21645515.2015.1081322",
                        "10.1007/s00296-015-3377-z",
                      #  "10.1111/1346-8138.13039",
                      # "10.1097/MJT.0000000000000330",
                      # "10.4103/0378-6323.172902",
                        "10.1097/MD.0000000000003676",
                        "10.1155/2016/9503652",
                        "10.1111/bjd.13486",
                        "10.1111/bjd.13691",
                        "10.1177/1060028015626545",
                        "10.1111/bjd.14507",
                        "10.1016/j.jaad.2016.02.1221",
                      #  "10.1097/MD.0000000000003576",
                      #  "10.3109/09546634.2015.1107180",
                        "10.1136/annrheumdis-2015-207841",
                        "10.1371/journal.pone.0145076",
                        "10.1007/s10198-014-0638-9",
                      #  "10.4238/2015.November.18.3",
                        "10.1007/s12325-015-0256-7",
                        "10.1186/s13020-015-0060-y",
                        "10.1177/1203475415586332",
                        "10.1038/ijo.2015.64",
                        "10.1111/bjd.14676",
                        "10.1186/s12944-015-0039-9",
                        "10.2147/PTT.S58010",
                        "10.1002/ptr.5316",
                        "10.1371/journal.pone.0157843",
                        "10.1111/jdv.12847",
                        "10.2340/00015555-1980",
                        "10.1111/jdv.12845",
                        "10.1136/bmj.h1269",
                        "10.1136/annrheumdis-2014-206624",
                        "10.1007/s13555-015-0068-3",
                        "10.1111/jdv.12749",
                        "10.1111/bjd.13437",
                        "10.1016/j.ijcard.2014.10.092",
                        "10.1111/phpp.12092",
                        "10.1038/jid.2015.206",
                        "10.1111/bjd.14077",
                        "10.1016/j.gene.2015.05.051",
                        "10.1016/j.jgg.2015.01.001",
                       # "10.3109/09546634.2014.927816",
                        "10.1016/j.jaad.2015.05.001",
                        "10.1111/jdv.12909",
                        "10.1111/ddg.12621",
                        "10.1016/j.jaad.2014.10.013",
                        "10.1159/000381225",
                        "10.2217/imt.15.50",
                        #"10.2147/PTT.S49996",
                        "10.3310/hta19860",
                        "10.4103/1947-2714.168657",
                        "10.1007/s40273-014-0244-9",
                       # "10.1007/s12013-014-0104-4",
                        "10.3899/jrheum.140880",
                       # "10.1093/qjmed/hcu073",
                        "10.1093/rheumatology/keu172",
                        "10.3899/jrheum.141112",
                        #"10.1089/dna.2013.2252",
                        #"10.1111/jdv.12256",
                        "10.1111/jdv.12106",
                        "10.1111/bjd.12663",
                        "10.1111/bjd.12670",
                        "10.1016/j.pec.2013.10.005",
                        "10.1111/bjd.12654",
                        "10.1002/ptr.5028",
                        "10.1111/ced.12390",
                        "10.1111/jdv.12562",
                        "10.1001/jamadermatol.2014.1111",
                       # "10.1155/2014/926836",
                        "10.1111/jdv.12238",
                       # "10.2310/7750.2014.13191",
                        "10.1111/ijd.12607",
                        "10.1111/bjd.12941",
                        "10.1111/bjd.12905",
                        "10.1038/jid.2013.508",
                        "10.1111/ddg.12396",
                        "10.1111/jdv.12560",
                        "10.1111/jdv.12239",
                        "10.1016/j.eujim.2014.01.010",
                        "10.1007/s40273-014-0130-5",
                        "10.1007/s40257-014-0064-x",
                        "10.1111/pde.12351",
                        "10.1016/j.atherosclerosis.2013.10.023",
                        "10.1586/14737167.2014.933671",
                        "10.1111/jdv.12561",
                        "10.1111/jdv.12563",
                        "10.1016/j.jtumed.2013.09.001",
                        "10.1136/annrheumdis-2012-202220",
                        #"10.1111/ced.12136",
                        "10.1016/j.jaad.2013.06.053",
                        "10.2147/BTT.S37606",
                       # "10.1016/j.jaad.2013.06.027",
                       # "10.1590/0102-311X00157013",
                        "10.1111/bjd.12557",
                        "10.1111/bjd.12473",
                        "10.1038/jid.2013.149",
                        "10.1016/j.jaad.2013.03.029",
                        "10.1097/HJH.0b013e32835bcce1",
                        "10.1001/jamainternmed.2013.7430",
                        "10.1155/2013/673078",
                        "10.1111/bjd.12355",
                        "10.1111/jdv.12162",
                        "10.1111/jdv.12165",
                        "10.1111/jdv.12163",
                        "10.1111/jdv.12058",
                       # "10.1111/bjd.12387",
                        "10.1111/jdv.12164",
                       # "10.1002/14651858.CD005028.pub3",
                        "10.1007/s00296-012-2637-4",
                        "10.1111/ced.12171",
                        # "10.1111/j.1365-4632.2012.5813.x",
                        "10.1111/1346-8138.12121",
                        "10.3109/09546634.2012.713462",
                        "10.1111/bjd.12276",
                        "10.1111/j.1468-3083.2012.04500.x",
                        "10.1016/j.jaad.2012.08.015",
                        "10.1007/s00403-013-1316-y",
                        "10.1161/JAHA.113.000062",
                        "10.1007/s40257-013-0015-y",
                        "10.1111/j.1468-3083.2012.04640.x",
                        "10.1007/s40257-013-0030-z",
                        "10.1111/bjd.12101",
                        "10.1038/jid.2012.339",
                        "10.1001/2013.jamadermatol.406",
                       # "10.1016/j.arcmed.2012.10.009",
                        "10.1111/jcpt.12044",
                        "10.1111/bjd.12039",
                        #"10.1111/bjd.12490",
                        "10.1002/14651858.CD009481.pub2",
                        "10.1136/ebmed-2011-100388",
                        "10.1038/nutd.2012.26",
                        "10.1111/bjd.12002",
                        #"10.1001/2013.jamadermatol.238",
                        "10.1590/S0482-50042012000600011", 
                        #"10.1111/j.1468-3083.2012.04492.x",
                        "10.1007/s00403-012-1266-9",
                        "10.1111/pde.12351",
                        "10.2340/00015555-1304",
                        "10.1111/bjd.12557",
                        "10.1371/journal.pone.0033486",
                        "10.1111/j.1468-3083.2012.04524.x",
                        #"10.1111/j.1468-3083.2012.04519.x",
                        "10.1111/j.1468-3083.2012.04518.x",
                        #"10.1111/j.1468-3083.2012.04523.x",
                       # "10.1111/j.1468-3083.2012.04522.x",
                        # "10.1111/j.1468-3083.2012.04520.x",
                        # "10.1111/j.1468-3083.2012.04525.x",
                        "10.1111/j.1468-3083.2012.04521.x",
                        "10.1001/archdermatol.2011.1916",
                        #"10.1007/s11655-012-1004-3",
                        "10.1016/j.jaad.2011.01.022",
                       # "10.1111/j.1365-2133.2011.10583.x",
                       # "10.3109/09546634.2010.487890",
                       # "10.4238/2011.October.21.6",
                        #"10.1186/1471-2288-11-32",
                        "10.1007/s11606-011-1698-5",
                        "10.1001/jama.2011.1211",
                        "10.1016/j.jaad.2010.09.734",
                        "10.1111/j.1468-3083.2011.03992.x",
                        "10.1111/j.1468-3083.2011.03993.x",
                        "10.1111/j.1468-3083.2011.03991.x",
                        "10.2340/00015555-0988",
                        "10.1185/03007995.2010.541022",
                        # "10.1016/j.semarthrit.2010.04.003",
                       # "10.1016/j.jaad.2009.06.048",
                        "10.1111/j.1365-2184.2010.00672.x",
                        # "10.1111/j.1468-3083.2009.03562.x",
                        "10.1111/j.1468-3083.2009.03563.x",
                       # "10.1111/j.1468-3083.2009.03564.x",
                       # "10.1038/jid.2009.391",
                       # "10.1111/j.1468-3083.2009.03565.x",
                       # "10.2165/11311020-000000000-00000",
                        # "10.1016/j.jaad.2009.04.029",
                        "10.1159/000233234",
                        # "10.1111/j.1365-2133.2008.08876.x",
                       #  "10.1111/j.1365-2133.2008.08732.x",
                       # "10.1111/j.1365-2133.2008.08673.x",
                        # "10.1080/09546630701271807",
                        "10.3310/hta10460",
                       # "10.2165/00128071-200607040-00006",
                       # "10.1002/14651858.CD011628",
                       # "10.1046/j.1365-2133.2002.04836.x",
                       # "10.1046/j.1365-2133.2000.04713.x",
                       # "10.1046/j.1365-2133.2001.04505.x",
                       # "10.1046/j.1365-2133.2001.04504.x",
                       # "10.1001/archderm.136.12.1536",
                       # "10.3310/hta4400",
                        "10.1136/bmj.320.7240.963",
                       # "10.1001/archderm.135.7.834",
                       # "10.1046/j.1365-2133.1997.19902071.x",
                        "10.4238/2015.April.22.16",
                       # "10.3109/08820139.2013.810241",
                        "10.1111/bjd.12393",
                       # "10.2165/11633110-000000000-00000",
                        "10.1111/j.1346-8138.2012.01577.x",
                        "10.1111/bjd.14788",
                        "10.1111/jdv.13749",
                        "10.2147/PPA.S117006",
                        "10.1007/s40259-016-0201-6",
                        "10.1053/j.gastro.2016.03.037",
                        "10.1111/jdv.14007",
                        "10.1002/acr.22815",
                        "10.1002/ptr.5640",
                       # "10.1007/s40268-016-0152-x",
                        "10.1007/s11136-016-1321-7",
                        # "10.5152/akd.2015.6136",
                        "10.1016/j.jid.2016.03.035",
                        "10.1111/bjd.14814",
                        # "10.1080/09546634.2016.1254331",
                        "10.1016/j.jaad.2016.08.012",
                        "10.1002/14651858.CD010017.pub2",
                        "10.1002/14651858.CD007633.pub2",
                        "10.1002/14651858.CD007633.pub2",
                        "10.1002/14651858.CD010497.pub2",
                        "10.1002/14651858.CD001213"
                    ))

####### fetch the altmetrics data ------------------

alm                <- function(x)  altmetrics(doi = x) %>% altmetric_data()

####### results to .csv file --------------------

results_altmetrics <- pmap_df(ids, alm)
readr::write_csv(results_altmetrics, path = 'results_altmetrics.csv')


##########  2. Data visualitation and analysis ---------------
###### DB  almetrics  ----------------------

setwd("~/Documents/mac book air carpetas/juanruanoruiz/Documents/Dermatología/investigacion/grupo_emergente_IMIBIC/nuevos proyectos/calidad de revisiones sistemáticas/articulo_PLoS ONE_altmetrics_PSO")
# db_altmet <- read_csv2("db_almetrics_all.csv", col_names = TRUE)
db_altmet               <- read_csv2("db_almetrics_no109.csv", col_names = TRUE)
names(db_altmet)

##### drop extrem review 
# db_altmet <- subset(db_altmet, ID_original != 109)

###### DB  amstar y robis  ----------------------
setwd("~/Documents/mac book air carpetas/juanruanoruiz/Documents/Dermatología/investigacion/grupo_emergente_IMIBIC/nuevos proyectos/calidad de revisiones sistemáticas/bases de datos/montaje_DBs_calidad_final")
db_amstar               <- read_csv2("AMSTARfinal_metadatos_articulos_con_topics.csv", col_names = TRUE)
names(db_amstar)


###### merging DBs  -------------------

m1                      <-merge(db_altmet, db_amstar, by.x="ID_original", by.y="article_Id", all.x=TRUE)


m1$AMSTAR_levels_2      <- factor(m1$AMSTAR_levels_2, levels=c("high_quality", "moderate_quality", "low_quality"))
m1$cochrane             <- as.factor(m1$cochrane)
m1$impact_factor        <- as.numeric(m1[,187])
m1$funding_academic     <- as.factor(m1$funding_academic)
m1$funding_industry     <- as.factor(m1$funding_industry)
m1$funding_class_2      <- as.factor(m1$funding_class_2)
m1$journal_dermatology  <- as.factor(m1$journal_dermatology)
m1$year                 <- as.factor(m1$year)

m1$funding_class_2 %>%
  fct_recode("Academic" = "Academic", "No  funding" = "No funding", "No funding" = "No funding", "Pharma" = "Pharma", "UNK" = "UNK") %>% levels()


###### 2.1. Boxplots and ANOVAs  ----------------------------------
my_comparisons   <- list(c("moderate_quality", "low_quality"), c("high_quality", "moderate_quality"), c("high_quality", "low_quality"))
my_comparisons_2 <- list(c("Academic", "No funding"), c("Academic", "Pharma"), c("Academic", "UNK"),  c("UNK", "Pharma"), c("UNK", "No funding"), c("No funding", "Pharma"))

# [88] "readers.citeulike" ------------------------------------------------------------
compare_means(readers.citeulike ~ AMSTAR_levels_2,  
              data = na.omit(m1[,c("readers.citeulike","AMSTAR_levels_2")]), 
              method = "anova")
p <- ggboxplot(na.omit(m1[,c("readers.citeulike","AMSTAR_levels_2")]), x = "AMSTAR_levels_2", y = "readers.citeulike",
          color = "AMSTAR_levels_2", palette = "jco",
          add = "jitter",
          short.panel.labs = FALSE)
p + stat_compare_means(comparisons=my_comparisons)

# [89] "readers.mendeley" ------------------------------------------------------------
compare_means(readers.mendeley ~ AMSTAR_levels_2,  
              data = na.omit(m1[,c("readers.mendeley","AMSTAR_levels_2")]), 
              method = "anova")
p <- ggboxplot(na.omit(m1[,c("readers.mendeley","AMSTAR_levels_2")]), x = "AMSTAR_levels_2", y = "readers.mendeley",
          color = "AMSTAR_levels_2", palette = "jco",
          add = "jitter",
          short.panel.labs = FALSE)
p + stat_compare_means(comparisons=my_comparisons)

# [90] "readers.connotea" ------------------------------------------------------------
compare_means(readers.connotea ~ AMSTAR_levels_2,  
              data = na.omit(m1[,c("readers.connotea","AMSTAR_levels_2")]), 
              method = "anova")
p <- ggboxplot(na.omit(m1[,c("readers.connotea","AMSTAR_levels_2")]), x = "AMSTAR_levels_2", y = "readers.connotea",
          color = "AMSTAR_levels_2", palette = "jco",
          add = "jitter",
          short.panel.labs = FALSE)
p + stat_compare_means(comparisons=my_comparisons)

# [91] "readers_count" ------------------------------------------------------------
compare_means(readers_count ~ AMSTAR_levels_2,  
              data = na.omit(m1[,c("readers_count","AMSTAR_levels_2")]), 
              method = "anova")
p <- ggboxplot(na.omit(m1[,c("readers_count","AMSTAR_levels_2")]), x = "AMSTAR_levels_2", y = "readers_count",
          color = "AMSTAR_levels_2", palette = "jco",
          add = "jitter",
          short.panel.labs = FALSE)
p + stat_compare_means(comparisons=my_comparisons)

# [61] "cited_by_posts_count" ------------------------------------------------------------
compare_means(cited_by_posts_count ~ AMSTAR_levels_2,  
              data = na.omit(m1[,c("cited_by_posts_count","AMSTAR_levels_2")]), 
              method = "anova")
p <- ggboxplot(na.omit(m1[,c("cited_by_posts_count","AMSTAR_levels_2")]), x = "AMSTAR_levels_2", y = "cited_by_posts_count",
          color = "AMSTAR_levels_2", palette = "jco",
          add = "jitter",
          short.panel.labs = FALSE)
p + stat_compare_means(comparisons=my_comparisons)

# [62] "cited_by_tweeters_count" ------------------------------------------------------------
compare_means(cited_by_tweeters_count ~ AMSTAR_levels,  
              data = na.omit(m1[,c("cited_by_tweeters_count","AMSTAR_levels")]), 
              method = "anova")
p <- ggboxplot(na.omit(m1[,c("cited_by_tweeters_count","AMSTAR_levels")]), x = "AMSTAR_levels", y = "cited_by_tweeters_count",
          color = "AMSTAR_levels", palette = "jco",
          add = "jitter",
          short.panel.labs = FALSE,
          legend= "")
p + stat_compare_means(comparisons=my_comparisons)

# [63] "cited_by_accounts_count" ------------------------------------------------------------
compare_means(cited_by_tweeters_count ~ AMSTAR_levels_2,  
              data = na.omit(m1[,c("cited_by_tweeters_count","AMSTAR_levels_2")]), 
              method = "anova")
p <- ggboxplot(na.omit(m1[,c("cited_by_tweeters_count","AMSTAR_levels_2")]), x = "AMSTAR_levels_2", y = "cited_by_tweeters_count",
          color = "AMSTAR_levels_2", palette = "jco",
          add = "jitter",
          short.panel.labs = FALSE,
          legend= "")
p + stat_compare_means(comparisons=my_comparisons)

# [64] "cited_by_feeds_count" ------------------------------------------------------------
compare_means(cited_by_accounts_count ~ AMSTAR_levels_2,  
              data = na.omit(m1[,c("cited_by_accounts_count","AMSTAR_levels_2")]), 
              method = "anova")
p <- ggboxplot(na.omit(m1[,c("cited_by_accounts_count","AMSTAR_levels_2")]), x = "AMSTAR_levels_2", y = "cited_by_accounts_count",
          color = "AMSTAR_levels_2", palette = "jco",
          add = "jitter",
          short.panel.labs = FALSE)
p + stat_compare_means(comparisons=my_comparisons)

# "cited_by_tweeters_count" x funding_class_2 -------------------------------------------
compare_means(cited_by_tweeters_count ~ funding_class_2,  
              data = na.omit(m1[,c("cited_by_tweeters_count","funding_class_2")]), 
              method = "anova")
p <- ggboxplot(na.omit(m1[,c("cited_by_tweeters_count","funding_class_2")]), x = "funding_class_2", y = "cited_by_tweeters_count",
          color = "funding_class_2", palette = "jco",
          add = "jitter",
          short.panel.labs = FALSE,
          legend= "")
p + stat_compare_means(comparisons=my_comparisons_2)

# "cited_by_tweeters_count" x funding_industry -------------------------------------------
compare_means(cited_by_tweeters_count ~ funding_industry,  
              data = na.omit(m1[,c("cited_by_tweeters_count","funding_industry")]), 
              method = "anova")
p <- ggboxplot(na.omit(m1[,c("cited_by_tweeters_count","funding_industry")]), x = "funding_industry", y = "cited_by_tweeters_count",
          color = "funding_industry", palette = "jco",
          add = "jitter",
          short.panel.labs = FALSE,
          legend= "")
p + stat_compare_means(label = "p.format")

# "cited_by_tweeters_count" x funding_academic -------------------------------------------
compare_means(cited_by_tweeters_count ~ funding_academic,  
              data = na.omit(m1[,c("cited_by_tweeters_count","funding_academic")]), 
              method = "anova")
p <- ggboxplot(na.omit(m1[,c("cited_by_tweeters_count","funding_academic")]), x = "funding_academic", y = "cited_by_tweeters_count",
          color = "funding_academic", palette = "jco",
          add = "jitter",
          short.panel.labs = FALSE,
          legend= "")
p + stat_compare_means(label = "p.format")

# "cited_by_tweeters_count" x journal_dermatology -------------------------------------------
compare_means(cited_by_tweeters_count ~ journal_dermatology,  
              data = na.omit(m1[,c("cited_by_tweeters_count","journal_dermatology")]), 
              method = "anova")
p <- ggboxplot(na.omit(m1[,c("cited_by_tweeters_count","journal_dermatology")]), x = "journal_dermatology", y = "cited_by_tweeters_count",
          color = "journal_dermatology", palette = "jco",
          add = "jitter",
          short.panel.labs = FALSE,
          legend= "")
p + stat_compare_means(label = "p.format")

# "cited_by_tweeters_count" x pharma_name -------------------------------------------
compare_means(cited_by_tweeters_count ~ pharma_name,  
              data = na.omit(m1[,c("cited_by_tweeters_count","pharma_name", "journal.y")]), 
              method = "anova")
p <- ggboxplot(na.omit(m1[,c("cited_by_tweeters_count","pharma_name", "journal.y")]), 
          x = "pharma_name", y = "cited_by_tweeters_count",
          color = "journal.y", palette = "jco",
          repel = TRUE,
          label.rectangle = FALSE, 
          add = "jitter",
          short.panel.labs = FALSE,
          legend= "top")
p + stat_compare_means(label = "p.format")
p + geom_text_repel() 

# "cited_by_tweeters_count" x year -------------------------------------------
compare_means(cited_by_tweeters_count ~ year,  
              data = na.omit(m1[,c("cited_by_tweeters_count","year", "AMSTAR_levels")]), 
              method = "anova", group.by = "AMSTAR_levels")
p <- ggboxplot(na.omit(m1[,c("cited_by_tweeters_count","year", "AMSTAR_levels")]), 
          x = "year", y = "cited_by_tweeters_count",
          color = "AMSTAR_levels", palette = "jco",
          add = "jitter",
          facet.by = "AMSTAR_levels", short.panel.labs = FALSE)
p + stat_compare_means(label = "p.format")

# "cited_by_tweeters_count" x impact_factor_cut
compare_means(cited_by_tweeters_count ~ impact_factor_cut,  
              data = na.omit(m1[,c("cited_by_tweeters_count","impact_factor_cut", "AMSTAR_levels_2")]), 
              method = "wilcox.test", group.by = "AMSTAR_levels_2")
p <- ggboxplot(na.omit(m1[,c("cited_by_tweeters_count","impact_factor_cut", "AMSTAR_levels_2")]), 
          x = "impact_factor_cut", y = "cited_by_tweeters_count",
          color = "AMSTAR_levels_2", palette = "jco",
          add = "jitter",
          facet.by = "AMSTAR_levels_2", short.panel.labs = FALSE)
p + stat_compare_means(label = "p.format")

# "cited_by_tweeters_count" x AMSTAR_levels_2 -------------------------------------------
compare_means(cited_by_tweeters_count ~ AMSTAR_levels_2,  
              data = na.omit(m1[,c("cited_by_tweeters_count","impact_factor_cut", "AMSTAR_levels_2")]), 
              method = "wilcox.test", group.by = "impact_factor_cut")
p <- ggboxplot(na.omit(m1[,c("cited_by_tweeters_count","impact_factor_cut", "AMSTAR_levels_2")]), 
          x = "AMSTAR_levels_2", y = "cited_by_tweeters_count",
          color = "impact_factor_cut", palette = "jco",
          add = "jitter",
          facet.by = "impact_factor_cut", short.panel.labs = FALSE)
p + stat_compare_means(label = "p.format")

# "cited_by_tweeters_count" x cochrane -------------------------------------------
compare_means(cited_by_tweeters_count ~ cochrane,  
              data = na.omit(m1[,c("cited_by_tweeters_count","cochrane")]), 
              method = "anova")
p <- ggboxplot(na.omit(m1[,c("cited_by_tweeters_count","cochrane")]), x = "cochrane", y = "cited_by_tweeters_count",
          color = "cochrane", palette = "jco",
          add = "jitter",
          short.panel.labs = FALSE,
          legend= "")
p + stat_compare_means(label = "p.format")

# "cited_by_tweeters_count" x metaanalysis_included -------------------------------------------
compare_means(cited_by_tweeters_count ~ metaanalysis_included,  
              data = na.omit(m1[,c("cited_by_tweeters_count","metaanalysis_included")]), 
              method = "anova")
p <- ggboxplot(na.omit(m1[,c("cited_by_tweeters_count","metaanalysis_included")]), x = "metaanalysis_included", y = "cited_by_tweeters_count",
          color = "metaanalysis_included", palette = "jco",
          add = "jitter",
          short.panel.labs = FALSE,
          legend= "")
p + stat_compare_means(label = "p.format")



########  2.2. Panels plots: tweets and readers BY journal ---------------------
########  ALL years ................

p1 <- ggplot(na.omit(m1[,c("ID_original", "cited_by_tweeters_count", "journal.y", "AMSTAR_levels", "year","best_quartile", "number_of_cites_Google_Scholar", "readers.mendeley", "cited_by_posts_count")]), 
             aes(x = fct_reorder(journal.y, cited_by_tweeters_count), 
                 y = cited_by_tweeters_count, 
                 color = AMSTAR_levels, 
                 label=year, 
                 show.legend=F), legend= "top") +
  geom_point(aes(x = fct_reorder(journal.y, cited_by_tweeters_count), y = cited_by_tweeters_count)) +
  geom_jitter(height = 3, width=0) +
  theme_minimal() +
  theme(legend.position = "none") +
  theme(axis.title.y=element_text(colour="grey20", size=6),
        axis.text.y=element_text(),
        axis.ticks.y=element_blank()) +
  scale_y_continuous(limits = c(-15, 100)) +
  labs(y = "# tweets", x =" ") +
  coord_flip() +
  geom_boxplot(show.legend=F) +
  geom_text_repel(aes(label=year), size = 2)

########  BY years ................
p1_facet <- ggplot(na.omit(m1[,c("ID_original", "cited_by_tweeters_count", "journal.y", "AMSTAR_levels", "year","best_quartile","impact_factor" , "impact_factor_cut", "number_of_cites_Google_Scholar", "readers.mendeley")]), 
                   aes(x = fct_reorder(journal.y, cited_by_tweeters_count), 
                       y = cited_by_tweeters_count, 
                       color = AMSTAR_levels, 
                       size= impact_factor*2, shape=impact_factor_cut, show.legend=F),legend= "top") +
  geom_point(aes(x = fct_reorder(journal.y, cited_by_tweeters_count), y = cited_by_tweeters_count, size=impact_factor*2, shape=impact_factor_cut)) +
  geom_jitter(height = 8, width=3) +
  scale_shape_manual(values = c(17, 25)) +
  theme_minimal() +
  theme(legend.position = "none") +
  theme(axis.title.y=element_text(colour="grey20", size=6),
        axis.text.y=element_text(),
        axis.ticks.y=element_blank()) +
  scale_y_continuous(limits = c(0, 50)) +
  labs(y = "# tweets", x =" ") +
  coord_flip() +
  facet_wrap(~ year, ncol = 7)

p2_facet <- ggplot(na.omit(m1[,c("ID_original", "cited_by_tweeters_count", "journal.y", "AMSTAR_levels", "year","best_quartile","num_authors", "number_of_cites_Google_Scholar", "readers.mendeley")]), aes(x = fct_reorder(journal.y, cited_by_tweeters_count), y = readers.mendeley, color = AMSTAR_levels, size=number_of_cites_Google_Scholar, alpha=number_of_cites_Google_Scholar, show.legend=F),
          legend= "top") +
  geom_point(aes(x = fct_reorder(journal.y, cited_by_tweeters_count), y = readers.mendeley, size=number_of_cites_Google_Scholar, alpha=number_of_cites_Google_Scholar*2)) +
  geom_jitter(height = 8, width=3) +
  scale_alpha(range = c(0.4, 1)) +
  #geom_smooth() +
  theme_minimal() +
  theme(legend.position = "none") +
  theme(axis.title.y=element_text(colour="grey20", size=6),
        axis.text.y=element_text(),
        axis.ticks.y=element_blank()) +
  scale_y_continuous(limits = c(0, 50)) +
  labs(y = "# mendeley readers", x =" ") +
  coord_flip() +
  facet_wrap(~ year, ncol = 7)


############### 2.4. Descriptive statistics ---------------------------
stats <- merge(m1, m1_mfa_wout_2, x.by="ID_original", y.by="ID_original", all.y=TRUE)
summarize(stats, aut=sum(num_authors))
summarize(stats, aut=mean(num_authors))
summarize(stats, aut=max(num_authors))
summarize(stats, aut=min(num_authors))

summarize(stats, aut=min(num_authors))


############### 2.5. GLM --------------------------------------
########## predictors of number_of_cites_Google_Scholar -------
m1_mfa_2                                <- subset(na.omit(m1[,c(1, 107, 164, 165, 168, 189, 61,62,63, 89,91,123, 127, 130)]))
m1_mfa_2$ID_original                    <- as.factor(m1_mfa_2$ID_original)  #1
m1_mfa_2$AMSTAR_levels_2                <- as.factor(m1_mfa_2$AMSTAR_levels_2) #107
m1_mfa_2$funding_academic               <- as.factor(m1_mfa_2$funding_academic) #164
m1_mfa_2$funding_industry               <- as.factor(m1_mfa_2$funding_industry) #165
m1_mfa_2$conflict_of_interest           <- as.numeric(m1_mfa_2$conflict_of_interest) #168
m1_mfa_2$impact_factor                  <- as.numeric(m1_mfa$impact_factor) #189
m1_mfa_2$cited_by_posts_count           <- as.numeric(m1_mfa_2$cited_by_posts_count) #61
m1_mfa_2$cited_by_tweeters_count        <- as.numeric(m1_mfa_2$cited_by_tweeters_count) #62
m1_mfa_2$cited_by_accounts_count        <- as.numeric(m1_mfa_2$cited_by_accounts_count) #63
m1_mfa_2$readers.mendeley               <- as.numeric(m1_mfa_2$readers.mendeley) #89
m1_mfa_2$readers_count                  <- as.numeric(m1_mfa_2$readers_count) #91
m1_mfa_2$number_of_cites_Google_Scholar <- as.numeric(m1_mfa_2$number_of_cites_Google_Scholar) #123
m1_mfa_2$journal.y                      <- as.factor(m1_mfa_2$journal.y) #127
m1_mfa_2$year                           <- as.factor(m1_mfa_2$year) #130

m1_mfa_wout_2 <- filter (m1_mfa_2, !rownames(m1_mfa_2) %in% c(36,114,134))


model_1 <- glm(log(number_of_cites_Google_Scholar+0.5,2) ~ AMSTAR_levels_2+funding_academic+funding_industry+conflict_of_interest+AMSTAR_levels_2*funding_academic+ AMSTAR_levels_2*funding_industry+AMSTAR_levels_2*conflict_of_interest + cited_by_tweeters_count+year + impact_factor+readers.mendeley, data=m1_mfa_wout_2)
model_1 <- glm(log(number_of_cites_Google_Scholar+0.5,2) ~ AMSTAR_levels_2+funding_academic+funding_industry+conflict_of_interest+ cited_by_tweeters_count+year + impact_factor+readers.mendeley, data=m1_mfa_wout_2)
model_1 <- glm(log(number_of_cites_Google_Scholar+0.5,2) ~ AMSTAR_levels_2+funding_academic+funding_industry+AMSTAR_levels_2*funding_academic+ AMSTAR_levels_2*funding_industry +year +readers.mendeley, data=m1_mfa_wout_2)

summary(model_1)
(ci <- confint(model_1))
exp(coef(model_1))
cbind(OR=coef(model_1), ci)
      
      
summary(model_1)
logLik(model_1)
ctable<-coef(summary(model_1))
p<-pnorm(abs(ctable[, "t value"]), lower.tail = FALSE) * 2
(ctable <- cbind(ctable, "p value" = p))
(ci <- confint(model_1))
exp(coef(model_1))
## OR and CI
exp(cbind(OR = coef(model_1), ci))


########## predictors of cited_by_tweeters_count -------

model_2 <- glm(log(cited_by_tweeters_count+0.5,2) ~ AMSTAR_levels_2+funding_academic+funding_industry+conflict_of_interest+AMSTAR_levels_2*funding_academic+ AMSTAR_levels_2*funding_industry+AMSTAR_levels_2*conflict_of_interest +year + impact_factor, data=m1_mfa_wout_2)
model_2 <- glm(log(cited_by_tweeters_count+0.5,2) ~ AMSTAR_levels_2+conflict_of_interest + impact_factor, data=m1_mfa_wout_2)

summary(model_2)

summary(model_2)
logLik(model_2)
ctable<-coef(summary(model_2))
p<-pnorm(abs(ctable[, "t value"]), lower.tail = FALSE) * 2
(ctable <- cbind(ctable, "p value" = p))
(ci <- confint(model_2))
exp(coef(model_2))
## OR and CI
exp(cbind(OR = coef(model_2), ci))





############### 2.6. Multiple Factor Analysis (MFA) using FactoMineR  ------------
###### 2.6.1. without NAs -------------------
m1_mfa                                <- subset(na.omit(m1[,c(1, 107, 164, 165, 168, 189, 61,62,63, 89,91,123)]))
m1_mfa$ID_original                         <- as.factor(m1_mfa$ID_original)  #1
m1_mfa$AMSTAR_levels_2                         <- as.factor(m1_mfa$AMSTAR_levels_2) #107
m1_mfa$funding_academic               <- as.factor(m1_mfa$funding_academic) #164
m1_mfa$funding_industry               <- as.factor(m1_mfa$funding_industry) #165
m1_mfa$conflict_of_interest           <- as.numeric(m1_mfa$conflict_of_interest) #168
m1_mfa$impact_factor                  <- as.numeric(m1_mfa$impact_factor) #189
m1_mfa$cited_by_posts_count           <- as.numeric(m1_mfa$cited_by_posts_count) #61
m1_mfa$cited_by_tweeters_count        <- as.numeric(m1_mfa$cited_by_tweeters_count) #62
m1_mfa$cited_by_accounts_count        <- as.numeric(m1_mfa$cited_by_accounts_count) #63
m1_mfa$readers.mendeley               <- as.numeric(m1_mfa$readers.mendeley) #89
m1_mfa$readers_count                  <- as.numeric(m1_mfa$readers_count) #91
m1_mfa$number_of_cites_Google_Scholar <- as.numeric(m1_mfa$number_of_cites_Google_Scholar) #123

names(m1_mfa)[1]                      <- "review"
names(m1_mfa)[2]                      <- "AMSTAR"
names(m1_mfa)[3]                      <- "Funding Academic"
names(m1_mfa)[4]                      <- "Funding Industry"
names(m1_mfa)[5]                      <- "Authors' conflict of interest"
names(m1_mfa)[6]                      <- "impact factor"
names(m1_mfa)[7]                      <- "Facebook"
names(m1_mfa)[8]                      <- "Tweeter"
names(m1_mfa)[9]                      <- "Google +"
names(m1_mfa)[10]                     <- "Mendeley readers"
names(m1_mfa)[11]                     <- "SCOPUS readers"
names(m1_mfa)[12]                     <- "Cites Google Scholar"

res.MFA <- MFA(m1_mfa [,-1], 
               group = c(1,2,1,1,3,2,1), 
               type = c("n", "n", "c", "c", "c", "c", "c"), 
               # type = c(rep("n",2),rep("c",5)),
               graph = TRUE, 
               ncp = 5, 
               name.group=c("amstar","funding", "conflict of interest", "publication","social", "readers", "cites"), 
               num.group.sup=1)
summary(res.MFA)


names(#### plot individual
fviz_screeplot(res.MFA, addlabels=TRUE)+ 
  theme_minimal()+
  labs(title = "Variances - PCA", x = "Principal Components", y = "% of variances")
fviz_contrib(res.MFA, choice="quanti.var", axes = 1, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))
fviz_contrib(res.MFA, choice="quanti.var", axes = 2, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))
fviz_contrib(res.MFA, choice="quanti.var", axes = 3, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))

fviz_contrib(res.MFA, choice="quali.var", axes = 1, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))
fviz_contrib(res.MFA, choice="quali.var", axes = 2, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))
fviz_contrib(res.MFA, choice="quali.var", axes = 3, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))

fviz_contrib(res.MFA, choice="group", axes = 1, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))
fviz_contrib(res.MFA, choice="group", axes = 2, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))
fviz_contrib(res.MFA, choice="group", axes = 3, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))

fviz_contrib(res.MFA, choice="partial.axes", axes = 1, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))
fviz_contrib(res.MFA, choice="partial.axes", axes = 2, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))
fviz_contrib(res.MFA, choice="partial.axes", axes = 3, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))

fviz_contrib(res.MFA, choice="ind", axes = 1, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))
fviz_contrib(res.MFA, choice="ind", axes = 2, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))
fviz_contrib(res.MFA, choice="ind", axes = 3, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))


###### 2.6.2. with data imputation :: Amelia package -------------------
install.packages("Amelia")
library("Amelia")

m1_mfa                                <- subset(m1[,c(1, 107, 164, 165, 168, 189, 61,62,63, 89,91,123)])
missmap(m1_mfa)
imputedDB_heat <- amelia(x = m1_mfa[,-1], m = 5,  # number of imputed data sets
                      noms = c("AMSTAR_levels_2", "funding_academic", "funding_industry"))

imputedDB_heat <- imputedDB_heat$imputations[[1]]
imputedDB_heat$Id_original <- m1_mfa[,1]

imputedDB_heat$Id_original                    <- as.factor(imputedDB_heat$Id_original)  #1

imputedDB_heat$AMSTAR_levels_2                <- as.factor(imputedDB_heat$AMSTAR_levels_2) #107
imputedDB_heat$funding_academic               <- as.factor(imputedDB_heat$funding_academic) #164
imputedDB_heat$funding_industry               <- as.factor(imputedDB_heat$funding_industry) #165
imputedDB_heat$conflict_of_interest           <- as.numeric(imputedDB_heat$conflict_of_interest) #168
imputedDB_heat$impact_factor                  <- as.numeric(imputedDB_heat$impact_factor) #189
imputedDB_heat$cited_by_posts_count           <- as.numeric(imputedDB_heat$cited_by_posts_count) #61
imputedDB_heat$cited_by_tweeters_count        <- as.numeric(imputedDB_heat$cited_by_tweeters_count) #62
imputedDB_heat$cited_by_accounts_count        <- as.numeric(imputedDB_heat$cited_by_accounts_count) #63
imputedDB_heat$readers.mendeley               <- as.numeric(imputedDB_heat$readers.mendeley) #89
imputedDB_heat$readers_count                  <- as.numeric(imputedDB_heat$readers_count) #91
imputedDB_heat$number_of_cites_Google_Scholar <- as.numeric(imputedDB_heat$number_of_cites_Google_Scholar) #123

names(imputedDB_heat)[1]                      <- "AMSTAR"
names(imputedDB_heat)[2]                      <- "Funding Academic"
names(imputedDB_heat)[3]                      <- "Funding Industry"
names(imputedDB_heat)[4]                      <- "Authors' conflict of interest"
names(imputedDB_heat)[5]                      <- "impact factor"
names(imputedDB_heat)[6]                      <- "Facebook"
names(imputedDB_heat)[7]                      <- "Tweeter"
names(imputedDB_heat)[8]                      <- "Google +"
names(imputedDB_heat)[9]                      <- "Mendeley readers"
names(imputedDB_heat)[10]                     <- "SCOPUS readers"
names(imputedDB_heat)[11]                     <- "Cites Google Scholar"
names(imputedDB_heat)[12]                     <- "ID_original"


res.MFA <- MFA(imputedDB_heat[,-12], 
               group = c(1,2,1,1,3,2,1), 
               type = c("n", "n", "c", "c", "c", "c", "c"), 
               # type = c(rep("n",2),rep("c",5)),
               graph = TRUE, 
               ncp = 5, 
               name.group=c("amstar","funding", "conflict of interest", "publication","social", "readers", "cites"), 
               num.group.sup=1)
summary(res.MFA)


names(#### plot individual
fviz_screeplot(res.MFA, addlabels=TRUE)+ 
  theme_minimal()+
  labs(title = "Variances - PCA", x = "Principal Components", y = "% of variances")
fviz_contrib(res.MFA, choice="quanti.var", axes = 1, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))
fviz_contrib(res.MFA, choice="quanti.var", axes = 2, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))
fviz_contrib(res.MFA, choice="quanti.var", axes = 3, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))

fviz_contrib(res.MFA, choice="quali.var", axes = 1, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))
fviz_contrib(res.MFA, choice="quali.var", axes = 2, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))
fviz_contrib(res.MFA, choice="quali.var", axes = 3, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))

fviz_contrib(res.MFA, choice="group", axes = 1, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))
fviz_contrib(res.MFA, choice="group", axes = 2, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))
fviz_contrib(res.MFA, choice="group", axes = 3, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))

fviz_contrib(res.MFA, choice="partial.axes", axes = 1, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))
fviz_contrib(res.MFA, choice="partial.axes", axes = 2, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))
fviz_contrib(res.MFA, choice="partial.axes", axes = 3, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))

fviz_contrib(res.MFA, choice="ind", axes = 1, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))
fviz_contrib(res.MFA, choice="ind", axes = 2, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))
fviz_contrib(res.MFA, choice="ind", axes = 3, sort.val = "none" )+scale_y_continuous(limits = c(0, 50))




#################
######## plotting heat maps --------------------------------
####  R packages ----------------

source("https://bioconductor.org/biocLite.R")
biocLite()
biocLite("ComplexHeatmap")
library("ComplexHeatmap")
library("circlize")
library("dendsort")
library("dendextend")



#### prepare matrix original ----------------
missmap(merge.db.heat)
db.heat                          <- facto_summarize(res.MFA, "ind", axes = 1:3)[,-1]
db.heat$Id_original              <- imputedDB_heat[,12]
merge.db.heat                    <- merge(imputedDB_heat, db.heat, by.x="ID_original", by.y="Id_original", all.y=TRUE)

# DB_heat                          <- na.omit(merge.db.heat[c(1, 107,164,165,168,189,61:63,89,91,123,190:192)])
DB_heat                          <- merge.db.heat[c(1:18)]


DB_heat                          <- DB_heat[order(DB_heat[,6]),]
heatDB                           <- DB_heat[c(1,13:18)]
# heatDB                           <- as.matrix(DB_heat[c(1,13:15)])

amstar_df                        <- (DB_heat[c(1,2)])
amstar                           <- as.matrix(amstar_df)

funding_academic_df              <- (DB_heat[c(1,3)])
funding_academic                 <- as.matrix(funding_academic_df)

funding_industry_df              <- (DB_heat[c(1,4)])
funding_industry                 <- as.matrix(funding_industry_df)

conflict_of_interest_df          <- (DB_heat[c(1,5)])
conflict_of_interest             <- as.matrix(conflict_of_interest_df)

impact_factor_df                 <- (DB_heat[c(1,6)])
impact_factor                    <- as.matrix(impact_factor_df)

cited_by_posts_count_df          <- (DB_heat[c(1,7)])
cited_by_posts_count             <- as.matrix(cited_by_posts_count_df)

cited_by_tweeters_count_df       <- (DB_heat[c(1,8)])
cited_by_tweeters_count          <- as.matrix(cited_by_tweeters_count_df)

cited_by_accounts_count_df       <- (DB_heat[c(1,9)])
cited_by_accounts_count          <- as.matrix(cited_by_accounts_count_df)

readers.mendeley_df              <- (DB_heat[c(1,10)])
readers.mendeley                 <- as.matrix(readers.mendeley_df)

readers_count_df                 <- (DB_heat[c(1,11)])
readers_count                    <- as.matrix(readers_count_df)

number_of_cites_Google_Scholar_df<- (DB_heat[c(1,12)])
number_of_cites_Google_Scholar   <- as.matrix(number_of_cites_Google_Scholar_df)


#### individual heat maps ----------------

topicAmstarPlot                    <- Heatmap(amstar[,2], 
                                            name="AMSTAR levels", 
                                            show_row_names = FALSE, 
                                            cluster_rows = FALSE, 
                                            width = unit(5, "mm"), 
                                            show_heatmap_legend = TRUE,
                                            col = c("steelblue4","red", "lightgreen"))

fundingAcademicPlot               <- Heatmap(funding_academic[,2], 
                                            name="Funding academic", 
                                            show_row_names = FALSE, 
                                            cluster_rows = FALSE, 
                                            width = unit(5, "mm"), 
                                            show_heatmap_legend = FALSE,
                                            col = c("white", "steelblue4"))

fundingIndustryPlot               <- Heatmap(funding_industry[,2], 
                                            name="Funding industry", 
                                            show_row_names = FALSE, 
                                            cluster_rows = FALSE, 
                                            width = unit(5, "mm"), 
                                            show_heatmap_legend = FALSE,
                                            col = c("white", "royalblue1"))

numAuthorsConflictInterestPlot    <- Heatmap(conflict_of_interest_df[,2], 
                                            name="Number of authors with conflict of interest", 
                                            show_row_names = FALSE, 
                                            cluster_rows = FALSE, 
                                            width = unit(5, "mm"), 
                                            #col = colorRamp2(c(0, 15), 
                                            show_heatmap_legend = TRUE,
                                            heatmap_legend_param = list(color_bar = "continuous"),
                                             col = colorRamp2(c(0, 30), c("white", "darkolivegreen4")))

impactFactorPlot                  <- Heatmap(impact_factor_df[,2], 
                                            name="Impact factor", 
                                            show_row_names = FALSE, 
                                            cluster_rows = FALSE, 
                                            width = unit(5, "mm"), 
                                            show_heatmap_legend = TRUE,
                                            heatmap_legend_param = list(color_bar = "continuous"),
                                            col = colorRamp2(c(0, 30), c("white", "green4")))

facebookPlot                      <- Heatmap(log(cited_by_posts_count_df[,2],2), 
                                            name="Facebook posts", 
                                            show_row_names = FALSE, 
                                            cluster_rows = FALSE, 
                                            width = unit(5, "mm"), 
                                            show_heatmap_legend = FALSE,
                                            heatmap_legend_param = list(color_bar = "continuous"),
                                            c("white", "firebrick1"))

tweetterPlot                      <- Heatmap(log(cited_by_tweeters_count_df[,2],2), 
                                            name="Tweets", 
                                            show_row_names = FALSE, 
                                            cluster_rows = FALSE, 
                                            width = unit(5, "mm"), 
                                            show_heatmap_legend = FALSE,
                                            heatmap_legend_param = list(color_bar = "continuous"),
                                            c("white", "coral3"))

googlePlusPlot                    <- Heatmap(log(cited_by_accounts_count_df[,2],2), 
                                            name="Google+ posts", 
                                            show_row_names = FALSE, 
                                            cluster_rows = FALSE, 
                                            width = unit(5, "mm"), 
                                            show_heatmap_legend = FALSE,
                                            heatmap_legend_param = list(color_bar = "continuous"),
                                            c("white", "magenta1"))

mendeleyReadersPlot               <- Heatmap(log(readers.mendeley_df[,2]+1,2), 
                                            name="Mendeley's readers", 
                                            show_row_names = FALSE, 
                                            cluster_rows = FALSE, 
                                            width = unit(5, "mm"), 
                                            show_heatmap_legend = FALSE,
                                            heatmap_legend_param = list(color_bar = "continuous"),
                                            c("white", "dodgerblue3"))

scopuesReadersPlot                <- Heatmap(log(readers_count_df[,2]+1,2), 
                                            name="SCOPUS readers", 
                                            show_row_names = FALSE, 
                                            cluster_rows = FALSE, 
                                            width = unit(5, "mm"), 
                                            show_heatmap_legend = FALSE,
                                            heatmap_legend_param = list(color_bar = "continuous"),
                                            c("white", "royalblue1"))
number_of_cites_Google_Scholar_df[,2] <- replace(number_of_cites_Google_Scholar_df[,2], number_of_cites_Google_Scholar_df[,2] < 0, 0)
ScholarPlot                       <- Heatmap(log(number_of_cites_Google_Scholar_df[,2]+1,2), 
                                           name="Cites in Google scholar", 
                                            show_row_names = FALSE, 
                                            cluster_rows = FALSE, 
                                            width = unit(5, "mm"), 
                                            show_heatmap_legend = TRUE,
                                            heatmap_legend_param = list(color_bar = "continuous"),
                                            c("white", "darkorange1"))


# dend <- hclust(dist(heatDB[,2:7]))
# dend <- color_branches(dend, k = 6)
set.seed(120)
set.seed(130)
set.seed(140)
mat_scaled <- t(apply(as.matrix(heatDB[,c(2:4, 6,7)]), 1, scale))
pcaFactors                       <- Heatmap(mat_scaled, 
                                            cluster_columns = FALSE, 
                                            cluster_rows = TRUE, 
                                            clustering_distance_rows = "euclidean",
                                            # clustering_method_rows = "complete",
                                            show_row_names = FALSE, 
                                            width = unit(20, "mm"),
                                            km = 6,
                                            #row_order = 1:164,
                                            show_heatmap_legend = FALSE,
                                            show_column_names = TRUE)

# getting the row order by CLUSTER-------------------
row_order(pcaFactors)


######## plotting all heat maps together ----------------

map_list<-(pcaFactors+
  topicAmstarPlot+
  fundingAcademicPlot+
  fundingIndustryPlot+
  numAuthorsConflictInterestPlot+
  impactFactorPlot+
  facebookPlot+
  tweetterPlot+
  googlePlusPlot+
  mendeleyReadersPlot+
  scopuesReadersPlot+
  ScholarPlot
  )

postscript("allHeatMaps.eps", 
           width = 2000, 
           height = 1000)
draw(map_list)
graphics.off()

tiff("allHeatMaps.tiff", 
     width = 2000, 
     height = 1000, 
     pointsize = 1/300, 
     units = 'in', 
     res = 300)
draw(map_list)
dev.off()





# ------------------------------------------------
plot(res.MFA)
plot(res.MFA, invisible="quali", habillage=1, cex=0.6)
plot(res.MFA,  choix = "ind", invisible="quali", habillage=1,ddEllipses=TRUE , cex=0.6, lab.par=TRUE)
plot(res.MFA,  choix = "ind", invisible="quali", habillage=1, cex=0.6, lab.par=TRUE, addEllipses=TRUE)
plot(res.MFA,choix="ind",partial="all")

#### plot variables
fviz_mfa_var(res.MFA, repel = TRUE, col.var = "cos2")
fviz_famd_var(res.MFA, repel = TRUE,"quali.var", col.var = "cos2")


############### 2.7. Clustering dendograms ----------------------
###### ALL.........................

res.all <- hcut(m1_mfa[,c(5:12)], k = 6, stand = TRUE)
fviz_dend(res.all, rect = TRUE, cex = 0.5,
          k_colors = c("#00AFBB","#2E9FDF", "#E7B800", "#FC4E07"))

######  clustering dendograms without outliers  -------------
m1_mfa_wout <- filter (m1_mfa, !rownames(m1_mfa) %in% c(36,114,134))
hc.wout <- hcut(m1_mfa_wout[,c(5:12)], k = 4, stand = TRUE)

#### BY # review  -------------
m1_mfa_wout$review[order.dendrogram(as.dendrogram(hc.wout))]
split(m1_mfa_wout$review, hc.wout$cluster)
hc.wout$labels <- m1_mfa_wout$review
plot(hc.wout)

#### BY # amstar  -------------
m1_mfa_wout$AMSTAR[order.dendrogram(as.dendrogram(hc.wout))]
split(m1_mfa_wout$AMSTAR, hc.wout$cluster)
hc.wout$labels <- m1_mfa_wout$AMSTAR
plot(hc.wout)

#### BY # journals AND all variables  -------------
m1_mfa_2                                <- subset(na.omit(m1[,c(1, 107, 164, 165, 168, 189, 61,62,63, 89,91,123, 127, 130)]))
m1_mfa_2$ID_original                    <- as.factor(m1_mfa_2$ID_original)  #1
m1_mfa_2$AMSTAR_levels_2                <- as.factor(m1_mfa_2$AMSTAR_levels_2) #107
m1_mfa_2$funding_academic               <- as.factor(m1_mfa_2$funding_academic) #164
m1_mfa_2$funding_industry               <- as.factor(m1_mfa_2$funding_industry) #165
m1_mfa_2$conflict_of_interest           <- as.numeric(m1_mfa_2$conflict_of_interest) #168
m1_mfa_2$impact_factor                  <- as.numeric(m1_mfa$impact_factor) #189
m1_mfa_2$cited_by_posts_count           <- as.numeric(m1_mfa_2$cited_by_posts_count) #61
m1_mfa_2$cited_by_tweeters_count        <- as.numeric(m1_mfa_2$cited_by_tweeters_count) #62
m1_mfa_2$cited_by_accounts_count        <- as.numeric(m1_mfa_2$cited_by_accounts_count) #63
m1_mfa_2$readers.mendeley               <- as.numeric(m1_mfa_2$readers.mendeley) #89
m1_mfa_2$readers_count                  <- as.numeric(m1_mfa_2$readers_count) #91
m1_mfa_2$number_of_cites_Google_Scholar <- as.numeric(m1_mfa_2$number_of_cites_Google_Scholar) #123
m1_mfa_2$journal.y                      <- as.factor(m1_mfa_2$journal.y) #127
m1_mfa_2$year                           <- as.factor(m1_mfa_2$year) #130

names(m1_mfa_2)[1]                      <- "review"
names(m1_mfa_2)[2]                      <- "AMSTAR"
names(m1_mfa_2)[3]                      <- "Funding Academic"
names(m1_mfa_2)[4]                      <- "Funding Industry"
names(m1_mfa_2)[5]                      <- "Authors' conflict of interest"
names(m1_mfa_2)[6]                      <- "impact factor"
names(m1_mfa_2)[7]                      <- "Facebook"
names(m1_mfa_2)[8]                      <- "Tweeter"
names(m1_mfa_2)[9]                      <- "Google +"
names(m1_mfa_2)[10]                     <- "Mendeley readers"
names(m1_mfa_2)[11]                     <- "SCOPUS readers"
names(m1_mfa_2)[12]                     <- "Cites Google Scholar"
names(m1_mfa_2)[13]                     <- "Journals"
names(m1_mfa_2)[14]                     <- "PublicationYear"


m1_mfa_wout_2 <- filter (m1_mfa_2, !rownames(m1_mfa_2) %in% c(36,114,134))

################   COMPARING DENDOGRAMS with dendextend package ---------------
m1_mfa_wout_2$AMSTAR <- plyr::revalue(m1_mfa_wout_2$AMSTAR, c("high_quality" = "3", "moderate_quality" = "2", "low_quality" = "1"))

dend_quality <- as.dendrogram(hclust(dist(m1_mfa_wout_2[,2]), method = "average"))
dend_conflict <- as.dendrogram(hclust(dist(m1_mfa_wout_2[,c(3:5)]), method = "average"))
dend_social <- as.dendrogram(hclust(dist(m1_mfa_wout_2[,c(7:9)]), method = "average"))
dend_usage <- as.dendrogram(hclust(dist(m1_mfa_wout_2[,c(10:12)]), method = "average"))

dend_quality %>% highlight_branches_col(viridis(100)) %>% plot
dend_conflict %>% highlight_branches_col(viridis(100)) %>% plot
dend_social %>% highlight_branches_col(viridis(100)) %>% plot
dend_usage %>% highlight_branches_col(viridis(100)) %>% plot

dl_1 <- dendlist(dend_social, dend_usage) %>% set("highlight_branches_col")
tanglegram(dl_1, sort = TRUE, common_subtrees_color_lines = TRUE, common_subtrees_color_branches = TRUE, highlight_distinct_edges  = TRUE)

# We may wish to improve the layout of the trees. For this we have the entanglement, 
# to measure the quality of the alignment of the two trees in the tanglegram layout, 
# and the untangle function, for improving it.
dl_1 %>% entanglement
dl_1 %>% untangle(method = "ladderize")

set.seed(3958)
x <- dl_1 %>% untangle(method = "random", R = 30) 
x %>% plot

x <- dl_1 %>% untangle(method = "step2side") 
x %>% plot

dl_2 <- dendlist(dend_conflict, dend_social) %>% set("highlight_branches_col")
tanglegram(dl_2, sort = TRUE, common_subtrees_color_lines = TRUE, common_subtrees_color_branches = TRUE, highlight_distinct_edges  = TRUE)

dl_2 %>% entanglement
dl_2 %>% untangle(method = "ladderize")

set.seed(3958)
x <- dl_2 %>% untangle(method = "random", R = 30) 
x %>% plot

x <- dl_2 %>% untangle(method = "step2side") 
x %>% plot


dl_3 <- dendlist(dend_quality, dend_conflict) %>% set("highlight_branches_col")
tanglegram(dl_3, sort = TRUE, common_subtrees_color_lines = TRUE, common_subtrees_color_branches = TRUE, highlight_distinct_edges  = TRUE)

dl_3 %>% entanglement
dl_3 %>% untangle(method = "ladderize")

set.seed(3958)
x <- dl_3 %>% untangle(method = "random", R = 30) 
x %>% plot

x <- dl_3 %>% untangle(method = "step2side") 
x %>% plot


dl_4 <- dendlist(dend_conflict, dend_usage) %>% set("highlight_branches_col")
tanglegram(dl_4, sort = TRUE, common_subtrees_color_lines = TRUE, common_subtrees_color_branches = TRUE, highlight_distinct_edges  = TRUE)

dl_4 %>% entanglement
dl_4 %>% untangle(method = "ladderize")

set.seed(3958)
x <- dl_4 %>% untangle(method = "random", R = 30) 
x %>% plot

x <- dl_4 %>% untangle(method = "step2side") 
x %>% plot



dl_5 <- dendlist(dend_quality, dend_usage) %>% set("highlight_branches_col")
tanglegram(dl_5, sort = TRUE, common_subtrees_color_lines = TRUE, common_subtrees_color_branches = TRUE, highlight_distinct_edges  = TRUE)

dl_5 %>% entanglement
dl_5 %>% untangle(method = "ladderize")

set.seed(3958)
x <- dl_5 %>% untangle(method = "random", R = 30) 
x %>% plot

x <- dl_5 %>% untangle(method = "step2side") 
x %>% plot




dend_all <- as.dendrogram(hclust(dist(m1_mfa_wout_2[,c(3:5, 7:9, 10:12, 2)]), method = "average"))
dend_minus_quality <- as.dendrogram(hclust(dist(m1_mfa_wout_2[,c(3:5, 7:9, 10:12)]), method = "average"))
dend_minus_conflict <- as.dendrogram(hclust(dist(m1_mfa_wout_2[,c(7:9, 10:12, 2)]), method = "average"))
dend_minus_social <- as.dendrogram(hclust(dist(m1_mfa_wout_2[,c(3:5, 10:12, 2)]), method = "average"))
dend_minus_usage <- as.dendrogram(hclust(dist(m1_mfa_wout_2[,c(3:5, 7:9, 2)]), method = "average"))

dl_all_1 <- dendlist(dend_all, dend_minus_quality) %>% set("highlight_branches_col")
tanglegram(dl_all_1, sort = TRUE, common_subtrees_color_lines = TRUE, common_subtrees_color_branches = TRUE, highlight_distinct_edges  = TRUE)
tanglegram(x, sort = FALSE, common_subtrees_color_lines = TRUE, common_subtrees_color_branches = TRUE, highlight_distinct_edges  = TRUE)

dl_all_1 %>% entanglement
dl_all_1 %>% untangle(method = "ladderize")

set.seed(3958)
x <- dl_all_1 %>% untangle(method = "random", R = 30) 
x %>% plot

x <- dl_all_1 %>% untangle(method = "step2side") 
x %>% plot



dl_all_2 <- dendlist(dend_all, dend_minus_conflict) %>% set("highlight_branches_col")
tanglegram(dl_all_2, sort = TRUE, common_subtrees_color_lines = TRUE, common_subtrees_color_branches = TRUE, highlight_distinct_edges  = TRUE)
tanglegram(x, sort = FALSE, common_subtrees_color_lines = TRUE, common_subtrees_color_branches = TRUE, highlight_distinct_edges  = TRUE)

dl_all_2 %>% entanglement
dl_all_2 %>% untangle(method = "ladderize")

set.seed(3958)
x <- dl_all_2 %>% untangle(method = "random", R = 30) 
x %>% plot

x <- dl_all_2 %>% untangle(method = "step2side") 
x %>% plot


dl_all_3 <- dendlist(dend_all, dend_minus_social) %>% set("highlight_branches_col")
tanglegram(dl_all_3, sort = TRUE, common_subtrees_color_lines = TRUE, common_subtrees_color_branches = TRUE, highlight_distinct_edges  = TRUE)
tanglegram(x, sort = FALSE, common_subtrees_color_lines = TRUE, common_subtrees_color_branches = TRUE, highlight_distinct_edges  = TRUE)

dl_all_3 %>% entanglement
dl_all_3 %>% untangle(method = "ladderize")

set.seed(3958)
x <- dl_all_3 %>% untangle(method = "random", R = 30) 
x %>% plot

x <- dl_all_3 %>% untangle(method = "step2side") 
x %>% plot



dl_all_4 <- dendlist(dend_all, dend_minus_usage) %>% set("highlight_branches_col")
tanglegram(dl_all_4, sort = TRUE, common_subtrees_color_lines = TRUE, common_subtrees_color_branches = TRUE, highlight_distinct_edges  = TRUE)
tanglegram(x, sort = FALSE, common_subtrees_color_lines = TRUE, common_subtrees_color_branches = TRUE, highlight_distinct_edges  = TRUE)

dl_all_4 %>% entanglement
dl_all_4 %>% untangle(method = "ladderize")

set.seed(3958)
x <- dl_all_4 %>% untangle(method = "random", R = 30) 
x %>% plot

x <- dl_all_4 %>% untangle(method = "step2side") 
x %>% plot

####################################################
















