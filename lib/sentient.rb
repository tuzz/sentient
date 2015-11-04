module Sentient
end

require "open3"

require "sentient/register"

require "sentient/expression/boolean"
require "sentient/expression/boolean/true"
require "sentient/expression/boolean/false"
require "sentient/expression/boolean/not"
require "sentient/expression/boolean/and"
require "sentient/expression/boolean/or"
require "sentient/expression/boolean/xor"
require "sentient/expression/boolean/equal"
require "sentient/expression/boolean/identity"

require "sentient/expression/integer"
require "sentient/expression/integer/literal"
require "sentient/expression/integer/pad"

require "sentient/expression/program"

require "sentient/solver/lingeling"
require "sentient/solver/result"

require "sentient/machine"
