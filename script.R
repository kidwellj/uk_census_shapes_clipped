require(tidyverse)
require(sf)

# Load admin polygons:
oa11 <- st_read("./data/infuse_oa_lyr_2011.shp")
# download 2011 LSOA polygons - level 2
lsoa11 <- st_read("./data/infuse_lsoa_lyr_2011.shp")
# download local authorities data for whole UK - level 1 (least detailed)
local_authorities <- st_read("data/infuse_dist_lyr_2011.shp")
# Load buildings shapefile:
buildings <- st_read("./data/OS_Open_Zoomstack_district_buildings.gpkg")
# open country shapefiles
countries <- st_read("data/infuse_ctry_2011.shp")

# Generate simplified versions at 10m:
oa11_simplified_10m <- st_simplify(oa11, dTolerance = 10)  # 10 m
lsoa11_simplified_10m <- st_simplify(lsoa11, dTolerance = 10)  # 10 m
local_authorities_simplified_10m <- st_simplify(local_authorities, dTolerance = 10)  # 10 m
countries_simplified_10m <- st_simplify(countries, dTolerance = 10)  # 10 m

st_write(oa11_simplified_10m, "data/infuse_oa_lyr_2011_simplified_10m.gpkg")
st_write(lsoa11_simplified_10m, "data/infuse_lsoa_lyr_2011_simplified_10m.gpkg")
st_write(local_authorities_simplified_10m, "data/infuse_dist_lyr_2011_simplified_10m.gpkg")
st_write(countries_simplified_10m, "data/infuse_ctry_2011_simplified_10m.gpkg")

# Generate simplified versions at 100m:
oa11_simplified_100m <- st_simplify(oa11, dTolerance = 100)  # 100 m
lsoa11_simplified_100m <- st_simplify(lsoa11, dTolerance = 100)  # 100 m
local_authorities_simplified_100m <- st_simplify(local_authorities, dTolerance = 100)  # 100 m
countries_simplified_100m <- st_simplify(countries, dTolerance = 100)  # 100 m

st_write(oa11_simplified_100m, "data/infuse_oa_lyr_2011_simplified_100m.gpkg")
st_write(lsoa11_simplified_100m, "data/infuse_lsoa_lyr_2011_simplified_100m.gpkg")
st_write(local_authorities_simplified_100m, "data/infuse_dist_lyr_2011_simplified_100m.gpkg")
st_write(countries_simplified_100m, "data/infuse_ctry_2011_simplified_100m.gpkg")

## Initial work on data with buildings shapefile for large scale visualation -----
# Create modest buffer around quite small building polygons for the sake of visualisation at 
# very large scale where small polygons can appear as points. Initial work in QGIS confirmed that 150m 
# will render coherent shapes at national zoom level after dissolving
# Use union to dissolve and merge overlapping shapes
buildings_buffer <- st_union(st_buffer(buildings,150))
# Write results to a file:
st_write(buildings_buffer, "data/OS_Open_Zoomstack_district_buildings_buffered.gpkg")

## Process countries simplified shapefiles -----
# Generate a masking layer, based on difference between buffered buildings layer and admin shapefile
# with filled space for unoccupied layers
difference_ctry <- st_difference(countries_simplified_100m$geom, buildings_buffer)
## Write results to a file:
st_write(difference_ctry, "data/infuse_ctry_2011_simplified_100m_buildings_overlay.gpkg")
# Simplify layer
difference_ctry_simplified = st_simplify(difference_ctry, dTolerance = 100)  # 100 m
st_write(difference_ctry_simplified, "data/infuse_ctry_2011_simplified_100m_buildings_overlay_simplified.gpkg")
# Invert polygons in this new layer
inversion_ctry <- st_difference(difference_ctry, countries_simplified_100m$geom)
# Write results to a file:
st_write(inversion_ctry, "data/infuse_ctry_2011_simplified_100m_buildings.gpkg")
inversion_ctry_simplified = st_simplify(inversion_ctry, dTolerance = 100)  # 100 m
st_write(inversion_ctry_simplified, "data/infuse_ctry_2011_simplified_100m_buildings_simplified.gpkg")

## Process local authorities simplified shapefiles -----
difference_la <- st_difference(local_authorities_simplified_100m$geom, buildings_buffer)
## Write results to a file:
st_write(difference_la, "data/infuse_dist_lyr_2011_simplified_100m_buildings_overlay.gpkg")
# Simplify layer
difference_simplified = st_simplify(difference_la, dTolerance = 100)  # 100 m
st_write(difference_simplified, "data/infuse_dist_lyr_2011_simplified_100m_buildings_overlay_simplified.gpkg")
# Invert polygons in this new layer
inversion_la <- st_difference(difference_la, local_authorities_simplified_100m$geom)
# Write results to a file:
st_write(inversion_la, "data/infuse_dist_lyr_2011_simplified_100m_buildings.gpkg")
inversion_simplified_la = st_simplify(inversion_la, dTolerance = 100)  # 100 m
st_write(inversion_simplified_la, "data/infuse_dist_lyr_2011_simplified_100m_buildings_simplified.gpkg")

## Process lsoa simplified shapefile -----
difference_lsoa <- st_difference(lsoa11_simplified_100m$geom, buildings_buffer)
## Write results to a file:
st_write(difference_lsoa, "data/infuse_lsoa_lyr_2011_simplified_100m_buildings_overlay.gpkg")
# Simplify layer
difference_lsoa_simplified = st_simplify(difference_lsoa, dTolerance = 100)  # 100 m
st_write(difference_lsoa_simplified, "data/infuse_lsoa_lyr_2011_simplified_100m_buildings_overlay_simplified.gpkg")

## Process oa simplified shapefile -----
difference_oa <- st_difference(oa11_simplified_100m$geom, buildings_buffer)
## Write results to a file:
st_write(difference_oa, "data/infuse_oa_lyr_2011_simplified_100m_buildings_overlay.gpkg")
# Simplify layer
difference_oa_simplified = st_simplify(difference_oa, dTolerance = 100)  # 100 m
st_write(difference_oa_simplified, "data/infuse_oa_lyr_2011_simplified_100m_buildings_overlay_simplified.gpkg")

## Process countries shapefile -----
difference_ctry <- st_difference(countries$geom, buildings_buffer)
# Write results to a file:
st_write(difference_ctry, "data/infuse_ctry_2011_buildings_overlay.gpkg")
# Invert polygons in this new layer
inversion <- st_difference(difference_ctry, countries$geom)
# Write results to a file:
st_write(inversion, "data/infuse_ctry_2011_buildings.gpkg")
# Create simplified version:
inversion_simplified = st_simplify(inversion, dTolerance = 100)  # 100 m
st_write(inversion_simplified, "data/infuse_ctry_2011_buildings_simplified.gpkg")

## Process local authorities shapefile -----
difference_la <- st_difference(local_authorities$geom, buildings_buffer)
# Write results to a file:
st_write(difference_la, "data/infuse_dist_lyr_2011_buildings_overlay.gpkg")
# Invert polygons in this new layer
inversion_la <- st_difference(difference_la, local_authorities$geom)
# Write results to a file:
st_write(inversion_la, "data/infuse_dist_lyr_2011_buildings.gpkg")

## Process lsoa shapefile -----
difference_lsoa <- st_difference(lsoa11$geom, buildings_buffer)
# Write results to a file:
st_write(difference_lsoa, "data/infuse_lsoa_lyr_2011_buildings_overlay.gpkg")
difference_lsoa_simplified = st_simplify(difference_lsoa, dTolerance = 100)  # 100 m
st_write(difference_lsoa_simplified, "data/infuse_lsoa_lyr_2011_buildings_overlay_simplified.gpkg")

## Process oa shapefile -----
difference_oa <- st_difference(oa11$geom, buildings_buffer)
# Write results to a file:
st_write(difference_oa, "data/infuse_oa_lyr_2011_buildings_overlay.gpkg")
difference_oa_simplified = st_simplify(difference_oa, dTolerance = 100)  # 100 m
st_write(difference_oa_simplified, "data/infuse_oa_lyr_2011_buildings_overlay_simplified.gpkg")
