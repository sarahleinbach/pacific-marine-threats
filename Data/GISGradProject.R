library(tidyverse)
setwd("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data")

#bar graphs of overall top threats for all regions combined
threatsoverall= read.csv("threat_counts.csv")
threatsoverallBar <- ggplot(data=threatsoverall,aes(x=reorder(Threat,SpeciesCount),y=SpeciesCount))+
  geom_bar(stat="identity",width=0.6)+
  geom_text(aes(label=SpeciesCount),vjust=-0.3,size=3.5)+
  theme_classic(base_size=12)+
  theme(axis.text.x=element_text(angle=45, hjust=1))+
  theme(legend.position="none")+
  labs(x="Threat",y="Number of Species Threatened")
threatsoverallBar

#bar graph tiled for top threats in each region
ECThreats <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/EastCentral/threat_counts.csv")
NEThreats <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/Northeastern/threat_counts.csv")
NWThreats <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/Northwestern/threat_counts.csv")
SEThreats <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/southeastern/threat_counts.csv")
SWThreats <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/southwestern/threat_counts.csv")
WCThreats <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/WesternCentral/threat_counts.csv")
ECThreats$Region <- c("EastCentral")
NEThreats$Region <- c("Northeastern")
NWThreats$Region <- c("Northwestern")
SEThreats$Region <- c("Southeastern")
SWThreats$Region <- c("Southwestern")
WCThreats$Region <- c("WestCentral")
threatsbyregiondf <- rbind(ECThreats,NEThreats,NWThreats,SEThreats,SWThreats,WCThreats)
regionthreatfacet <- ggplot(data=threatsbyregiondf, aes(x=Threat,y=Species.Count))+
  geom_bar(stat="identity",width=0.6)+
  facet_wrap(~Region)+
  theme_classic(base_size=12)+
  theme(axis.text.x=element_text(angle=45, hjust=1))+
  theme(legend.position="none")
#regionthreatfacet HIDEOUS GRAPH

topthreethreatsregion <- threatsbyregiondf %>% filter(Threat == "fishing and harvesting aquatic resources"| Threat == "domestic and urban waste water"|Threat == "temperature extremes")

#boxplots of number of species threatened overall in each country by region
ECCountries <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/EastCentral/countries_speciescount.csv")
NECountries <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/Northeastern/countries_speciescount.csv")
NWCountries <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/Northwestern/countries_speciescount.csv")
SECountries <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/southeastern/countries_speciescount.csv")
SWCountries <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/southwestern/countries_speciescount.csv")
WCCountries <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/WesternCentral/countries_speciescount.csv")
ECCountries$Region <- c("EastCentral")
NECountries$Region <- c("Northeastern")
NWCountries$Region <- c("Northwestern")
SECountries$Region <- c("Southeastern")
SWCountries$Region <- c("Southwestern")
WCCountries$Region <- c("WestCentral")
countryspcount <- rbind(ECCountries,NECountries,NWCountries,SECountries,SWCountries,WCCountries)
countryspcount$Region=as.factor(countryspcount$Region)
countrycountBox <- ggplot(data=countryspcount)+
  geom_boxplot(mapping=aes(x=reorder(Region,Species),y=Species),width=0.8)+
  geom_jitter(mapping=aes(x=Region,y=Species,color=Region,fill=Region),shape=21,color="black",size=3.0,width=0.15)+
  theme_classic(base_size=12)+
  scale_fill_manual(breaks=c("Northeastern","Southeastern","Southwestern","EastCentral","Northwestern","WestCentral"),
                    values=c("#EE462F","#EF632F","#FEF833","#76F112","#50CCFC","#9D55FD"),
                    labels=c("Northeast","Southeast","Southwest","Eastern Central","Northwest","Western Central"))+
  labs(y="Number of Species Threatened",x="Region")+
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_rect(colour = "black", size=1), axis.text.x = element_blank(), axis.ticks.x = element_blank())
countrycountBox

results=aov(Species~Region,data=countryspcount)
summary(results)
TukeyHSD(results)


