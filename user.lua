-- MQTT connect script with deep sleep
-- Remember to connect GPIO16 and RST to enable deep sleep

dofile("wifi.lua")
dofile("settings.lua")

-- Setup MQTT client and events
m = mqtt.Client(client_id, 120, username, password)
temperature = 0
humidity = 0

-- DHT22 sensor logic
function get_sensor_data()
  pin = 4
  status, temp, humi, temp_dec, humi_dec = dht.read(pin)
  if status == dht.OK then
    print("DHT Temp:"..temp.."; ".."Humidity:"..humi)
  elseif status == dht.ERROR_CHECKSUM then
    print( "DHT Checksum error.")
  elseif status == dht.ERROR_TIMEOUT then
    print ( "DHT timed out." )
  end
end

function loop()
  if wifi.sta.status() == wifi.STA_GOTIP then
    -- Stop the loop
    tmr.stop(0)

    --- Check the IP Address ---
    print(wifi.sta.getip())

    m:connect( mqtt_broker_ip , mqtt_broker_port, 0, function(conn)
      print("Connected to MQTT")
      print("  IP: ".. mqtt_broker_ip)
      print("  Port: ".. mqtt_broker_port)
      print("  Client ID: ".. mqtt_client_id)
      print("  Username: ".. mqtt_username)
      -- Get sensor data
      get_sensor_data()
      m:publish(mqtt_topic.."/temperature",temp, 0, 0, function(conn)
        m:publish(mqtt_topic.."/humidity",humi, 0, 0, function(conn)
          deep_sleep()
        end)
      end)
    end,
    function(conn, reason)
      print("MQTT Connection failed: "..reason)
      deep_sleep()
    end)
  else
    print("Connecting...")
  end
end

function deep_sleep()
  print("Going to deep sleep for "..(time_between_sensor_readings/1000).." seconds")
  node.dsleep(time_between_sensor_readings*1000)
end

tmr.alarm(0, 100, 1, function() loop() end)
