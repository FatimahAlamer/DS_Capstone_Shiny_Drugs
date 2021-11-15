library(tidyverse)
library(leaflet)
library(naniar)
library(report)

HumanDrugs <- read_csv("Data/HumanDrugs.csv")
top_price <- read_csv("Data/top_price.csv")



#Correcting spelling issues:
HumanDrugs %>% rename(`Manufacture Country` = `Manufacture Country...29`,`Second Agent`=`Secosnd Agent`)->HumanDrugs

#Correcting spelling issues:
HumanDrugs[HumanDrugs == 20211] <- 2021

HumanDrugs %>%
  mutate(Drug_Status= case_when(
    (`Manufacture Country`== "Saudi Arabia") ~ "Saudi Drugs",
    (`Manufacture Country` != "Saudi Arabia") ~ "Non Saudi Drugs")) -> HumanDrugs
# missing visulzation:

gg_miss_var(HumanDrugs)
vis_miss(HumanDrugs)
colnames(HumanDrugs)
#it will not be used in analysis 
#1811
HumanDrugs$`Scientific Name` = tolower(HumanDrugs$`Scientific Name`)
library(babynames)
babynames
HumanDrugs

df[df == "Old Value"] <- "New Value"

HumanDrugs %>% distinct(`Scientific Name`)->dis_Human_drugs
# inconsistency, removing unssry salts  
df$conference <- str_replace(df$conference, "trihydrate", "")
HumanDrugs$`Scientific Name` <- str_replace(HumanDrugs$`Scientific Name`, " ,", ",")
HumanDrugs$`Scientific Name` <- str_replace(HumanDrugs$`Scientific Name`, "monosodium", "")
HumanDrugs$`Scientific Name` <- str_replace(HumanDrugs$`Scientific Name`, "acetate", "")
HumanDrugs$`Scientific Name` <- str_replace(HumanDrugs$`Scientific Name`, "(", "")

HumanDrugs$`Scientific Name` <- str_replace(HumanDrugs$`Scientific Name`, "fumarate", "")

HumanDrugs$`Scientific Name` <- str_replace(HumanDrugs$`Scientific Name`, "hcl", "")
HumanDrugs$`Scientific Name` <- str_replace(HumanDrugs$`Scientific Name`, "hydrochloride", "")
HumanDrugs$`Scientific Name` <- str_replace(HumanDrugs$`Scientific Name`, "monohydrate", "")
HumanDrugs$`Scientific Name` <- str_replace(HumanDrugs$`Scientific Name`, "acetate", "")
# spelling issues:
HumanDrugs[HumanDrugs=="(cefalexin (cephalexin"] <- "cefalexin (cephalexin)"
HumanDrugs[HumanDrugs=="acyclovir (aciclovir)"] <- "acyclovir"
HumanDrugs[HumanDrugs=="adapalene , benzoyl peroxide"] <- "adapalene, benzoyl peroxide"
HumanDrugs[HumanDrugs=="adrenaline acid tartrate"] <- "adrenaline"
HumanDrugs[HumanDrugs=="alendronate sodium)"] <- "alendronate"
HumanDrugs[HumanDrugs=="allergin"] <- "allergen"
HumanDrugs[HumanDrugs=="ambroxol hydrochloride"] <- "ambroxol"
HumanDrugs[HumanDrugs=="allergin"] <- "allergen"
HumanDrugs[HumanDrugs=="amoxicillin, potassium clavulanate"] <- "amoxicillin, clavulanic acid"
HumanDrugs[HumanDrugs=="amoxycillin"] <- "amoxicillin"
HumanDrugs[HumanDrugs=="ampicillin sodium"] <- "ampicillin"
HumanDrugs[HumanDrugs=="anastrozole"] <- "anastrazole"
HumanDrugs[HumanDrugs=="antazoline hcl , tetrahydrozoline hcl"] <- "antazoline hydrochloride , tetrahydrozoline hydrochloride"
HumanDrugs[HumanDrugs=="anthraquinone glycosides of rhubarb extract , salicylic acid"] <- "anthraquinon glycosides, salicylic acid"
HumanDrugs[HumanDrugs=="aripiprazol"] <- "aripiprazole"
HumanDrugs[HumanDrugs=="articaine hydrochloride, adrenaline tartrate"] <- "articaine hydrochloride , adrenaline"
HumanDrugs[HumanDrugs=="atomoxetine hydrochloride"] <- "atomoxetine"
HumanDrugs[HumanDrugs=="atorvastatin calcium trihydrate"] <- "atorvastatin"
HumanDrugs[HumanDrugs=="atorvastatin calcium"] <- "atorvastatin"
HumanDrugs[HumanDrugs=="atropine sulphate"] <- "atropine sulfate"
HumanDrugs[HumanDrugs=="azathioprine hydrochloride"] <- "azathioprine"
HumanDrugs[HumanDrugs=="water for injections"] <- "water"
HumanDrugs[HumanDrugs=="diclofenac potassium"] <- "diclofenac"
HumanDrugs[HumanDrugs=="amlodipine, valsartan, hydrochlorothiazide"] <- "amlodipine , valsartan  , hydrochlorothiazide"
HumanDrugs[HumanDrugs=="sodium chloride, potassium chloride , tri sodium citrate anhydrous , anhydrous dextrose"] <- "sodium chloride, potassium chloride , tri sodium citrate anhydrous , dextrose anhydrous"
HumanDrugs[HumanDrugs=="beclomethasone dipropionate"] <- "beclometasone dipropionate"
HumanDrugs[HumanDrugs=="bosentan"] <- "bosentan"
HumanDrugs[HumanDrugs=="bosutinib"] <- "bosutinib"
HumanDrugs[HumanDrugs=="brimonidine tartrate, timolol (as maleate)"] <- "brimonidine tartrate, timolol maleate"
HumanDrugs[HumanDrugs=="formoterol"] <- "formterol"
HumanDrugs[HumanDrugs=="busulfan"] <- "butenafine"
HumanDrugs[HumanDrugs=="caffeine citrate"] <- "caffeine"
HumanDrugs[HumanDrugs=="calcipotriol (as ), betamethasone (as dipropionate)"] <- "calcipotriol, betamethasone"
HumanDrugs[HumanDrugs=="diclofenac potassium"] <- "diclofenac"
HumanDrugs[HumanDrugs=="diclofenac potassium"] <- "diclofenac"

write.csv(HumanDrugs,"Data/HumanDrugs.csv")



# Saudi drugs =2315

sdrugs$`Scientific Name` = tolower(sdrugs$`Scientific Name`)


sdrugs %>% select (AtcCode1,`Scientific Name`,`Drug_Status`) ->SATC
#distinct Saudi srugs =561

# non Saudi 
nosdrugs$`Scientific Name` = tolower(nosdrugs$`Scientific Name`)


nosdrugs %>% select (AtcCode1,`Scientific Name`,`Drug_Status`) ->NOATC


#
NOATC %>% distinct(`Scientific Name`)->dis_NOATC




#1654

HumanDrugs %>% group_by(`Scientific Name`) %>% filter(`Manufacture Country`!="Saudi Arabia") ->No_Saudi_Drug
HumanDrugs %>% group_by(`Scientific Name`) %>% filter(`Manufacture Country`=="Saudi Arabia") ->Saudi_Drug

Saudi_Drug %>% 
  anti_join(No_Saudi_Drug, by = "Scientific Name") ->anti_Saudi
anti_Saudi %>% distinct(`Scientific Name`)->di_anti_Saudi


colnames(HumanDrugs)
# anti jon for non Saudi drugs
NOATC %>% 
  anti_join(SATC, by = "Scientific Name") ->anti
anti %>% distinct(`Scientific Name`)->dis_anti


# anti join for saudi drug
SATC %>% 
  anti_join(NOATC, by = "AtcCode1") ->anti2
anti2 %>% distinct(`Scientific Name`)->dis_anti2
ALLOPURINOL

#SATC %>% distinct(`Scientific Name`)->dis_ASTC
#SATC[!grepl("DEXTROSE", SATC$`Scientific Name`),]

#SATC %>% filter(!grepl('DEXTROSE',`Scientific Name`))-> gggg
#SATC %>% filter(!grepl('Sodium chloride',`Scientific Name`))-> MMM


#df %>% filter(!grepl('REVERSE', Name))
#library(stringr)

#df %>%  filter(!str_detect(Name, 'REVERSE'))




#anti join
dis_ASTC %>% 
  anti_join(dis_NOATC, by = "Scientific Name") ->anti_for_SA


anti_for_SA %>%
  filter(-contains("DEXTROSE"))->anti_for_SA_NO_DX

#
dis_NOATC %>% 
  anti_join(dis_ASTC, by = "Scientific Name") ->anti_for_NOSA


nosdrugs %>% count(AtcCode1) -> NOSAtcCode1

#HumanDrugs %>% select (AtcCode1) %>% filter(AtcCode1== "NA") ->NAATC

HumanDrugs %>% select (AtcCode1,`Scientific Name`,`Drug_Status`) ->sn


#by name

anti2 %>% distinct(AtcCode1,`Scientific Name`,`Drug_Status`)->mn

unique(anti2$`Scientific Name`) -> unanti2

SATC %>% 
  anti_join(NOATC, by = "Scientific Name") ->anti222

unique(anti2$`Scientific Name`) -> unanti2

#anti2 %>% group_by(AtcCode1) %>% summarise(AtcCode1 = n()) %>% arrange(desc(AtcCode1)) -> MMMM

NAATC %>%filter (AtcCode1=="NA") -> NNNN