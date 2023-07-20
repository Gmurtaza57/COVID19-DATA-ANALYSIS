# PortfolioProjects
## COVID-19 Data Analysis using SQL

This repository contains SQL queries and analysis for COVID-19 data using the "PortfolioProject..CovidDeaths" and "PortfolioProject..CovidVaccination" tables. The data is used to explore various aspects of the pandemic, including infection rates, death percentages, vaccination trends, and more. 

### Data Exploration

The data is first explored to understand the total cases, total deaths, and death percentages based on the location and date. The analysis provides insights into the likelihood of dying if contracting COVID-19 in different countries ("DeathPercentage") and what percentage of the population has been infected with the virus ("PercentPopulationInfected1").

### Countries with Highest Infection Rates

The analysis identifies countries with the highest infection rates compared to their population. The query calculates the "HighestInfectionCount" and "PercentPopulationInfected" for each country and presents the results in descending order of infection rate.

### Countries with Highest Death Counts

Another query focuses on countries with the highest death counts per population. It calculates the "TotalDeathCount" for each country and presents the results in descending order of the death count.

### Death Counts by Continent

A separate analysis groups the data by continent to identify the continents with the highest death counts per population. The query calculates the "TotalDeathCount" for each continent and presents the results in descending order.

### Global COVID-19 Numbers

The analysis provides global COVID-19 statistics, including the total cases, total deaths, and death percentage globally.

### Population vs. Vaccinations

The data is used to explore the relationship between a country's population and the number of vaccinations administered. The query calculates the "RollingPeopleVaccinated" and presents the results for each country and date.

### Using CTE (Common Table Expression)

A Common Table Expression (CTE) is utilized to simplify complex queries. The CTE is named "PopvsVac" and includes data related to population and vaccinations. The final query selects data from the CTE and calculates the percentage of the population vaccinated ("RollingPeopleVaccinated/Population") for each country and date.

### Using Temporary Table

A temporary table named "#PercentPopulationVaccinate" is created to store the data related to population and vaccinations. The data is then selected from the temporary table, and the percentage of the population vaccinated is calculated for each country and date.

### Creating a View

A view named "PercentPopulationVaccinated" is created to store the data related to population and vaccinations. The view simplifies the querying process by providing a pre-defined structure for accessing the required data.

Overall, this repository showcases different SQL queries and analyses to gain insights into COVID-19 data. The queries explore infection rates, death percentages, vaccination trends, and more, providing valuable information for understanding the impact of the pandemic globally and regionally.
