---
layout: default

title: Geo Zones
description: "2D spatial zone-based parameter interpolation"

parent: Processes
grand_parent: Reference

permalink: /processes/geo-zones.html
---
# Geo Zones

![Geo Zones]({{ site.img }}/reference/processes/geo-zones.png "Geo Zones")

Create interactive zones in 2D space where parameters change based on position within those zones. Define areas with different behaviors and interpolate smoothly between them as objects or people move through the space.

Perfect for location-based installations, interactive floor projections, or any system where you want different behaviors in different areas of a physical or virtual space.

## How it works

Geo Zones lets you define multiple zones in a 2D coordinate system, each with its own parameter values. As a position input moves through this space, the system interpolates between zone values to create smooth transitions.

**Position input** - XY coordinates representing location in 2D space, in latitude / longitude. 
**Zone definition** - Create zones with shapes, positions, and parameter values  
**Blur** - Smooth blending between zone parameters  
**Multiple outputs** - Different parameters can have different zone configurations

## Creative applications

**Interactive floors**: Create floor projections where different areas trigger different sounds, visuals, or lighting as people walk through them.

**Spatial audio zones**: Use position tracking to control [[DBAP]] or [[GBAP]] spatialization parameters, creating areas with different acoustic characteristics.

**Installation narratives**: Create story-driven installations where different physical locations trigger different narrative elements or media content.

**Performance spaces**: Design performance areas where musicians or dancers moving to different stage positions automatically affect sound or lighting parameters.

**Gallery interactivity**: Let gallery visitors discover different content by exploring different areas of an exhibition space.

## Usage

The most important thing for the process is the definition of the zones.
Zones are defined through a simple JSON syntax:

```json
[ // Root array containing the zones
  { // First zone
    "polygon": [ // Points of the polygon in lat / lon
            [45.528668022454156, -73.59866480075671], 
            [45.528640776488615, -73.59863261424853],
            [45.52871155322648, -73.59861115657641]
    ],
    // All the other members will be associated with the zone
    "variable1": 0.1, // Numbers will be interpolated depending on the blur radius
    "variable2": "Foo"
  }, 
  { // Second zone
    "polygon": [
            [45.52895895772783, -73.59866748296572], 
            [45.52878514835371, -73.59859506332232],
            [45.52880409516411, -73.59868491732432],
            [45.528858743384646, -73.59878281795336],
            [45.528947213892906, -73.59873319708659]
       ],
    "variable1": 0.81,
    "variable2": "Foo|Bar" // String values act as enumerations, with | indicating that multiples values are present.
  }, 
]
```

The process outputs the following: 

```json
{
  // If we're inside a zone: 
  "inside": [ distance_to_side, distance_to_center, influence ], 

  // If we're close enought to a zone:
  "closest": [ distance_to_side, distance_to_center, influence ], 

  // Raw information for every zone
  "per_zone": [ 
    [ distance_to_side, distance_to_center, influence ], // for first zone
    [ distance_to_side, distance_to_center, influence ], // for second zone
    // etc.
   ], 

   // Interpolated values of the attributes set in the zone definition
   "attributes": { 
     "variable1": 0.75,
     "variable2_Foo": 1.0, // One will be created for each enumeration member
     "variable2_Bar": 0.0,
   }
}
```


Here is for instance a complete example of zones from a Montreal park:

```json
[
    {
        "polygon": [
            [45.52890437603729, -73.59889355630321], 
            [45.52867350296089, -73.59877343022181],
            [45.528668022454156, -73.59866480075671],
            [45.52871155322648, -73.59861115657641],
            [45.52878514835371, -73.59859506332232],
            [45.52880409516411, -73.59868491732432],
            [45.528858743384646, -73.59878281795336],
            [45.528947213892906, -73.59873319708659]
       ],
        "volume": 79.9,
        "superficie": 131,
        "residus": "HeavyMetal" 
    },
    {
        "polygon": [
            [45.52895895772783, -73.59866748296572], 
            [45.52878514835371, -73.59859506332232],
            [45.52880409516411, -73.59868491732432],
            [45.528858743384646, -73.59878281795336],
            [45.528947213892906, -73.59873319708659]
       ],
        "volume": 55.5,        
        "superficie": 91,
        "residus": "HeavyMetal|MatieresResiduelles" 
    },
    {
        "polygon": [
            [45.528668022454156, -73.59866480075671], 
            [45.528640776488615, -73.59863261424853],
            [45.52871155322648, -73.59861115657641]
       ],
        "volume": 55.5,
        
        "superficie": 91,
        "residus": "HeavyMetal|MatieresResiduelles"
    },
    {
        "polygon": [
            [45.52895895772783, -73.59866748296572], 
            [45.52893954112888, -73.59843681299044],
            [45.528815369301896, -73.59847838723017],
            [45.52891652317469, -73.59836305224253],
            [45.52894455188325, -73.59828660928561],
            [45.52894455188325, -73.59828660928561],
            [45.528925605120165, -73.59837646328761],
            [45.52896866596742, -73.59846899949862],
            [45.529004210716344, -73.59854812466456]
       ],
        "volume": 489.6,
        
        "superficie": 322,
        "residus": "HeavyMetal"
    },
    {
        "polygon": [
            [45.52894455188325, -73.59828660928561], 
            [45.528925605120165, -73.59837646328761],
            [45.52896866596742, -73.59846899949862],
            [45.529004210716344, -73.59854812466456],
            [45.52909722189715, -73.59829331480815],
            [45.529001235559086, -73.5982490583594]
       ],
        "volume": 187,
        
        "superficie": 187,
        "residus": "HeavyMetal"
    },
    {
        "polygon": [
            [45.52912932168997, -73.59817932092501], 
            [45.52920651771554, -73.59797144972636],
            [45.52908469510181, -73.597727368706],
            [45.528979626807086, -73.59791646444155],
            [45.529009847650784, -73.59799290739848],
            [45.52904210406851, -73.59802241169764]
       ],
        "volume": 334,
        
        "superficie": 334,
        "residus": "HeavyMetal"
    },
    {
        "polygon": [
            [45.528979626807086, -73.59791646444155], 
            [45.529009847650784, -73.59799290739848],
            [45.52894220302412, -73.59794999205424]
       ],
        "volume": 120,
        
        "superficie": 240,
        "residus": "HeavyMetal" 
    },
    {
        "polygon": [
            [45.52894423861794, -73.5975999637778],
            [45.528854202234676, -73.59764690243556],
            [45.52878671399659, -73.59777698957278],
            [45.52881129787547, -73.59784270369364],
            [45.528807696405224, -73.59793255769564],
            [45.52878342567628, -73.59797144972636],
            [45.528755396887455, -73.59803716384722],
            [45.52884010951448, -73.5980680092509],
            [45.528922942994804, -73.59797547303988]
       ],
        "volume": 120,
        
        "superficie": 240,
        "residus": "HeavyMetal" 
    },
    {
        "polygon": [
            [45.528571878463225, -73.59710643731906],
            [45.52862261227488, -73.5973853870566],
            [45.528598341466065, -73.59742427908732],
            [45.52861916736876, -73.59755973064257],
            [45.528529130465145, -73.59758521162821],
            [45.52850673864912, -73.59763215028597],
            [45.52839806777833, -73.59764556133105],
            [45.52842296498062, -73.5975637539561],
            [45.52840621023194, -73.5974926754172],
            [45.528389455478276, -73.59744037234141],
            [45.52834827322601, -73.59739611589266],
            [45.52837097825894, -73.59734381281687],
            [45.528359860609044, -73.59728882753207]
       ],
        "volume": 297.5,
        "superficie": 595,
        "residus": "MatieresResiduelles|Hydrocarbures" 
    },
    {
        "polygon": [
            [45.52839806777833, -73.59764556133105], 
            [45.52842296498062, -73.5975637539561],
            [45.52840621023194, -73.5974926754172],
            [45.528389455478276, -73.59744037234141],
            [45.52834827322601, -73.59739611589266],
            [45.52832212337431, -73.59758789383723]
       ],
        "volume": 107.8,
        "superficie": 98,
        "residus": "MatieresResiduelles|Hydrocarbures" 
    },
    {
        "polygon": [
            [45.528120752545135, -73.59679395996882],
            [45.528240541627376, -73.59661291086032],
            [45.528280158072214, -73.59669740044428],
            [45.5282784356087, -73.59692404710604]
       ],
        "volume": 87,
        
        "superficie": 145,
        "residus": "Hydrocarbures" 
    },
    {
        "polygon": [
            [45.527962129571236, -73.59724859439685],
            [45.527847350748175, -73.59719629132105],
            [45.5277645156839, -73.59716544591738],
            [45.52791092542931, -73.597005854481]
       ],
        "volume": 58.5,
        
        "superficie": 167,
        "residus": "MatieresResiduelles"
    }
]
```
