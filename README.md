# DS_Capstone_Shiny_Drugs_Analysis 
Capstone project for Misk Data Science Immersive Program

![Shiny Drugs](https://user-images.githubusercontent.com/89705616/142781811-cd2d1fac-118b-4607-b823-1ce6ef7073b2.png)


## **Links**
- Click [here](https://fatimahalamer.github.io/DS_Capstone_Shiny_Drugs/SFDA_MarkDown.html) for SFDA analysis document  
- Click [here](https://zuah3d-fatimahalamer.shinyapps.io/Interactive_Shiny_SFDA/) for SFDA shiny app

## **Summary**
*This project contains two parts:*

1- HTML document which provides a general description for Saudi FDA (SFDA) drugs, with comparing between Saudi drugs and non-Saudi drugs & how much our dependency on non-Saudi drugs.  

2- Shiny app For SFDA contains:  

- All of the registered manufacturing countries in one interactive map with present the name of highest price with each country. I added (Longitude&Latitude)to enable the map.  
- Interactive plot for all registered drugs by country and price, It was impossible to show them in the regular plot due to extreme values, the interactive plot enables that!  
- Interactive Table to allow searching by any keywords, or specifying, registered year, country, drug type, or route of administration  
- Pediatric paracetamol calculator, the most common used drug for children to reduce fever (antipyretic), however, the dose is needed to be calculated based on age, the app provides the calculated dose with integer number without a decimal component

## **Data**
data is availble in SFDA website, it contains 37 variables:

Variable  | Description
-------- | -------------
Register Number  | Every drug has unique registered number  
Register Year  | Year of drug registration  
Product type | All drugs for human use  
Drug Type|   Generic, biological, NCE (new chemical entity), Radio pharmaceutical or Health products   
Sub-Type  | Allergen product, biological bio, biosimilar, Biotechnology product ..etc
Scientific Name | Generic Name  
Scientific Name Arabic | Generic name in Arabic
Trade Name  | Commercial name
Trade Name Arabic | Commercial name in Arabic 
Strength | Strength of active ingredients in the drug 
Strength Unit | Strength Unit such as mg, g , ml ...etc
Pharmaceutical Form | solution, powder for inj..etc
Administration Route | Route of Administration 
AtcCode1  |  Anatomical Therapeutic Chemical (ATC) Classification, main pharmacological group
AtcCode2  | Pharmacological or Therapeutic subgroup
Size |  drug size
Size Unit  | unit size such as ml
Package Types | Blister, Bottle, Vial, Ampule ..etc
Package Size |  size of the package
Legal Status | prescription or Over counter drug
Product Control | controlled/uncontrolled
Distribute area | hospital or pharmacy 
Public price | public price for the drug in SR
shelf Life | length of time that a drug can be stored in months
Storage conditions | specific requirements for registered drugs
Marketing Company  |  a company that provides marketing services for drugs
Marketing Country |   a country that provides marketing services for drugs
Manufacture Name | Manufacture Name of drugs
Manufacture Country | Manufacture Country of the drugs 
2Manufacture Name  | second Manufacture Name of drugs
Manufacture Country | Country of the drug manufacturer
Secondary package  manufacture  |  Secondary package  manufacture 
Main Agent   | company that provides organizing transactions between two other parties.
Second Agent | there could be more than 1 agent for the same drug
Third agent  | there could be more than 2 agents for the same drug 
Marketing Status  |   all drugs are marketed 
Authorization Status  |  valid or suspended 
