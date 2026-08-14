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

[Datasets]

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

- Which states have the most beneficiary enrollments relative to their populations of Medicare Beneficiaries?

### **Data Reports:**

<table>
  <tr>
    <img width="1338" height="750" alt="image" src="https://github.com/user-attachments/assets/c36cbaac-31d4-4022-827b-a524dfd6ce35" />
    <br>
    <img width="1343" height="752" alt="image" src="https://github.com/user-attachments/assets/35f7fca2-d3fd-4e14-8e46-596d5a8723b1" />
  </tr>
</table>

To interact with the dashboards and see the data models behind them, see the Power BI section of the project, linked here:

[Dashboard](https://app.powerbi.com/view?r=eyJrIjoiYTliNjJlYTQtMDMyMC00OWFjLWI5ZDQtZDkzNGFhOTQwOTliIiwidCI6ImRmZWM4YzJjLThlNWUtNDI4Yy05MmE4LTkzOTI1ZjM3Y2JlYiJ9)

___

## **Data Preprocessing:**

Aside from generic data preprocessing (outlier management, missing values and duplicates) there were a couple of unique challenges to preparing this data. For one thing, one of the datasets needed to be scraped for reference, so I used the following code snippet to scrape it and convert it into a dataframe:

```Python
url = 'https://en.wikipedia.org/wiki/List_of_U.S._states_and_territories_by_population'
headers = {
    "User-Agent": "Mozilla/5.0"
}

response = requests.get(url, headers = headers)

tables = pd.read_html(response.text)
len(tables)
```

The other main challenge is more obvious: There are 3 seperate tables that need to be organized and prepped. I decided to join the Population table and the Beneficiary table with the following code snippet, as they shared a similar structure and can be connected by state abbreviation.

```Python
df_population = df_pop4.merge(
    df_bene4,
    on = 'STATE_ABV',
    how = 'inner')
```

The final output for the Population Info table looks like this:

|STATE|STATE\_ABV|POPULATION|TOT\_BENES|
|---|---|---|---|
|California|CA|39355309\.0|7130161\.0|
|Texas|TX|31709821\.0|4921992\.0|
|Florida|FL|23462518\.0|5249062\.0|
|New York|NY|20002427\.0|4009232\.0|
|Pennsylvania|PA|13059432\.0|3006500\.0|

Now I can see the general population and the Medicare beneficiary population side by side. To see each step of the data cleaning process, the data preprocessing section of this project is linked here:

[Preprocessing](Hospice_+_SNF.ipynb)  

___

## **How can I solve the problem?**

My approach is to create a ratio in DAX that shows the states with the highest number of enrollments to 100k Medicare beneficiares. I'll use the Hospice Facility ratio as an example.

```DAX
p100k Hospice = 
DIVIDE(
    [#Hospice],
    SUM(population[TOT BENES])
) * 100000
```

<img width="322" height="247" alt="image" src="https://github.com/user-attachments/assets/42344931-8df4-4834-895b-233db76154ce" />
<br>
I chose to use Medicare beneficiaries instead of the general population for this ratio because Medicare beneficiaries are a more likely demographic to have demand for HCFs and SNFs.

___

## **Results and Observations:**

- Despite there being millions of Medicare beneficiaries per state, there's only about 20,000 total SNFs and HCFs in the US as of October 2025.

- Approximately 75% of SNFs and HCFs are For-Profit establishments.

<div align="center">
    <img width="851" height="281" alt="image" src="https://github.com/user-attachments/assets/5d2aa264-f1f7-4a80-8d00-fc46158940c7" />
</div>
<br>

- Approximately 80-90% of SNFs and HCFs are either Corporations or LLCs.

<div align="center">
    <img width="850" height="278" alt="image" src="https://github.com/user-attachments/assets/2abc6ad3-4737-4192-8ae2-8c48806f782c" />
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
