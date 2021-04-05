library(tidyverse)
setwd("/Users/lumosmaximma/PycharmProjects/pacific-marine-threats/Data")

#bar graph of number of species threatened in each region
Region <- c("EastCentral","Northeastern","Northwestern","Southeastern","Southwestern","WesternCentral")
Number <- c(183,2,294,31,157,342)
spperregion <- data.frame(Region,Number)
spperregion
spperregionBar <- ggplot(data=spperregion,aes(x=reorder(Region,Number),y=Number))+
  geom_bar(stat="identity",width=0.6)+
  geom_text(aes(label=Number),vjust=-0.3,size=3.5)+
  theme_classic(base_size=12)+
  theme(axis.text.x=element_text(angle=45, hjust=1))+
  theme(legend.position="none")+
  scale_x_discrete(labels=c("EastCentral"="Eastern Central","Northeastern"="Northeastern","Northwestern"="Northwestern","Southeastern"="Southeastern","Southwestern"="Southwestern","WesternCentral"="Western Central"))+
  labs(x="Region",y="Number of Threatened Species")
spperregionBar

#bar graphs of overall top threats for all regions combined
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
overallthreatsdf <- rbind(ECThreats,NEThreats,NWThreats,SEThreats,SWThreats,WCThreats)