### Shane Whelan
### R integration with Tableau
### 09-06-2017

# Connection between R and Tableau Server
library(Rserve)
Rserve()
library(mvoutlier)

#################
# https://www.tableau.com/learn/tutorials/on-demand/how-integrate-r-and-tableau?reg-delay=true
# This is where we might want to get to in the end.
# Step 1: Install and Configure R and Rserve
# Install R and run the Rserve service. For more information on installing and configuring R, see R Implementation Notes.
# Note: If R is not installed on the computer running Tableau Server, it must be configured for a remote connection.
# Step 2: Configure Tableau Server
# Stop Tableau Server.
# Open the Command Prompt as an administrator and change to the Tableau Server bin directory. For example:
#   32-bit: cd "C:\Program Files (x86)\Tableau\Tableau Server\9.1\bin"
# 64-bit: cd "C:\Program Files\Tableau\Tableau Server\9.1\bin"
# Enter the following commands to set the host address and port values:
#   tabadmin set vizqlserver.rserve.host <ip address of Rserve>
#   tabadmin set vizqlserver.rserve.port <port of Rserve>
#   Enter the following command to register the changes:
#   tabadmin config
# Start Tableau Server.
#################

# workflow.

# create dataframe
data(iris)
iris_2 <- rbind(iris, iris)
save(iris, iris_2, file="/Users/wheeldogg/Dropbox/Documents/workspace/sample.RData")


# originally.
# 1. Run R script on Server.
# 2. Output an Excel sheet.
# 3. Load automatically data in Tableau and update.

# now.
# 1. Run R script to output .tde
# 2. Read in tde file and use python Tableau API.
# 3. Tableau data is updated automatically.

# 1.
# R package able to export data frames as .TDE
# https://community.tableau.com/ideas/2831
# The idea will be to use python and R together.
# Thus the R python pipe.
# R mainly for data analysis packages.
# Python for connections between databases and Tableau.


# https://github.com/Btibert3/tableau-r
# led to the hack around in terms of using .rdata loaded in python


### RUN R SCRIPT.

# at the end run 

save.image(file="1.RData")

save(city, country, file="1.RData")



# read in the data from the R session within python
r.r("load('test-data.rdata')")
# from R.
# Can you use R to create a data extract file .tds

#######
# 1. Best idea is to run python script that extracts the DATAFRAME in python
#### (if I cant get TableauR working)
# 1. read in r session data.
r.r("load('test-data.rdata')")

r.r('dim(df)')

# use comm to bring in as pandas data frame
# http://pandas.pydata.org/pandas-docs/stable/r_interface.html
df = com.load_data('df')
df.head()

# done.

#######

### 2. 
### to python

# http://nbviewer.jupyter.org/github/Btibert3/tableau-r/blob/master/Python-R-Tableau-Predictive-Modeling.ipynb

# https://www.doingdata.org/blog/how-to-create-a-tableau-data-extract-using-python


# Once installed we can start importing the Document API Library in order to find information on our data source (scroll down if you can’t wait to see the complete script).
# // import Document API
# from tableaudocumentapi import Datasource

# The next step is to load the Tableau Data Source (.tds) file by creating a variable.

# // load your tds file
# sourceTDS = Datasource.from_file('your_file.tds')

# I navigated to the file location before I started the script, if you haven’t you need to add the path of the file to the filename. Once done, we can now extract the first piece of information from our datasource, the total number of fields.

# // number of fields
# len(sourceTDS.fields)

# However, this is not very clear if you run it because the output will just be a bunch of numbers. Let’s add some text to the output.

# // number of fields
# print '{} total fields in your data source'.format(len(sourceTDS.fields))

# The next thing we can do is break this down by individual fields with a for loop. This will return the names of the fields and the field types. You can also add for example, field.calculation in the for loop, which will return a boolean if the field is a calculation. Another element you can add is the default field aggregation or the description of the field.

# for field in sourceTDS.fields.values():
# print field.name, field.datatype



# issue with Running the python Tableau api on non windows environment.

# try and download a windows conda environment.


# DATA HOSTED WITH ♥ BY PASTEBIN.COM - DOWNLOAD RAW - SEE ORIGINAL
# from tableaudocumentapi import Datasource
 
# sourceTDS = Datasource.from_file('Superstore_Example.tds')
 
# print '{} total fields in your data source'.format(len(sourceTDS.fields))
 
# // print to a file called 'output.txt'
# for count, field in enumerate(sourceTDS.fields.values()):
#     with open('output.txt','a') as output:
#         output.write('{:&amp;&gt;4}: {} is a {}'.format(count+1, field.name, field.datatype))
#         blank_line = False
#         if field.calculation:
#             output.write('      the formula is {}'.format(field.calculation))
#             blank_line = True
#         if field.default_aggregation:
#             output.write('      the default aggregation is {}'.format(field.default_aggregation))
#             blank_line = True
#         if field.description:
#             output.write('      the description is {}'.format(field.description))
 
#         if blank_line:
#             output.write('')
           
# output.close()



#### 3. Tableau
#### on the Tableau side.

# http://www.simafore.com/blog/bid/120209/Integrating-Tableau-and-R-for-data-analytics-in-four-simple-steps


