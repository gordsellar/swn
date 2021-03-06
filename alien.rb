#!/usr/bin/env ruby
#
# alien.rb
# SWN Alien Generator
#
# Copyright (c) 2014 Steve Simenic <orffen@orffenspace.com>
#
# This file is part of the SWN Toolbox.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

require './unindent'
require 'yaml'

# This class generates an alien race from tables/alien.yaml, 
# which has the following attributes:
#
# - body_type (string)
# - social_structure (string)
# - lenses (array)
#
class Alien
  attr_reader :body_type, :social_structure, :lenses

  def initialize
    yaml = YAML.load(File.read('tables/alien.yaml'))
    @body_type        = yaml['body_type'].sample.to_str
    @social_structure = yaml['social_structure'].sample.to_str
    @lenses           = []
    [1, 2, 2, 3, 4].sample.times { @lenses.push(yaml['lens'].sample.to_str) }
  end

  def to_s
    <<-EOS.unindent
      |Body Type: #{@body_type}
      |Social Structure: #{@social_structure}
      |Lenses: #{@lenses.join(', ')}
      EOS
  end
end


if __FILE__ == $0
  Integer(ARGV.shift || 1).times do |e|
    puts '-----------+-+-+-----------' unless e.zero?
    puts Alien.new
  end
end
