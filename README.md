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
<img  src="https://github.com/JuanFGQ/weather_app/assets/97085649/7935166b-2827-4fe2-bf3c-c600a1b4321a" width="200px" height="350px"> |  <img src="https://github.com/JuanFGQ/weather_app/assets/97085649/0a400742-035d-4b61-8a00-0542afab9d2a" width="200px" height="350px">


  ## :house: Home Page
  <img align="right" src="https://github.com/JuanFGQ/weather_app/assets/97085649/d4e84264-583c-4945-abc3-24d606d88df6" width="150px" height="300px">

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

## :newspaper: News Page
  <img  align ="right" src="https://github.com/JuanFGQ/weather_app/assets/97085649/226a9714-655c-4ee2-ae43-b94c805f477e" width="150px" height="300px">
  <img  align ="right" src="https://github.com/JuanFGQ/weather_app/assets/97085649/5fe769c1-1585-450c-9b6f-cc008a9bfbff" width="150px" height="300px">
  
## ***Features***
  * Sort news from newest to older.
  * Tap on for go to the news web.
  * Save your favorite news for saw later.
  * Once news was save, cant save again,and the app will provide feedback to the user.

--------------------------------------------------------

## :mag: Search Page
  <img  align ="right" src="https://github.com/JuanFGQ/weather_app/assets/97085649/b84b6dbb-d68f-4ffe-a6be-dd1d2d5abb75" width="150px" height="300px">
  <img  align ="right" src="https://github.com/JuanFGQ/weather_app/assets/97085649/f3c2f1a5-b941-45fd-aa96-e03725f47bec" width="150px" height="300px">
  

## ***Features***
  -  This page use MapBox Search Api to get all the suggested places according to search argument
      - Get a list of places only with one letter on search bar
      - Can save and delete places you´ve search before even if app was close previosuly,the history will persist.

--------------------------------------------------------

## :iphone: App Tools
  <img    src="https://github.com/JuanFGQ/weather_app/assets/97085649/2899382c-c031-4d77-b75f-0c693bfcf769" width="150px" height="300px">
  <img    src="https://github.com/JuanFGQ/weather_app/assets/97085649/1659dcbf-7129-4c3d-b4e8-aeebd248ef32" width="150px" height="300px">


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
  
     
![shadeCompilation](https://github.com/JuanFGQ/weather_app/assets/97085649/7df5dd7a-73c8-4466-bbde-5a19673964d2)

* once these modifications have been applied this was the result
  * the remaining janks are imperceptible when app is working.
  
![performance improvement](https://github.com/JuanFGQ/weather_app/assets/97085649/795fd911-7d7b-4862-b38b-663e922d22dc)


 



