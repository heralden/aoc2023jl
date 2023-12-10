module utils

export readinput

function readinput(filename)
  path = joinpath(@__DIR__, "..", "data", filename)
  s = open(path, "r") do file
      read(file, String)
  end
  return s
end

end
