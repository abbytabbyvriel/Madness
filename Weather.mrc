
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; weather underground for mIRC ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;by eqrunner ;;v4.1;;

/*
-- COMMANDS --
!w  or !weather [zipcode|city,state|city,country|airport] = will return weather current conditions.
!current [zipcode|city,state|city,country|airport] = will return current conditions.
!forecast [zipcode|city,state|city,country|airport] = will give detailed 3 day forecast (for us)
!forecast5 [zipcode|city,state|city,country|airport] = will send 5 day forecast to $nick that requested. (to prevent chan flooding)
!alerts [zipcode|city,state|city,country|airport] = will tell you if there are any weather alerts in your area.
!alertinfo [zipcode|city,state|city,country|airport] = will send $nick the detailed report of alerts in said area
!time [zipcode|city,state|city,country|airport] = will return current time.

-- REGISTER --
Register - Each user can assign a default location with themself. So in the future they can use just the command ( !weather, or !forecast, or !alerts, etc)
![w|forecast|forecast5|alerts|alertinfo|time|current] REGISTER [zipcode|city,state|city,country|airport] = will link user to said default location
![w|forecast|forecast5|alerts|alertinfo|time|current] REGISTER [zipcode|city,state|city,country|airport] = will CHANGE users default if they already have registured.
![w|forecast|forecast5|alerts|alertinfo|time|current] REMOVE = will remove the users default location
User can use any of the !commands to registure. !weather register 90210, will work just as well as !time register 90210

-- HELP --
![w|forecast|forecast5|alerts|alertinfo|time|current] [?|help] = Will message user the list of above commands just as they are written.

-- Switch --
![w|forecast|forecast5|alerts|alertinfo|time|current] [ON|OFF} = Will turn the script ON or OFF. Currently only set for Ops only.


-- NOTES- -
Notes from wunderground:
We don't support old style abbreviations like Conn. for Connecticut, use CT
If you are searching for an international city, try the name of the country or province
Don't use provinces for non-us cities (ie: Vancouver, BC)
Zipcodes only work in Canada, UK and the US
*/


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
on *:CONNECT: {
  if ($hget(wu_reg) == $null) { hmake wu_reg 100 }
  if ($isfile(wu_reg.dat)) { hload wu_reg wu_reg.dat }
}
ON *:DISCONNECT: {
  if ($hget(wu_reg)) { hsave -o wu_reg wu_reg.dat }
}

on $*:INPUT:#: {
  if ($regex($1,/^[!](w|weather|forecast|forecast5|alert|alerts|alertinfo|alertsinfo|time|current)/Si)) wunderground $1-
}

on $*:text:/^[!](w |weather|forecast|forecast5|alert|alerts|alertinfo|alertsinfo|time|current)/Si:#: {
  wunderground $1-
}

alias wunderground {
  ;botabuse 
  unset %wu_*

  ;--- Preperation. Sets up all the variables needed for the script ---
  set %wu_command $1
  set %wu_2 $2
  set %wu_location $2-
  set %wu_3 $3
  set %wu_3_long $3-
  set %wu_nick $nick
  set %wu_network $network
  set %wu_chan $chan
  ;set %wu_onoff $+(%,wunderground_,%wu_chan)

  ;--- Registration Check. Checks to see if the $nick already has a 'default' location on file ---
  if ($2 == $null) { 
    if ($hget(wu_reg,%wu_nick) != $null) {
      set %wu_location $hget(wu_reg,%wu_nick)
    }
    if ($hget(wu_reg,%wu_nick) == $null) {
      .notice $nick Please specify a location $1 [zipcode|city,state|city,country|airport]
      wu_cleanup
    }
  }
  ;--- Modify Registration and Help and ON/OFF Switch ---
  if ($2 != $null) {
    if (%wu_2 == register) && (%wu_3 != $null) {
      hadd -m wu_reg %wu_nick %wu_3_long
      .notice %wu_nick You are now linked to %wu_3_long
      set %wu_location $hget(wu_reg,%wu_nick)
      ;echo -s %wu_location
    }
    if (%wu_2 == remove) {
      hdel wu_reg %wu_nick
      .notice %wu_nick Your location association has been removed. 
      wu_cleanup
    }
    if (%wu_2 == ?) || (%wu_2 == help) { 
      wu_help 

    }

    ;;;---Below is used to turn the script on or off, but only if user is an op of a channel ---

    if (%wu_2 == on) || (%wu_2 == off) && (%wu_nick isop %wu_chan) {
      if (%wu_2 == on) {
        set $+(%,wunderground_,%wu_chan) ON
        .notice %wu_nick !weather script is now ON
        wu_cleanup
        halt   
      }
      if (%wu_2 == off) {
        set $+(%,wunderground_,%wu_chan) OFF
        .notice %wu_nick !weather script is now OFF
        wu_cleanup
        halt     
      }
    } ;end of %wu_on/off


    ;--- Default for a channel ---
    if ($2 == shoutdrive) && (%wu_network == iPocalypse) {
      set %wu_location 90046
    } ; end of Default for a channel

  } ;end of ($2 != $null)


  ;--- Checks if wunderground is suppost to be OFF for the channel --
  if ($($+(%,wunderground_,%wu_chan),2) == OFF) {
    wu_cleanup
    halt
  }

  ;---Command Prep. Checks command to see which data file it will be pulling from depending on command entered ---
  set %wu_address $replace(%wu_location,$chr(32),$chr(43)) 
  if (%wu_command == !w )  set %wu_command !weather
  if (%wu_command == !weather) || (%wu_command == !current) || (%wu_command == !time) { 
    set %wu_link $+(/auto/wui/geo/WXCurrentObXML/index.xml?query=,%wu_address)
    set %wu_host api.wunderground.com
    sockopen wunderground %wu_host 80
  }
  if (%wu_command == !forecast) || (%wu_command == !forecast5) { 
    set %wu_link $+(/auto/wui/geo/ForecastXML/index.xml?query=,%wu_address)
    set %wu_host www.wunderground.com
    sockopen wunderground %wu_host 80

  }
  if (%wu_command == !alert) set %wu_command !alerts
  if (%wu_command == !alertsinfo) set %wu_command !alertinfo
  if (%wu_command == !alerts) || (%wu_command == !alertinfo) { 
    set %wu_link $+(/auto/wui/geo/AlertsXML/index.xml?query=,%wu_address)
    set %wu_host www.wunderground.com
    sockopen wunderground %wu_host 80
  }

  ;echo -s LINK: %wu_link
}


on *:sockopen:wunderground: {

  ;sockwrite -n $sockname GET %wu_link XML/1.0
  sockwrite -n $sockname GET %wu_link
  sockwrite -n $sockname Host: %wu_host
  sockwrite -n $sockname $crlf
}

on *:sockread:wunderground: {
  sockread %wu_temp
  if ($regex(%wu_temp,/([[:xdigit:]]{2});/)) {
    set %wu_temp $replace(%wu_temp,$+(&#x,$regml(1),;),$chr($base($regml(1),16,10)))
  }
  set %wu_temp $regsubex(%wu_temp,/[\46\43](\d+)\73/g,$chr(\1))
  set %wu_temp $replacex(%wu_temp,&quot;,",&amp;lt;,<,&amp;rt;,>,&amp;deg;,°,&amp;,&)
  ;set %wu_temp $regsubex(%wu_temp,/&#(\d+)\;/g,$chr(\1))
  ;echo -s %wu_temp

  ;--- Variables for Weather, Current and Time Command ---
  if (%wu_command == !weather) || (%wu_command == !current) || (%wu_command == !time) { 
    ; local info
    if (<full> isin %wu_temp) && (%wu_full == $null) %wu_full = $remove(%wu_temp,<full>,</full>,$chr(9)) 
    if (<city> isin %wu_temp) && (%wu_city == $null) %wu_city = $remove(%wu_temp,<city>,</city>,$chr(9)) 
    if (<state> isin %wu_temp) && (%wu_state == $null) %wu_state = $remove(%wu_temp,<state>,</state>,$chr(9)) 
    if (<state_name> isin %wu_temp) && (%wu_state_name == $null) %wu_state_name = $remove(%wu_temp,<state_name>,</state_name>,$chr(9)) 
    if (<country> isin %wu_temp) && (%wu_country == $null)  %wu_country = $remove(%wu_temp,<country>,</country>,$chr(9)) 
    if (<country_iso3166> isin %wu_temp) && (%wu_country_iso3166 == $null) %wu_country_iso3166 = $remove(%wu_temp,<country_iso3166>,</country_iso3166>,$chr(9)) 
    if (<zip> isin %wu_temp) && (%wu_zip == $null)  %wu_zip = $remove(%wu_temp,<zip>,</zip>,$chr(9)) 
    if (<latitude> isin %wu_temp) && (%wu_latitude == $null) %wu_latitude = $remove(%wu_temp,<latitude>,</latitude>,$chr(9)) 
    if (<longitude> isin %wu_temp) && (%wu_longitude == $null) %wu_longitude = $remove(%wu_temp,<longitude>,</longitude>,$chr(9)) 
    if (<elevation> isin %wu_temp) && (%wu_elevation == $null) %wu_elevation = $remove(%wu_temp,<elevation>,</elevation>,$chr(9)) 

    if (<local_time> isin %wu_temp) %wu_local_time = $remove(%wu_temp,<local_time>,</local_time>,$chr(9)) 
    if (<local_time_rfc822> isin %wu_temp) %wu_local_time_rfc822 = $remove(%wu_temp,<local_time_rfc822>,</local_time_rfc822>,$chr(9)) 

    ; current weather
    if (<weather> isin %wu_temp) %wu_weather = $remove(%wu_temp,<weather>,</weather>,$chr(9)) 
    if (<temperature_string> isin %wu_temp) %wu_temperature_string = $remove(%wu_temp,<temperature_string>,</temperature_string>,$chr(9)) 
    if (<temp_f> isin %wu_temp) %wu_temp_f = $remove(%wu_temp,<temp_f>,</temp_f>,$chr(9))
    if (<temp_c> isin %wu_temp) %wu_temp_c = $remove(%wu_temp,<temp_c>,</temp_c>,$chr(9)) 
    if (<relative_humidity> isin %wu_temp) %wu_relative_humidity = $remove(%wu_temp,<relative_humidity>,</relative_humidity>,$chr(9)) 

    ; wind
    if (<wind_string> isin %wu_temp) %wu_wind_string = $remove(%wu_temp,<wind_string>,</wind_string>,$chr(9)) 
    if (<wind_dir> isin %wu_temp) %wu_wind_dir = $remove(%wu_temp,<wind_dir>,</wind_dir>,$chr(9)) 
    if (<wind_degrees> isin %wu_temp) %wu_wind_degrees = $remove(%wu_temp,<wind_degrees>,</wind_degrees>,$chr(9)) 
    if (<wind_mph> isin %wu_temp) %wu_wind_mph = $remove(%wu_temp,<wind_mph>,</wind_mph>,$chr(9)) 
    if (<wind_gust_mph> isin %wu_temp) %wu_wind_gust_mph = $remove(%wu_temp,<wind_gust_mph>,</wind_gust_mph>,$chr(9)) 

    if (<pressure_string> isin %wu_temp) %wu_pressure_string = $remove(%wu_temp,<pressure_string>,</pressure_string>,$chr(9)) 
    if (<pressure_mb> isin %wu_temp) %wu_pressure_mb = $remove(%wu_temp,<pressure_mb>,</pressure_mb>,$chr(9))
    if (<pressure_in> isin %wu_temp) %wu_pressure_in = $remove(%wu_temp,<pressure_in>,</pressure_in>,$chr(9))
    if (<dewpoint_string> isin %wu_temp) %wu_dewpoint_string = $remove(%wu_temp,<dewpoint_string>,</dewpoint_string>,$chr(9))
    if (<dewpoint_f> isin %wu_temp) %wu_dewpoint_f = $remove(%wu_temp,<dewpoint_f>,</dewpoint_f>,$chr(9))
    if (<dewpoint_c> isin %wu_temp) %wu_dewpoint_c = $remove(%wu_temp,<dewpoint_c>,</dewpoint_c>,$chr(9))

    if (<heat_index_string> isin %wu_temp) %wu_heat_index_string = $remove(%wu_temp,<heat_index_string>,</heat_index_string>,$chr(9))
    if (<heat_index_f> isin %wu_temp) %wu_heat_index_f = $remove(%wu_temp,<heat_index_f>,</heat_index_f>,$chr(9))
    if (<heat_index_c> isin %wu_temp) %wu_heat_index_c = $remove(%wu_temp,<heat_index_c>,</heat_index_c>,$chr(9))
    if (<windchill_string> isin %wu_temp) %wu_windchill_string = $remove(%wu_temp,<windchill_string>,</windchill_string>,$chr(9))
    if (<windchill_f> isin %wu_temp) %wu_windchill_f = $remove(%wu_temp,<windchill_f>,</windchill_f>,$chr(9))
    if (<windchill_c> isin %wu_temp) %wu_windchill_c = $remove(%wu_temp,<windchill_c>,</windchill_c>,$chr(9))

    if (<visibility_mi> isin %wu_temp) %wu_visibility_mi = $remove(%wu_temp,<visibility_mi>,</visibility_mi>,$chr(9))
    if (<visibility_km> isin %wu_temp) %wu_visibility_km = $remove(%wu_temp,<visibility_km>,</visibility_km>,$chr(9))
  }

  ;--- Variables for Forecast Command ---
  if (%wu_command == !forecast) || (%wu_command == !forecast5) {
    if (<period> isin %wu_temp) set %wu_period $remove(%wu_temp,<period>,</period>,$chr(9),$chr(32))
    if (<high> isin %wu_temp) set %wu_xtemp 1
    if (<low> isin %wu_temp) set %wu_xtemp 2
    if (<simpleforecast> isin %wu_temp) set %wu_simpleforecast 1

    if (<title> isin %wu_temp) && (%wu_period == 1) %wu_f1_title = $remove(%wu_temp,<title>,</title>,$chr(9))
    if (<fcttext> isin %wu_temp) && (%wu_period == 1) %wu_f1_fcttext = $remove(%wu_temp,<fcttext>,</fcttext>,$chr(9))
    if (<title> isin %wu_temp) && (%wu_period == 2) %wu_f2_title = $remove(%wu_temp,<title>,</title>,$chr(9))
    if (<fcttext> isin %wu_temp) && (%wu_period == 2) %wu_f2_fcttext = $remove(%wu_temp,<fcttext>,</fcttext>,$chr(9))

    if (%wu_simpleforecast == 1) {
      if (<weekday> isin %wu_temp) set $+(%,wu_P,%wu_period,_weekday) $remove(%wu_temp,<weekday>,</weekday>,$chr(9),$chr(32))
      if (<conditions> isin %wu_temp) set $+(%,wu_P,%wu_period,_conditions) $remove(%wu_temp,<conditions>,</conditions>,$chr(9))
      if (%wu_xtemp == 1) {
        if (<fahrenheit> isin %wu_temp) set $+(%,wu_P,%wu_period,_highf) $remove(%wu_temp,<fahrenheit>,</fahrenheit>,$chr(9),$chr(32))
        if (<celsius> isin %wu_temp) set $+(%,wu_P,%wu_period,_highc) $remove(%wu_temp,<celsius>,</celsius>,$chr(9),$chr(32))
      }
      if (%wu_xtemp == 2) {
        if (<fahrenheit> isin %wu_temp) set $+(%,wu_P,%wu_period,_lowf) $remove(%wu_temp,<fahrenheit>,</fahrenheit>,$chr(9),$chr(32))
        if (<celsius> isin %wu_temp) set $+(%,wu_P,%wu_period,_lowc) $remove(%wu_temp,<celsius>,</celsius>,$chr(9),$chr(32))
      }
    }
  }
  ;--- Variables for Alerts Command ---
  if (%wu_command == !alerts) || (%wu_command == !alertinfo) { 
    ;echo -s %wu_temp
    set -n %wu_ac <alert count="
    if (%wu_ac isin %wu_temp) set -n %wu_a_count $remove(%wu_temp,<termsofservice link="http://www.wunderground.com/weather/api/d/terms.html">This feed will be deprecated. Please switch to http://www.wunderground.com/weather/api/</termsofservice>,<alert count=",">,$chr(32),$chr(9))
    if (<AlertItem> isin %wu_temp) inc %wu_a_i
    if (<type> isin %wu_temp) set $+(%,wu_a,%wu_a_i,_type) $remove(%wu_temp,<type>,</type>,$chr(9)) 
    if (<description> isin %wu_temp) set $+(%,wu_a,%wu_a_i,_description) $remove(%wu_temp,<description>,</description>,$chr(9))
    if (<date epoch isin %wu_temp) set $+(%,wu_a,%wu_a_i,_date) $right($remove(%wu_temp,<date epoch=",">,</date>,$chr(9)),-12)
    if (<expires epoch isin %wu_temp) set $+(%,wu_a,%wu_a_i,_expires) $right($remove(%wu_temp,<expires epoch=",">,</expires>,$chr(9)),-10)
    if (</message> isin %wu_temp) { set %wu_msg OFF | set $+(%,wu_a,%wu_a_i,_count) $(%wu_msg_c,2) | set %wu_msg_c 0 }
    if (%wu_msg == ON) {
      inc %wu_msg_gc
      inc %wu_msg_c 
      set $+(%,wu_a,%wu_a_i,_message,%wu_msg_c) %wu_temp
    }
    if (<message> isin %wu_temp) { set %wu_msg ON }
  }
}



on *:sockclose:wunderground: {
  ;--- Spacers. Such as -|-  |  and -|
  var %wu_space = $+($chr(45),$chr(124),$chr(45))
  var %wu_space2 = $+($chr(32),$chr(124),$chr(32))
  var %wu_spaceend = $+($chr(45),$chr(124))

  ;--- Removes + sign from address variable
  set %wu_address $replace(%wu_address,$chr(43),$chr(32)) 

  if (%wu_command == !weather) { 
    set %wu_present $remove(%wu_full,$chr(9),$chr(32),$chr(44))
    if (%wu_present == $null) msg %wu_chan Location not found
    if (%wu_present != $null) msg %wu_chan %wu_full $+ : %wu_weather and $+(%wu_temp_f,$chr(176),F,$chr(47),%wu_temp_c,$chr(176),C)
  }
  if (%wu_command == !current) { 
    set %wu_present $remove(%wu_full,$chr(9),$chr(32),$chr(44))
    if (%wu_present == $null) msg %wu_chan Location not found
    if (%wu_present != $null) msg %wu_chan %wu_full $+ : %wu_weather and $+(%wu_temp_f,$chr(176),F,$chr(47),%wu_temp_c,$chr(176),C) $&
      $+ %wu_space2 Heat Index: $+(%wu_heat_index_f,$chr(176),F,$chr(47),%wu_heat_index_c,$chr(176),C)$&
      $+ %wu_space2 Winds %wu_wind_string $&
      $+ %wu_space2 Windchill: $+(%wu_windchill_f,$chr(176),F,$chr(47),%wu_windchill_c,$chr(176),C) $&
      $+ %wu_space2 Pressure: $+(%wu_pressure_in,in,$chr(47),%wu_pressure_mb,mb) $&
      $+ %wu_space2 Humidity: %wu_relative_humidity $&
      $+ %wu_space2 Dew: $+(%wu_dewpoint_f,$chr(176),F,$chr(47),%wu_dewpoint_c,$chr(176),C) $&
      $+ %wu_space2 Visiblity: $+(%wu_visibility_mi,mi,$chr(47),%wu_visibility_km,km)
  }

  if (%wu_command == !time) {
    msg %wu_chan %wu_full $+ : %wu_local_time
  }
  if (%wu_command == !forecast) || (%wu_command == !forecast5) {
    if (%wu_f1_title != $null) { 
      var %wu_forecast1 $(%wu_f1_title $+ : %wu_f1_fcttext)
      var %wu_forecast2 $(%wu_f2_title $+ : %wu_f2_fcttext)
      if (%wu_f2_title != %wu_P2_weekday ) var %wu_forecast3 $(%wu_P2_weekday $+ : %wu_P2_conditions $+ . High: $+(%wu_P2_highf,$chr(176),F) $chr(47) $+(%wu_P2_highc,$chr(176),C) Low: $+(%wu_P2_lowf,$chr(176),F) $chr(47) $+(%wu_P2_lowc,$chr(176),C)) 
      ;if (%wu_f2_title != %wu_P2_weekday ) var %wu_forecast3 $(%wu_P4_weekday $+ : %wu_P4_conditions $+ . High: $+(%wu_P4_highf,$chr(176),F) $chr(47) $+(%wu_P4_highc,$chr(176),C) Low: $+(%wu_P4_lowf,$chr(176),F) $chr(47) $+(%wu_P4_lowc,$chr(176),C))

      if (%wu_f2_title == %wu_P2_weekday ) var %wu_forecast3 $(%wu_P3_weekday $+ : %wu_P3_conditions $+ . High: $+(%wu_P3_highf,$chr(176),F) $chr(47) $+(%wu_P3_highc,$chr(176),C) Low: $+(%wu_P3_lowf,$chr(176),F) $chr(47) $+(%wu_P3_lowc,$chr(176),C))
      .timer 1 0 msg %wu_chan %wu_address $+ : %wu_forecast1
      .timer 1 1 msg %wu_chan %wu_forecast2 %wu_space %wu_forecast3 %wu_spaceend 
    }
    if (%wu_f1_title == $null) {
      var %wu_forecast1 $(%wu_P1_weekday $+ : %wu_P1_conditions $+ . High: $+(%wu_P1_highf,$chr(176),F,$chr(40),%wu_P1_highc,$chr(176),C,$chr(41)) Low: $+(%wu_P1_lowf,$chr(176),F,$chr(40),%wu_P1_lowc,$chr(176),C,$chr(41)))
      var %wu_forecast2 $(%wu_P2_weekday $+ : %wu_P2_conditions $+ . High: $+(%wu_P2_highf,$chr(176),F,$chr(40),%wu_P2_highc,$chr(176),C,$chr(41)) Low: $+(%wu_P2_lowf,$chr(176),F,$chr(40),%wu_P2_lowc,$chr(176),C,$chr(41)))
      var %wu_forecast3 $(%wu_P3_weekday $+ : %wu_P3_conditions $+ . High: $+(%wu_P3_highf,$chr(176),F,$chr(40),%wu_P3_highc,$chr(176),C,$chr(41)) Low: $+(%wu_P3_lowf,$chr(176),F,$chr(40),%wu_P3_lowc,$chr(176),C,$chr(41)))
      .timer 1 0 msg %wu_chan %wu_address $+ : %wu_forecast1  
      .timer 1 1 msg %wu_chan %wu_forecast2 %wu_space %wu_forecast3
    }
  }

  if (%wu_command == !forecast5) {
    ;.timer 1 0 .msg %wu_chan %wu_P1_weekday $+ : %wu_P1_conditions $+ . High: $+(%wu_P1_highf,$chr(176),F,$chr(40),%wu_P1_highc,$chr(176),C,$chr(41)) - Low: $+(%wu_P1_lowf,$chr(176),F,$chr(40),%wu_P1_lowc,$chr(176),C,$chr(41))
    .timer 1 1 .msg %wu_nick Your forcast for %wu_address
    .timer 1 2 .msg %wu_nick %wu_P1_weekday $+ : %wu_P1_conditions $+ . High: $+(%wu_P1_highf,$chr(176),F,$chr(40),%wu_P1_highc,$chr(176),C,$chr(41)) - Low: $+(%wu_P1_lowf,$chr(176),F,$chr(40),%wu_P1_lowc,$chr(176),C,$chr(41))
    .timer 1 3 .msg %wu_nick %wu_P2_weekday $+ : %wu_P2_conditions $+ . High: $+(%wu_P2_highf,$chr(176),F,$chr(40),%wu_P2_highc,$chr(176),C,$chr(41)) - Low: $+(%wu_P2_lowf,$chr(176),F,$chr(40),%wu_P2_lowc,$chr(176),C,$chr(41))
    .timer 1 4 .msg %wu_nick %wu_P3_weekday $+ : %wu_P3_conditions $+ . High: $+(%wu_P3_highf,$chr(176),F,$chr(40),%wu_P3_highc,$chr(176),C,$chr(41)) - Low: $+(%wu_P3_lowf,$chr(176),F,$chr(40),%wu_P3_lowc,$chr(176),C,$chr(41))
    .timer 1 5 .msg %wu_nick %wu_P4_weekday $+ : %wu_P4_conditions $+ . High: $+(%wu_P4_highf,$chr(176),F,$chr(40),%wu_P4_highc,$chr(176),C,$chr(41)) - Low: $+(%wu_P4_lowf,$chr(176),F,$chr(40),%wu_P4_lowc,$chr(176),C,$chr(41))
    .timer 1 6 .msg %wu_nick %wu_P5_weekday $+ : %wu_P5_conditions $+ . High: $+(%wu_P5_highf,$chr(176),F,$chr(40),%wu_P5_highc,$chr(176),C,$chr(41)) - Low: $+(%wu_P5_lowf,$chr(176),F,$chr(40),%wu_P5_lowc,$chr(176),C,$chr(41))
    .timer 1 7 .msg %wu_nick %wu_P6_weekday $+ : %wu_P6_conditions $+ . High: $+(%wu_P6_highf,$chr(176),F,$chr(40),%wu_P6_highc,$chr(176),C,$chr(41)) - Low: $+(%wu_P6_lowf,$chr(176),F,$chr(40),%wu_P6_lowc,$chr(176),C,$chr(41))
  }

  if (%wu_command == !alerts) {
    if (%wu_a_count == 0) msg %wu_chan %wu_address $+ : No Alerts
    if (%wu_a_count > 0) {
      msg %wu_chan %wu_address $+ : %wu_a_count Alerts
      var %i 1
      while (%i <= %wu_a_count) {
        .timer 1 %i msg %wu_chan %wu_a_start $($+(%,wu_a,%i,_description),2) till $($+(%,wu_a,%i,_expires),2) %wu_a_end
        inc %i
      }
      .timer 1 %i .notice %wu_nick use $chr(2) !alertinfo $chr(2) [zipcode|city,state|city,country|airport] for alert details
    }
  }
  if (%wu_command == !alertinfo) {
    if (%wu_a_count == 0) msg %wu_chan %wu_address $+ : No Alerts
    if (%wu_a_count > 0) {
      ;msg %wu_chan %wu_address $+ : %wu_a_count Alerts - See PM for details
      .msg %wu_nick %wu_address $+ : %wu_a_count Alerts
      var %i 1 , %i_gc 1
      while (%i <= %wu_a_count) {
        .timer 1 %i_gc .msg %wu_nick $chr(2) $($+(%,wu_a,%i,_description),2) $chr(2) from $($+(%,wu_a,%i,_date),2) till $($+(%,wu_a,%i,_expires),2)
        var %i_msg 1
        while (%i_msg <= $($+(%,wu_a,%i,_count),2)) {
          .timer 1 %i_gc .msg %wu_nick $($+(%,wu_a,%i,_message,%i_msg),2)
          inc %i_gc
          inc %i_msg
        }
        inc %i
      }
      .timer 1 %i_gc .msg %wu_nick --------- End of Alerts -------
    }
  }



  ;echo -s End-------- of WU $time --------
  wu_cleanup
}

alias wu_help {
  .timer 1 0 .msg %wu_nick $me $+ ' Weather Commands: (16 lines)
  .timer 1 1 .msg %wu_nick !weather !current !forecast !forecast5 !alerts !alertinfo !time
  .timer 1 2 .msg %wu_nick Use above commands with your desired location. 
  .timer 1 3 .msg %wu_nick !weather [zipcode|city,state|city,country|airport]
  .timer 1 4 .msg %wu_nick Examples: !weather 90210 - !weather Beverly Hills, CA - !weather LAX - !weather E2J4C7
  .timer 1 5 .msg %wu_nick You can also set a default location for yourself. Just type: !weather REGISTER [location]
  .timer 1 6 .msg %wu_nick To remove from the list, simply type !weather REMOVE
  .timer 1 7 .msg %wu_nick After you have registure, You can simply use !weather and it will bring up your default
  .timer 1 8 .msg %wu_nick -----END OF WEATHER HELP -----
  wu_cleanup
}

alias wu_cleanup {
  unset %wu_*
}


/*
---- VERSION HISTORY -----
1.0 
- Original creation

2.0 
- Added !current command
- Unknown modifications

3.0 
- Added REGISTER and HELP functions
- Fixed !forecast, !forecast5, !alerts !alertinfo Address still including + sign error.

3.1
- Added !weather ON and OFF command to turn the script on or off. (set for OPS ONLY)

3.2
- Modified !weather ON/OFF command. Now the ON and OFF commands are Per #channel basis. (allowing it to be on in one chan, but off in another

3.3
- Line 238, TOS line had changed. Updated $remove() to reflect new text.

4.0
- Local Support. Now Local user (mIRC client hosting the script) can also activate and use the script. .
4.1
- Fixed !w command. Now it works.
*/
