library("dplyr")
library("data.table")
# Since the file size is big, more than 500MB
# Read the first several rows to have a rough idea of what the data looks like
da <- read.csv("repdata_data_StormData.csv.bz2", nrows=10)

# Check the column names to see which columns are interested
colNames <- names(da)

# Since we are particular interested in the two questions
# (1) Which event types are most harmful with respect to population health
# (2) Which event types have the greatest economic consequences
# We select these columns for analysis in the meanwhile saving memory space.

colIdx <- match(c("EVTYPE", "FATALITIES", "INJURIES", "PROPDMG", "PROPDMGEXP",
                  "CROPDMG", "CROPDMGEXP", "REFNUM"), colNames)

# Since the data is big, we use the library data.table to read it into memory
# by using multiple threads, library("data.table")
fda <- fread("repdata_data_StormData.csv.bz2", select=colIdx)

# The "PROPDMGEXP" and "CROPDMGEXP" denote the damage scale, so wee need to
# check how they look like
unique(fda$PROPDMGEXP)
unique(fda$CROPDMGEXP)

# So now we only focus on "K,k", "M,m", and "B,b", and convert them into
# 10^3, 10^6 and 10^9. However the for loop is too slow
###

## So we can use dplyr package to group and summarize the data
#Fatalities
f_fda <- group_by(fda, EVTYPE)
f_fda <- summarise(f_fda, FATALITIES_SUM=sum(FATALITIES))
f_fda <- f_fda[order(f_fda$FATALITIES_SUM, decreasing = TRUE), ]
head(f_fda, n=10)

#Injuries
i_fda <- group_by(fda, EVTYPE)
i_fda <- summarise(i_fda, INJURIES_SUM=sum(INJURIES))
i_fda <- i_fda[order(i_fda$INJURIES_SUM, decreasing = TRUE), ]
head(i_fda, n=10)

#Property damage
pd_fda <- subset(fda, 
                 fda$PROPDMGEXP == "K"|fda$PROPDMGEXP == "M"|fda$PROPDMGEXP == "B",
                 c("EVTYPE", "PROPDMG", "PROPDMGEXP"))
pd_fda <- group_by(pd_fda, .dots=c("EVTYPE", "PROPDMGEXP"))
pd_fda <- summarise(pd_fda, PROPDMG_SUM=sum(PROPDMG))
ungroup(pd_fda)
nrows <- nrow(pd_fda)
for (i in 1 : nrows) {
  pdu <- pd_fda$PROPDMGEXP[i]
  if (pdu == "K") {
    pd_fda$PROPDMG_SUM[i] <- pd_fda$PROPDMG_SUM[i] * 1000
  } else if (pdu == "M") {
    pd_fda$PROPDMG_SUM[i] <- pd_fda$PROPDMG_SUM[i] * 1000000
  } else if (pdu == "B") {
    pd_fda$PROPDMG_SUM[i] <- pd_fda$PROPDMG_SUM[i] * 1000000000
  }
}
pd_fda <- group_by(pd_fda, EVTYPE)
spd_fda <- summarise(pd_fda, PROPDMG_SUM=sum(PROPDMG_SUM))
spd_fda <- spd_fda[order(spd_fda$PROPDMG_SUM, decreasing = TRUE), ]
head(spd_fda, n=10)

#Crop damage
cd_fda <- subset(fda, 
                 fda$CROPDMGEXP == "K"|fda$CROPDMGEXP == "M"|fda$CROPDMGEXP == "B",
                 c("EVTYPE", "CROPDMG", "CROPDMGEXP"))
cd_fda <- group_by(cd_fda, .dots=c("EVTYPE", "CROPDMGEXP"))
cd_fda <- summarise(cd_fda, CROPDMG_SUM=sum(CROPDMG))
ungroup(cd_fda)
nrows <- nrow(cd_fda)
for (i in 1 : nrows) {
  cdu <- cd_fda$CROPDMGEXP[i]
  if (cdu == "K") {
    cd_fda$CROPDMG_SUM[i] <- cd_fda$CROPDMG_SUM[i] * 1000
  } else if (cdu == "M") {
    cd_fda$CROPDMG_SUM[i] <- cd_fda$CROPDMG_SUM[i] * 1000000
  } else if (pdu == "B") {
    cd_fda$CROPDMG_SUM[i] <- cd_fda$CROPDMG_SUM[i] * 1000000000
  }
}
cd_fda <- group_by(cd_fda, EVTYPE)
scd_fda <- summarise(cd_fda, CROPDMG_SUM=sum(CROPDMG_SUM))
scd_fda <- scd_fda[order(scd_fda$CROPDMG_SUM, decreasing = TRUE), ]
head(scd_fda, n=10)
