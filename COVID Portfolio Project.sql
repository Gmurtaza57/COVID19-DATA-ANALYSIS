SELECT *
From PortfolioProject..CovidDeaths
where continent is not null
Order By 3,4

--SELECT *
--From PortfolioProject..CovidVaccination
--Order by 3,4

-- Select Data that we are going to be using

SELECT location, date, total_cases, new_cases, total_deaths,population
From PortfolioProject..CovidDeaths
order by 1,2


--Looking at Total Cases vs Total Deaths
-- Shows likehood of dying if you contract covid in your country
SELECT location, date, total_cases, total_deaths, (CONVERT(decimal,total_deaths)/(total_cases))*100 AS DeathPercentage
From PortfolioProject..CovidDeaths
where location like '%pak%'
order by 1,2

-- Looking at Total Cases vs Population
-- Shows what percentage of population got Covid
SELECT location, date, total_cases, Population, (total_cases)/(population)*100 AS PercentPopulationInfected1
From PortfolioProject..CovidDeaths
where location like '%pak%'
order by 1,2


--Looking at Countries with Highest Infection Rate compared to Population
SELECT Location, Population, MAX(total_cases) AS HighestInfectionCount, ((MAX(total_cases))/(population))*100 AS 
PercentPopulationInfected  
From PortfolioProject..CovidDeaths
--where location like '%pak%'
Group by Location,Population
order by PercentPopulationInfected DESC;


-- Showing Countries with Highest Death Count per population
SELECT Location, MAX(cast(total_deaths as int)) AS TotalDeathCount
From PortfolioProject..CovidDeaths
--where location like '%pak%'
where continent is not null
Group by Location
order by TotalDeathCount DESC;

-- lets break everything down by continent
-- Showing Continent with Highest Death Count per population
SELECT continent, MAX(cast(total_deaths as int)) AS TotalDeathCount
From PortfolioProject..CovidDeaths
--where location like '%pak%'
where continent is not null
Group by continent
order by TotalDeathCount DESC;


 -- GLOBAL NUMBERS
 SELECT  SUM(new_cases) as total_cases ,SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage  
From PortfolioProject..CovidDeaths
--where location like '%pak%' 
WHERE continent is not null
order by 1,2

-- Looking at Total Population vs Vaccinations
SELECT dea.continent, dea.location ,dea.date, vac.new_vaccinations
,SUM(CONVERT(BIGINT,vac.new_vaccinations)) OVER (partition by dea.location   order by dea.location,dea.Date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccination vac
	On dea.location = vac.location 
	and dea.date = vac.date
where dea.continent is not null
order by 1 , 2 , 3 




-- USE CTE 
With PopvsVac (Continent, Location, Date , Population, New_Vaccinations,RollingPeopleVaccinated) as 
(SELECT dea.continent, dea.location ,dea.date, dea.population,vac.new_vaccinations
,SUM(CONVERT(BIGINT,vac.new_vaccinations)) OVER (partition by dea.location   order by dea.location,dea.Date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccination vac
	On dea.location = vac.location 
	and dea.date = vac.date
where dea.continent is not null
---order by 1 , 2 , 3 
)
SELECT * ,(RollingPeopleVaccinated/Population)*100
FROM PopvsVac

-- TEMP TABLE 
DROP Table if exists #PercentPopulationVaccinate
Create Table #PercentPopulationVaccinate
(Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric )

INSERT INTO #PercentPopulationVaccinate
SELECT dea.continent, dea.location ,dea.date, vac.new_vaccinations, dea.population
,SUM(CONVERT(BIGINT,vac.new_vaccinations)) OVER (partition by dea.location   order by dea.location,dea.Date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccination vac
	On dea.location = vac.location 
	and dea.date = vac.date
where dea.continent is not null
--order by 1 , 2 , 3 

SELECT * ,(RollingPeopleVaccinated/Population)*100
FROM #PercentPopulationVaccinate





CREATE VIEW PercentPopulationVaccinated as 
SELECT dea.continent, dea.location ,dea.date, vac.new_vaccinations
,SUM(CONVERT(BIGINT,vac.new_vaccinations)) OVER (partition by dea.location   order by dea.location,dea.Date) AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccination vac
	On dea.location = vac.location 
	and dea.date = vac.date
where dea.continent is not null

SELECT *
FROM PercentPopulationVaccinated