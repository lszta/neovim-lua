local Plug = {
  begin = vim.fn['plug#begin'],

  ends = function ()
    vim.fn['plug#end']()
  end
}

local meta = {
  __call = function (_, repo, opts)
    opts = opts or vim.empty_dict()

    opts['do'] = opts.run
    opts.run = nil

    opts['for'] = opts.ft
    opts.ft = nil

    vim.call('plug#', repo, opts)
  end
}

return setmetatable(Plug, meta)
