<div align="center">

# Hospice Care and Skilled Nursing Facility Demand

</div>

---

## **Important Notes:**

### **The Data:**

The data for this project was obtained from the following sources:

- 16 **publicly available** datasets containing Hospice Care Facility Quarterly Enrollment records and Skilled Nursing Facility Monthly Enrollment records for 2025. It was obtained from the US Data.gov.

[Data Source](https://github.com/H2-data/Hospice_and_Skilled_Nursing_Demand/tree/main/Hospice) (Hospice)

[Data Source](https://github.com/H2-data/Hospice_and_Skilled_Nursing_Demand/tree/main/SNF) (SNF)

- 2 **publicly available** datasets containing Hospice Care Facility and Skilled Nursing Facility Monthly Opening records for 2025. It was obtained from CMS.Data.gov.

[Data Source](https://data.cms.gov/provider-data/dataset/yc9t-dgbk) (Hospice)

[Data Source](https://data.cms.gov/provider-data/dataset/4pq5-n9py) (SNF)

[Dataset](https://github.com/H2-data/Hospice_and_Skilled_Nursing_Demand/blob/main/Hospice_General-Information_May2026.csv) (Hospice)

[Dataset](https://github.com/H2-data/Hospice_and_Skilled_Nursing_Demand/blob/main/NH_ProviderInfo_May2026.csv) (SNF)

- A **publicly available** dataset containing state by state population data. It was scraped from a Wikipedia page regarding demographics.

[Data Source](https://en.wikipedia.org/wiki/List_of_U.S._states_and_territories_by_population)

[Dataset](https://github.com/H2-data/Hospice_and_Skilled_Nursing_Demand/blob/main/population%20data.csv)

- A **publicly available** dataset containing Medicare Beneficiary enrollment information from 2013 to 2025. It was created by the Centers for Medicare and Medicaid Services (CMS).

[Data Source](https://data.cms.gov/resources/medicare-monthly-enrollment-data-dictionary)

[Dataset](https://github.com/H2-data/Hospice_and_Skilled_Nursing_Demand/blob/main/Medicare%20Monthly%20Enrollment%20Data_October%202025.zip)

### **How to Read and Run This Repository:**

- Files are labelled from 01-05. They can be read in numeric order. This README file contains the important points of the analysis, and should be read first.

- To test the code on this project, you will need access to the following resources:
  
  	- Visual Studio Code (Or any other all-inclusive coding environment.)
  	- A MySQL environment extension
  	- Power BI Desktop
  	- An OBDC Connector
  	- A Python environment extension with the following libraries installed:
 
      - Pandas
	  - Numpy
	  - Matplotlib
	  - Seaborn
      - SQLalchemy
  	  - requests
  	  - BeautifulSoup
  
**Step 1.** Plug the CSV file into the python script and run it until you reach the 'Database Creation' section. 

**Step 2.** Once you get to the Database Creation section, you can put the username, password and database name into the SQL alchemy engine object. Then run the code. It should slice the cleaned data into tables and send them to the database. This project does not use any SQL, so you don't need to run anything in the SQL workbench.

**Step 3.** Open the Power BI pbix file.

**Step 4.** You need to have an ODBC connector since the code is MySQL. Once you've created the connection object, you can connect the database to Power BI using the Power Query. This should activate the dashboard.

### **Who is the Project's Intended Recipient?:**

- This project is meant to be recieved and read by the Healthco Medical Solutions expansion project and marketing managers currently looking to open new healthcare facilities across the US. This project will use the aforementioned datasets to find out which states have a high population and a low number of Hospice Care and Skilled Nursing facilities, contributing demand assessment into the decision-making process.
___

## **Scenario and Objective:**

Healthco Medical Solutions (Not a real company) is planning on opening new healthcare facilities across the United States. They have assigned a team of data analysts and market researchers to investigate the demand for specific healthcare facilities in the United States. For my part, I have been assigned to evaluate the demand for Hospice Care facilities and Skilled Nursing facilities (henceforth HCFs and SNFs for convenience). I will use 3 datasets: Beneficiaries, Population and Hospice/SNF Enrollment Data. They will be cleaned, organized and analyzed to answer the following questions:

- What is the 'lay of the land?' What are the trends of these businesses in regards to their overall distributions and how they are structured?

- Which states have a high demand for HCFs facilities and SNFs based on the number of enrollments?

I will translate these business questions into more specific data questions:

- What are the distributions of ORGANIZATION_TYPE_STRUCTURE and PROPRIETARY_NONPROFIT structures?

- Which states have the most beneficiary enrollments relative to their facilities?

### **Data Reports:**

<table>
  <tr>
    <img width="1282" height="717" alt="Screenshot 2026-07-05 142825" src="https://github.com/user-attachments/assets/b22c4592-9e6a-4d3d-bc34-e786b3e3ef5f" />
    <br>
    <img width="1282" height="717" alt="Screenshot 2026-07-05 142858" src="https://github.com/user-attachments/assets/0dae62cb-d311-4d24-860c-2da05f2f8f66" />
  </tr>
</table>

To interact with the dashboards and see the data models behind them, see the Power BI section of the project, linked here:

[Dashboard]()

___

## **Data Preprocessing:**

Aside from generic data preprocessing (outlier management, missing values and duplicates) there was one unique challenge to preparing this data. Most of the datasets came in folders and files, but one of the datasets needed to be scraped for reference, so I used the following code snippet to scrape it and convert it into a dataframe:

```Python
url = 'https://en.wikipedia.org/wiki/List_of_U.S._states_and_territories_by_population'
headers = {
    "User-Agent": "Mozilla/5.0"
}

response = requests.get(url, headers = headers)

tables = pd.read_html(response.text)
len(tables)
```

Other than that, it was fairly straightforward. To see each step of the data cleaning process, the data preprocessing section of this project is linked here:

[Preprocessing](Hospice_+_SNF.ipynb)  

___

## **How can I solve the problem?**

My approach is to create a ratio in DAX that compares the number of facilities to the number of enrollments in each state. If the number is high, that means there's a large disparity between the two. 

```DAX
#SNF_enrollments = 
COUNT('snf_enrollments'[ENROLLMENT STATE])

SNF_enroll/facility_rate = 
DIVIDE([#SNF_enrollments], [#SNF_facilities], BLANK())
```

Using this simple ratio, I can visualize demand for facilities and pinpoint specific states.
___

## **Results and Observations:**

- Despite there being millions of Medicare beneficiaries per state, there's only about 20,000 total SNFs and HCFs in the US during 2025.

- Approximately 75% of SNFs and HCFs are For-Profit establishments.

- Approximately 80-90% of SNFs and HCFs are either Corporations or LLCs.

<div align="center">
    <img width="697" height="172" alt="Screenshot 2026-08-14 114730" src="https://github.com/user-attachments/assets/c4020283-bc66-4b4b-adb3-f3a879de84a7" />
</div>
<br>

<div align="center">
    <img width="700" height="175" alt="Screenshot 2026-08-14 114745" src="https://github.com/user-attachments/assets/2e9c3557-afa5-43fc-9445-05c2f735ef3e" />
</div>
<br>

- Here are the states with the highest demand for HCFs based on the ratio:

<div align="center">
  <img width="802" height="325" alt="image" src="https://github.com/user-attachments/assets/043e0eb8-460f-4dd1-8534-222c75031759" />
</div>
<br>

- Here are the states with the highest demand for SNFs based on the ratio:

<div align="center">
    <img width="802" height="369" alt="image" src="https://github.com/user-attachments/assets/21a7fe02-2625-449d-88cf-a4bd503649a5" />
</div>

- For evaluating and visualizing Hospice and SNF demand, **I only used the top 20 states by beneficiary population** to ensure there are enough beneficiaries in the area for profitability.

- These facilities are traditionally **For-Profit Corporations and LLCs**, so working within this well-tested corporate framework appears to be the most consistent option.

- **New York, Maryland and Florida** present the highest demand for Hospice Care facilities. After Maryland, there is a 33% increase in beneficiary to facility ratio for the following states, a rather steep dropoff. However, New York specifically could incur higher costs due to real estate and living costs, so referencing the budget and expense tables of other New York HCFs is paramount. 

- **Arizona, Washington, Florida, South Carolina and New York** present the highest demand for Skilled Nursing facilities. Arizona seems to present especially high demand, as there is a 30% difference between it and the state with the second highest demand, Washington.

- It's important to note that the data used is enrollment data for October 2025, meaning that data for a larger period of time may be necessary. Furthermore, understanding state by state compliance regulations and demographic patterns would allow for more conclusive findings.
