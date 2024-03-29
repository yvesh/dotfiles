-- Simple collections of snippets / macros
-- Playing around with luasnip
-- fmt is offering way more features

local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node

-- All
ls.add_snippets('all', {
  s('date', { t('-- ' .. os.date '%Y-%m-%d') }),
})

-- Vue.js
ls.add_snippets('vue', {
  s('myts', {
    t '<script lang="ts">',
    t { '', '' },
    t { '', '</script>' },
    t { '', '' },
    t { '', '<template>' },
    t { '', '\t<div>' },
    t { '', '' },
    t { '', '\t</div>' },
    t { '', '</template>' },
  }),

  s('date', { t('// ' .. os.date '%Y-%m-%d') }),
})
