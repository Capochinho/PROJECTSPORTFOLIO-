# Previewing the datasets
select * from covid_deaths;
select * from covid_vaccinations;

#Extracting of data to be used
select  location, date, total_cases, new_cases, total_deaths, population
from covid_deaths;

#Looking at Total cases vs Total deaths
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage, 
(100-(total_deaths/total_cases)*100) as SurvivingPercentage  
from covid_deaths;

#Focusing on Africa Total cases vs Total deaths
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage, 
(100-(total_deaths/total_cases)*100) as SurvivingPercentage  
from covid_deaths
where location like "%africa%";

#skewing the results to only Ghana
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage, 
(100-(total_deaths/total_cases)*100) as SurvivingPercentage  
from covid_deaths
where location = "Ghana";

#Focusing on Total cases vs Population
select location,date, population, total_cases, 
(cast(total_cases as decimal)/population)*100 as PopulationInfected,  (100-(cast(total_cases as decimal)/population)*100) as PopulationNotInfected 
from covid_deaths;

#Highest Infection Rate compared to countries population
select location, max(cast(total_cases as decimal)) as HighestCount, 
max((cast(total_cases as decimal)/population))*100 as PopulationInfected
from covid_deaths
where continent is not null
group by location
order by PopulationInfected desc;

#Looking at Countries with highest DeathCount
select location, max(cast(total_deaths as decimal)) as HighestDeathCount 
from covid_deaths
where continent is not null
group by location
order by HighestDeathCount desc;

#DeathCount Base on Continent
select location, max(cast(total_deaths as decimal)) as TotalDeathCount
from covid_deaths
where continent is  null
group by location
order by TotalDeathCount desc;


#WORLDWIDE NUMBERS
select date, total_cases, total_deaths, 
(cast(total_deaths as decimal)/total_cases)*100 as DeathPercentage 
from covid_deaths
where continent is not null;

select date, sum(new_cases), sum(new_deaths),
(sum(new_deaths)/sum(new_cases))*100 DeathRate
from covid_deaths
group by date;

#showing Total cases, Total deaths and DeathPercentage
select  sum(new_cases), sum(new_deaths),
(sum(new_deaths)/sum(new_cases))*100 DeathRate
from covid_deaths;


#Focusing on Total Population vs Vaccination
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(new_vaccinations as decimal)) over (partition by location order by date, location) as RollingNumberVaccinated 
from covid_deaths dea
inner join covid_vaccinations vac
on dea.date = vac.date
and dea.location = vac.location
where dea.continent is not null;

#the number of People vaccinated against population

with Percent_vaccinated (continent, location, date, population, new_vaccinations,RollingNumberVaccinated )
as (
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(new_vaccinations as decimal)) over (partition by location order by date, location) as RollingNumberVaccinated 
from covid_deaths dea
inner join covid_vaccinations vac
on dea.date = vac.date
and dea.location = vac.location
where dea.continent is not null
)
select *, (RollingNumberVaccinated/population) as PopulationPercentVaccinated
from Percent_vaccinated;

create view Percent_vaccinated as
 select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(new_vaccinations as decimal)) over (partition by location order by date, location) as RollingNumberVaccinated 
from covid_deaths dea
inner join covid_vaccinations vac
on dea.date = vac.date
and dea.location = vac.location
where dea.continent is not null;

select * from percentpopulationvaccinated;
