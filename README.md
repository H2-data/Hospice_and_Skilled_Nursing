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

**Step 2.** Once you get to the Database Creation section, you can put the username, password and database name into the SQL alchemy engine object. Then run the code. It should slice the cleaned data into tables and send them to the database.

**Step 3.** Run the SQL code on a MySQL workbench to see the growth rates for enrollments and facilities.

**Step 4.** Open the Power BI pbix file.

**Step 5.** You need to have an ODBC connector since the code is MySQL. Once you've created the connection object, you can connect the database to Power BI using the Power Query. This should activate the dashboard.

### **Who is the Project's Intended Recipient?:**

- This project is meant to be recieved and read by the Healthco Medical Solutions expansion project and marketing managers currently opening new healthcare facilities across the US. This project will use the aforementioned datasets to find out which states have a high population and a low number of Hospice Care and Skilled Nursing facilities, contributing demand assessment to the decision-making process.
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
    <img width="1160" height="652" alt="Screenshot 2026-08-14 132703" src="https://github.com/user-attachments/assets/849e4f9f-3745-400f-8801-e39f5cbcb228" />
    <br>
    <img width="1162" height="652" alt="Screenshot 2026-08-14 132722" src="https://github.com/user-attachments/assets/6ba8bd72-cc17-4f1d-bdd0-e0c2b74dc9a3" />
  </tr>
</table>

To view and interact with the dashboard, you can view the published version linked [HERE](https://app.powerbi.com/view?r=eyJrIjoiYThlNTI0OTUtNWE5Yy00YjlkLWE0YzgtZDA1OWRjMDE4ZTE0IiwidCI6ImRmZWM4YzJjLThlNWUtNDI4Yy05MmE4LTkzOTI1ZjM3Y2JlYiJ9).

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
  <img width="1122" height="302" alt="Screenshot 2026-08-14 130904" src="https://github.com/user-attachments/assets/5ad9d8d4-fc5e-4547-81dc-66d00dd7c889" />
</div>
<br>

- Here are the states with the highest demand for SNFs based on the ratio:

<div align="center">
    <img width="1081" height="307" alt="Screenshot 2026-08-14 130534" src="https://github.com/user-attachments/assets/86b82f33-ec89-4190-9371-2ab36f53fccc" />
</div>

- Conveniently and interestingly, demand for Hospice Care Facilities and Skilled Nursing Facilities appears to be regional. There is more demand for hospice care in the eastern states and more demand for skilled nursing facilities in the west. This will likely make establishing localized promotion campaigns much easier.

- These facilities are traditionally **For-Profit Corporations and LLCs**, so working within this well-tested corporate framework appears to be the most consistent option.

- **Nevada, California and Arizona** present the highest demand for Hospice Care facilities. These top 3 should be considered top priority, because there's a roughly 50% drop off in the demand ratio number when comparing them to the other states in the top 10.

- **New York, Texas and Wisconsin** present the highest demand for Skilled Nursing facilities, however all states in the top 10 for SNFs have similar scores between 11-13, meaning priority can be evenly distributed. New York technically has the highest demand, but it could incur higher costs due to real estate and living prices, so referencing the budget and expense tables of other New York HCFs is paramount. 

- It's important to note that the data used is enrollment data for 2025, meaning that data for a larger period of time may be necessary. Furthermore, understanding state by state compliance regulations and demographic patterns would allow for more conclusive findings.
