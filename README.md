This is the official code repository for "The Farzi Rockstars". This Spring application was developed during HaXplore 2.0, the online hackathon conducted by Codefest, the annual departmental fest of Computer Science department, IIT BHU Varanasi.

### The Farzi Rockstars

* Divya Gupta (Team Leader)
* Khushi Agrawal
* Ekta Sinha
* Divyanshi Parashar

#### Hassle-free grocery shopping in COVID-19


#### Overview

In times of COVID-19, social distancing has become of utmost importance. A lot of delivery partners also shut down due to lack of funds, etc. However, daily essentials such as fruits, vegetables, medicines, etc. are of utmost importance and need to be purchased regularly. To enhance grocery shopping experience, we aim to introduce the concept of "Takeaway Shopping", similar to Takeaway food deliveries offered by many food chain partners. Our concept enables the user to select the products they need to shop, wherein they also put up an estimated pickup time. This will be entered by the user during checkout, while also paying for the items purchased. This will help in preventing crowding at billing centres at such shops, which is needed to contain the spread of COVID-19. 
Vendors have also been adversely affected due to COVID with lockdown being imposed in the entire country, hampering their sales and their daily meals. Some have also suffered to earn bread for their family members. Our webapp provides the option to partner up with the store, wherein they can sell their products at our quoted price. Thus, this will have a 2-way benefit: benefitting the customers to avoid over-crowding and have a smooth hassle-free shopping experience, and benefitting the vendors by providing them employment means in these challenging times. 

We plan to have 3 interfaces:
* User interface: for purchasing products, checkout, updating their profile, bill payment, etc.
* Vendor interface: for interacting with the admin, putting up their proposals of the items they wish to sell to the shop, and their expected price. Any other negotiations if needed. 
* Admin interface: for adding/updating products, viewing all orders, and viewing vendor proposals. 

#### Technology used

Our application uses Spring framework for developing the webapp. SQL is used to store data in the backend. Spring involves the use of Java, JSP, and JDBC queries for retrieval of data.

#### Screenshots/Demo Video

* The Home Page

![alt text](https://github.com/divya-gupta-2499/The_Farzi_Rockstars/blob/main/Screenshot%20from%202021-03-27%2015-54-51.png)

* The Sample Login Page

![alt text](https://github.com/divya-gupta-2499/The_Farzi_Rockstars/blob/main/Screenshot%20from%202021-03-27%2015-55-13.png)

(Note: The frontend design makes use of predesigned templates.)

#### Usage

Run the command "mvn clean install" from the location where pom.xml file is located to check if the application builds successfully. Upon successful BUILD, it creates a .war file in the target folder. We use Tomcat server to run our application. So, copy the .war file in the webapp folder of Tomcat and then move to the bin folder and run "./catalina.sh start" command. This starts the tomcat server and hosts our webapp locally. Head over to "http://localhost:8080/departmental" to view the home page.  

#### Tracks used

We used an open PS idea to develop a solution for tackling the rising cases of COVID-19 while also ensuring that the daily needs of people are fulfilled. 

#### AWS Services Used

So far, we haven't explored much about the AWS services, but we plan to host our webapp using AWS.




