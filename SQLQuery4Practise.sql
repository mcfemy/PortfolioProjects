-- The first step was importing the data and checking to see all the rows and columns for the two data set
select *
from PortFolioProject..CD
order by 3, 4

select *
from PortFolioProject..CV
order by 3, 4

-- select Data that we will be using
select location, date,total_cases, new_cases, total_deaths, population
from PortFolioProject..CD
where continent is not null
order by 1, 2

-- Looking at Total Cases Vs Total Death
select location, date, total_cases, cast(Total_deaths as int), cast((total_deaths /total_cases) as int)*100 as PercentDeathCount
from PortFolioProject..CD
where location like '%states%'
order by 1, 2


-- Looking at total cases vs population
-- It shows percentage of population that has covid

select location, date,total_cases, population, (total_cases/population)*100 as PercentPopulationInfected
from PortFolioProject..CD
--where location like '%states%'
where continent is not null
order by 1, 2


-- Looking at countries with highest infection rate compared to Population

select location, population, max(total_cases) as HighestInfectionCount,  max((total_cases/population))*100 as PercentPopulationInfected
from PortFolioProject..CD
--where location like '%states%'
where continent is not null
Group by location, population
order by PercentPopulationInfected desc

--LET'S BREAK THINGS DOWN BY CONTINENT
--Looking at countries with highest death count per population


select location, MAX(cast(Total_deaths as int)) as TotalDeathCounts
from PortFolioProject..CD
--where location like '%states%'
where continent is null
Group by location
order by TotalDeathCounts desc

--showing continent with higest death count per population

select continent, MAX(cast(Total_deaths as int)) as TotalDeathCounts
from PortFolioProject..CD
--where location like '%states%'
where continent is not null
Group by continent
order by TotalDeathCounts desc

-- Global Numbers

select date, SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths --(SUM(CAST(new_deaths as int)/SUM(New_Cases))*100
-- where location like '%states%'
from PortFolioProject.dbo.CD
where continent is not null
Group by date
order by 1, 2

select SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths --(SUM(CAST(new_deaths as int)/SUM(New_Cases))*100
-- where location like '%states%'
from PortFolioProject.dbo.CD
where continent is null
--Group by date
order by 1, 2

---- JOINING THE TWO TABLES TOGETHER.

select *
from PortFolioProject..CV
Join PortFolioProject..CD
on CV.location = CD.location
and CV.date = CD.date

-- Looking at Total Population vs Vaccinations
select CD.continent, CD.location, CD.date, CD.population
from PortFolioProject..CV
Join PortFolioProject..CD
on CV.location = CD.location
and CV.date = CD.date
where cd.continent is not null
order by 2, 3