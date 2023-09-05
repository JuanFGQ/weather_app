# ***Weather app with local news by place***

# :page_with_curl: **_App Features_**
  * ***State Management*** : provider.
  * ***Data Save***        : sqfLite.
  * ***Assets***: Dynamic assets change according to weather state.
  * ***Language*** : spanish and english.
  * ***API´s*** :
    - MapBox
    - Weather_Api
    - News_Api


## :calling: App Permissions

| :satellite: Location Permission | :bell: Notification Permission |
|-----------------|--------------|
|handleled with Geolocator and Permission Handler Package| Handleled with Awesome_notification Package|
<img  src="https://github.com/JuanFGQ/weather_app/assets/97085649/b09fd467-8152-4b44-907b-acc18d7b06d5" width="200px" height="350px"> |  <img src="https://github.com/JuanFGQ/weather_app/assets/97085649/8afe07f6-7b6d-41fc-82d5-66f193672024" width="200px" height="350px">


  ## :house: Home Page
  <img align="right" src="https://github.com/JuanFGQ/weather_app/assets/97085649/6de4f7d5-2a38-4be4-a2b8-5d6371f8db96" width="150px" height="300px">

  ## ***Features***
  * Dynamic background image, depending on the weather.
  * See all local news.
  * Save your favorite place.
  * Update to real location
  * Check out the weather elsewhere and their local news.
  * Set notifications whenever you want.
  * See more data about actual weather
  * Check weekly forecast



--------------------------------------------------------

![screen-recording-20230904-200322_gxtVqK3m]()

## :newspaper: News Page
  <img  align ="right" src="https://github.com/JuanFGQ/weather_app/assets/97085649/9a1f337c-f534-43f0-881c-c009db9ef7d0" width="150px" height="300px">
  <img  align ="right" src="https://github.com/JuanFGQ/weather_app/assets/97085649/daf9d4a8-ffd5-45cf-ab26-c2d965818a46" width="150px" height="300px">
  

## ***Features***
  * Sort news from newest to older.
  * Tap on for go to the news web.
  * Save your favorite news for saw later.
  * Once news was save, cant save again,and the app will provide feedback to the user.

--------------------------------------------------------

## :mag: Search Page
  <img  align ="right" src="https://github.com/JuanFGQ/weather_app/assets/97085649/70f7b653-27e9-4f4d-a7ca-3b68b60f1e89" width="150px" height="300px">
  <img  align ="right" src="https://github.com/JuanFGQ/weather_app/assets/97085649/1a1b5850-1e7b-4f33-8c72-48058b32ec30" width="150px" height="300px">


## ***Features***
  -  This page use MapBox Search Api to get all the suggested places according to search argument
      - Get a list of places only with one letter on search bar
      - Can save and delete places you´ve search before even if app was close previosuly,the history will persist.

--------------------------------------------------------

## :iphone: App Tools
  <img    src="https://github.com/JuanFGQ/weather_app/assets/97085649/81002a41-876c-40c0-acb4-31a9f257b21e" width="150px" height="300px">
  <img    src="https://github.com/JuanFGQ/weather_app/assets/97085649/6ecb0c39-64a4-47f1-85ab-2d7df8a357fb" width="150px" height="300px">


## ***Features***
  - List of all saved news and places
  - Manage news or places you want into the list deleting whatever you want
  - Language change to Spanish or English
--------------------------------------------------------

# :bar_chart: ***App Optimization***
  ## ***_Optimization Process_***
  
  * I ran the app in profile mode on a physical device and then took a look at Flutter DevTools to analyze where the errors were.
   * most of the janks were caused by Raster UI thread which means an overhead in the rendering of our widgets and/or assets.
      * _to solve this_: remove some unnecessary effects, like shadowLayers and elevation effects.
         * resize and optimize assets like images and gift, reducing image size , resolution and weight.
  

![shadeCompilation](https://github.com/JuanFGQ/weather_app/assets/97085649/983ef339-66c1-4b4f-ade3-17ce043e133f)

* once these modifications have been applied this was the result
  * the remaining janks are imperceptible when app is working.
  
![performance improvement](https://github.com/JuanFGQ/weather_app/assets/97085649/354a7928-61d3-4f41-8176-c5f65a80ae34)


 


