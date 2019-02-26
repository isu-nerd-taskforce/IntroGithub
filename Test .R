#To find the html of the website, right click and select inspect. 
myurl <- ("https://www.pols.iastate.edu/dir/#faculty")
myhtml<-read_html(myurl)

#To get the extra links embedded within the primary link 
#Estimate the nodes by guess and check e.g. [62:86]
html_nodes(myhtml, "a")[62:86]
#html_nodes(myhtml, "div/a")[62:86]

#Name the nodes 
#href and a encompass the data such as the .entry-title and .title
mynodes<-html_nodes(myhtml,"a")[62:86]
myattr<-html_attr(mynodes,"href")
myattr
#Alternatively, use the piping operator 
facpaths<-html_nodes(myhtml, "a")[62:86] %>% html_attr("href")

#Stumping the constant for href e.g. header 
mystub<-"https://www.pols.iastate.edu"
myurls<-paste0(mystub, myattr)

#cbinding the function 
get_info<-function(myurls){
  myurls[1] %>% read_html() %>% html_nodes(".entry-title") %>% html_text() -> pname
  myurls[1] %>% read_html() %>% html_nodes(".title") %>% html_text() -> title
  cbind.data.frame(pname,title)
}

#To format the information (Usually rbind)
lapply(myurls,get_info)
#To clean up the information
do.call(rbind, lapply(myurls, get_info))

