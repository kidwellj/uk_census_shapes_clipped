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

# Create modest buffer around quite small building polygons for the sake of visualisation at very large scale where small polygons can appear as points
buffer <- st_buffer(buildings,150)
# Dissolve and merge overlapping shapes
union <- st_union(buffer)
# Generate a masking layer, with filled space for unoccupied layers
difference <- st_difference(local_authorities$geom, union)
# Write results to a file:
st_write(difference, "data/local_authorities_cropped_union_buffer_150.gpkg")
# Invert polygons in this new layer
inversion <- st_difference(local_authorities$geom, difference)
# Write results to a file:
st_write(inversion, "data/local_authorities_cropped_union_buffer_150_inverted.gpkg")

# open country shapefiles
countries <- st_read("data/infuse_ctry_2011.shp")
# Create modest buffer around quite small building polygons for the sake of visualisation at very large scale where small polygons can appear as points
buffer <- st_buffer(buildings,150)
# Dissolve and merge overlapping shapes
union <- st_union(buffer)
# Generate a masking layer, with filled space for unoccupied layers
difference <- st_difference(countries$geom, union)
# Write results to a file:
st_write(difference, "data/countries_cropped_union_buffer_150.gpkg")
# Invert polygons in this new layer
inversion <- st_difference(countries$geom, difference)
# Write results to a file:
st_write(inversion, "data/countries_cropped_union_buffer_150_inverted.gpkg")
