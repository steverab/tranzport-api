# Tranzport-API

A simple departures API for Munich's public transportation system.

## API

Base URL: `https://tranzport-api.herokuapp.com`

## Endpoints

### `GET /departures`

- **Parameters**: Requires a `station` parameter, e.g. `station=Marienplatz`.
- **Returns**: All the departures which are currently available for the station given.

```json

[
  { 
    "destination" : "Flughafen München",
    "line" : "S8",
    "minutes" : 0
  },
  { 
    "destination" : "Grafrath",
    "line" : "S4",
    "minutes" : 0
  },
  { 
    "destination" : "Freising/Flughafen München",
    "line" : "S1",
    "minutes" : 1
  },
  { 
    "destination" : "Klinikum Großhadern",
    "line" : "U6",
    "minutes" : 2
  },
  { 
    "destination" : "Tierpark (Alemannenstr)",
    "line" : "52",
    "minutes" : 2
  },
  { 
    "destination" : "Ostbahnhof",
    "line" : "S1",
    "minutes" : 2
  },
  { 
    "destination" : "Herrsching",
    "line" : "S8",
    "minutes" : 3
  },
  { 
    "destination" : "Ebersberg",
    "line" : "S4",
    "minutes" : 4
  },
  { 
    "destination" : "Fürstenried West",
    "line" : "U3",
    "minutes" : 5
  },
  { 
    "destination" : "Garching-Forschungszentrum",
    "line" : "U6",
    "minutes" : 5
  },
  { 
    "destination" : "Moosach",
    "line" : "U3",
    "minutes" : 6
  },
  { 
    "destination" : "Petershausen",
    "line" : "S2",
    "minutes" : 7
  },
  { 
    "destination" : "Holzkirchen",
    "line" : "S3",
    "minutes" : 7
  },
  { 
    "destination" : "Tierpark (Alemannenstr)",
    "line" : "52",
    "minutes" : 8
  },
  { 
    "destination" : "Starnberg",
    "line" : "S6",
    "minutes" : 9
  },
  { 
    "destination" : "Münchner Freiheit",
    "line" : "U6",
    "minutes" : 11
  },
  { 
    "destination" : "Höllriegelskreuth",
    "line" : "S7",
    "minutes" : 11
  },
  { 
    "destination" : "Klinikum Großhadern",
    "line" : "U6",
    "minutes" : 12
  },
  { 
    "destination" : "Kreuzstraße",
    "line" : "S7",
    "minutes" : 12
  },
  { 
    "destination" : "Ostbahnhof",
    "line" : "S6",
    "minutes" : 13
  }
]

```
