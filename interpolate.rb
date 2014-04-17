require 'rubygems'
require 'interpolate'
require 'pp'

# a non-linear set of multi-dimensional points;
# perhaps the location of some actor in relation to time
time_frames = {
  0 => [0, 0, 0],
  1 => [1, 0, 0],
  2 => [0, 1, 0],
  3 => [0, 0, 2],
  4 => [3, 0, 1],
  5 => [1, 2, 3],
  6 => [0, 0, 0]
}

path = Interpolate::Points.new(time_frames)

# play the actor's positions in time increments of 0.25
(0).step(6, 0.25) do |time|
  position = path.at(time)
  puts ">> At #{time}s, actor is at:"
  p position
end
