--------Covid 19 Data Exploration 
--Skills used: Joins, subquery, analytic Functions, Aggregate Functions, Converting Data Types



--select data that we are going to use
select c.location,c.date,c.total_cases,c.total_deaths,c.population
from [project].[dbo].[CovidDeaths]c
order by 1,2
------------------------------------------------------------------------------
--global numbers
--looking at the global cases and deaths numbers per day and the percentage for death
--1
select sum(c.new_cases)as sum_cases,
sum(cast(c.new_deaths as int))as sum_deaths,
sum(cast(c.new_deaths as int))/sum(c.new_cases)*100 as deathpercentage
from [project].[dbo].[CovidDeaths]c
where c.continent is not null
order by 1,2
--------------------------------------------------------------------------------
--braking things by continent
---the data is not perfect and when you search per continent you won't fint the 
---right data but looking per loction and adding is not null function you will find the right data
--2
select c.location,max(cast(c.total_deaths as int))as max_deaths
from [project].[dbo].[CovidDeaths]c
where c.continent is  null
group by c.location
order by  max_deaths desc
----------------------------------------------------------------------------------
--looking at countries that have the highst infection rate compard to population
--3
select c.location,c.population,max(c.total_cases)as max_cases,(max(c.total_cases)/c.population)*100
as pop_cases
from [project].[dbo].[CovidDeaths]c
where c.continent is not null
group by c.location,c.population
order by  pop_cases desc
-----------------------------------------------------------------------------------
--4
select c.location,c.population,c.date,max(c.total_cases)as max_cases,(max(c.total_cases)/c.population)*100
as pop_cases
from [project].[dbo].[CovidDeaths]c
where c.continent is not null
group by c.location,c.population,c.date
order by  pop_cases desc
------------------------------------------------------------------------------------
-----------------------------------more optional queries----------------------------
--looking at total cases vs total deaths
--shows the likelihood of dynig from corona in each country
select c.location,c.date,c.total_cases,c.total_deaths,(c.total_deaths/c.total_cases)*100 as deathpercentage
from [project].[dbo].[CovidDeaths]c
order by 1,2

--looking at the total cases vs population
--shows what percentage of population got covid
select c.location,c.date,c.total_cases,c.population, (c.total_cases/c.population)*100 as pop_cases
from [project].[dbo].[CovidDeaths]c
where c.continent is not null
order by 1,2


--showing countries with the highst death count per population
select c.location,c.population,c.date,max(cast(c.total_deaths as int))as max_deaths,
(max(cast(c.total_deaths as int))/c.population)*100 as pop_deaths
from [project].[dbo].[CovidDeaths]c
where c.continent is not null
group by c.location,c.population,c.date
order by  pop_deaths desc


--looking on total population vs total vaccination
select c1.location,max(c1.population)as max_p,max(c2.total_vaccinations)max_v,
max(c2.total_vaccinations)/max(c1.population)*100 as vaccine_percent
from [project].[dbo].[CovidDeaths]c1
join [project]..CovidVaccinations$ c2
on c1.location=c2.location
and c1.date=c2.date
where c1.continent is not null
group by c1.location
order by vaccine_percent desc

--looking on new vaccination over time per loction and population vs total vaccination
select c3.*,c3.sum_vaccine/c3.population*100 as vaccine_percent
from
(select c1.continent, c1.location,c1.date,c1.population,c2.new_vaccinations,
sum(cast(c2.new_vaccinations as int)) over(partition by c1.location order by c1.location,c1.date) 
as sum_vaccine
from [project].[dbo].[CovidDeaths]c1
join [project]..CovidVaccinations$ c2
on c1.location=c2.location
and c1.date=c2.date
where c1.continent is not null
)c3
order by 1,2
