local _M = {}

function _M.curry(func, args)
  return function() func(args) end
end

function _M.curryRequire(plugin, args, modArgs)
  if args == nil then return _M.curry(require, plugin) end

  return function()
    local mod = require(plugin)

    if type(args) == "string" then return mod[args](modArgs) end

    for i, method in ipairs(args) do
      mod = mod[method]

      if i == #args then
        return mod(modArgs)
      end
    end
  end
end

function _M.curryPlugin(plugin)
  return _M.curryRequire('plugins.' .. plugin)
end

return _M
