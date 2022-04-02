# UK Census Polygons - Clipped!

Choropleth visualisations of data can often end up visually misleading in that they colour in polygons which contain vast tracts of uninhabited land. A more accurate visual communication can be achieved by clipping administrative polygons to data on the presence of buildings, that is, only using choropleth shading for areas which are inhabited.

It is time consuming to produce this data, so I have done so programatically and uploaded the resulting geopackage files to a public repository for easy re-use for reproducible research. 

The files in this repository are only the code used to produce those files. Separate licenses apply to that data etc.

Data derived from these computations can be found [on zenodo](https://zenodo.org/deposit/6395804). 

Please note, final clipping doesn't seem to work in R on the current version, so I am finishing these using `difference` in QGIS. Output with versions used is as follows:


```
QGIS version: 3.16.15-Hannover
QGIS code revision: e7fdad6431
Qt version: 5.14.2
GDAL version: 3.2.1
GEOS version: 3.9.1-CAPI-1.14.2
PROJ version: Rel. 6.3.2, May 1st, 2020
Processing algorithm…
Algorithm 'Difference' starting…
Input parameters:
{ 'INPUT' : 'infuse_dist_lyr_2011_simplified_100m.gpkg|layername=infuse_dist_lyr_2011_simplified_100m', 'OUTPUT' : 'infuse_dist_lyr_2011_simplified_100m_buildings_simplified.gpkg', 'OVERLAY' : 'infuse_dist_lyr_2011_simplified_100m_buildings_overlay_simplified.gpkg|layername=infuse_dist_lyr_2011_simplified_100m_buildings_overlay_simplified' }

Execution completed in 262.19 seconds
Results:
{'OUTPUT': 'infuse_dist_lyr_2011_simplified_100m_buildings.gpkg'}

Loading resulting layers
Algorithm 'Difference' finished

QGIS version: 3.16.15-Hannover
QGIS code revision: e7fdad6431
Qt version: 5.14.2
GDAL version: 3.2.1
GEOS version: 3.9.1-CAPI-1.14.2
PROJ version: Rel. 6.3.2, May 1st, 2020
Processing algorithm…
Algorithm 'Difference' starting…
Input parameters:
{ 'INPUT' : 'infuse_ctry_2011_simplified_100m.gpkg|layername=infuse_ctry_2011_simplified_100m', 'OUTPUT' : 'infuse_ctry_2011_simplified_100m_buildings_simplified.gpkg', 'OVERLAY' : 'infuse_ctry_2011_simplified_100m_buildings_overlay_simplified.gpkg|layername=infuse_ctry_2011_simplified_100_buildings_overlay_simplified' }

Execution completed in 1548.94 seconds
Results:
{'OUTPUT': 'infuse_ctry_2011_simplified_100m_buildings_simplified.gpkg'}

Loading resulting layers
Algorithm 'Difference' finished
```