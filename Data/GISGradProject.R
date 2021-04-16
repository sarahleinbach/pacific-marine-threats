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
#threatsoverallBar

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

#boxplots of number of species threatened in each country in each region by fishing
ECfish <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/EastCentral/5_4_countries.csv")
NEfish <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/Northeastern/5_4_countries.csv")
NWfish <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/Northwestern/5_4_countries.csv")
SEfish <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/southeastern/5_4_countries.csv")
SWfish <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/southwestern/5_4_countries.csv")
WCfish <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/WesternCentral/5_4_countries.csv")
ECfish$Region <- c("EastCentral")
NEfish$Region <- c("Northeastern")
NWfish$Region <- c("Northwestern")
SEfish$Region <- c("Southeastern")
SWfish$Region <- c("Southwestern")
WCfish$Region <- c("WestCentral")
fish <- rbind(ECfish,NEfish,NWfish,SEfish,SWfish,WCfish)

fish$Region=as.factor(fish$Region)
fishBox <- ggplot(data=fish)+
  geom_boxplot(mapping=aes(x=reorder(Region,Species.count),y=Species.count),width=0.8)+
  geom_jitter(mapping=aes(x=Region,y=Species.count,color=Region,fill=Region),shape=21,color="black",size=3.0,width=0.15)+
  theme_classic(base_size=12)+
  scale_fill_manual(breaks=c("Northeastern","Southeastern","Southwestern","EastCentral","Northwestern","WestCentral"),
                    values=c("#EE462F","#EF632F","#FEF833","#76F112","#50CCFC","#9D55FD"),
                    labels=c("Northeast","Southeast","Southwest","Eastern Central","Northwest","Western Central"))+
  labs(y="Number of Species Threatened",x="Region")+
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_rect(colour = "black", size=1), axis.text.x = element_blank(), axis.ticks.x = element_blank())
fishBox

results2=aov(Species.count~Region,data=fish)
summary(results2)
TukeyHSD(results2)

#boxplots of number of species threatened in each country in each region by wastewater
ECwaste <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/EastCentral/11_3_countries.csv")
NEwaste <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/Northeastern/11_3_countries.csv")
NWwaste <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/Northwestern/11_3_countries.csv")
SEwaste <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/southeastern/11_3_countries.csv")
SWwaste <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/southwestern/11_3_countries.csv")
WCwaste <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/WesternCentral/11_3_countries.csv")
ECwaste$Region <- c("EastCentral")
NEwaste$Region <- c("Northeastern")
NWwaste$Region <- c("Northwestern")
SEwaste$Region <- c("Southeastern")
SWwaste$Region <- c("Southwestern")
WCwaste$Region <- c("WestCentral")
waste <- rbind(ECwaste,NEwaste,NWwaste,SEwaste,SWwaste,WCwaste)

waste$Region=as.factor(waste$Region)
wasteBox <- ggplot(data=waste)+
  geom_boxplot(mapping=aes(x=reorder(Region,Species.count),y=Species.count),width=0.8)+
  geom_jitter(mapping=aes(x=Region,y=Species.count,color=Region,fill=Region),shape=21,color="black",size=3.0,width=0.15)+
  theme_classic(base_size=12)+
  scale_fill_manual(breaks=c("Northeastern","Southeastern","Southwestern","EastCentral","Northwestern","WestCentral"),
                    values=c("#EE462F","#EF632F","#FEF833","#76F112","#50CCFC","#9D55FD"),
                    labels=c("Northeast","Southeast","Southwest","Eastern Central","Northwest","Western Central"))+
  labs(y="Number of Species Threatened",x="Region")+
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_rect(colour = "black", size=1), axis.text.x = element_blank(), axis.ticks.x = element_blank())
wasteBox

results3=aov(Species.count~Region,data=waste)
summary(results3)
TukeyHSD(results3)

#boxplots of number of species threatened in each country in each region by temp extremes
ECtemp <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/EastCentral/9_1_countries.csv")
NWtemp <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/Northwestern/9_1_countries.csv")
SEtemp <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/southeastern/9_1_countries.csv")
SWtemp <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/southwestern/9_1_countries.csv")
WCtemp <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/WesternCentral/9_1_countries.csv")
ECtemp$Region <- c("EastCentral")
NWtemp$Region <- c("Northwestern")
SEtemp$Region <- c("Southeastern")
SWtemp$Region <- c("Southwestern")
WCtemp$Region <- c("WestCentral")
temp <- rbind(ECtemp,NWtemp,SEtemp,SWtemp,WCtemp)

temp$Region=as.factor(temp$Region)
tempBox <- ggplot(data=temp)+
  geom_boxplot(mapping=aes(x=reorder(Region,Species.count),y=Species.count),width=0.8)+
  geom_jitter(mapping=aes(x=Region,y=Species.count,color=Region,fill=Region),shape=21,color="black",size=3.0,width=0.15)+
  theme_classic(base_size=12)+
  scale_fill_manual(breaks=c("Southeastern","Southwestern","EastCentral","Northwestern","WestCentral"),
                    values=c("#EF632F","#FEF833","#76F112","#50CCFC","#9D55FD"),
                    labels=c("Southeast","Southwest","Eastern Central","Northwest","Western Central"))+
  labs(y="Number of Species Threatened",x="Region")+
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_rect(colour = "black", size=1), axis.text.x = element_blank(), axis.ticks.x = element_blank())
tempBox

results4=aov(Species.count~Region,data=temp)
summary(results4)
TukeyHSD(results4)

#bar graphs for each region showing the number of species threatened by the top three threats
ECThreats2 <- ECThreats %>% filter(Threat == "fishing and harvesting aquatic resources" | Threat == "domestic and urban waste water" | Threat == "temperature extremes")
ECtop <- ggplot(data=ECThreats2, aes(x=Threat,y=Species.Count,fill+Threat))+
  geom_bar(stat='identity',width=0.8)+
  theme_classic(base_size=12)+
  scale_fill_manual(values=c("#000000","#7a7a7a","#c8c8c8"))+
  labs(y="Number of Species Threatened",x="Threat")+
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_rect(colour = "black", size=1),
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank())
ECtop

NEThreats2 <- NEThreats %>% filter(Threat == "fishing and harvesting aquatic resources" | Threat == "domestic and urban waste water" | Threat == "temperature extremes")
NEtop <- ggplot(data=NEThreats2, aes(x=Threat,y=Species.Count,fill+Threat))+
  geom_bar(stat='identity',width=0.8)+
  theme_classic(base_size=12)+
  scale_fill_manual(values=c("#000000","#7a7a7a","#c8c8c8"))+
  labs(y="Number of Species Threatened",x="Threat")+
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_rect(colour = "black", size=1))
NEtop

NWThreats2 <- NWThreats %>% filter(Threat == "fishing and harvesting aquatic resources" | Threat == "domestic and urban waste water" | Threat == "temperature extremes")
NWtop <- ggplot(data=NWThreats2, aes(x=Threat,y=Species.Count,fill+Threat))+
  geom_bar(stat='identity',width=0.8)+
  theme_classic(base_size=12)+
  scale_fill_manual(values=c("#000000","#7a7a7a","#c8c8c8"))+
  labs(y="Number of Species Threatened",x="Threat")+
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_rect(colour = "black", size=1),
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank())
NWtop

SEThreats2 <- SEThreats %>% filter(Threat == "fishing and harvesting aquatic resources" | Threat == "domestic and urban waste water" | Threat == "temperature extremes")
SEtop <- ggplot(data=SEThreats2, aes(x=Threat,y=Species.Count,fill+Threat))+
  geom_bar(stat='identity',width=0.8)+
  theme_classic(base_size=12)+
  scale_fill_manual(values=c("#000000","#7a7a7a","#c8c8c8"))+
  labs(y="Number of Species Threatened",x="Threat")+
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_rect(colour = "black", size=1),
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank())
SEtop

SWThreats2 <- SWThreats %>% filter(Threat == "fishing and harvesting aquatic resources" | Threat == "domestic and urban waste water" | Threat == "temperature extremes")
SWtop <- ggplot(data=SWThreats2, aes(x=Threat,y=Species.Count,fill+Threat))+
  geom_bar(stat='identity',width=0.8)+
  theme_classic(base_size=12)+
  scale_fill_manual(values=c("#000000","#7a7a7a","#c8c8c8"))+
  labs(y="Number of Species Threatened",x="Threat")+
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_rect(colour = "black", size=1),
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank())
SWtop

WCThreats2 <- WCThreats %>% filter(Threat == "fishing and harvesting aquatic resources" | Threat == "domestic and urban waste water" | Threat == "temperature extremes")
WCtop <- ggplot(data=WCThreats2, aes(x=Threat,y=Species.Count,fill+Threat))+
  geom_bar(stat='identity',width=0.8)+
  theme_classic(base_size=12)+
  scale_fill_manual(values=c("#000000","#7a7a7a","#c8c8c8"))+
  labs(y="Number of Species Threatened",x="Threat")+
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_rect(colour = "black", size=1))
WCtop

#pie charts of taxonomic composition for each region
ECtaxa <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/EastCentral/taxa_counts.csv")
NWtaxa <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/Northwestern/taxa_counts.csv")
SEtaxa <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/southeastern/taxa_counts.csv")
SWtaxa <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/southwestern/taxa_counts.csv")
WCtaxa <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/WesternCentral/taxa_counts.csv")
NEtaxa <- read.csv("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data/Northeastern/taxa_counts.csv")

ECtaxapi <- ggplot(ECtaxa, aes(x="",y=Species.Count,fill=index))+
  geom_bar(stat="identity",width=1)+
  coord_polar("y",start=0)+
  theme_void()
ECtaxapi

NWtaxapi <- ggplot(NWtaxa, aes(x="",y=Species.Count,fill=index))+
  geom_bar(stat="identity",width=1)+
  coord_polar("y",start=0)+
  theme_void()
NWtaxapi

SEtaxapi <- ggplot(SEtaxa, aes(x="",y=Species.Count,fill=index))+
  geom_bar(stat="identity",width=1)+
  coord_polar("y",start=0)+
  theme_void()
SEtaxapi

SWtaxapi <- ggplot(SWtaxa, aes(x="",y=Species.Count,fill=index))+
  geom_bar(stat="identity",width=1)+
  coord_polar("y",start=0)+
  theme_void()
SWtaxapi

WCtaxapi <- ggplot(WCtaxa, aes(x="",y=Species.Count,fill=index))+
  geom_bar(stat="identity",width=1)+
  coord_polar("y",start=0)+
  theme_void()
WCtaxapi

NEtaxapi <- ggplot(NEtaxa, aes(x="",y=Species.Count,fill=index))+
  geom_bar(stat="identity",width=1)+
  coord_polar("y",start=0)+
  theme_void()
NEtaxapi

#determining if a threat is more significant between regions
wasteall <- rbind(ECwaste,NEwaste,NWwaste,SEwaste,SWwaste,WCwaste)
wasteall$Threat <- c("waste")
fishall <- rbind(ECfish,NEfish,NWfish,SEfish,SWfish,WCfish)
fishall$Threat <- c("fish")
tempall <- rbind(ECtemp,NWtemp,SEtemp,SWwaste,WCtemp)
tempall$Threat <- c("temp")
threatsall <- rbind(wasteall,tempall,fishall)
results6=aov(Species.count~Threat,data=threatsall)
summary(results6)
TukeyHSD(results6)

#determining which threat is more significant within a region
WCfish$Threat <- c("fish")
WCwaste$Threat <- c("waste")
WCtemp$Threat <- c("temp")
WCthreatstat <- rbind(WCfish,WCwaste,WCtemp)
results7=aov(Species.count~Threat,data=WCthreatstat)
summary(results7)
TukeyHSD(results7)



