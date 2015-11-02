module Sentient
end

require "open3"

require "sentient/expression/boolean"
require "sentient/expression/boolean/true"
require "sentient/expression/boolean/false"
require "sentient/expression/boolean/not"
require "sentient/expression/boolean/and"
require "sentient/expression/boolean/or"
require "sentient/expression/boolean/equal"

require "sentient/expression/program"

require "sentient/solver/lingeling"
require "sentient/solver/result"
