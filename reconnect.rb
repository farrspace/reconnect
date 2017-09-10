#!/usr/bin/env ruby

# Required configuration
SSID = "your-network-name-here"
PASSWORD = "your-password-here"

# Optional configuration (likely already correct) 
INTERFACE = "en1"
AIRPORT_COMMAND = "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"

# Script
if SSID == "your-network-name-here" || PASSWORD == "your-password-here"
  raise "Add your SSID and PASSWORD to the configuration options" 
end

def current_network
  `networksetup -getairportnetwork #{INTERFACE}`.sub("Current Wi-Fi Network: ", "").strip
end

def ssid_available?
  `#{AIRPORT_COMMAND} -s "#{SSID}"`.to_s.include? SSID
end

def connected_to_any?
  !current_network.include?("You are not associated with an AirPort network.")
end

def connect
  !`networksetup -setairportnetwork #{INTERFACE} #{SSID} #{PASSWORD}`.to_s.include?("Failed")
end

def try_valiantly
  result = false
  2.times do |n|
    log "reconnect try[#{n+1}]".green
    break if result = connect
  end
  result
end

def powercycle
  `networksetup -setairportpower #{INTERFACE} off`
  `networksetup -setairportpower #{INTERFACE} on`
end

def log(message)
  puts "#{Time.now} >>> #{message}"
end

def run
  if !connected_to_any?
    if ssid_available?
      try_valiantly
      if current_network == SSID
        log "Re-connected to #{SSID}.".yellow
      else
        log "Could not connect to #{SSID}, power-cycling airport card.".red
      end

      powercycle
      try_valiantly
      if current_network == SSID
        log "Re-connected to #{SSID}.".yellow
      else
        log "Could not connect to #{SSID}. ".red
      end

    else
      log "#{SSID} not available, not trying to connect.".red
    end
  end
end

class String
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end
  def blue; colorize(34); end
  def bold; colorize(1); end
  def green; colorize(32); end
  def pink; colorize(35); end
  def red; colorize(31); end
  def yellow; colorize(33); end
end

if ARGV[0] == "start"
  log "reconnect.rb started".blue

  if connected_to_any?
    log "[#{current_network}]".green
  end

  while true
    run
    sleep 60*2
  end
else

  if connected_to_any?
    log "[#{current_network}]".green
  end
  run
end
