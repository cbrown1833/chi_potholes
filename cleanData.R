### Read 311 Potholes File Downloaded from Chicago Data Portal
### https://data.cityofchicago.org/
potholes<-read.csv("311_Potholes_Jan_24_2015_dwnld.csv",stringsAsFactors=FALSE)

### remove duplicates
potholes <- potholes[!grepl("Dup",potholes$STATUS),]

### remove 2009/2010 and also 2015; only want 2011-2014 start times
potholes <- potholes[!(substr(potholes$CREATION.DATE,7,10)=="2010"),]
potholes <- potholes[!(substr(potholes$CREATION.DATE,7,10)=="2009"),]
potholes <- potholes[!(substr(potholes$CREATION.DATE,7,10)=="2015"),]

# Remove all Community.Areas that are NA or 0
potholes <- subset(potholes, !is.na(potholes$Community.Area))
potholes <- subset(potholes, !(potholes$Community.Area==0))

###Take only Completed Requests
c_req <- potholes[!(potholes$COMPLETION.DATE==""),]

###Format date, calculate completion days, bind to dataset
cr_s_date <- as.Date(c_req$CREATION.DATE,"%m/%d/%Y")
cr_c_date <- as.Date(c_req$COMPLETION.DATE,"%m/%d/%Y")
cDays <- cr_c_date - cr_s_date; cDays <- as.integer(cDays)
c_req <- cbind(cr_s_date,cr_c_date,cDays,c_req)

#remove individual outliers
c_req <- c_req[(c_req$cDays<280),]   
write.csv(c_req, file="311_Potholes_clean.csv")
