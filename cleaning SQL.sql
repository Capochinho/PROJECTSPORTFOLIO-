select * from nashvillehousing;

select SaleDate, convert(date, SaleDate) 
from nashville_housing;

update nashville_housing
set SaleDate = convert(date, SaleDate);

alter table nashville_housing
add column ConvertedSaleDate date;

update nashville_housing
set ConvertedSaleDate = convert(date, SaleDate);

select * from nashville_housing;

select *
from nashville_housing;

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.PropertyAddress, b.PropertyAddress)
from nashville_housing a
inner join nashville_housing b
on a.ParcelID = b.ParcelID
and a.UniqueID <> b.UniqueID
where PropertyAddress is null;

update a
set PropertyAddress = isnull(a.PropertyAddress, b.PropertyAddress)
from nashville_housing a
inner join nashville_housing b
on a.ParcelID = b.ParcelID
and a.UniqueID <> b.UniqueID
where PropertyAddress is null;

select PropertyAddress 
from nashville_housing;

select substring(PropertyAddress, 1, locate(',' , PropertyAddress)-1) as Address,
substring(PropertyAddress, locate(',', PropertyAddress)+1, length(PropertyAddress))
from nashville_housing;

alter table nashville_housing
add column PropertySplitAddress varchar(255);

update nashville_housing
set PropertySplitAddress =substring(PropertyAddress, 1, locate(',' , PropertyAddress)-1);

alter table nashville_housing
add column PropertySplitCity varchar(255);

update nashville_housing
set PropertySplitCity =substring(PropertyAddress, locate(',', PropertyAddress)+1, length(PropertyAddress));

select 
from nashville_housing;
